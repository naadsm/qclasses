unit QStringMaps;

(*
QStringMaps.pas
---------------
Begin: 2006/11/28
Last revision: $Date: 2011-10-29 00:32:26 $ $Author: areeves $
Version: $Revision: 1.17 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
Author: Shaun Case <Shaun.Case@colostate.edu>
------------------------------------------------------
Copyright (C) 2006 - 2007 Aaron Reeves

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

  This unit implements classes similar to Qt QMaps (see
  http://doc.trolltech.com/4.1/qmap.html) that use string keys.
  Syntax follows the QMap interface as closely as possible:
  any deviations should be noted in the comments in the implementation section.
}


interface

  uses
    Classes,
    Variants
  ;

  { If this function returns false, the DLL didn't load and these classes cannot be used. }
  function qStringMapsDllLoaded( msg: pstring = nil ): boolean;

//-----------------------------------------------------------------------------
// StringObjectMap
//-----------------------------------------------------------------------------
  { A typedef for the C++ map implementation. }
  type TStringObjectMapHandle = Pointer;

  { A typedef for the objects that will be values in the map. }
  type TObjectHandle = Pointer;

  { The map itself. }
  type TQStringObjectMap = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the class.
      }
      _h: TStringObjectMapHandle;

      // Properties
      //-----------
      { Is the map empty? }
      function getIsEmpty(): boolean;

      { How many objects are in the map? }
      function getSize(): integer;

    public
      // Construction/destruction
      //-------------------------
      constructor create(); overload; virtual;
      constructor create( const source: TQStringObjectMap ); overload;

      { Deletes (frees) the map.  Objects stored as values in the map are NOT deleted. }
      destructor destroy(); override;

      // Useful functions
      //------------------
      { Copys an existing map.  THIS FUNCTION SHOULD BE OVERRIDDEN TO ACTUALLY DO ANYTHING USEFUL. }
      procedure assign( Source: TObject ); virtual;

      { Inserts a new value into the map, with the specified key. }
      procedure insert( const key: string; const val: TObject );
      procedure Add(const key: string; const val: TObject );

      { Retrieves a value from the map based on the specified key. }
      function value( const key: string ): TObject; virtual;

      { WARNING: these functions will NOT return the keys/values in the original insertion order!! }
      function keyAtIndex( idx: integer ): string;
      function itemAtIndex( idx: integer ): TObject;

      { Retrieves the first value in the map. }
      function first(): TObject;

      { Removes a value from the map based on the key. }
      function remove( const key: string ): integer;

      { Does the map contain a value with the specified key? }
      function contains( const key: string ): boolean;

      { What is the key associated with the specified value? }
      function key( const val: TObject ): string;

      { Removes all values from the map.  Objects stored in the map are NOT freed. }
      procedure clear();

      { Removes all values from the map, AND frees (deletes) them. }
      procedure deleteValues();

      procedure rename( const oldName, newName: string );

      procedure delete( const key: string );

      procedure debug();

      // Properties
      //-----------
      { Is the map empty? }
      property isEmpty: boolean read getIsEmpty;

      { How many objects are in the map? }
      property size: integer read getSize;

      { Synonym for size. }
      property count: integer read getSize;

      property  Item[const Key: String]: TObject read value write insert; default;

      { WARNING: These properties will NOT return the keys/values in the original insertion order!! }
      //property  values[idx: integer]: TObject read GetItemByIndex;
      //property  keys[idx: integer]: String read GetKeyByIndex;

      // Testing/debugging
      //------------------
      { Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used. }
      procedure test();
    end
  ;


  { An iterator for StringObjectMap }
  type TQStringObjectMapIterator = class
    protected
      _idx: integer;
      _map: TQStringObjectMap;

    public
      constructor create( const map: TQStringObjectMap );

      function key(): string;
      function value(): TObject;

      procedure incr();
      procedure decr();
    end
  ;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// QStringLongIntMap
//-----------------------------------------------------------------------------
  { A typedef for the C++ map implementation. }
  type TLongIntMapHandle = Pointer;

  { The map itself. }
  type TQStringLongIntMap = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the class.
      }
      _h: TLongIntMapHandle;

      // Properties
      //-----------
      { Is the map empty? }
      function getIsEmpty(): boolean;

      { How many objects are in the map? }
      function getSize(): integer;

    public
      constructor create(); overload; virtual;
      constructor create( const source: TQStringLongIntMap ); overload;

      { Deletes (frees) the map.  Objects stored as values in the map are NOT deleted. }
      destructor destroy(); override;

      // Useful functions
      //------------------
      procedure assign( Source: TQStringLongIntMap );

      { Inserts a new value into the map, with the specified key. }
      procedure insert( const key: string; const val: LongInt );
      procedure Add( const key: string; const val: LongInt );

      { Retrieves a value from the map based on the specified key. }
      function value( const key: string ): LongInt; virtual;

      { WARNING: these functions will NOT return the keys/values in the original insertion order!! }
      function keyAtIndex( idx: integer ): string;
      function itemAtIndex( idx: integer ): LongInt;

      { Retrieves the first value in the map. }
      function first(): LongInt;

      { Removes a value from the map based on the key. }
      function remove( const key: string ): integer;

      { Does the map contain a value with the specified key? }
      function contains( const key: string ): boolean;
      function qHasKey( const key: string ): boolean;
      function HasKey( const key: string ): boolean;

      { What is the key associated with the specified value? }
      function key( const val: integer ): string;

      { Removes all values from the map.  Objects stored in the map are NOT freed. }
      procedure clear();

      { Removes all values from the map, AND frees (deletes) them. }
      procedure deleteValues();

      procedure rename( const oldName, newName: string );

      procedure delete( const key: string );

      procedure debug();

      // Properties
      //-----------
      { Is the map empty? }
      property isEmpty: boolean read getIsEmpty;

      { How many objects are in the map? }
      property size: integer read getSize;

      { Synonym for size. }
      property count: integer read getSize;

      property  Item[const Key: String]: LongInt read value write insert; default;

      // Testing/debugging
      //------------------
      { Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used. }
      procedure test();
    end
  ;


  { An iterator for the map. }
  type TQStringLongIntMapIterator = class
    protected
      _idx: integer;
      _map: TQStringLongIntMap;

    public
      constructor create( const map: TQStringLongIntMap );

      function key(): string;
      function value(): LongInt;
      function Done(): Boolean;
      function isEmpty(): Boolean;

      procedure incr();
      procedure decr();
    end
  ;

  type TQStringIntMap = class( TQStringLongIntMap ) end;
  type TQStringIntMapIterator = class( TQStringLongIntMapIterator ) end;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// StringStringMap
//-----------------------------------------------------------------------------
  { A typedef for the C++ map implementation. }
  type TStringMapHandle = Pointer;

  { The map itself. }
  type TQStringStringMap = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the class.
      }
      _h: TStringMapHandle;

      // Properties
      //-----------
      { Is the map empty? }
      function getIsEmpty(): boolean;

      { How many objects are in the map? }
      function getSize(): integer;

    public
      constructor create(); overload;  virtual;
      constructor create( const source: TQStringStringMap ); overload;


      { Deletes (frees) the map.  Objects stored as values in the map are NOT deleted. }
      destructor destroy(); override;

      // Useful functions
      //------------------
      procedure assign( Source: TQStringStringMap );

      { Inserts a new value into the map, with the specified key. }
      procedure insert( const key: string; const val: String );
      procedure Add( const key: string; const val: String );

      { Retrieves a value from the map based on the specified key. }
      function value( const key: string ): String; virtual;

      { WARNING: these functions will NOT return the keys/values in the original insertion order!! }
      function GetKeyByIndex( index: integer ):String;
      function GetItemByIndex( index: integer ):String;
      function keyAtIndex( idx: integer ): string;
      function itemAtIndex( idx: integer ): string;


      { Retrieves the first value in the map. }
      function first(): String;

      { Removes a value from the map based on the key. }
      function remove( const key: string ): integer;

      { Does the map contain a value with the specified key? }
      function contains( const key: string ): boolean;
      function qHasKey( const key: string ): boolean;
      function HasKey( const key: string ): boolean;

      { What is the key associated with the specified value? }
      function key( const val: string ): string;

      { Removes all values from the map.  Objects stored in the map are NOT freed. }
      procedure clear();

      { Removes all values from the map, AND frees (deletes) them. }
      procedure deleteValues();

      procedure rename( const oldName, newName: string );

      procedure delete( const key: string );

      procedure debug();

      // Properties
      //-----------
      { Is the map empty? }
      property isEmpty: boolean read getIsEmpty;

      { How many objects are in the map? }
      property size: integer read getSize;

      { Synonym for size. }
      property count: integer read getSize;

      property  Item[const Key: String]: String read value write insert; default;

      // Testing/debugging
      //------------------
      { Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used. }
      procedure test();
    end
  ;


  { An iterator for the map. }
  type TQStringStringMapIterator = class
    protected
      _idx: integer;
      _map: TQStringStringMap;

    public
      constructor create( const map: TQStringStringMap );

      function key(): string;
      function value(): String;
      function Done(): Boolean;
      function isEmpty(): Boolean;

      procedure incr();
      procedure decr();
    end
  ;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// StringVariantMap
//
// NOTE: unlike other classes in this file, TQStringVariantMap does not
// directly use the qClasses DLL.  This class is implemented primarily in
// Delphi, but uses a TQStringIntMap to lend a hand.
//-----------------------------------------------------------------------------
  type TQStringVariantMap = class
    protected
      _variants: array of variant;
      _map: TQStringIntMap;

      function getIsEmpty(): boolean;
      function getSize(): integer;

    public
      constructor create();
      destructor destroy(); override;

      { Inserts a new value into the map, with the specified key. }
      procedure insert( const key: string; const val: variant );

      { Retrieves a value from the map based on the specified key. }
      function value( const key: string ): variant;

      { WARNING: these functions will NOT return the keys/values in the original insertion order!! }
      function keyAtIndex( idx: integer ): string;
      function itemAtIndex( idx: integer ): variant;

      { Retrieves the first value in the map. }
      function first(): variant;

      { Removes a value from the map based on the key. }
      function remove( const key: string ): integer;

      { Does the map contain a value with the specified key? }
      function contains( const key: string ): boolean;

      { What is the key associated with the specified value? }
      function key( const val: variant ): string;

      { Removes all values from the map.  Objects stored in the map are NOT freed. }
      procedure clear();

      procedure rename( const oldName, newName: string );

      procedure delete( const key: string );

      procedure debug();

      // Properties
      //-----------
      { Is the map empty? }
      property isEmpty: boolean read getIsEmpty;

      { How many objects are in the map? }
      property size: integer read getSize;

      { Synonym for size. }
      property count: integer read getSize;

      property  Item[const Key: String]: variant read value write insert; default;
    end
  ;
//-----------------------------------------------------------------------------


implementation

  uses
    Windows,
    SysUtils,

    MyStrUtils,
    DebugWindow,

    QClassesDebugging
  ;

  const
    SHOWDEBUGMSG: boolean = false; // set to true to enable debugging messages for this unit.

  var
    qStringObjectMapLoaded: boolean;
    qStringLongIntMapLoaded: boolean;
    qStringStringMapLoaded: boolean;

    qStringMapsDllLoadError: string;

//*****************************************************************************
// Checking the DLL
//*****************************************************************************
  function qStringMapsDllLoaded( msg: pstring = nil ): boolean;
    begin
      result :=
        qStringObjectMapLoaded
      and
        qStringLongIntMapLoaded
      and
        qStringStringMapLoaded
      ;

      if( nil <> msg ) then
        msg^ := msg^ + qStringMapsDllLoadError
      ;
    end
  ;
//*****************************************************************************



//*****************************************************************************
// StringObjectMap
//*****************************************************************************
  //---------------------------------------------------------------------------
  // StringObjectMapMap function pointers, loaded from qclasses.dll
  //---------------------------------------------------------------------------
    var
      // Map functions for StringObjectMap
      //----------------------------------
      newStringObjectMap: function(): TStringObjectMapHandle; cdecl;
      freeStringObjectMap: procedure( h: TStringObjectMapHandle ); cdecl;

      stringObjectMapInsert: procedure( h: TStringObjectMapHandle; key: string; val: TObject ); cdecl;
      stringObjectMapValue: function( h: TStringObjectMapHandle; key: string ): TObject; cdecl;
      stringObjectMapItemAtIndex: function( h: TStringObjectMapHandle; idx: integer): TObject; cdecl;
      stringObjectMapKeyAtIndex: function( h: TStringObjectMapHandle; idx: integer): pchar; cdecl;
      stringObjectMapBegin: function( h: TStringObjectMapHandle ): TObject; cdecl;
      stringObjectMapRemoveFirst: function( h: TStringObjectMapHandle ): TObject; cdecl;

      stringObjectMapKey: function( h: TStringObjectMapHandle; val: TObject ): pchar; cdecl;

      stringObjectMapRemove: function( h: TStringObjectMapHandle; key: string ): integer; cdecl;
      stringObjectMapContains: function( h: TStringObjectMapHandle; key: string ): boolean; cdecl;
      stringObjectMapClear: procedure( h: TStringObjectMapHandle ); cdecl;

      stringObjectMapIsEmpty: function( h: TStringObjectMapHandle ): boolean; cdecl;
      stringObjectMapSize: function( h: TStringObjectMapHandle ): integer; cdecl;

      stringObjectMapTest: procedure( h: TStringObjectMapHandle ); cdecl;

      // Map iterator functions for StringObjectMap
      //-------------------------------------------
      stringObjectMapIteratorKey: procedure( const h: TStringObjectMapHandle; const idx: integer; buf: pchar ); cdecl;
      stringObjectMapIteratorValue: function( const h: TStringObjectMapHandle; const idx: integer ): TObject; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringObjectMapMap: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQStringObjectMap.create();
      begin
        inherited create();

        if ( qStringObjectMapLoaded ) then
          begin
            _h := newStringObjectMap();

            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!', SHOWDEBUGMSG );
          end;
      end
    ;


    constructor TQStringObjectMap.create( const source: TQStringObjectMap );
      begin
        inherited create();

        if ( qStringObjectMapLoaded ) then
          begin
            _h := newStringObjectMap();

            self.assign( source );
            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
          end
        else
          begin
            _h := nil;
            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!', SHOWDEBUGMSG );
          end;
      end
    ;


    {*
      Deletes (frees) the map.  Objects stored as values in the map are not deleted.
      To delete the objects in the map, use deleteValues() first.
    }
    destructor TQStringObjectMap.destroy();
      begin
        freeStringObjectMap( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringObjectMap: Useful functions
  //---------------------------------------------------------------------------
    {*
      Copys an existing map.  THIS FUNCTION SHOULD BE OVERRIDDEN TO ACTUALLY DO
      ANYTHING USEFUL.

      The code below gives an example, but for a map containing any real
      objects, "TPersistent.create()" should be replaced with the constructor
      for the class of objects that will be stored in the map. See the class
      TFruitMap and the procedure TForm1.btnCopyClick() in the demo application
      for a working implementation.
    }
    procedure TQStringObjectMap.assign( Source: TObject );
      var
        src: TQStringObjectMap;
        it: TQStringObjectMapIterator;
        newObj: TObject;
      begin
        // If this exception is raised, the programmer forgot to read the comment above.
        raise exception.Create( 'The "virtual abstract" function TQStringObjectMap.assign() has been called.' );

        src := source as TQStringObjectMap;
        it := TQStringObjectMapIterator.create( src );

        repeat
          if( nil <> it.value() ) then
            begin
              newObj := TObject.Create();
              //newObj.Assign( it.value() );
              self.insert( it.key(), newObj );
            end
          ;

          it.incr();
        until ( nil = it.value() );

        it.Free();
      end
    ;


    {*
      Inserts a new value into the map, with the specified key.  In Qt's QMap, insert()
      returns an iterator that contains the newly inserted object.  Here, insert()
      has no return value.
    }
    procedure TQStringObjectMap.insert( const key: string; const val: TObject );
      var
        tKey:string;
      begin
        tKey := trim( key );
        stringObjectMapInsert( _h, pchar( tKey ), val );
      end
    ;


    procedure TQStringObjectMap.Add(const key: string; const val: TObject );
      begin
        insert( key, val );
      end
    ;


    function TQStringObjectMap.value( const key: string ): TObject;
      var
        tKey:string;
      begin
        tKey := trim( key );
        result := stringObjectMapValue( _h, pchar( tkey ) );
      end
    ;


    function TQStringObjectMap.keyAtIndex( idx: integer ): string;
      begin
        result := String( stringObjectMapKeyAtIndex( _h, idx ) );
      end
    ;


    function TQStringObjectMap.itemAtIndex( idx: integer ): TObject;
      begin
        result := stringObjectMapItemAtIndex( _h, idx );
      end
    ;


    {*
      Returns the first object in the map.  Renamed from begin() in QMap because
      "begin" is a reserved word in Delphi.  in QMap, begin() returns an iterator.
      Because iterators have not been fully reimplemented here, first() returns
      the object that is the first value in the map.  The key associated with this
      value is not available (although it could be stored in a char buffer, if
      needed).

      Returns nil if the map is empty.
    }
    function TQStringObjectMap.first(): TObject;
      begin
        if( self.isEmpty ) then
          result := nil
        else
          result := stringObjectMapBegin( _h )
        ;
      end
    ;


    {*
      Removes a value from the map based on the key.  In Qt's QMap, remove() returns
      the number of values removed, which may be more than one if insertMulti() is allowed.
      Since insertMulti() is not (yet?) implemented here, remove() will return a maximum of 1.
    }
    function TQStringObjectMap.remove( const key: string ): integer;
      var
       tKey:String;
      begin
        tKey := trim( key );
        result := stringObjectMapRemove( _h, pchar( tKey ) );
      end
    ;


    function TQStringObjectMap.contains( const key: string ): boolean;
      var
        tKey:String;
      begin
        tKey := trim( key );
        result := stringObjectMapContains( _h, pchar( tKey ) );
      end
    ;
    

    function TQStringObjectMap.key( const val: TObject ): string;
      begin
        result := string( stringObjectMapKey( _h, val ) );
      end
    ;


    {*
      Removes all values from the map.  Objects stored in the map are NOT freed.
    }
    procedure TQStringObjectMap.clear();
      begin
        stringObjectMapClear( _h );
      end
    ;


    {*
      Removes all values from the map, AND deletes (frees) objects stored in the map.
      There is no exact equivalent to deleteValues() in Qt's QMap, but erase() is close.
    }
    procedure TQStringObjectMap.deleteValues();
      var
        tempObj: TObject;
        itemFound: boolean;

        function removeFirst(): TObject;
          begin
            if( self.isEmpty ) then
              result := nil
            else
              result := stringObjectMapRemoveFirst( _h )
            ;
          end
        ;

      begin
        repeat
          tempObj := removeFirst();
          itemFound := (nil <> tempObj );
          if( itemFound ) then freeAndNil( tempObj );
        until not( itemFound );
      end
    ;


    procedure TQStringObjectMap.rename( const oldName, newName: string );
      var
        val: TObject;
      begin
        val := self.value( oldName );
        self.remove( oldName );
        self.insert( newName, val );
      end
    ;


    procedure TQStringObjectMap.delete( const key: string );
      var
        val: TObject;
        tKey:String;
      begin
        tKey := trim( key );
        val := self.value( tKey );
        self.remove( tKey );
        val.Free();
      end
    ;

    procedure TQStringObjectMap.debug();
      var
        i: integer;
        item: TObject;
      begin
        dbcout( endl, true );
        dbcout( '-- TQStringObjectMap.debug', true );

        for i := 0 to self.count - 1 do
          begin
            item := self.itemAtIndex(i);
            dbcout( '  Key: ' + self.keyAtIndex(i) + ', Item address: ' + intToStr( cardinal( addr( item ) ) ), true );
          end
        ;

        dbcout( '-- Done.', true );
        dbcout( endl, true );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringObjectMap: Properties
  //---------------------------------------------------------------------------
    function TQStringObjectMap.getIsEmpty(): boolean;
      begin
        result := stringObjectMapIsEmpty( _h );
      end
    ;


    function TQStringObjectMap.getSize(): integer;
      begin
        result := stringObjectMapSize( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringObjectMap: Testing/debugging
  //---------------------------------------------------------------------------
    {*
      Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used,
      otherwise test() won't do anything.

      Qt's QMap has no equivalent of test(), but it can be a handy little function.
    }
    procedure TQStringObjectMap.test();
      begin
        stringObjectMapTest( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringObjectMap iterator: Construction
  //---------------------------------------------------------------------------
    constructor TQStringObjectMapIterator.create( const map: TQStringObjectMap );
      begin
        inherited create();

        _map := map;
        _idx := 0;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringObjectMap iterator: Useful functions
  //---------------------------------------------------------------------------
    function TQStringObjectMapIterator.key(): string;
      var
        buf: array[0..1024] of char;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          begin
            stringObjectMapIteratorKey( _map._h, _idx, buf );
            result := buf;
          end
        else
          result := ''
        ;
      end
    ;


    function TQStringObjectMapIterator.value(): TObject;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := stringObjectMapIteratorValue( _map._h, _idx )
        else
          result := nil
        ;
      end
    ;


    procedure TQStringObjectMapIterator.incr();
      begin
        if( _map.count > _idx ) then inc( _idx );
      end
    ;


    procedure TQStringObjectMapIterator.decr();
      begin
        if( -1 < _idx ) then dec( _idx );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringObjectMap: Loading function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadStringObjectMapDLL( var dllHandle: THandle );
      var
        ret_val: boolean;
      begin
        ret_val := true;

        dbcout( 'Attempting to set function pointers in loadStringObjectMapDLL.dllHandle..', SHOWDEBUGMSG );

        newStringObjectMap := GetProcAddress( dllHandle, 'newStringObjectMap' );
        if( nil = @newStringObjectMap ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: newStringObjectMap.' + endl;
            ret_val := false;
          end
        ;

        freeStringObjectMap := GetProcAddress( dllHandle, 'freeStringObjectMap' );
        if( nil = @freeStringObjectMap ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: freeStringObjectMap.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapInsert := GetProcAddress( dllHandle, 'stringObjectMapInsert' );
        if( nil = @stringObjectMapInsert ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapInsert.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapValue := GetProcAddress( dllHandle, 'stringObjectMapValue' );
        if( nil = @stringObjectMapValue ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapValue.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapItemAtIndex := GetProcAddress( dllHandle, 'stringObjectMapItemAtIndex' );
        if( nil = @stringObjectMapItemAtIndex ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapItemAtIndex.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapKeyAtIndex := GetProcAddress( dllHandle, 'stringObjectMapKeyAtIndex' );
        if( nil = @stringObjectMapKeyAtIndex ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapKeyAtIndex.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapBegin := GetProcAddress( dllHandle, 'stringObjectMapBegin' );
        if( nil = @stringObjectMapBegin ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapBegin.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapRemoveFirst := GetProcAddress( dllHandle, 'stringObjectMapRemoveFirst' );
        if( nil = @stringObjectMapRemoveFirst ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapRemoveFirst.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapRemove := GetProcAddress( dllHandle, 'stringObjectMapRemove' );
        if( nil = @stringObjectMapRemove ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapRemove.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapContains := GetProcAddress( dllHandle, 'stringObjectMapContains' );
        if( nil = @stringObjectMapContains ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapContains.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapKey := GetProcAddress( dllHandle, 'stringObjectMapKey' );
        if( nil = @stringObjectMapKey ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapKey.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapClear := GetProcAddress( dllHandle, 'stringObjectMapClear' );
        if( nil = @stringObjectMapClear ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapClear.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapIsEmpty := GetProcAddress( dllHandle, 'stringObjectMapIsEmpty' );
        if( nil = @stringObjectMapIsEmpty ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapIsEmpty.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapSize := GetProcAddress( dllHandle, 'stringObjectMapSize' );
        if( nil = @stringObjectMapSize ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapSize.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapTest := GetProcAddress( dllHandle, 'stringObjectMapTest' );
        if( nil = @stringObjectMapTest ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapTest.' + endl;
            ret_val := false;
          end
        ;

        // Iterator functions
        //-------------------
        stringObjectMapIteratorKey := GetProcAddress( dllHandle, 'stringObjectMapIteratorKey' );
        if( nil = @stringObjectMapIteratorKey ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapIteratorKey.' + endl;
            ret_val := false;
          end
        ;

        stringObjectMapIteratorValue := GetProcAddress( dllHandle, 'stringObjectMapIteratorValue' );
        if( nil = @stringObjectMapIteratorValue ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringObjectMapIteratorValue.' + endl;
            ret_val := false;
          end
        ;

        qStringObjectMapLoaded := ret_val;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// StringLongIntMap
//*****************************************************************************
  //---------------------------------------------------------------------------
  // StringLongIntMap function pointers
  //---------------------------------------------------------------------------
    var
      newStringLongIntMap: function(): TLongIntMapHandle; cdecl;
      freeStringLongIntMap: procedure( h: TLongIntMapHandle ); cdecl;

      stringLongIntMapInsert: procedure( h: TLongIntMapHandle; key: string; val: LongInt ); cdecl;
      stringLongIntMapValue: function( h: TLongIntMapHandle; key: string ): LongInt; cdecl;

      stringLongIntMapKeyAtIndex: function( h: TLongIntMapHandle; const idx: integer ): pchar; cdecl;
      stringLongIntMapItemAtIndex: function( h: TLongIntMapHandle; const idx: integer ): LongInt; cdecl;

      stringLongIntMapBegin: function( h: TLongIntMapHandle ): LongInt; cdecl;
      // (1/18/07): Currently unused, but available in the DLL
      //stringLongIntMapRemoveFirst: function( h: TLongIntMapHandle ): LongInt; cdecl;

      stringLongIntMapRemove: function( h: TLongIntMapHandle; key: string ): integer; cdecl;
      stringLongIntMapContains: function( h: TLongIntMapHandle; key: string ): boolean; cdecl;
      stringLongIntMapClear: procedure( h: TLongIntMapHandle ); cdecl;

      stringLongIntMapKey: function( h: TLongIntMapHandle; const val: LongInt ): pchar; cdecl;

      stringLongIntMapIsEmpty: function( h: TLongIntMapHandle ): boolean; cdecl;
      stringLongIntMapSize: function( h: TLongIntMapHandle ): integer; cdecl;

      stringLongIntMapTest: procedure( h: TLongIntMapHandle ); cdecl;

      // Map iterator functions
      //-----------------------
      stringLongIntMapIteratorKey: procedure( const h: TLongIntMapHandle; const idx: integer; buf: pchar ); cdecl;
      stringLongIntMapIteratorValue: function( const h: TLongIntMapHandle; const idx: integer ): LongInt; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringLongIntMap: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQStringLongIntMap.create();
      begin
        inherited create();

        if ( qStringLongIntMapLoaded ) then
          begin
            _h := newStringLongIntMap();

            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
          end
        else
          begin
            _h := nil;
           dbcout( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!', SHOWDEBUGMSG );
          end;
      end
    ;


    constructor TQStringLongIntMap.create( const source: TQStringLongIntMap );
      begin
        inherited create();

        if ( qStringLongIntMapLoaded ) then
          begin
            _h := newStringLongIntMap();

            self.assign( source );
            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
          end
        else
          begin
            _h := nil;
           dbcout( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!', SHOWDEBUGMSG );
          end;
      end
    ;


    {*
      Deletes (frees) the map.  Objects stored as values in the map are not deleted.
      To delete the objects in the map, use deleteValues() first.
    }
    destructor TQStringLongIntMap.destroy();
      begin
        if( nil <> _h ) then
          freeStringLongIntMap( _h )
        ;
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringLongIntMap: Useful functions
  //---------------------------------------------------------------------------
    {*
      Copys an existing map.
    }
    procedure TQStringLongIntMap.assign( Source: TQStringLongIntMap );
      var
        src: TQStringLongIntMap;
        it: TQStringLongIntMapIterator;
      begin
        // If this exception is raised, the programmer forgot to read the comment above.
        //raise exception.Create( 'The "virtual abstract" function TQStringLongIntMap.assign() has been called.' );

        src := source as TQStringLongIntMap;
        it := TQStringLongIntMapIterator.create( src );

        repeat
          if( not it.Done() ) then
            self.insert( it.key(), it.value() )
          ;

          it.incr();
        until ( it.Done() );

        it.Free();
      end
    ;


    {*
      Inserts a new value into the map, with the specified key.  In Qt's QMap, insert()
      returns an iterator that contains the newly inserted object.  Here, insert()
      has no return value.
    }
    procedure TQStringLongIntMap.insert( const key: string; const val: LongInt );
      var
        tKey:string;
      begin
        tKey := trim( key );
        stringLongIntMapInsert( _h, pchar( tKey ), val );
      end
    ;


    procedure TQStringLongIntMap.Add( const key: string; const val: LongInt );
      begin
        self.insert( key, val );
      end
    ;


    function TQStringLongIntMap.value( const key: string ): LongInt;
      var
        tKey:string;
      begin
        tKey := trim( key );
        result := stringLongIntMapValue( _h, pchar( tKey ) );
      end
    ;


    function TQStringLongIntMap.keyAtIndex( idx: integer ): string;
      begin
        result := String( stringLongIntMapKeyAtIndex( _h, idx ) );
      end
    ;


    function TQStringLongIntMap.itemAtIndex( idx: integer ): LongInt;
      begin
        result := stringLongIntMapItemAtIndex( _h, idx );
      end
    ;


    {*
      Returns the first object in the map.  Renamed from begin() in QMap because
      "begin" is a reserved word in Delphi.  in QMap, begin() returns an iterator.
      Because iterators have not been fully reimplemented here, first() returns
      the object that is the first value in the map.  The key associated with this
      value is not available (although it could be stored in a char buffer, if
      needed).

      Returns nil if the map is empty.
    }
    function TQStringLongIntMap.first(): LongInt;
      begin
        if( self.isEmpty ) then
          result := -1
        else
          result := stringLongIntMapBegin( _h )
        ;
      end
    ;


    {*
      Removes a value from the map based on the key.  In Qt's QMap, remove() returns
      the number of values removed, which may be more than one if insertMulti() is allowed.
      Since insertMulti() is not (yet?) implemented here, remove() will return a maximum of 1.
    }
    function TQStringLongIntMap.remove( const key: string ): integer;
      begin
        result := stringLongIntMapRemove( _h, pchar( key ) );
      end
    ;


    function TQStringLongIntMap.contains( const key: string ): boolean;
      var
        tKey:String;
      begin
        tKey := trim( key );
        result := stringLongIntMapContains( _h, pchar( tKey ) );
      end
    ;


    function TQStringLongIntMap.HasKey( const key: string ): boolean;
      begin
        result := self.contains( key );
      end
    ;


    function TQStringLongIntMap.qHasKey( const key: string ): boolean;
      begin
        result := self.contains( key );
      end
    ;


    function TQStringLongIntMap.key( const val: LongInt ): string;
      begin
        result := string( stringLongIntMapKey( _h, val ) );
      end
    ;


    {*
      Removes all values from the map.  Objects stored in the map are NOT freed.
    }
    procedure TQStringLongIntMap.clear();
      begin
        stringLongIntMapClear( _h );
      end
    ;


    procedure TQStringLongIntMap.deleteValues();
      begin
        stringLongIntMapClear( _h );
      end
    ;


    procedure TQStringLongIntMap.rename( const oldName, newName: string );
      var
        val: LongInt;
      begin
        val := self.value( oldName );
        self.remove( oldName );
        self.insert( newName, val );
      end
    ;


    procedure TQStringLongIntMap.delete( const key: string );
      begin
        self.remove( key );
      end
    ;


    procedure TQStringLongIntMap.debug();
      var
        it: TQStringLongIntMapIterator;
      begin
        it := TQStringLongIntMapIterator.create( self );

        dbcout( endl + '==== TQStringLongIntMap.debug()', true );
        repeat
          if( not it.Done() ) then
            dbcout( 'key: ' + it.key() + ', + value: ' + intToStr( it.value() ), true );
            self.insert( it.key(), it.value() )
          ;

          it.incr();
        until ( it.Done() );

        dbcout( '==== Done ' + endl, true );

        it.Free();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringLongIntMap: Properties
  //---------------------------------------------------------------------------
    function TQStringLongIntMap.getIsEmpty(): boolean;
      begin
        result := stringLongIntMapIsEmpty( _h );
      end
    ;


    function TQStringLongIntMap.getSize(): integer;
      begin
        result := stringLongIntMapSize( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringLongIntMap: Testing/debugging
  //---------------------------------------------------------------------------
    {*
      Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used,
      otherwise test() won't do anything.

      Qt's QMap has no equivalent of test(), but it can be a handy little function.
    }
    procedure TQStringLongIntMap.test();
      begin
        stringLongIntMapTest( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringLongIntMap iterator: Construction
  //---------------------------------------------------------------------------
    constructor TQStringLongIntMapIterator.create( const map: TQStringLongIntMap );
      begin
        inherited create();

        _map := map;
        _idx := 0;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringLongIntMap iterator: Useful functions
  //---------------------------------------------------------------------------
    function TQStringLongIntMapIterator.key(): string;
      var
        buf: array[0..1024] of char;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          begin
            stringLongIntMapIteratorKey( _map._h, _idx, buf );
            result := buf;
          end
        else
          result := ''
        ;
      end
    ;


    function TQStringLongIntMapIterator.isEmpty(): Boolean;
      begin
        result := Done();
      end
    ;


    function TQStringLongIntMapIterator.Done(): Boolean;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
           result := false
         else
           result := true;
      end
    ;


    function TQStringLongIntMapIterator.value(): LongInt;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := stringLongIntMapIteratorValue( _map._h, _idx )
        else
          result := -1
        ;
      end
    ;


    procedure TQStringLongIntMapIterator.incr();
      begin
        if( _map.count > _idx ) then inc( _idx );
      end
    ;


    procedure TQStringLongIntMapIterator.decr();
      begin
        if( -1 < _idx ) then dec( _idx );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringLongIntMap: Loading function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadStringLongIntMapDLL( var dllHandle: THandle );
      var
        ret_val:boolean;
      begin
        ret_val := true;

        dbcout( 'Attempting to set function pointers for StringLongIntMap...', SHOWDEBUGMSG );

        newStringLongIntMap := GetProcAddress( dllHandle, 'newStringLongIntMap' );
        if( nil = @newStringLongIntMap ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: newStringLongIntMap.' + endl;
            ret_val := false;
          end
        ;

        freeStringLongIntMap := GetProcAddress( dllHandle, 'freeStringLongIntMap' );
        if( nil = @freeStringLongIntMap ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: freeStringLongIntMap.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapInsert := GetProcAddress( dllHandle, 'stringLongIntMapInsert' );
        if( nil = @stringLongIntMapInsert ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapInsert.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapValue := GetProcAddress( dllHandle, 'stringLongIntMapValue' );
        if( nil = @stringLongIntMapValue ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapValue.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapKeyAtIndex := GetProcAddress( dllHandle, 'stringLongIntMapKeyAtIndex' );
        if( nil = @stringLongIntMapKeyAtIndex ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapKeyAtIndex.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapItemAtIndex := GetProcAddress( dllHandle, 'stringLongIntMapItemAtIndex' );
        if( nil = @stringLongIntMapItemAtIndex ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapItemAtIndex.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapBegin := GetProcAddress( dllHandle, 'stringLongIntMapBegin' );
        if( nil = @stringLongIntMapBegin ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapBegin.' + endl;
            ret_val := false;
          end
        ;

        (*
        // (1/18/07) Currently unused, but available in the DLL
        stringLongIntMapRemoveFirst := GetProcAddress( dllHandle, 'stringLongIntMapRemoveFirst' );
        if( nil = @stringLongIntMapRemoveFirst ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapRemoveFirst.' + endl;
            ret_val := false;
          end
        ;
        *)

        stringLongIntMapRemove := GetProcAddress( dllHandle, 'stringLongIntMapRemove' );
        if( nil = @stringLongIntMapRemove ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapRemove.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapKey := GetProcAddress( dllHandle, 'stringLongIntMapKey' );
        if( nil = @stringLongIntMapKey ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapKey.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapContains := GetProcAddress( dllHandle, 'stringLongIntMapContains' );
        if( nil = @stringLongIntMapContains ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapContains.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapClear := GetProcAddress( dllHandle, 'stringLongIntMapClear' );
        if( nil = @stringLongIntMapClear ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapClear.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapIsEmpty := GetProcAddress( dllHandle, 'stringLongIntMapIsEmpty' );
        if( nil = @stringLongIntMapIsEmpty ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapIsEmpty.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapSize := GetProcAddress( dllHandle, 'stringLongIntMapSize' );
        if( nil = @stringLongIntMapSize ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapSize.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapTest := GetProcAddress( dllHandle, 'stringLongIntMapTest' );
        if( nil = @stringLongIntMapTest ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapTest.' + endl;
            ret_val := false;
          end
        ;

        // Iterator functions
        //-------------------
        stringLongIntMapIteratorKey := GetProcAddress( dllHandle, 'stringLongIntMapIteratorKey' );
        if( nil = @stringLongIntMapIteratorKey ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapIteratorKey.' + endl;
            ret_val := false;
          end
        ;

        stringLongIntMapIteratorValue := GetProcAddress( dllHandle, 'stringLongIntMapIteratorValue' );
        if( nil = @stringLongIntMapIteratorValue ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringLongIntMapIteratorValue.' + endl;
            ret_val := false;
          end
        ;

        qStringLongIntMapLoaded := ret_val;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// StringStringMap
//*****************************************************************************
  //---------------------------------------------------------------------------
  // Map functions for StringStringMap
  //---------------------------------------------------------------------------
    var
      newStringStringMap: function(): TStringMapHandle; cdecl;
      freeStringStringMap: procedure( h: TStringMapHandle ); cdecl;

      stringStringMapInsert: procedure( h: TStringMapHandle; key: string; val: String ); cdecl;
      stringStringMapValue: function( h: TStringMapHandle; key: pchar ): pchar; cdecl;
      stringStringItemAtIndex: function( h: TStringMapHandle; index: integer ): pchar; cdecl;
      stringStringKeyAtIndex: function( h: TStringMapHandle; index: integer ): pchar; cdecl;

      stringStringMapBegin: function( h: TStringMapHandle ): pchar; cdecl;
      // (1/18/07) Currently unused, but available in the DLL
      //stringStringMapRemoveFirst: function( h: TStringMapHandle ): pchar; cdecl;

      stringStringMapRemove: function( h: TStringMapHandle; key: string ): integer; cdecl;
      stringStringMapContains: function( h: TStringMapHandle; key: string ): boolean; cdecl;
      stringStringMapClear: procedure( h: TStringMapHandle ); cdecl;

      stringStringMapKey: function( h: TStringMapHandle; const val: string ): pchar; cdecl;

      stringStringMapIsEmpty: function( h: TStringMapHandle ): boolean; cdecl;
      stringStringMapSize: function( h: TStringMapHandle ): integer; cdecl;

      stringStringMapTest: procedure( h: TStringMapHandle ); cdecl;

      // Map iterator functions
      //-----------------------
      stringStringMapIteratorKey: procedure( const h: TStringMapHandle; const idx: integer; buf: pchar ); cdecl;
      stringStringMapIteratorValue: function( const h: TStringMapHandle; const idx: integer ): pchar; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringStringMap: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQStringStringMap.create();
      begin
        inherited create();

        if ( qStringStringMapLoaded ) then
          begin
            _h := newStringStringMap();

            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
          end
        else
          begin
            _h := nil;
           dbcout( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!', SHOWDEBUGMSG );
          end;
      end
    ;


    constructor TQStringStringMap.create( const source: TQStringStringMap );
      begin
        inherited create();

        if ( qStringStringMapLoaded ) then
          begin
            _h := newStringStringMap();

            self.assign( source );
            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
          end
        else
          begin
            _h := nil;
           dbcout( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!', SHOWDEBUGMSG );
          end;
      end
    ;


    {*
      Deletes (frees) the map.  Objects stored as values in the map are not deleted.
      To delete the objects in the map, use deleteValues() first.
    }
    destructor TQStringStringMap.destroy();
      begin
        freeStringStringMap( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringStringMap: Useful functions
  //---------------------------------------------------------------------------
    {*
      Copys an existing map.
    }
    procedure TQStringStringMap.assign( Source: TQStringStringMap );
      var
        src: TQStringStringMap;
        it: TQStringStringMapIterator;
      begin
        // If this exception is raised, the programmer forgot to read the comment above.
        //raise exception.Create( 'The "virtual abstract" function TQStringStringMap.assign() has been called.' );

        src := source as TQStringStringMap;
        it := TQStringStringMapIterator.create( src );

        repeat
          if( not it.Done() ) then
            begin
              self.insert( it.key(), PChar(it.value()) );
            end
          ;

          it.incr();
        until ( it.Done() );

        it.Free();
      end
    ;


    {*
      Inserts a new value into the map, with the specified key.  In Qt's QMap, insert()
      returns an iterator that contains the newly inserted object.  Here, insert()
      has no return value.
    }
    procedure TQStringStringMap.insert( const key: string; const val: String );
      var
        tKey:string;
      begin
        tKey := trim( key );
        stringStringMapInsert( _h, pchar( tKey ), pchar( val ) );
      end
    ;


    procedure TQStringStringMap.Add( const key: string; const val: String );
      begin
        self.insert( key, val );
      end
    ;


    function TQStringStringMap.value( const key:String ): String;
      var
        tKey:String;
        ret_val:PChar;
      begin
        tKey := trim( key );
        ret_val := PChar( stringStringMapValue( _h, pchar( tKey ) ) );
        result := String( ret_val );
      end
    ;


    {*
      Returns the first object in the map.  Renamed from begin() in QMap because
      "begin" is a reserved word in Delphi.  in QMap, begin() returns an iterator.
      Because iterators have not been fully reimplemented here, first() returns
      the object that is the first value in the map.  The key associated with this
      value is not available (although it could be stored in a char buffer, if
      needed).

      Returns nil if the map is empty.
    }
    function TQStringStringMap.first(): String;
      begin
        if( self.isEmpty ) then
          result := ''
        else
          result := String( stringStringMapBegin( _h ) )
        ;
      end
    ;


    {*
      Removes a value from the map based on the key.  In Qt's QMap, remove() returns
      the number of values removed, which may be more than one if insertMulti() is allowed.
      Since insertMulti() is not (yet?) implemented here, remove() will return a maximum of 1.
    }
    function TQStringStringMap.remove( const key: string ): integer;
      var
       tkey:String;
      begin
        tkey := trim( key );
        result := stringStringMapRemove( _h, pchar( tkey ) );
      end
    ;


    function TQStringStringMap.contains( const key: string ): boolean;
      var
        tkey:String;
      begin
        tkey := trim( key );
        result := stringStringMapContains( _h, pchar( tkey ) );
      end
    ;


     function TQStringStringMap.key( const val: string ): string;
      begin
        result := string( stringStringMapKey( _h, val ) );
      end
    ;


    function TQStringStringMap.HasKey( const key: string ): boolean;
      begin
        result :=  qHasKey( key );
      end
    ;


    function TQStringStringMap.qHasKey( const key: string ): boolean;
      var
        tkey:String;
      begin
        tkey := trim( key );
        result := self.contains( tkey );
      end
    ;


    {*
      Removes all values from the map.  Objects stored in the map are NOT freed.
    }
    procedure TQStringStringMap.clear();
      begin
        stringStringMapClear( _h );
      end
    ;


    procedure TQStringStringMap.deleteValues();
      begin
        stringStringMapClear( _h );
      end
    ;


    procedure TQStringStringMap.rename( const oldName, newName: string );
      var
        val: String;
      begin
        val := String( self.value( oldName ) );
        self.remove( oldName );
        self.insert( newName, val );
      end
    ;


    procedure TQStringStringMap.delete( const key: string );
      begin
        self.remove( key );
      end
    ;


    procedure TQStringStringMap.debug();
      var
        i: integer;
      begin
        dbcout( endl, true );
        dbcout( '-- TQStringStringMap.debug', true );

        for i := 0 to self.count - 1 do
          dbcout( '  Key: ' + self.keyAtIndex(i) + ', Item: ' + self.itemAtIndex(i), true )
        ;

        dbcout( '-- Done.', true );
        dbcout( endl, true );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringStringMap: Properties
  //---------------------------------------------------------------------------
    function TQStringStringMap.getIsEmpty(): boolean;
      begin
        result := stringStringMapIsEmpty( _h );
      end
    ;


    function TQStringStringMap.GetKeyByIndex( index: integer ):String;
      begin
        result := keyAtIndex( index );
      end
    ;


    function TQStringStringMap.GetItemByIndex( index: integer ):String;
      begin
        result := itemAtIndex( index );
      end
    ;


    function TQStringStringMap.keyAtIndex( idx: integer ): string;
      begin
        result := String( stringStringKeyAtIndex( _h, idx ) );
      end
    ;


    function TQStringStringMap.itemAtIndex( idx: integer ): string;
      begin
        result := String( stringStringItemAtIndex( _h, idx ) );
      end
    ;


    function TQStringStringMap.getSize(): integer;
      begin
        result := stringStringMapSize( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringStringMap: Testing/debugging
  //---------------------------------------------------------------------------
    {*
      Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used,
      otherwise test() won't do anything.

      Qt's QMap has no equivalent of test(), but it can be a handy little function.
    }
    procedure TQStringStringMap.test();
      begin
        stringStringMapTest( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringStringMap iterator: Construction
  //---------------------------------------------------------------------------
    constructor TQStringStringMapIterator.create( const map: TQStringStringMap );
      begin
        inherited create();

        _map := map;
        _idx := 0;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringStringMap iterator: Useful functions
  //---------------------------------------------------------------------------
    function TQStringStringMapIterator.key(): string;
      var
        buf: array[0..1024] of char;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          begin
            stringStringMapIteratorKey( _map._h, _idx, buf );
            result := buf;
          end
        else
          result := ''
        ;
      end
    ;


    function TQStringStringMapIterator.isEmpty(): Boolean;
      begin
        result := Done();
      end
    ;


    function TQStringStringMapIterator.Done(): Boolean;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
           result := false
         else
           result := true;
      end
    ;


    function TQStringStringMapIterator.value(): String;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := String( stringStringMapIteratorValue( _map._h, _idx ) )
        else
          result := ''
        ;
      end
    ;


    procedure TQStringStringMapIterator.incr();
      begin
        if( _map.count > _idx ) then inc( _idx );
      end
    ;


    procedure TQStringStringMapIterator.decr();
      begin
        if( -1 < _idx ) then dec( _idx );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringStringMap: Loading function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadStringStringMapDLL( var dllHandle: THandle );
      var
        ret_val:boolean;
      begin
        ret_val := true;

        dbcout( 'Library qclasses.dll was successfully loaded.', SHOWDEBUGMSG );

        dbcout( 'Attempting to set function pointers...', SHOWDEBUGMSG );

        newStringStringMap := GetProcAddress( dllHandle, 'newStringStringMap' );
        if( nil = @newStringStringMap ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: newStringStringMap.' + endl;
            ret_val := false;
          end
        ;

        freeStringStringMap := GetProcAddress( dllHandle, 'freeStringStringMap' );
        if( nil = @freeStringStringMap ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: freeStringStringMap.' + endl;
            ret_val := false;
          end
        ;

        stringStringMapInsert := GetProcAddress( dllHandle, 'stringStringMapInsert' );
        if( nil = @stringStringMapInsert ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapInsert.' + endl;
            ret_val := false;
          end
        ;

        stringStringMapValue := GetProcAddress( dllHandle, 'stringStringMapValue' );
        if( nil = @stringStringMapValue ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapValue.' + endl;
            ret_val := false;
          end
        ;


        stringStringItemAtIndex := GetProcAddress( dllHandle, 'stringStringItemAtIndex' );
        if( nil = @stringStringItemAtIndex ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringItemAtIndex.' + endl;
            ret_val := false;
          end
        ;

        stringStringKeyAtIndex := GetProcAddress( dllHandle, 'stringStringKeyAtIndex' );
        if( nil = @stringStringKeyAtIndex ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringKeyAtIndex.' + endl;
            ret_val := false;
          end
        ;

        stringStringMapBegin := GetProcAddress( dllHandle, 'stringStringMapBegin' );
        if( nil = @stringStringMapBegin ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapBegin.' + endl;
            ret_val := false;
          end
        ;

        (*
        // (1/18/07) Currently unused, but available in the DLL
        stringStringMapRemoveFirst := GetProcAddress( dllHandle, 'stringStringMapRemoveFirst' );
        if( nil = @stringStringMapRemoveFirst ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapRemoveFirst.' + endl;
            ret_val := false;
          end
        ;
        *)

        stringStringMapRemove := GetProcAddress( dllHandle, 'stringStringMapRemove' );
        if( nil = @stringStringMapRemove ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapRemove.' + endl;
            ret_val := false;
          end
        ;

        stringStringMapContains := GetProcAddress( dllHandle, 'stringStringMapContains' );
        if( nil = @stringStringMapContains ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapContains.' + endl;
            ret_val := false;
          end
        ;

        stringStringMapKey := GetProcAddress( dllHandle, 'stringStringMapKey' );
        if( nil = @stringStringMapKey ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapKey.' + endl;
            ret_val := false;
          end
        ;

        stringStringMapClear := GetProcAddress( dllHandle, 'stringStringMapClear' );
        if( nil = @stringStringMapClear ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapClear.' + endl;
            ret_val := false;
          end
        ;

        stringStringMapIsEmpty := GetProcAddress( dllHandle, 'stringStringMapIsEmpty' );
        if( nil = @stringStringMapIsEmpty ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapIsEmpty.' + endl;
            ret_val := false;
          end
        ;

        stringStringMapSize := GetProcAddress( dllHandle, 'stringStringMapSize' );
        if( nil = @stringStringMapSize ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapSize.' + endl;
            ret_val := false;
          end
        ;

        stringStringMapTest := GetProcAddress( dllHandle, 'stringStringMapTest' );
        if( nil = @stringStringMapTest ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapTest.' + endl;
            ret_val := false;
          end
        ;

        // Iterator functions
        //-------------------
        stringStringMapIteratorKey := GetProcAddress( dllHandle, 'stringStringMapIteratorKey' );
        if( nil = @stringStringMapIteratorKey ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapIteratorKey.' + endl;
            ret_val := false;
          end
        ;

        stringStringMapIteratorValue := GetProcAddress( dllHandle, 'stringStringMapIteratorValue' );
        if( nil = @stringStringMapIteratorValue ) then
          begin
            qStringMapsDllLoadError := qStringMapsDllLoadError + 'MISSING FUNCTION: stringStringMapIteratorValue.' + endl;
            ret_val := false;
          end
        ;

        qStringStringMapLoaded := ret_val;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// StringVariantMap
//*****************************************************************************
  //---------------------------------------------------------------------------
  // StringVariantMap: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQStringVariantMap.create();
      begin
        inherited create();

        _map := TQStringIntMap.create();
      end
    ;


    destructor TQStringVariantMap.destroy();
      begin
        freeAndNil( _map );
        setLength( _variants, 0 );

        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringVariantMap: Useful functions
  //---------------------------------------------------------------------------
    { Inserts a new value into the map, with the specified key. }
    procedure TQStringVariantMap.insert( const key: string; const val: variant );
      var
        newIdx: integer;
      begin
        newIdx := length( _variants );
        setLength( _variants, newIdx + 1 );
        _variants[newIdx] := val;
        _map.insert( key, newIdx );
      end
    ;


    { Retrieves a value from the map based on the specified key. }
    function TQStringVariantMap.value( const key: string ): variant;
      var
        idx: integer;
      begin
        idx := _map.value( key );
        result := _variants[idx];
      end
    ;


    { WARNING: this function will NOT return keys in the original insertion order!! }
    function TQStringVariantMap.keyAtIndex( idx: integer ): string;
      begin
        result := _map.keyAtIndex( idx );
      end
    ;


    { WARNING: this function will NOT return items in the original insertion order!! }
    function TQStringVariantMap.itemAtIndex( idx: integer ): variant;
      var
        idx2: integer;
      begin
        idx2 := _map.itemAtIndex( idx );
        result := _variants[idx2];
      end
    ;


    { Retrieves the first value in the map. }
    function TQStringVariantMap.first(): variant;
      var
        idx2: integer;
      begin
        idx2 := _map.itemAtIndex(0);
        result := _variants[idx2];
      end
    ;


    { Removes a value from the map based on the key. }
    function TQStringVariantMap.remove( const key: string ): integer;
      begin
        result := _map.remove( key );
        // The item will actually stay in the variant array, but it can never be accessed again.
        // A little memory will be burned until the variant array is freed.
      end
    ;


    { Does the map contain a value with the specified key? }
    function TQStringVariantMap.contains( const key: string ): boolean;
      begin
        result := _map.contains( key );
      end
    ;


    { What is the key associated with the specified value? }
    function TQStringVariantMap.key( const val: variant ): string;
      var
        i: integer;
        idx: integer;
      begin
        idx := -1;

        for i := 0 to length( _variants ) - 1 do
          begin
            if( _variants[i] = val ) then
              begin
                idx := i;
                break;
              end
            ;
          end
        ;

        if( -1 < idx ) then
          result := _map.key( idx )
        else
          result := ''
        ;
      end
    ;


    { Removes all values from the map. }
    procedure TQStringVariantMap.clear();
      begin
        _map.clear();
        setLength( _variants, 0 );
      end
    ;


    procedure TQStringVariantMap.rename( const oldName, newName: string );
      begin
        _map.rename( oldName, newName );
      end
    ;


    procedure TQStringVariantMap.delete( const key: string );
      begin
        self.remove( key );
      end
    ;

    procedure TQStringVariantMap.debug();
      var
        i: integer;
        v: variant;
      begin
        dbcout( endl, true );
        dbcout( '-- TQStringVariantMap.debug', true );

        for i := 0 to self.count - 1 do
          begin
            v := self.itemAtIndex(i);
            if( null = v ) then
              dbcout( '  Key: ' + self.keyAtIndex(i) + ', Item: (null)', true )
            else
              dbcout( '  Key: ' + self.keyAtIndex(i) + ', Item: ' + string( v ), true )
            ;
          end
        ;

        dbcout( '-- Done.', true );
        dbcout( endl, true );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringVariantMap: Properties
  //---------------------------------------------------------------------------
    function TQStringVariantMap.getIsEmpty(): boolean;
      begin
        result := _map.isEmpty;
      end
    ;


    function TQStringVariantMap.getSize(): integer;
      begin
        result := _map.count;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringVariantMap: Testing/debugging
  //---------------------------------------------------------------------------

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

      if( dllHandle >= 32 ) then // // library was successfully loaded.  Assign function pointers now.
        begin
          loadStringObjectMapDLL( dllHandle );
          loadStringLongIntMapDLL( dllHandle );
          loadStringStringMapDLL( dllHandle );
        end
      ;
    end
  ;
//*****************************************************************************


initialization
  qStringMapsDllLoadError := '';

  qStringObjectMapLoaded := false;
  qStringLongIntMapLoaded := false;
  qStringStringMapLoaded := false;

  loadDynamicDLL();

end.


