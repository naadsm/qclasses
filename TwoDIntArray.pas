unit TwoDIntArray;

(*
TwoDIntArray.pas
----------------
Begin: 2008/12/15
Last revision: $Date: 2011-10-25 05:05:08 $ $Author: areeves $
Version: $Revision: 1.8 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <Aaron.Reeves@colostate.edu>
------------------------------------------------------
Copyright (C) 2008 - 2010 Animal Population Health Institute, Colorado State University

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*)

{$INCLUDE Defs.inc}

interface

  uses
    Classes,

    MyDelphiArrayUtils,

    QIntegerMaps,
    QVectors
  ;


  {*
    Each column in a 2D array is a QVector.
    
    The assumption is that every value in the 2D array will be filled in:
    if this assumption is not (roughly) accurate, memory could be used more efficiently
    by using a sparse array: see class TOneDPlusSparseArray in unit SparseArrays.
    (Note that, as of this writing, the code in SparseArrays is probably not complete.)
  }

  // FIX ME: all functions should check that c and r are not negative numbers.
  // Consider making them unsigned integers.
  type TTwoDIntArray = class( TQIntegerObjectMap )
    protected
      _nCols: integer;
      _nRows: integer;
      _defaultVal: integer;
      _autoExpand: boolean;
      _headers: TStringList;

      function dimensionsOK( const c, r: integer ): boolean;

    public
      constructor create( const nCols: integer = 0; const nRows: integer = 0; const defaultVal: integer = 0; const autoExpand: boolean = true );
      destructor destroy(); override;

      procedure fill( const val: integer );

      function createVectorFromRow( const r: integer ): TQIntegerVector;
      function createArrayFromRow( const r: integer ): TARIntArray;
      function createVectorFromColumn( const c: integer ): TQIntegerVector;
      function createArrayFromColumn( const c: integer ): TARIntArray;

      procedure setAt( const c, r: integer; const val: integer );
      function getAt( const c, r: integer ): integer;
      function at(const c, r: integer): integer;
      
      procedure setCol( const c: integer; const v: TQIntegerVector );
      procedure setRow( const r: integer; const v: TQIntegerVector );
      
      procedure appendCol( const v: TQIntegerVector );
      //procedure appendRow( const v: TQIntegerVector );

      procedure expand( const c, r: integer );

      procedure setColHeader( const c: integer; const val: string );
      procedure setColHeaders( const headers: TStringList );

      procedure debug();
      procedure debugTranspose();

      function asDelimitedText( const delimiter: char; const useHeaders: boolean = true ): string;
      function asCsv( const useHeaders: boolean = true ): string;

      property isDynamic: boolean read _autoExpand;
      property nCols: integer read _nCols;
      property nRows: integer read _nRows;
    end
  ;

  {$IFDEF DEBUG}
  procedure twoDIntArrayUnitTest();
  {$ENDIF}


implementation

  uses
    SysUtils,
    StrUtils,

    MyStrUtils,
    DebugWindow,
    I88n
  ;

  
  constructor TTwoDIntArray.create( const nCols: integer = 0; const nRows: integer = 0; const defaultVal: integer = 0; const autoExpand: boolean = true );
    var
      i: integer;
      v: TQIntegerVector; 
    begin
      inherited create();
      
      _nCols := nCols;
      _nRows := nRows;
      _defaultVal := defaultVal;
      _autoExpand := autoExpand;
      _headers := nil;
      
      for i := 0 to _nCols - 1 do
        begin
          v := TQIntegerVector.create();
          v.resize( _nRows );
          v.fill( _defaultVal );
          self.add( i, v );
        end
      ;
    end
  ;


  destructor TTwoDIntArray.destroy();
    var
      i: integer;
    begin
      for i := 0 to _nCols - 1 do
        self.value( i ).Free
      ;

      freeAndNil( _headers );
      
      inherited destroy();
    end
  ;


  procedure TTwoDIntArray.fill( const val: integer );
    var
      c: integer;
    begin
      for c := 0 to _nCols -1 do
        ( self.value( c ) as TQIntegerVector ).fill( val )
      ;
    end
  ;


  function TTwoDIntArray.createVectorFromRow( const r: integer ): TQIntegerVector;
    var
      v: TQIntegerVector;
      i: integer;
    begin
      v := TQIntegerVector.create();
      v.resize( _nCols );

      for i := 0 to _nCols - 1 do
        v.itemAt[i] := getAt( i, r )
      ;

      result := v;
    end
  ;


  function TTwoDIntArray.createArrayFromRow( const r: integer ): TARIntArray;
    var
      a: TARIntArray;
      i: integer;
    begin
      setLength( a, _nCols );
      for i := 0 to _nCols - 1 do
        a[i] := getAt( i, r )
      ;

      result := a;
    end
  ;


  function TTwoDIntArray.createVectorFromColumn( const c: integer ): TQIntegerVector;
    begin
      if( nil = self.value( c ) ) then
        begin
          if( _autoExpand ) then
            getAt( c, 0 ) // This will force the 2D array to be resized
          else
            begin
              raise exception.create( 'Column ' + intToStr( c ) + ' out of bounds in TTwoDIntArray.createVectorFromColumn(): dimensions are ' + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) );
              result := nil;
              exit;
            end
          ;
        end
      ;

      result := TQIntegerVector.create( self.value( c ) as TQIntegerVector );
    end
  ;


  function TTwoDIntArray.createArrayFromColumn( const c: integer ): TARIntArray;
    var
      v: TQIntegerVector;
      i: integer;
      a: TARIntArray;
    begin
      if( nil = self.value( c ) ) then
        begin
          if( _autoExpand ) then
            getAt( c, 0 ) // This will force the 2D array to be resized
          else
            begin
              raise exception.create( 'Column ' + intToStr( c ) + ' out of bounds in TTwoDIntArray.createVectorFromColumn(): dimensions are ' + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) );
              result := nil;
              exit;
            end
          ;
        end
      ;

      v := self.value( c ) as TQIntegerVector;
      setLength( a, _nRows );
      for i := 0 to v.size - 1 do
        a[i] := v.at( i )
      ;

      result := a;
    end
  ;


  procedure TTwoDIntArray.expand( const c, r: integer );
    var
      i, j: integer;
      v: TQIntegerVector;
    begin
      // Add columns by creating new TQIntegerWectors.
      if( c > _nCols ) then
        begin
          dbcout2( 'Adding columns...' );
          for i := _nCols - 1 to c - 1 do
            begin
              v := TQIntegerVector.create();
              v.resize( _nRows );
              v.fill( _defaultVal );
              self.add( i, v );
            end
          ;
          _nCols := c;
        end
      ;

      // Add rows by resizing existing TQIntegerWectors and filling the tails.
      if( r > _nRows ) then
        begin
          dbcout2( 'Adding rows...' );
          for i := 0 to _nCols - 1 do
            begin
              v := self.value( i ) as TQIntegerVector;
              v.resize( r );
              for j := _nRows - 1 to r - 1 do
                v.itemAt[j] := _defaultVal
              ;
            end
          ;
          _nRows := r;
        end
      ;

      dbcout2( '+++ Dimensions are now ' + intToStr( _nCols ) + ' x ' + intToStr( _nRows ) );
    end
  ;


  function TTwoDIntArray.dimensionsOK( const c, r: integer ): boolean;
    begin
      result := true;

      // Do we have enough columns?  If not, should we add them?
      if( c >= _nCols ) then
        begin
          if( _autoExpand ) then
            self.expand( c + 1, _nRows )
          else
            begin
              raise exception.create(
                'Column index (' + intToStr( c ) + ')'
                + ' out of bounds in TTwoDIntArray: dimensions are '
                + intToStr( _nCols ) + ' by ' + intToStr( _nRows )
              );
              result := false;
            end
          ;
        end
      ;

      // Do we have enough rows?  If not, should we add them?
      if( r >= _nRows ) then
        begin
          if( _autoExpand ) then
            self.expand( _nCols, r + 1 )
          else
            begin
              raise exception.create(
                'Row index (' + intToStr( r ) + ')'
                + ' out of bounds in TTwoDIntArray: dimensions are '
                + intToStr( _nCols ) + ' by ' + intToStr( _nRows )
              );
              result := false;
            end
          ;
        end
      ;
    end
  ;


  procedure TTwoDIntArray.setAt( const c, r: integer; const val: integer );
    var
      v: TQIntegerVector;
    begin
      if( dimensionsOK( c, r ) ) then
        begin
          v := self.value( c ) as TQIntegerVector;
          v.itemAt[r] := val;
        end
      ;
    end
  ;


  function TTwoDIntArray.getAt( const c, r: integer ): integer;
    begin
      result := at( c, r );
    end
  ;

  function TTwoDIntArray.at( const c, r: integer ): integer;
    var
      v: TQIntegerVector;
    begin
      if( dimensionsOK( c, r ) ) then
        begin
          v := self.value( c ) as TQIntegerVector;
          result := v.itemAt[r];
        end
      else
        result := _defaultVal
      ;
    end
  ;


  procedure TTwoDIntArray.setCol( const c: integer; const v: TQIntegerVector );
    var
      col: TQIntegerVector;
      i: integer;
    begin
      if( dimensionsOK( c, _nRows - 1 ) ) then
        begin
          col := self.value(c) as TQIntegerVector;
          col.clear();
          for i := 0 to v.count - 1 do
            col.append( v.at(i) )
          ;
          for i := v.count to _nRows - 1 do
            col.append( _defaultVal )
          ;
        end
      ;
    end
  ;


  procedure TTwoDIntArray.setRow( const r: integer; const v: TQIntegerVector );
    var
      i: integer;
    begin
      if( dimensionsOK( v.size - 1, r ) ) then
        begin
          for i := 0 to v.count - 1 do
            ( self.value(i) as TQIntegerVector )[r] := v[i]
          ;
        end
      ;
    end
  ;


  procedure TTwoDIntArray.appendCol( const v: TQIntegerVector );
    var
      newV: TQIntegerVector;
    begin
      inc( _nCols );
      newV := TQIntegerVector.create( v );
      self.add( _nCols - 1, newV );
    end
  ;


  procedure TTwoDIntArray.setColHeader( const c: integer; const val: string );
    var
      oldNCols: integer;
      i: integer;
    begin
      // Has _headers already been set?
      if( nil = _headers ) then
        begin
          _headers := TStringList.Create();
          for i := 0 to _nCols - 1 do
            _headers.Append( 'Column_' + intToStr( i ) )
          ;
        end
      ;

      // Do we have enough columns?  If not, should we add them?
      if( c >= _nCols ) then
        begin
          if( _autoExpand ) then
            begin
              oldNCols := _nCols;
              self.expand( c + 1, _nRows );
              for i := oldNCols to _nCols - 1 do
                _headers.Append( 'Column_' + intToStr( i ) )
              ;
            end
          else
            begin
              raise exception.create(
                'Column index (' + intToStr( c ) + ')'
                + ' out of bounds in TTwoDIntArray.setColHeader(): dimensions are '
                + intToStr( _nCols ) + ' by ' + intToStr( _nRows )
              );
              exit;
            end
          ;
        end
      ;

      _headers.Strings[c] := val;
    end
  ;


  procedure TTwoDIntArray.setColHeaders( const headers: TStringList );
    begin
      if( headers.Count <> _nCols ) then
        raise exception.Create( 'Wrong number of headers in TTwoDIntArray.setColHeaders' )
      else
        begin
          if( nil <> _headers ) then
            begin
              dbcout2( 'Removing old headers in TTwoDIntArray.setColHeaders' );
              freeAndNil( _headers );
            end
          ;

          _headers := TStringList.create();
          _headers.Assign( headers );
        end
      ;
    end
  ;


  function TTwoDIntArray.asCsv( const useHeaders: boolean = true ): string;
    begin
      result := asDelimitedText( csvListSep(), useHeaders );
    end
  ;


  function TTwoDIntArray.asDelimitedText( const delimiter: char; const useHeaders: boolean = true ): string;
    var
      str: string;
      c, r: integer;
    begin
      if( nil <> _headers ) then
        begin
          _headers.Delimiter := delimiter;
          result := _headers.DelimitedText + endl;
        end
      else
        result := ''
      ;

      for r := 0 to _nRows - 1 do
        begin
          str := '';
          for c := 0 to _nCols - 1 do
            begin
              str := str + intToStr( getAt( c, r ) );
              if( c < _nCols - 1 ) then
                str := str + delimiter
              else
                str := str + endl
              ;
            end
          ;
          result := result + str;
        end
      ;
    end
  ;

  procedure TTwoDIntArray.debug();
    var
      c, r: integer;
      str: string;
    begin
      dbcout( '---------------TTwoDIntArray debug', true );

      dbcout( 'Dimensions: ' + intToStr( _nCols ) + ' cols by ' + intToStr( _nRows ) + ' rows.', true );

      if( nil = _headers ) then
        dbcout( '(No headers specified)', true )
      else
        dbcout( i88nCsv( _headers ), true )
      ;

      for r := 0 to _nRows - 1 do
        begin
          str := '';
          for c := 0 to _nCols - 1 do
            str := str + intToStr( self.getAt( c, r ) ) + '  '
          ;
          dbcout( str, true );
        end
      ;

      dbcout( '----------Done TTwoDIntArray debug', true );
    end
  ;


  procedure TTwoDIntArray.debugTranspose();
    var
      c, r: integer;
      str: string;
    begin
      dbcout( '---------------TTwoDIntArray debug (TRANSPOSED)', true );

      dbcout( 'Dimensions: ' + intToStr( _nRows ) + ' cols by ' + intToStr( _nCols ) + ' rows.', true );

      if( nil = _headers ) then
        dbcout( '(No headers specified)', true )
      else
        dbcout( i88nCsv( _headers ), true )
      ;

      for c := 0 to _nCols - 1 do
        begin
          str := '';
          for r := 0 to _nRows - 1 do
            str := str + intToStr( self.getAt( c, r ) ) + '  '
          ;
          dbcout( str, true );
        end
      ;

      dbcout( '----------Done TTwoDIntArray debug (TRANSPOSED)', true );
    end
  ;


  {$IFDEF DEBUG}
  procedure twoDIntArrayUnitTest();
    var
      errMsg: string;
      twoDArr: TTwoDIntArray;
      i: integer;
      v, w, x: TQIntegerVector;
    begin
      errMsg := '';

      if( not qIntegerMapsDllLoaded( @errMsg ) ) then
        begin
          dbcout2( 'Integer map did not load:' + endl + errMsg );
          exit;
        end
      ;
      if( not qVectorsDllLoaded( @errMsg ) ) then
        begin
          dbcout2( 'Wector did not load:' + endl + errMsg );
          exit;
        end
      ;

      dbcout( '5 x 5 array filled with 1s:', true );
      twoDArr := TTwoDIntArray.create( 5, 5, 1, true );
      twoDArr.debug();
      dbcout( endl, true );

      dbcout( 'Set cell (3,4) to new value of 6:', true );
      twoDArr.setAt( 3, 4, 6 );
      twoDArr.debug();
      dbcout( endl, true );

      dbcout( 'Set diagonals to new values:', true );
      for i := 0 to twoDArr.nCols - 1 do
        twoDArr.setAt( i, i, i )
      ;
      twoDArr.debug();
      dbcout( endl, true );

      dbcout( 'Add a row, making the array 5 x 6:', true );
      twoDArr.expand( 5, 6 );
      twoDArr.debug();
      dbcout( endl, true );

      dbcout( 'Add a column, and fill it with 2s:', true );
      twoDArr.expand( 6, 6 );
      for i := 0 to twoDArr.nCols - 1 do
        twoDArr.setAt( 5, i, 2 )
      ;
      twoDArr.debug();
      dbcout( endl, true );

      dbcout( 'Let the array be automatically resized by setting cell (7,2) to 7.', true );
      dbcout( 'The result should be 8 cols by 6 rows:', true );
      twoDArr.setAt( 7, 2, 7 );
      twoDArr.debug();
      dbcout( endl, true );

      dbcout( 'Let the array be automatically resized by setting cell (5,10) to 9.', true );
      dbcout( 'The result should be 8 cols by 11 rows:', true );
      twoDArr.setAt( 5, 10, 9 );
      twoDArr.debug();
      dbcout( endl, true );

      freeAndNil( twoDArr );

      dbcout( 'Create a new 3 x 3 array, filled with 3s:', true );
      twoDArr := TTwoDIntArray.create( 3, 3, 3 );
      twoDArr.debug();
      dbcout( endl, true );

      dbcout( 'Resize the array to 6 x 5:, and change the values of the diagonal:', true );
      twoDArr.expand( 6, 5 );
      for i := 0 to 4 do
        twoDArr.setAt( i, i, i )
      ;
      twoDArr.debug();
      dbcout( endl, true );

      dbcout( 'Retrieve row #4:', true );
      v := twoDArr.createVectorFromRow( 4 );
      v.debug();
      v.Free();
      dbcout( endl, true );

      dbcout2( 'Retrieve column #3:', true );
      v := twoDArr.createVectorFromColumn( 3 );
      v.debug();
      v.Free();
      dbcout( endl, true );

      dbcout( 'Set header for column 3 to "ThisIsMyHeader":', true );
      twoDArr.setColHeader( 3, 'ThisIsMyHeader' );
      twoDArr.debug();
      dbcout( endl, true );

      dbcout( 'Set header for column 9 to "AnotherHeader":', true );
      twoDArr.setColHeader( 9, 'AnotherHeader' );
      twoDArr.debug();
      dbcout( endl, true );

      dbcout( 'as a CSV string:', true );
      dbcout( twoDArr.asCsv(), true );
      dbcout( endl, true );

      dbcout( 'Create a new copy of column 2:', true );
      w := twoDArr.createVectorFromColumn( 2 );
      x := TQIntegerVector.create( w );
      w.debug();
      x.debug();
      w.Free();

      dbcout( 'Do it again for column 0:', true );
      w := twoDArr.createVectorFromColumn( 0 );
      x := TQIntegerVector.create( w );
      w.debug();
      x.debug();
      w.Free();

      dbcout( 'All done!', true );
      freeAndNil( twoDArr );
    end
  ;
  {$ENDIF}


end.


