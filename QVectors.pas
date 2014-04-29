unit QVectors;

(*
QVectors.pas
-------------
Begin: 2007/01/13
Last revision: $Date: 2012-08-14 19:15:19 $ $Author: areeves $
Version: $Revision: 1.21 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2007 - 2012 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*)


{*
  The QClasses for Delphi collection is a set of useful data structures and
  container classes for the Delphi programming language (see
  http://www.codegear.com/products/delphi). Rather than reimplementing these data
  structures in "pure" Delphi, QClasses provides a set of wrappers for classes
  and functions written in C++ using the excellent Qt toolkit from Trolltech
  (see http://www.trolltech.com/products/qt).  These classes and functions are
  made available via a dynamically loaded library (qclasses.dll) and can be
  used with Delphi applications.

  This unit implements classes similar to Qt QVectors (see
  http://doc.trolltech.com/4.1/qvector.html).  Syntax follows the QVector interface
  as closely as possible: any deviations should be noted in the comments in the
  implementation section.
}


{*
  TODO:
    - Write an "assign" function for each class.
}

interface

  uses
    Classes,

    MyDelphiArrayUtils
  ;

  { If this function returns false, the DLL didn't load and these classes cannot be used. }
  function qVectorsDllLoaded( msg: pstring = nil ): boolean;

//-----------------------------------------------------------------------------
// IntegerVector
//-----------------------------------------------------------------------------
  { A typedef for the C++ vector implementation. }
  type TIntegerVectorHandle = Pointer;

  { The map itself. }
  type TQIntegerVector = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the TQIntegerObjectMap class.
      }
      _h: TIntegerVectorHandle;

      function getCapacity(): integer;
      function getCount(): integer;
      function getIsEmpty(): boolean;

      function getAt( const idx: integer ): integer;
      procedure setAt( const idx: integer; const val: integer );

      function getSum(): integer;

    public
      constructor create(); overload; virtual;
      constructor create( const source: TQIntegerVector ); overload;
      constructor create( const size: integer; const defaultVal: integer = 0 ); overload;

      { Deletes (frees) the vector. }
      destructor destroy(); override;

      procedure append( const val: integer );

      procedure clear();

      procedure assign( const source: TQIntegerVector );

      function contains( const val: integer ): boolean;

      procedure resize( const newSize: integer );

      procedure sort();

      procedure fill( const val: integer );

      function at( const idx: integer ): integer;

      // FIX ME: functions to consider:
      //procedure addVectorVals( const v: TQIntegerVector );
      //procedure subtractVectorVals( const v: TQIntegerVector ); 

      (*
      // FIX ME: more functions to consider.  IMPLEMENT AS SHOWN FOR QDoubleVector: SEE BELOW
      procedure fillRange( const startIdx, endIdx: integer; const val: integer );

      { What is the mean of the first n items in the array (or the whole array, if n= 0)? }
      function mean( const n: integer = 0 ): double;

      { What is the standard deviation of the first n items in the array (or the whole array, if n= 0)? }
      function stDev( const n: integer = 0 ): double;

      { What is the indicated quantile of the first n items in the array (or the whole array, if n= 0)? }
      function quantile( const quant: double; const n: integer = 0 ): double;

      { What is the high value of the first n items in the array (or the whole array, if n= 0)? }
      function low( const n: integer = 0 ): integer;

      { What is the low value of the first n items in the array (or the whole array, if n= 0)? }
      function high( const n: integer = 0 ): integer;
      *)

      { Returns true on success. }
      function writeTextFile( const fileName: string; const appendToExistingFile: boolean = false ): boolean;

      procedure debug();

      property capacity: integer read getCapacity;
      property count: integer read getCount;
      property size: integer read getCount;
      property isEmpty: boolean read getIsEmpty;

      property sum: integer read getSum;

      property itemAt[ const idx: integer ]: integer read getAt write setAt; default;
    end
  ;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// DoubleVector
//-----------------------------------------------------------------------------
  { A typedef for the C++ vector implementation. }
  type TDoubleVectorHandle = Pointer;

  { The map itself. }
  type TQDoubleVector = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the TQDoubleObjectMap class.
      }
      _h: TDoubleVectorHandle;
      _sorted: boolean;

      function getCapacity(): integer;
      function getCount(): integer;
      function getIsEmpty(): boolean;

      function getAt( const idx: integer ): double;
      procedure setAt( const idx: integer; const val: double );

      { Used to do some math with the values in the vector. }
      function indicesOK( var startIdx, endIdx: integer ): boolean;

    public
      constructor create(); overload; virtual;
      constructor create( const source: TQDoubleVector ); overload;
      constructor create( const size: integer; const defaultVal: double = 0.0 ); overload;

      { Deletes (frees) the vector. }
      destructor destroy(); override;

      procedure assign( const source: TQDoubleVector );

      procedure clear();

      function contains( const val: double ): boolean;

      procedure append( const val: double );

      procedure resize( const newSize: integer );

      procedure sort();

      procedure fill( const val: double );

      function at( const idx: integer ): double;

      { Adds values from v to corresponding elements in self. }
      procedure addVector( const v: TQDoubleVector );

      { What is the mean of the specified items in the array (or the whole array, if startIdx = 0 and endIdx = -1)? }
      function mean( startIdx: integer = 0; endIdx: integer = -1 ): double;

      { What is the standard deviation of the first n items in the array (or the whole array, if startIdx = 0 and endIdx = -1)? }
      function stddev( startIdx: integer = 0; endIdx: integer = -1 ): double;

      { What is the indicated quantile of the first n items in the array (or the whole array, if startIdx = 0 and endIdx = -1)? }
      function quantile( const quant: double; startIdx: integer = 0; endIdx: integer = -1 ): double;

      function quantileSorted( const quant: double ): double;

      { What is the high value of the first n items in the array (or the whole array, if startIdx = 0 and endIdx = -1)? }
      function low( startIdx: integer = 0; endIdx: integer = -1 ): double;

      { What is the low value of the first n items in the array (or the whole array, if startIdx = 0 and endIdx = -1)? }
      function high( startIdx: integer = 0; endIdx: integer = -1 ): double;

      { What is the sum of the first n items in the array (or the whole array, if startIdx = 0 and endIdx = -1)? }
      function sum( startIdx: integer = 0; endIdx: integer = -1 ): double;

      (*
      // FIX ME: functions to consider
      procedure fillRange( const startIdx, endIdx: integer; const val: double );
      *)

      {* Create a new Delphi array from the QVector }
      function createDoubleArray(): TARDoubleArray;

      procedure debug();

      { Returns true on success. }
      function writeTextFile( const fileName: string; const appendToExistingFile: boolean = false ): boolean;

      function asColString(): string;
      function asRowString( const delimiter: char ): string;

      property capacity: integer read getCapacity;
      property count: integer read getCount;
      property size: integer read getCount;
      property isEmpty: boolean read getIsEmpty;

      property itemAt[ const idx: integer ]: double read getAt write setAt; default;
      property sorted: boolean read _sorted;
    end
  ;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// BooleanVector
//-----------------------------------------------------------------------------
  { A typedef for the C++ vector implementation. }
  type TBooleanVectorHandle = Pointer;

  { The map itself. }
  type TQBooleanVector = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the TQBooleanObjectMap class.
      }
      _h: TBooleanVectorHandle;

      function getCapacity(): integer;
      function getCount(): integer;
      function getIsEmpty(): boolean;

      function getAt( const idx: integer ): boolean;
      procedure setAt( const idx: integer; const val: boolean );

    public
      constructor create(); overload; virtual;
      constructor create( const source: TQBooleanVector ); overload;

      { Deletes (frees) the vector. }
      destructor destroy(); override;

      procedure assign( const source: TQBooleanVector );

      procedure clear();

      function contains( const val: boolean ): boolean;

      procedure append( const val: boolean );

      procedure resize( const newSize: integer );

      procedure fill( const val: boolean );

      function at( const idx: integer ): boolean;

      (*
      // FIX ME: functions to consider
      procedure fillRange( const startIdx, endIdx: integer; const val: boolean );
      *)

      { Returns true on success. }
      function writeTextFile( const fileName: string; const appendToExistingFile: boolean = false ): boolean;

      procedure debug();

      property capacity: integer read getCapacity;
      property count: integer read getCount;
      property size: integer read getCount;
      property isEmpty: boolean read getIsEmpty;

      property itemAt[ const idx: integer ]: boolean read getAt write setAt; default;
    end
  ;
//-----------------------------------------------------------------------------


implementation

  uses
    Forms, // For Application object
    SysUtils,
    Windows,

    DebugWindow,
    MyStrUtils,
    I88n
  ;

  const
    SHOWDEBUGMSG: boolean = false; // set to true to enable debugging messages for this unit.

  var
    qIntegerVectorLoaded: boolean;
    qDoubleVectorLoaded: boolean;
    qBooleanVectorLoaded: boolean;

    loadErrors: string;

//*****************************************************************************
// Checking the DLL
//*****************************************************************************
  function qVectorsDllLoaded( msg: pstring = nil ): boolean;
    begin
      result := 
        qIntegerVectorLoaded
      and
        qDoubleVectorLoaded
      and
        qBooleanVectorLoaded
      ;

      if( nil <> msg ) then
        msg^ := msg^ + loadErrors
      ;
    end
  ;
//*****************************************************************************



//*****************************************************************************
// IntegerVector
//*****************************************************************************
  //---------------------------------------------------------------------------
  // IntegerVector function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
    var
      // Vector functions
      //------------------
      newIntegerVector: function(): TIntegerVectorHandle; cdecl;
      freeIntegerVector: procedure( const h: TIntegerVectorHandle ); cdecl;

      integerVectorClear: procedure( const h: TIntegerVectorHandle ); cdecl;
      integerVectorContains: function( const h: TIntegerVectorHandle; const val: integer ): boolean; cdecl;
      integerVectorAppend: procedure( const h: TIntegerVectorHandle; const val: integer ); cdecl;
      integerVectorResize: procedure( const h: TIntegerVectorHandle; const newSize: integer ); cdecl;
      integerVectorCapacity: function(  const h: TIntegerVectorHandle ): integer; cdecl;
      integerVectorCount: function( const h: TIntegerVectorHandle ): integer; cdecl;
      integerVectorAt: function( const h: TIntegerVectorHandle; const idx: integer ): integer; cdecl;
      integerVectorSetAt: procedure( const h: TIntegerVectorHandle; const idx: integer; const val: integer ); cdecl;
      integerVectorSort: procedure( const h: TIntegerVectorHandle ); cdecl;
      integerVectorFill: procedure( const h: TIntegerVectorHandle; const val: integer ); cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerVector: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQIntegerVector.create();
      begin
        inherited create();

        if ( qIntegerVectorLoaded ) then
          begin
            _h := newIntegerVector();

            dbcout( 'Internal vector address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal vector address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQIntegerVector.create( const source: TQIntegerVector );
      begin
        inherited create();

        if ( qIntegerVectorLoaded ) then
          begin
            _h := newIntegerVector();

            dbcout( 'Internal vector address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );

            assign( source );
          end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal vector address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQIntegerVector.create( const size: integer; const defaultVal: integer = 0 );
      begin
        inherited create();

        if ( qIntegerVectorLoaded ) then
          begin
            _h := newIntegerVector();

            dbcout( 'Internal vector address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );

            resize( size );
            fill( defaultVal );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal vector address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    destructor TQIntegerVector.destroy();
      begin
        freeIntegerVector( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerVector: Major functions
  //---------------------------------------------------------------------------
    procedure TQIntegerVector.clear();
      begin
        integerVectorClear( _h );
      end
    ;


    procedure TQIntegerVector.assign( const source: TQIntegerVector );
      var
        i: integer;
      begin
        clear();
        for i := 0 to source.size - 1 do
          self.append( source[i] )
        ;
      end
    ;

    function TQIntegerVector.contains( const val: integer ): boolean;
      begin
        result := integerVectorContains( _h, val );
      end
    ;


    procedure TQIntegerVector.append( const val: integer );
      begin
        integerVectorAppend( _h, val );
      end
    ;


    procedure TQIntegerVector.resize( const newSize: integer );
      begin
        integerVectorResize( _h, newSize );
      end
    ;


    function TQIntegerVector.getCapacity(): integer;
      begin
        result := integerVectorCapacity( _h );
      end
    ;


    function TQIntegerVector.getCount(): integer;
      begin
        result := integerVectorCount( _h );
      end
    ;


    function TQIntegerVector.getIsEmpty(): boolean;
      begin
        result := ( 0 = self.count );
      end
    ;


    function TQIntegerVector.getSum(): integer;
      var
        i: integer;
      begin
        result := 0;
        for i := 0 to self.count - 1 do
          result := result + self[i]
        ;
      end
    ;

    
    function TQIntegerVector.getAt( const idx: integer ): integer;
      begin
        if( idx > count - 1 ) then
          raise exception.Create( 'idx out of bounds in TQIntegerVector.getAt' )
        else
          result := integerVectorAt( _h, idx )
        ;
      end
    ;


    procedure TQIntegerVector.setAt( const idx: integer; const val: integer );
      begin
        if( idx > count - 1 ) then
          raise exception.Create( 'idx (' + intToStr( idx ) + ') out of bounds in TQIntegerVector.setAt: vector has size ' + intToStr( size ) )
        else
          integerVectorSetAt( _h, idx, val )
        ;
      end
    ;


    procedure TQIntegerVector.sort();
      begin
        dbcout( 'h is ' + intToStr( cardinal( _h ) ), true );
         
        integerVectorSort( _h );
      end
    ;


    procedure TQIntegerVector.fill( const val: integer );
      begin
        integerVectorFill( _h, val );
      end
    ;


    function TQIntegerVector.at( const idx: integer ): integer;
      begin
        result := getAt( idx );
      end
    ;


    { Returns true on success. }
    function TQIntegerVector.writeTextFile( const fileName: string; const appendToExistingFile: boolean = false ): boolean;
      var
        i: integer;
        f: TextFile;
      begin
        try
          assignFile( f, fileName );
          if( appendToExistingFile ) then
            system.append( f )
          else
            begin
              rewrite( f );
              writeLn( f, tr( 'Values' ) );
            end
          ;

          for i := 0 to self.count - 1 do
            writeLn( f, intToStr( self.at(i) ) )
          ;

          flush( f );
          closeFile( f );
          result := true;
        except
          result := false;
        end;
      end
    ;


    procedure TQIntegerVector.debug();
      var
        i: integer;
      begin
        dbcout( '--- TQIntegerVector.debug', true );
        dbcout( 'Number of elements: ' + intToStr( self.count ), true );
        for i := 0 to self.count - 1 do
          dbcout( self[i], true )
        ;
        dbcout( '--- Done.' + endl, true );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerVector: Loading function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadIntegerVectorDLL( var dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadIODynamicDLL...', true );

        newIntegerVector := GetProcAddress( dllHandle, 'newIntegerVector' );
        if( nil = @newIntegerVector ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newIntegerVector.' + endl;
            result := false;
          end
        ;

        freeIntegerVector := GetProcAddress( dllHandle, 'freeIntegerVector' );
        if( nil = @freeIntegerVector ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: freeIntegerVector.' + endl;
            result := false;
          end
        ;

        integerVectorClear := GetProcAddress( dllHandle, 'integerVectorClear' );
        if( nil = @integerVectorClear ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: integerVectorClear.' + endl;
            result := false;
          end
        ;

        integerVectorContains := GetProcAddress( dllHandle, 'integerVectorContains' );
        if( nil = @integerVectorContains ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: integerVectorContains.' + endl;
            result := false;
          end
        ;

        integerVectorAppend := GetProcAddress( dllHandle, 'integerVectorAppend' );
        if( nil = @integerVectorAppend ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: integerVectorAppend.' + endl;
            result := false;
          end
        ;

        integerVectorResize := GetProcAddress( dllHandle, 'integerVectorResize' );
        if( nil = @integerVectorResize ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: integerVectorResize.' + endl;
            result := false;
          end
        ;

        integerVectorCapacity := GetProcAddress( dllHandle, 'integerVectorCapacity' );
        if( nil = @integerVectorCapacity ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: integerVectorCapacity.' + endl;
            result := false;
          end
        ;

        integerVectorCount := GetProcAddress( dllHandle, 'integerVectorCount' );
        if( nil = @integerVectorCount ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: integerVectorCount.' + endl;
            result := false;
          end
        ;

        integerVectorAt := GetProcAddress( dllHandle, 'integerVectorAt' );
        if( nil = @integerVectorAt ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: integerVectorAt.' + endl;
            result := false;
          end
        ;

        integerVectorSetAt := GetProcAddress( dllHandle, 'integerVectorSetAt' );
        if( nil = @integerVectorSetAt ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: integerVectorSetAt.' + endl;
            result := false;
          end
        ;

        integerVectorSort := GetProcAddress( dllHandle, 'integerVectorSort' );
        if( nil = @integerVectorSort ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: integerVectorSort.' + endl;
            result := false;
          end
        ;

        integerVectorFill := GetProcAddress( dllHandle, 'integerVectorFill' );
        if( nil = @integerVectorFill ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: integerVectorFill.' + endl;
            result := false;
          end
        ;

        qIntegerVectorLoaded := result;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// DoubleVector
//*****************************************************************************
  //---------------------------------------------------------------------------
  // DoubleVector function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
    var
      // Vector functions
      //------------------
      newDoubleVector: function(): TDoubleVectorHandle; cdecl;
      freeDoubleVector: procedure( const h: TDoubleVectorHandle ); cdecl;

      doubleVectorClear: procedure( const h: TDoubleVectorHandle ); cdecl;
      doubleVectorContains: function( const h: TDoubleVectorHandle; const val: double ): boolean; cdecl;
      doubleVectorAppend: procedure( const h: TDoubleVectorHandle; const val: double ); cdecl;
      doubleVectorResize: procedure( const h: TDoubleVectorHandle; const newSize: integer ); cdecl;
      doubleVectorCapacity: function(  const h: TDoubleVectorHandle ): integer; cdecl;
      doubleVectorCount: function( const h: TDoubleVectorHandle ): integer; cdecl;
      doubleVectorAt: function( const h: TDoubleVectorHandle; const idx: integer ): double; cdecl;
      doubleVectorSetAt: procedure( const h: TDoubleVectorHandle; const idx: integer; const val: double ); cdecl;
      doubleVectorSort: procedure( const h: TDoubleVectorHandle ); cdecl;
      doubleVectorFill: procedure( const h: TDoubleVectorHandle; const val: double ); cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // DoubleVector: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQDoubleVector.create();
      begin
        inherited create();

        _sorted := false;

        if ( qDoubleVectorLoaded ) then
          begin
            _h := newDoubleVector();

            dbcout( 'Internal vector address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal vector address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQDoubleVector.create( const source: TQDoubleVector );
      begin
        inherited create();

        if ( qDoubleVectorLoaded ) then
          begin
            _h := newDoubleVector();
            dbcout( 'Internal vector address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
            assign( source );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal vector address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQDoubleVector.create( const size: integer; const defaultVal: double = 0.0 );
      begin
        inherited create();

        _sorted := false;

        if ( qDoubleVectorLoaded ) then
          begin
            _h := newDoubleVector();
            dbcout( 'Internal vector address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
            resize( size );
            fill( defaultVal );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal vector address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;
    

    destructor TQDoubleVector.destroy();
      begin
        freeDoubleVector( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // DoubleVector: Major functions
  //---------------------------------------------------------------------------
    procedure TQDoubleVector.clear();
      begin
        doubleVectorClear( _h );
        _sorted := false;
      end
    ;


    procedure TQDoubleVector.assign( const source: TQDoubleVector );
      var
        i: integer;
      begin
        clear();

        for i := 0 to source.size - 1 do
          self.append( source[i] )
        ;

        _sorted := source._sorted;
      end
    ;


    function TQDoubleVector.contains( const val: double ): boolean;
      begin
        result := doubleVectorContains( _h, val );
      end
    ;


    procedure TQDoubleVector.append( const val: double );
      begin
        doubleVectorAppend( _h, val );
        _sorted := false;
      end
    ;


    procedure TQDoubleVector.resize( const newSize: integer );
      begin
        doubleVectorResize( _h, newSize );
        _sorted := false;
      end
    ;


    function TQDoubleVector.getCapacity(): integer;
      begin
        result := doubleVectorCapacity( _h );
      end
    ;


    function TQDoubleVector.getCount(): integer;
      begin
        result := doubleVectorCount( _h );
      end
    ;


    function TQDoubleVector.getIsEmpty(): boolean;
      begin
        result := ( 0 = self.count );
      end
    ;


    function TQDoubleVector.getAt( const idx: integer ): double;
      begin
        if( idx > count - 1 ) then
          raise exception.Create( 'idx ' + intToStr( idx ) + ' out of bounds in TQDoubleVector.getAt' )
        else
          result := doubleVectorAt( _h, idx )
        ;
      end
    ;


    procedure TQDoubleVector.setAt( const idx: integer; const val: double );
      begin
        if( idx > count - 1 ) then
          raise exception.Create( 'idx out of bounds in TQDoubleVector.setAt(): count = ' + intToStr( count ) + ', idx = ' + intToStr( idx ) )
        else
          doubleVectorSetAt( _h, idx, val )
        ;
        _sorted := false;
      end
    ;


    procedure TQDoubleVector.sort();
      begin
        if( not( _sorted ) ) then
          begin
            doubleVectorSort( _h );
            _sorted := true;
          end
        ;
      end
    ;


    procedure TQDoubleVector.fill( const val: double );
      begin
        doubleVectorFill( _h, val );
        _sorted := false;
      end
    ;


    function TQDoubleVector.at( const idx: integer ): double;
      begin
        result := getAt( idx );
      end
    ;

    
    function TQDoubleVector.createDoubleArray(): TARDoubleArray;
      var
        arr: TARDoubleArray;
        i: integer;
      begin
        setLength( arr, self.count );

        for i := 0 to self.count - 1 do
          arr[i] := self.at( i )
        ;

        result := arr;
      end
    ;


    { Returns true on success. }
    function TQDoubleVector.writeTextFile( const fileName: string; const appendToExistingFile: boolean = false ): boolean;
      var
        i: integer;
        f: TextFile;
      begin
        try
          assignFile( f, fileName );
          if( appendToExistingFile ) then
            system.append( f )
          else
            begin
              rewrite( f );
              writeLn( f, tr( 'Values' ) );
            end
          ;

          for i := 0 to self.count - 1 do
            begin
              writeLn( f, uiFloatToStr( self.at(i), 10 ) );
              Application.processMessages();
            end
          ;

          flush( f );
          closeFile( f );
          result := true;
        except
          result := false;
        end;
      end
    ;


    function TQDoubleVector.asColString(): string;
      var
        i: integer;
      begin
        result := '';
        for i := 0 to self.count - 1 do
          begin
            result := result + uiFloatToStr( self.at(i), 10 ) + endl;
            Application.processMessages();
          end
        ;
      end
    ;


    function TQDoubleVector.asRowString( const delimiter: char ): string;
      var
        i: integer;
      begin
        result := '';
        for i := 0 to self.count - 1 do
          begin
            if( i < self.count - 1 ) then
              result := result + uiFloatToStr( self.at(i), 10 ) + delimiter
            else
              result := result + uiFloatToStr( self.at(i), 10 )
            ;
            Application.processMessages();
          end
        ;
      end
    ;

    procedure TQDoubleVector.debug();
      var
        i: integer;
      begin
        dbcout( '--- TQDoubleVector.debug', true );
        dbcout( 'Number of elements: ' + intToStr( self.count ), true );
        dbcout( 'Sorted: ' + usBoolToText( self.sorted ), true );
        for i := 0 to self.count - 1 do
          dbcout( self[i], true )
        ;
        dbcout( '--- Done.' + endl, true );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // DoubleVector: Math
  //---------------------------------------------------------------------------
  function TQDoubleVector.indicesOK( var startIdx, endIdx: integer ): boolean;
    begin
      if( endIdx = -1 ) then
        endIdx := count - 1
      ;

      if( ( startIdx < 0 ) or ( startIdx > count - 1 ) ) then
        begin
          raise exception.create( 'startIdx ' + intToStr( startIdx ) + ' out of bounds in TQDoubleVector.mean' );
          result := false;
        end
      else if( ( endIdx < 0 ) or ( endIdx > count - 1 ) or ( endIdx < startIdx ) ) then
        begin
          raise exception.create( 'endIdx ' + intToStr( endIdx ) + ' out of bounds in TQDoubleVector.mean' );
          result := false;
        end
      else
        result := true
      ;
    end
  ;


  { What is the standard deviation of the first n items in the array (or the whole array, if startIdx = 0 and endIdx = -1)? }
  function TQDoubleVector.stddev( startIdx: integer = 0; endIdx: integer = -1 ): double;
    var
      i: integer;
      sum: double;
      cnt: integer;
      mean: double;
    begin
      if( endIdx = -1 ) then
        endIdx := count - 1
      ;    
    
      result := 0.0;

      if( indicesOK( startIdx, endIdx ) ) then
        begin
          mean := self.mean( startIdx, endIdx );

          sum := 0.0;               // sum differences from the mean, for greater accuracy
          cnt := 0;
          for i := startIdx to endIdx do
            begin
              sum := sum + sqr( mean - itemAt[i] );
              inc( cnt );
            end
          ;
          result := sqrt( sum / (cnt - 1) );
        end
      ;
    end
  ;


  procedure TQDoubleVector.addVector( const v: TQDoubleVector );
    var
      i: integer;
    begin
      if( self.count <> v.count ) then
        raise exception.Create( 'Adding values from vectors of unequal length in TQDoubleVector.addVector()' )
      else
        begin
          for i := 0 to self.count - 1 do
            self.setAt( i, ( self.at(i) + v.at(i) ) )
          ;
        end
      ;
    end
  ;


  { What is the mean of the specified items in the array (or the whole array, if startIdx = 0 and endIdx = -1)? }
  function TQDoubleVector.mean( startIdx: integer = 0; endIdx: integer = -1 ): double;
    var
      i: integer;
      sum: double;
      cnt: integer;
    begin
      if( endIdx = -1 ) then
        endIdx := count - 1
      ;    
    
      result := 0.0;

      sum := 0.0;
      cnt := 0;
      if( indicesOK( startIdx, endIdx ) ) then
        begin
          for i := startIdx to endIdx do
            begin
              sum := sum + itemAt[i];
              inc( cnt );
            end
          ;

          result := sum / cnt;
        end
      ;
    end
  ;


  function TQDoubleVector.quantile( const quant: double; startIdx: integer = 0; endIdx: integer = -1 ): double;
    var
      v: TQDoubleVector;
      i: integer;
    begin
      if( endIdx = -1 ) then
        endIdx := count - 1
      ;    
    
      result := 0.0;

      if( indicesOK( startIdx, endIdx ) ) then
        begin
          if( ( 0 = startIdx ) and ( count - 1 = endIdx ) and ( sorted ) ) then
            result := self.quantileSorted( quant )
          else
            begin
              v := TQDoubleVector.create();
              for i := startIdx to endIdx do
                v.append( itemAt[i] )
              ;
              v.sort();
              result := v.quantileSorted( quant );
              v.free();
            end
          ;
        end
      ;
    end
  ;


  {
    What is the indicated quantile of the first n items in the array (or the whole array, if startIdx = 0 and endIdx = -1)?
    This function is based on code for the GNU Scientific Library, version 1.6
  }
  function TQDoubleVector.quantileSorted( const quant: double ): double;
    var
      index: double;
      lhs: integer;
      delta: double;
      n: integer;
    begin
      n := count;
      index := quant * ( n - 1 );
      lhs := trunc( index );
      delta := index - lhs;

      if( 0 = n ) then
        result := 0.0
      else if( n - 1 = lhs ) then
        result := itemAt[n-1]
      else
        result := ( 1 - delta ) * itemAt[lhs] + delta * itemAt[lhs + 1]
      ;
    end
  ;


  { What is the high value of the first n items in the array (or the whole array, if startIdx = 0 and endIdx = -1)? }
  function TQDoubleVector.low( startIdx: integer = 0; endIdx: integer = -1 ): double;
    var
      i: integer;
      min: double;
    begin
      if( endIdx = -1 ) then
        endIdx := count - 1
      ;    
    
      result := 0.0;

      if( indicesOK( startIdx, endIdx ) ) then
        begin
          min := itemAt[startIdx];
          for i := startIdx to endIdx do
            begin
              if( min > itemAt[i] ) then
                min := itemAt[i]
              ;
            end
          ;

          result := min;
        end
      ;
    end
  ;

  { What is the low value of the first n items in the array (or the whole array, if if startIdx = 0 and endIdx = -1)? }
  function TQDoubleVector.high( startIdx: integer = 0; endIdx: integer = -1 ): double;
    var
      i: integer;
      max: double;
    begin
      if( endIdx = -1 ) then
        endIdx := count - 1
      ;    
    
      result := 0.0;

      if( indicesOK( startIdx, endIdx ) ) then
        begin
          max := itemAt[startIdx];
          for i := startIdx to endIdx do
            begin
              if( max < itemAt[i] ) then
                max := itemAt[i]
              ;
            end
          ;

          result := max;
        end
      ;
    end
  ;


  function TQDoubleVector.sum( startIdx: integer = 0; endIdx: integer = -1 ): double;
    var
      i: integer;
    begin
      if( endIdx = -1 ) then
        endIdx := count - 1
      ;
      
      result := 0.0;

      if( indicesOK( startIdx, endIdx ) ) then
        begin
          for i := startIdx to endIdx do
            result := result + itemAt[i]
          ;
        end
      ;
    end
  ;

  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // DoubleVector: Loading function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadDoubleVectorDLL( var dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadIODynamicDLL...', true );

        newDoubleVector := GetProcAddress( dllHandle, 'newDoubleVector' );
        if( nil = @newDoubleVector ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newDoubleVector.' + endl;
            result := false;
          end
        ;

        freeDoubleVector := GetProcAddress( dllHandle, 'freeDoubleVector' );
        if( nil = @freeDoubleVector ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: freeDoubleVector.' + endl;
            result := false;
          end
        ;

        doubleVectorClear := GetProcAddress( dllHandle, 'doubleVectorClear' );
        if( nil = @doubleVectorClear ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: doubleVectorClear.' + endl;
            result := false;
          end
        ;

        doubleVectorContains := GetProcAddress( dllHandle, 'doubleVectorContains' );
        if( nil = @doubleVectorContains ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: doubleVectorContains.' + endl;
            result := false;
          end
        ;

        doubleVectorAppend := GetProcAddress( dllHandle, 'doubleVectorAppend' );
        if( nil = @doubleVectorAppend ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: doubleVectorAppend.' + endl;
            result := false;
          end
        ;

        doubleVectorResize := GetProcAddress( dllHandle, 'doubleVectorResize' );
        if( nil = @doubleVectorResize ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: doubleVectorResize.' + endl;
            result := false;
          end
        ;

        doubleVectorCapacity := GetProcAddress( dllHandle, 'doubleVectorCapacity' );
        if( nil = @doubleVectorCapacity ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: doubleVectorCapacity.' + endl;
            result := false;
          end
        ;

        doubleVectorCount := GetProcAddress( dllHandle, 'doubleVectorCount' );
        if( nil = @doubleVectorCount ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: doubleVectorCount.' + endl;
            result := false;
          end
        ;

        doubleVectorAt := GetProcAddress( dllHandle, 'doubleVectorAt' );
        if( nil = @doubleVectorAt ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: doubleVectorAt.' + endl;
            result := false;
          end
        ;

        doubleVectorSetAt := GetProcAddress( dllHandle, 'doubleVectorSetAt' );
        if( nil = @doubleVectorSetAt ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: doubleVectorSetAt.' + endl;
            result := false;
          end
        ;

        doubleVectorSort := GetProcAddress( dllHandle, 'doubleVectorSort' );
        if( nil = @doubleVectorSort ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: doubleVectorSort.' + endl;
            result := false;
          end
        ;

        doubleVectorFill := GetProcAddress( dllHandle, 'doubleVectorFill' );
        if( nil = @doubleVectorFill ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: doubleVectorFill.' + endl;
            result := false;
          end
        ;

        qDoubleVectorLoaded := result;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// BooleanVector
//*****************************************************************************
  //---------------------------------------------------------------------------
  // BooleanVector function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
    var
      // Vector functions
      //------------------
      newBooleanVector: function(): TBooleanVectorHandle; cdecl;
      freeBooleanVector: procedure( const h: TBooleanVectorHandle ); cdecl;

      booleanVectorClear: procedure( const h: TBooleanVectorHandle ); cdecl;
      booleanVectorContains: function( const h: TBooleanVectorHandle; const val: boolean ): boolean; cdecl;
      booleanVectorAppend: procedure( const h: TBooleanVectorHandle; const val: boolean ); cdecl;
      booleanVectorResize: procedure( const h: TBooleanVectorHandle; const newSize: integer ); cdecl;
      booleanVectorCapacity: function(  const h: TBooleanVectorHandle ): integer; cdecl;
      booleanVectorCount: function( const h: TBooleanVectorHandle ): integer; cdecl;
      booleanVectorAt: function( const h: TBooleanVectorHandle; const idx: integer ): boolean; cdecl;
      booleanVectorSetAt: procedure( const h: TBooleanVectorHandle; const idx: integer; const val: boolean ); cdecl;
      booleanVectorFill: procedure( const h: TBooleanVectorHandle; const val: boolean ); cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // BooleanVector: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQBooleanVector.create();
      begin
        inherited create();

        if ( qBooleanVectorLoaded ) then
          begin
            _h := newBooleanVector();

            dbcout( 'Internal vector address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal vector address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQBooleanVector.create( const source: TQBooleanVector );
      begin
        inherited create();

        if ( qBooleanVectorLoaded ) then
          begin
            _h := newBooleanVector();
            dbcout( 'Internal vector address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
            assign( source );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal vector address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    destructor TQBooleanVector.destroy();
      begin
        freeBooleanVector( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // BooleanVector: Major functions
  //---------------------------------------------------------------------------
    procedure TQBooleanVector.assign( const source: TQBooleanVector );
      var
        i: integer;
      begin
        clear();
        for i := 0 to source.size - 1 do
          self.append( source[i] )
        ;
      end
    ;

      
    procedure TQBooleanVector.clear();
      begin
        booleanVectorClear( _h );
      end
    ;


    function TQBooleanVector.contains( const val: boolean ): boolean;
      begin
        result := booleanVectorContains( _h, val );
      end
    ;


    procedure TQBooleanVector.append( const val: boolean );
      begin
        booleanVectorAppend( _h, val );
      end
    ;


    procedure TQBooleanVector.resize( const newSize: integer );
      begin
        booleanVectorResize( _h, newSize );
      end
    ;


    function TQBooleanVector.getCapacity(): integer;
      begin
        result := booleanVectorCapacity( _h );
      end
    ;


    function TQBooleanVector.getCount(): integer;
      begin
        result := booleanVectorCount( _h );
      end
    ;


    function TQBooleanVector.getIsEmpty(): boolean;
      begin
        result := ( 0 = self.count );
      end
    ;


    function TQBooleanVector.getAt( const idx: integer ): boolean;
      begin
        if( idx > count - 1 ) then
          raise exception.Create( 'idx out of bounds in TQBooleanVector.getAt' )
        else
          result := booleanVectorAt( _h, idx )
        ;
      end
    ;


    procedure TQBooleanVector.setAt( const idx: integer; const val: boolean );
      begin
        if( idx > count - 1 ) then
          raise exception.Create( 'idx (' + intToStr( idx ) + ') out of bounds in TQBooleanVector.setAt() (length ' + intToStr( count ) + ')' )
        else
          begin
            //dbcout( 'Setting index ' + intToStr( idx ) + ' of internal vector address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
            booleanVectorSetAt( _h, idx, val );
          end
        ;
      end
    ;


    procedure TQBooleanVector.fill( const val: boolean );
      begin
        booleanVectorFill( _h, val );
      end
    ;


    function TQBooleanVector.at( const idx: integer ): boolean;
      begin
        result := getAt( idx );
      end
    ;


    { Returns true on success. }
    function TQBooleanVector.writeTextFile( const fileName: string; const appendToExistingFile: boolean = false ): boolean;
      var
        i: integer;
        f: TextFile;
      begin
        try
          assignFile( f, fileName );
          if( appendToExistingFile ) then
            system.append( f )
          else
            begin
              rewrite( f );
              writeLn( f, tr( 'Values' ) );
            end
          ;

          for i := 0 to self.count - 1 do
            writeLn( f, boolToStr( self.at(i) ) )
          ;

          flush( f );
          closeFile( f );
          result := true;
        except
          result := false;
        end;
      end
    ;


    procedure TQBooleanVector.debug();
      var
        i: integer;
      begin
        dbcout( '--- TQBooleanVector.debug', true );
        dbcout( 'Number of elements: ' + intToStr( self.count ), true );
        for i := 0 to self.count - 1 do
          dbcout( self[i], true )
        ;
        dbcout( '--- Done.' + endl, true );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // BooleanVector: Loading function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadBooleanVectorDLL( var dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadIODynamicDLL...', true );

        newBooleanVector := GetProcAddress( dllHandle, 'newBooleanVector' );
        if( nil = @newBooleanVector ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newBooleanVector.' + endl;
            result := false;
          end
        ;

        freeBooleanVector := GetProcAddress( dllHandle, 'freeBooleanVector' );
        if( nil = @freeBooleanVector ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: freeBooleanVector.' + endl;
            result := false;
          end
        ;

        booleanVectorClear := GetProcAddress( dllHandle, 'booleanVectorClear' );
        if( nil = @booleanVectorClear ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: booleanVectorClear.' + endl;
            result := false;
          end
        ;

        booleanVectorContains := GetProcAddress( dllHandle, 'booleanVectorContains' );
        if( nil = @booleanVectorContains ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: booleanVectorContains.' + endl;
            result := false;
          end
        ;

        booleanVectorAppend := GetProcAddress( dllHandle, 'booleanVectorAppend' );
        if( nil = @booleanVectorAppend ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: booleanVectorAppend.' + endl;
            result := false;
          end
        ;

        booleanVectorResize := GetProcAddress( dllHandle, 'booleanVectorResize' );
        if( nil = @booleanVectorResize ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: booleanVectorResize.' + endl;
            result := false;
          end
        ;

        booleanVectorCapacity := GetProcAddress( dllHandle, 'booleanVectorCapacity' );
        if( nil = @booleanVectorCapacity ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: booleanVectorCapacity.' + endl;
            result := false;
          end
        ;

        booleanVectorCount := GetProcAddress( dllHandle, 'booleanVectorCount' );
        if( nil = @booleanVectorCount ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: booleanVectorCount.' + endl;
            result := false;
          end
        ;

        booleanVectorAt := GetProcAddress( dllHandle, 'booleanVectorAt' );
        if( nil = @booleanVectorAt ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: booleanVectorAt.' + endl;
            result := false;
          end
        ;

        booleanVectorSetAt := GetProcAddress( dllHandle, 'booleanVectorSetAt' );
        if( nil = @booleanVectorSetAt ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: booleanVectorSetAt.' + endl;
            result := false;
          end
        ;

        booleanVectorFill := GetProcAddress( dllHandle, 'booleanVectorFill' );
        if( nil = @booleanVectorFill ) then
          begin
            loadErrors := loadErrors +  'MISSING FUNCTION: booleanVectorFill.' + endl;
            result := false;
          end
        ;

        qBooleanVectorLoaded := result;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// DLL Loading
//*****************************************************************************
  // Dynamic loading takes more code than static loading,
  // but it is far more graceful when it doesn't work.
  procedure loadDynamicDLL();
     var
      dllHandle: THandle; //Handle used to open the DLL.  Defined in unit Windows.
    begin
      try
        dllHandle := loadLibrary( 'qclasses.dll' );
        dbcout( 'loadLibrary qclasses.dll successful.', SHOWDEBUGMSG );
      except
        dllHandle := 0;
        dbcout( 'loadLibrary qclasses.dll failed.', SHOWDEBUGMSG );
      end;

      if( dllHandle >= 32 ) then // library was successfully loaded.  Assign function pointers now.
        begin
          loadIntegerVectorDLL( dllHandle );
          loadDoubleVectorDLL( dllHandle );
          loadBooleanVectorDLL( dllHandle );
        end
      ;
    end
  ;
//*****************************************************************************

initialization

  loadErrors := '';

  qIntegerVectorLoaded := false;
  qDoubleVectorLoaded := false;
  qBooleanVectorLoaded := false;

  loadDynamicDLL();

end.
