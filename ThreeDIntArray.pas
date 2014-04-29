unit ThreeDIntArray;

(*
ThreeDIntArray.pas
----------------
Begin: 2009/02/14
Last revision: $Date: 2011-10-25 05:05:08 $ $Author: areeves $
Version: $Revision: 1.2 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <Aaron.Reeves@colostate.edu>
------------------------------------------------------
Copyright (C) 2009 Animal Population Health Institute, Colorado State University

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*)

interface

  uses
    // Standard Delphi units
    Classes,

    // QClasses for Delphi
    QIntegerMaps,
    QVectors,
    TwoDIntArray
  ;

  {*
    Each 'plane' (z-level) in a 3D array is a 2D array.
    
    The assumption is that every value in the array will be filled in.  If only a few
    values will be filled, a much more memory-efficient data structure could be devised.
  }

  (*
    FIX ME:
    - All functions should check that the indices (x, y, and z) are not negative numbers. Consider making them unsigned integers.
    - Consider adding auto-expand capability, similar to TwoDIntArray.
  *)
  type TThreeDIntArray = class( TQIntegerObjectMap )
    protected
      _nCols: integer;  // index 'x'
      _nRows: integer;  // index 'y'
      _nPlanes: integer; // index 'z'
      _defaultVal: integer;

      _labels: TStringList;

      function dimensionsOK( const x, y, z: integer ): boolean;

    public
      constructor create( const x, y, z: integer; const defaultVal: integer = 0 );
      destructor destroy(); override;

      procedure setColHeader( const x: integer; const val: string );
      procedure setColHeaders( const headers: TStringList );

      procedure setLabel( const z: integer; const val: string );
      procedure setLabels( const labels: TStringList );

      procedure fill( const val: integer );

      procedure setAt( const x, y, z, val: integer );
      function at( const x, y, z: integer ): integer;

      procedure setCol( const x, z: integer; const v: TQIntegerVector );

      procedure debug();
      procedure debugTranspose();

      property nCols: integer read _nCols;
      property nRows: integer read _nRows;
      property nPlanes: integer read _nPlanes;

      property xDim: integer read _nCols;
      property yDim: integer read _nRows;
      property zDim: integer read _nPlanes;
    end
  ;

implementation

  uses
    // Standard Delphi units
    SysUtils,

    // APHI General-Purpose Delphi Library
    DebugWindow,
    MyStrUtils
  ;

  constructor TThreeDIntArray.create( const x, y, z: integer; const defaultVal: integer = 0 );
    var
      i: integer;
      plane: TTwoDIntArray;
    begin
      inherited create();

      _nCols := x;
      _nRows := y;
      _nPlanes := z;
      _defaultVal := defaultVal;

      _labels := nil;

      for i := 0 to _nPlanes - 1 do
        begin
          plane := TTwoDIntArray.create( x, y, defaultVal, false );
          self.Add( i, plane );
        end
      ;

    end
  ;


  destructor TThreeDIntArray.destroy();
    var
      z: integer;
    begin
      for z := 0 to _nPlanes - 1 do
        self.value( z ).free()
      ;

      freeAndNil( _labels );

      inherited destroy()
    end
  ;


  procedure TThreeDIntArray.setColHeader( const x: integer; const val: string );
    var
      z: integer;
    begin
      for z := 0 to _nPlanes - 1 do
        ( self.value( z ) as TTwoDIntArray ).setColHeader( x, val )
      ;
    end
  ;


  procedure TThreeDIntArray.setColHeaders( const headers: TStringList );
    var
      z: integer;
    begin
      if( headers.Count <> _nCols ) then
        raise exception.Create( 'Wrong number of headers in TThreeDIntArray.setColHeaders()' )
      else
        begin
          for z := 0 to _nPlanes - 1 do
            ( self.value( z ) as TTwoDIntArray ).setColHeaders( headers )
          ;
        end
      ;
    end
  ;


  procedure TThreeDIntArray.setLabel( const z: integer; const val: string );
    var
      i: integer;
    begin
      // Has _labels already been set?
      if( nil = _labels ) then
        begin
          _labels := TStringList.Create();
          for i := 0 to _nCols - 1 do
            _labels.Append( 'Plane_' + intToStr( i ) )
          ;
        end
      ;

      // Do we have enough planes?
      if( z >= _nPlanes ) then
        begin
          raise exception.create(
            'Plane index (' + intToStr( z ) + ')'
            + ' out of bounds in TThreeDIntArray.setLabel(): dimensions are '
            + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) + ' by ' + intToStr( _nPlanes )
          );
          exit;
        end
      ;

      _labels.Strings[z] := val;
    end
  ;


  procedure TThreeDIntArray.setLabels( const labels: TStringList );
    begin
      if( labels.Count <> _nPlanes ) then
        raise exception.Create( 'Wrong number of headers in TThreeDIntArray.setLabels()' )
      else
        begin
          freeAndNil( _labels );
          _labels := TStringList.create();
          _labels.Assign( labels );
        end
      ;
    end
  ;


  function TThreeDIntArray.dimensionsOK( const x, y, z: integer ): boolean;
    begin
      result := true;

      // Do we have enough columns?
      if( x >= _nCols ) then
        begin
          raise exception.create(
            'Column index (' + intToStr( x ) + ')'
            + ' out of bounds in TThreeDIntArray: dimensions are '
            + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) + ' by ' + intToStr( _nPlanes )
          );
          result := false;
        end
      ;

      // Do we have enough rows?
      if( y >= _nRows ) then
        begin
          raise exception.create(
            'Row index (' + intToStr( y ) + ')'
            + ' out of bounds in TThreeDIntArray: dimensions are '
            + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) + ' by ' + intToStr( _nPlanes )
          );
          result := false;
        end
      ;

      if( z >= _nPlanes ) then
        begin
          raise exception.create(
            'Plane index (' + intToStr( z ) + ')'
            + ' out of bounds in TThreeDIntArray: dimensions are '
            + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) + ' by ' + intToStr( _nPlanes )
          );
          result := false;
        end
      ;
    end
  ;

  
  procedure TThreeDIntArray.fill( const val: integer );
    var
      z: integer;
    begin
      for z := 0 to self.count - 1 do
        ( self.value( z ) as TTwoDIntArray ).fill( val )
      ;
    end
  ;
  

  procedure TThreeDIntArray.setAt( const x, y, z, val: integer );
    begin
      if( dimensionsOK( x, y, z ) ) then
        ( self.value( z ) as TTwoDIntArray ).setAt( x, y, val )
      ;
    end
  ;


  function TThreeDIntArray.at( const x, y, z: integer ): integer;
    begin
      if( dimensionsOK( x, y, z ) ) then
        result := ( self.value( z ) as TTwoDIntArray ).at( x, y )
      else
        result := _defaultVal
      ;
    end
  ;


  procedure TThreeDIntArray.setCol( const x, z: integer; const v: TQIntegerVector );
    begin
      if( dimensionsOK( x, 0, z ) ) then
        ( self.value( z ) as TTwoDIntArray ).setCol( x, v )
      ;
    end
  ;


  procedure TThreeDIntArray.debug();
    var
      z: integer;
      str: string;
    begin
      dbcout( '============================== TThreeDIntArray debug', true );

      for z := 0 to _nPlanes - 1 do
        begin
          str := 'PLANE ' + intToStr( z );
          if( nil <> _labels ) then
            str := str + ' (' + _labels.Strings[z] + ')'
          ;
          dbcout( str, true );

          ( self.value( z ) as TTwoDIntArray ).debug();

          dbcout( endl, true );
        end
      ;

      dbcout( '============================== Done TThreeDIntArray debug', true );
    end
  ;


  procedure TThreeDIntArray.debugTranspose();
    var
      z: integer;
      str: string;
    begin
      dbcout( '============================== TThreeDIntArray debug', true );

      for z := 0 to _nPlanes - 1 do
        begin
          str := 'PLANE ' + intToStr( z );
          if( nil <> _labels ) then
            str := str + ' (' + _labels.Strings[z] + ')'
          ;
          dbcout( str, true );

          ( self.value( z ) as TTwoDIntArray ).debugTranspose();

          dbcout( endl, true );
        end
      ;

      dbcout( '============================== Done TThreeDIntArray debug', true );
    end
  ;


end.