unit ThreeDDoubleArray;

(*
ThreeDDoubleArray.pas
---------------------
Begin: 2009/02/14
Last revision: $Date: 2011-10-25 05:05:08 $ $Author: areeves $
Version: $Revision: 1.4 $
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
    TwoDDoubleArray
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
  type TThreeDDoubleArray = class( TQIntegerObjectMap )
    protected
      _nCols: integer;  // index 'x'
      _nRows: integer;  // index 'y'
      _nPlanes: integer; // index 'z'
      _defaultVal: double;

      _labels: TStringList;

      function dimensionsOK( const x, y, z: integer ): boolean;

    public
      constructor create( const x, y, z: integer; const defaultVal: double = 0.0 );
      destructor destroy(); override;

      procedure setColHeader( const x: integer; const val: string );
      procedure setColHeaders( const headers: TStringList );

      procedure setLabel( const z: integer; const val: string );
      procedure setLabels( const labels: TStringList );

      procedure fill( const val: double );

      procedure setAt( const x, y, z: integer; const val: double );
      function at( const x, y, z: integer ): double;

      procedure setCol( const x, z: integer; const v: TQDoubleVector );
      // These might be useful some day...
      //procedure setRow( const y, z: integer; const v: TQDoubleVector );
      //procedure setPlane( const z: integer; const v: TTwoDDoubleArray ); overload;
      //procedure setPlane( const x, y: integer; const v: TTwoDDoubleArray ); overload;

      { Returns a pointer to an existing object }
      function zPlane( const z: integer ): TTwoDDoubleArray;

      { Creates a copy of an existing object, with x columns and y rows }
      function createZPlane( const z: integer ): TTwoDDoubleArray;

      { Creates a new object with z columns and y rows }
      function createXPlane( const x: integer ): TTwoDDoubleArray;

      { Creates a new object with z columns and x rows.  FIX ME: This function has NOT been adequately tested. }
      function createYPlane( const y: integer ): TTwoDDoubleArray;
      
      // These might be useful some day.
      // See TwoDDoubleArray for more ideas...
      //procedure col( const x, z: integer ): TQDoubleVector; // Could return a pointer to an existing object
      //procedure row( const x, y: integer ): TQDoubleVector; // Would require creation of a new object

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

  constructor TThreeDDoubleArray.create( const x, y, z: integer; const defaultVal: double = 0.0 );
    var
      i: integer;
      plane: TTwoDDoubleArray;
    begin
      inherited create();

      _nCols := x;
      _nRows := y;
      _nPlanes := z;
      _defaultVal := defaultVal;

      _labels := TStringList.create();

      for i := 0 to _nPlanes - 1 do
        begin
          plane := TTwoDDoubleArray.create( x, y, defaultVal, false );
          self.Add( i, plane );
        end
      ;

    end
  ;


  destructor TThreeDDoubleArray.destroy();
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


  procedure TThreeDDoubleArray.setColHeader( const x: integer; const val: string );
    var
      z: integer;
    begin
      for z := 0 to _nPlanes - 1 do
        ( self.value( z ) as TTwoDDoubleArray ).setColHeader( x, val )
      ;
    end
  ;


  procedure TThreeDDoubleArray.setColHeaders( const headers: TStringList );
    var
      z: integer;
    begin
      if( headers.Count <> _nCols ) then
        raise exception.Create( 'Wrong number of headers in TThreeDDoubleArray.setColHeaders()' )
      else
        begin
          for z := 0 to _nPlanes - 1 do
            ( self.value( z ) as TTwoDDoubleArray ).setColHeaders( headers )
          ;
        end
      ;
    end
  ;


  procedure TThreeDDoubleArray.setLabel( const z: integer; const val: string );
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
            + ' out of bounds in TThreeDDoubleArray.setLabel(): dimensions are '
            + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) + ' by ' + intToStr( _nPlanes )
          );
          exit;
        end
      ;

      _labels.Strings[z] := val;
    end
  ;


  procedure TThreeDDoubleArray.setLabels( const labels: TStringList );
    begin
      if( labels.Count <> _nPlanes ) then
        raise exception.Create( 'Wrong number of headers in TThreeDDoubleArray.setLabels(): ' + intToStr( labels.Count ) + ' labels, ' + intToStr( _nPlanes ) + ' planes' )
      else
        begin
          //freeAndNil( _labels );
          //_labels := TStringList.create();
          _labels.Assign( labels );
        end
      ;
    end
  ;


  function TThreeDDoubleArray.dimensionsOK( const x, y, z: integer ): boolean;
    begin
      result := true;

      // Do we have enough columns?
      if( x >= _nCols ) then
        begin
          raise exception.create(
            'Column index (' + intToStr( x ) + ')'
            + ' out of bounds in TThreeDDoubleArray: dimensions are '
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
            + ' out of bounds in TThreeDDoubleArray: dimensions are '
            + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) + ' by ' + intToStr( _nPlanes )
          );
          result := false;
        end
      ;

      if( z >= _nPlanes ) then
        begin
          raise exception.create(
            'Plane index (' + intToStr( z ) + ')'
            + ' out of bounds in TThreeDDoubleArray: dimensions are '
            + intToStr( _nCols ) + ' by ' + intToStr( _nRows ) + ' by ' + intToStr( _nPlanes )
          );
          result := false;
        end
      ;
    end
  ;

  
  procedure TThreeDDoubleArray.fill( const val: double );
    var
      z: integer;
    begin
      for z := 0 to self.count - 1 do
        ( self.value( z ) as TTwoDDoubleArray ).fill( val )
      ;
    end
  ;
  

  procedure TThreeDDoubleArray.setAt( const x, y, z: integer; const val: double );
    begin
      if( dimensionsOK( x, y, z ) ) then
        ( self.value( z ) as TTwoDDoubleArray ).setAt( x, y, val )
      ;
    end
  ;


  function TThreeDDoubleArray.at( const x, y, z: integer ): double;
    begin
      if( dimensionsOK( x, y, z ) ) then
        result := ( self.value( z ) as TTwoDDoubleArray ).at( x, y )
      else
        result := _defaultVal
      ;
    end
  ;


  procedure TThreeDDoubleArray.setCol( const x, z: integer; const v: TQDoubleVector );
    begin
      if( dimensionsOK( x, 0, z ) ) then
        ( self.value( z ) as TTwoDDoubleArray ).setCol( x, v )
      ;
    end
  ;


  function TThreeDDoubleArray.zPlane( const z: integer ): TTwoDDoubleArray;
    begin
      if( dimensionsOK( 0, 0, z ) ) then
        result := ( self.value( z ) as TTwoDDoubleArray )
      else
        result := nil
      ;
    end
  ;


  function TThreeDDoubleArray.createZPlane( const z: integer ): TTwoDDoubleArray;
    begin
      if( dimensionsOK( 0, 0, z ) ) then
        result := TTwoDDoubleArray.create( (self.value( z ) as TTwoDDoubleArray ) )
      else
        result := nil
      ;
    end
  ;


  function TThreeDDoubleArray.createXPlane( const x: integer ): TTwoDDoubleArray;
    var
      z: integer;
      v: TQDoubleVector;
    begin
      if( dimensionsOK( x, 0, 0 ) ) then
        begin

          result := TTwoDDoubleArray.create( self.zDim, self.yDim, 0.0, false );

          for z := 0 to self.zDim - 1 do
            begin
              v := (self.zPlane(z) as TTwoDDoubleArray).col( x );
              result.setCol( z, v );
            end
          ;

        end
      else
        result := nil
      ;
    end
  ;


  function TThreeDDoubleArray.createYPlane( const y: integer ): TTwoDDoubleArray;
    var
      x, z: integer;
    begin
      if( dimensionsOK( 0, y, 0 ) ) then
        begin

          result := TTwoDDoubleArray.create( self.zDim, self.xDim, 0.0, false );

          for z := 0 to self.zDim - 1 do
            begin
              for x := 0 to self.xDim - 1 do
                result.setAt( z, x, self.at( x, y, z ) )
              ;
            end
          ;

        end
      else
        result := nil
      ;
    end
  ;



  procedure TThreeDDoubleArray.debug();
    var
      z: integer;
      str: string;
    begin
      dbcout( '============================== TThreeDDoubleArray debug', true );

      for z := 0 to _nPlanes - 1 do
        begin
          str := 'PLANE ' + intToStr( z );
          if( nil <> _labels ) then
            str := str + ' (' + _labels.Strings[z] + ')'
          ;
          dbcout( str, true );

          ( self.value( z ) as TTwoDDoubleArray ).debug();

          dbcout( endl, true );
        end
      ;

      dbcout( '============================== Done TThreeDDoubleArray debug', true );
    end
  ;


  procedure TThreeDDoubleArray.debugTranspose();
    var
      z: integer;
      str: string;
    begin
      dbcout( '============================== TThreeDDoubleArray debug', true );

      for z := 0 to _nPlanes - 1 do
        begin
          str := 'PLANE ' + intToStr( z );
          if( nil <> _labels ) then
            str := str + ' (' + _labels.Strings[z] + ')'
          ;
          dbcout( str, true );

          ( self.value( z ) as TTwoDDoubleArray ).debugTranspose();

          dbcout( endl, true );
        end
      ;

      dbcout( '============================== Done TThreeDDoubleArray debug', true );
    end
  ;


end.