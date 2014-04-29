unit TwoDDoubleArray;

(*
TwoDDoubleArray.pas
-------------------
Begin: 2009/2/14
Last revision: $Date: 2011-10-25 05:05:08 $ $Author: areeves $
Version: $Revision: 1.11 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <Aaron.Reeves@colostate.edu>
------------------------------------------------------
Copyright (C) 2009 - 2011 Animal Population Health Institute, Colorado State University

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*)

{$INCLUDE Defs.inc}

interface

  uses
    Types,
    Classes,

    MyDelphiArrayUtils,

    QIntegerMaps,
    QVectors
  ;


  {*
    Each column in a 2D array is a QVector.
    
    The assumption is that every value in the 2D array will be filled in:
    if this assumption is not (roughly) accurate, memory could be used more efficiently
    by a more sophisticated data structure.
  }

  // FIX ME: all functions should check that c and r are not negative numbers.
  // Consider making them unsigned integers.
  type TTwoDDoubleArray = class( TQIntegerObjectMap )
    protected
      _nCols: integer;
      _nRows: integer;
      _defaultVal: double;
      _autoExpand: boolean;
      _headers: TStringList;

      function dimensionsOK( const c, r: integer ): boolean;

    public
      constructor create(
        const nCols: integer = 0;
        const nRows: integer = 0;
        const defaultVal: double = 0.0;
        const autoExpand: boolean = false
      ); overload;
      constructor create( const src: TTwoDDoubleArray ); overload;

      destructor destroy(); override;

      procedure assign( const src: TTwoDDoubleArray ); reintroduce;

      procedure fill( const val: double );

      function createVectorFromRow( const r: integer ): TQDoubleVector;
      function createArrayFromRow( const r: integer ): TARDoubleArray;
      function createVectorFromColumn( const c: integer ): TQDoubleVector;
      function createArrayFromColumn( const c: integer ): TARDoubleArray;

      procedure setAt( const c, r: integer; const val: double );
      function getAt( const c, r: integer ): double;
      function at(const c, r: integer): double;
      
      procedure setCol( const c: integer; const v: TQDoubleVector );
      procedure setRow( const r: integer; const v: TQDoubleVector );
      
      procedure appendCol( const v: TQDoubleVector );
      //procedure appendRow( const v: TQDoubleVector );

      { Returns a pointer to an existing object }
      function col( const c: integer ): TQDoubleVector;

      { Return newly created objects }
      function createCol( const c: integer ): TQDoubleVector;
      //function createRow( const r: integer ): TQDoubleVector;

      procedure expand( const c, r: integer );

      procedure setColHeader( const c: integer; const val: string );
      procedure setColHeaders( const headers: TStringList );

      procedure addArray( const src: TTwoDDoubleArray );

      procedure debug();
      procedure debugTranspose();

      function asDelimitedText( const delimiter: char; const useHeaders: boolean = true ): string;
      function asCsv( const useHeaders: boolean = true ): string;
      function rectAsDelimitedText( const rect: TRect; const delimiter: char; const useHeaders: boolean = true ): string;

      property isDynamic: boolean read _autoExpand;
      property nCols: integer read _nCols;
      property nRows: integer read _nRows;
    end
  ;

  {$IFDEF DEBUG}
  procedure twoDDoubleArrayUnitTest();
  {$ENDIF}


implementation

  uses
    SysUtils,
    StrUtils,

    MyStrUtils,
    DebugWindow,
    I88n
  ;

  
  constructor TTwoDDoubleArray.create(
        const nCols: integer = 0;
        const nRows: integer = 0; const
        defaultVal: double = 0.0;
        const autoExpand: boolean = false
      );
    var
      i: integer;
      v: TQDoubleVector; 
    begin
      // FIX ME: There may be a memory leak when autoExpand is used.

      inherited create();
      
      _nCols := nCols;
      _nRows := nRows;
      _defaultVal := defaultVal;
      _autoExpand := autoExpand;

      _headers := nil;

      for i := 0 to _nCols - 1 do
        begin
          v := TQDoubleVector.create();
          v.resize( _nRows );
          v.fill( _defaultVal );
          self.add( i, v );
        end
      ;
    end
  ;


  constructor TTwoDDoubleArray.create( const src: TTwoDDoubleArray );
    begin
      inherited create();
      _headers := nil;
      assign( src );
    end
  ;

  destructor TTwoDDoubleArray.destroy();
    var
      i: integer;
    begin
      //for i := 0 to _nCols - 1 do
      for i := 0 to self.count - 1 do
        self.value( i ).Free
      ;

      freeAndNil( _headers );
      
      inherited destroy();
    end
  ;


  procedure TTwoDDoubleArray.assign( const src: TTwoDDoubleArray );
    var
      i: integer;
      v: TQDoubleVector;
    begin
      self._nCols := src._nCols;
      self._nRows := src._nRows;
      self._defaultVal := src._defaultVal;
      self._autoExpand := src._autoExpand;

      freeAndNil( self._headers );

      if( nil <> src._headers ) then
        begin
          self._headers := TStringList.Create();
          self._headers.Assign( src._headers );
        end
      ;

      for i := 0 to _nCols - 1 do
        begin
          v := TQDoubleVector.create( src.col(i) );
          self.add( i, v );
        end
      ;
    end
  ;


  procedure TTwoDDoubleArray.fill( const val: double );
    var
      c: integer;
    begin
      for c := 0 to _nCols -1 do
        ( self.value( c ) as TQDoubleVector ).fill( val )
      ;
    end
  ;


  function TTwoDDoubleArray.createVectorFromRow( const r: integer ): TQDoubleVector;
    var
      v: TQDoubleVector;
      i: integer;
    begin
      v := TQDoubleVector.create();
      v.resize( _nCols );

      for i := 0 to _nCols - 1 do
        v.itemAt[i] := getAt( i, r )
      ;

      result := v;
    end
  ;


  function TTwoDDoubleArray.createArrayFromRow( const r: integer ): TARDoubleArray;
    var
      a: TARDoubleArray;
      i: integer;
    begin
      setLength( a, _nCols );
      for i := 0 to _nCols - 1 do
        a[i] := getAt( i, r )
      ;

      result := a;
    end
  ;


  function TTwoDDoubleArray.createVectorFromColumn( const c: integer ): TQDoubleVector;
    begin
      if( nil = self.value( c ) ) then
        begin
          if( _autoExpand ) then
            getAt( c, 0 ) // This will force the 2D array to be resized
          else
            begin
              raise exception.create( 'Column ' + intToStr( c ) + ' out of bounds in TTwoDDoubleArray.createVectorFromColumn(): dimensions are ' + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) );
              result := nil;
              exit;
            end
          ;
        end
      ;

      result := TQDoubleVector.create( self.value( c ) as TQDoubleVector );
    end
  ;


  function TTwoDDoubleArray.createArrayFromColumn( const c: integer ): TARDoubleArray;
    var
      v: TQDoubleVector;
      i: integer;
      a: TARDoubleArray;
    begin
      if( nil = self.value( c ) ) then
        begin
          if( _autoExpand ) then
            getAt( c, 0 ) // This will force the 2D array to be resized
          else
            begin
              raise exception.create( 'Column ' + intToStr( c ) + ' out of bounds in TTwoDDoubleArray.createVectorFromColumn(): dimensions are ' + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) );
              result := nil;
              exit;
            end
          ;
        end
      ;

      v := self.value( c ) as TQDoubleVector;
      setLength( a, _nRows );
      for i := 0 to v.size - 1 do
        a[i] := v.at( i )
      ;

      result := a;
    end
  ;


  procedure TTwoDDoubleArray.expand( const c, r: integer );
    var
      i, j: integer;
      v: TQDoubleVector;
    begin
      // FIX ME: There may be a memory leak when autoExpand is used.
      // But if there is, I can't find it...
      
      // Add columns by creating new TQDoubleWectors.
      if( c > _nCols ) then
        begin
          //dbcout2( 'Adding columns...' );
          for i := _nCols to c - 1 do
            begin
              v := TQDoubleVector.create();
              v.resize( _nRows );
              v.fill( _defaultVal );
              self.add( i, v );
            end
          ;
          _nCols := c;
        end
      ;

      // Add rows by resizing existing TQDoubleVectors and filling the tails.
      if( r > _nRows ) then
        begin
          //dbcout2( 'Adding rows...' );
          for i := 0 to _nCols - 1 do
            begin
              v := self.value( i ) as TQDoubleVector;
              v.resize( r );
              for j := _nRows to r - 1 do
                v.itemAt[j] := _defaultVal
              ;
            end
          ;
          _nRows := r;
        end
      ;

      //dbcout2( '+++ Dimensions are now ' + intToStr( _nCols ) + ' x ' + intToStr( _nRows ) );
    end
  ;


  function TTwoDDoubleArray.dimensionsOK( const c, r: integer ): boolean;
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
                + ' out of bounds in TTwoDDoubleArray: dimensions are '
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
                + ' out of bounds in TTwoDDoubleArray: dimensions are '
                + intToStr( _nCols ) + ' by ' + intToStr( _nRows )
              );
              result := false;
            end
          ;
        end
      ;
    end
  ;


  procedure TTwoDDoubleArray.setAt( const c, r: integer; const val: double );
    var
      v: TQDoubleVector;
    begin
      if( dimensionsOK( c, r ) ) then
        begin
          v := self.value( c ) as TQDoubleVector;
          v.itemAt[r] := val;
        end
      ;
    end
  ;


  function TTwoDDoubleArray.getAt( const c, r: integer ): double;
    begin
      result := at( c, r );
    end
  ;

  function TTwoDDoubleArray.at( const c, r: integer ): double;
    var
      v: TQDoubleVector;
    begin
      if( dimensionsOK( c, r ) ) then
        begin
          v := self.value( c ) as TQDoubleVector;
          result := v.itemAt[r];
        end
      else
        result := _defaultVal
      ;
    end
  ;


  procedure TTwoDDoubleArray.setCol( const c: integer; const v: TQDoubleVector );
    var
      col: TQDoubleVector;
      i: integer;
    begin
      if( dimensionsOK( c, _nRows - 1 ) ) then
        begin
          col := self.value(c) as TQDoubleVector;
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


  procedure TTwoDDoubleArray.setRow( const r: integer; const v: TQDoubleVector );
    var
      i: integer;
    begin
      if( dimensionsOK( v.size - 1, r ) ) then
        begin
          for i := 0 to v.count - 1 do
            ( self.value(i) as TQDoubleVector )[r] := v[i]
          ;
        end
      ;
    end
  ;


  procedure TTwoDDoubleArray.appendCol( const v: TQDoubleVector );
    var
      newV: TQDoubleVector;
    begin
      inc( _nCols );
      newV := TQDoubleVector.create( v );
      self.add( _nCols - 1, newV );
    end
  ;


  function TTwoDDoubleArray.col( const c: integer ): TQDoubleVector;
    begin
      if( dimensionsOK( c, 0 ) ) then
        result := self.item[c] as TQDoubleVector
      else
        result := nil
      ;
    end
  ;


  function TTwoDDoubleArray.createCol( const c: integer ): TQDoubleVector;
    begin
      if( dimensionsOK( c, 0 ) ) then
        result := TQDoubleVector.create( self.item[c] as TQDoubleVector )
      else
        result := nil
      ;
    end
  ;


  procedure TTwoDDoubleArray.setColHeader( const c: integer; const val: string );
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
                + ' out of bounds in TTwoDDoubleArray.setColHeader(): dimensions are '
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


  procedure TTwoDDoubleArray.setColHeaders( const headers: TStringList );
    begin
      if( headers.Count <> _nCols ) then
        raise exception.Create( 'Wrong number of headers in TTwoDDoubleArray.setColHeaders' )
      else
        begin
          if( nil <> _headers ) then
            begin
              dbcout2( 'Removing old headers in TTwoDDoubleArray.setColHeaders...' );
              freeAndNil( _headers );
            end
          ;

          _headers := TStringList.create();
          _headers.Assign( headers );
        end
      ;
    end
  ;


  procedure TTwoDDoubleArray.addArray( const src: TTwoDDoubleArray );
    var
      i: integer;
    begin
      if( ( src.nCols = self.nCols ) and ( src.nRows = self.nRows ) ) then
        begin
          for i := 0 to self.nCols - 1 do
            ( self.Item[i] as TQDoubleVector ).addVector( src.Item[i] as TQDoubleVector )
        end
      else
        raise exception.Create( 'Bad dimensions in TTwoDDoubleArray.addArray()' )
      ;
    end
  ;


  function TTwoDDoubleArray.asCsv( const useHeaders: boolean = true ): string;
    begin
      result := asDelimitedText( csvListSep(), useHeaders );
    end
  ;


  function TTwoDDoubleArray.asDelimitedText( const delimiter: char; const useHeaders: boolean = true ): string;
    var
      r: TRect;
    begin
      r.Left := 0;
      r.Right := _nCols - 1;
      r.Top := 0;
      r.Bottom := _nRows - 1;

      result := rectAsDelimitedText( r, delimiter, useHeaders );
    end
  ;


  function TTwoDDoubleArray.rectAsDelimitedText( const rect: TRect; const delimiter: char; const useHeaders: boolean = true ): string;
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

      for r := rect.Top to rect.Bottom do
        begin
          str := '';
          for c := rect.Left to rect.right do
            begin
              str := str + uiFloatToStr( getAt( c, r ) );
              if( c < rect.right ) then
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


  procedure TTwoDDoubleArray.debug();
    var
      c, r: integer;
      str: string;
    begin
      dbcout( '---------------TTwoDDoubleArray debug', true );

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
            str := str + uiFloatToStr( self.getAt( c, r ) ) + '  '
          ;
          dbcout( str, true );
        end
      ;

      dbcout( '----------Done TTwoDDoubleArray debug', true );
    end
  ;


  procedure TTwoDDoubleArray.debugTranspose();
    var
      c, r: integer;
      str: string;
    begin
      dbcout( '---------------TTwoDDoubleArray debug (TRANSPOSED)', true );

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
            str := str + uiFloatToStr( self.getAt( c, r ) ) + '  '
          ;
          dbcout( str, true );
        end
      ;

      dbcout( '----------Done TTwoDDoubleArray debug (TRANSPOSED)', true );
    end
  ;


  {$IFDEF DEBUG}
  procedure twoDDoubleArrayUnitTest();
    var
      errMsg: string;
      twoDArr: TTwoDDoubleArray;
      i: integer;
      v, w, x: TQDoubleVector;
    begin
      errMsg := '';

      if( not qIntegerMapsDllLoaded( @errMsg ) ) then
        begin
          dbcout2( 'Double map did not load:' + endl + errMsg );
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
      twoDArr := TTwoDDoubleArray.create( 5, 5, 1, true );
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
      twoDArr := TTwoDDoubleArray.create( 3, 3, 3 );
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
      x := TQDoubleVector.create( w );
      w.debug();
      x.debug();
      w.Free();

      dbcout( 'Do it again for column 0:', true );
      w := twoDArr.createVectorFromColumn( 0 );
      x := TQDoubleVector.create( w );
      w.debug();
      x.debug();
      w.Free();

      dbcout( 'All done!', true );
      freeAndNil( twoDArr );
    end
  ;
  {$ENDIF}


end.


