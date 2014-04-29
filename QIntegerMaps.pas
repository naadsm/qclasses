unit QIntegerMaps;

(*
QIntegerMaps.pas
----------------
Begin: 2006/12/20
Last revision: $Date: 2011-10-25 05:05:07 $ $Author: areeves $
Version: $Revision: 1.15 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2006 - 2010 Aaron Reeves

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

  This unit implements classs similar to Qt QMaps (see
  http://doc.trolltech.com/4.1/qmap.html) that use integer keys.
  Syntax follows the QMap interface as closely as possible:
  any deviations should be noted in the comments in the implementation section.
}


interface

  uses
    Classes
  ;

  { If this function returns false, the DLL didn't load and these classes cannot be used. }
  function qIntegerMapsDllLoaded( msg: pstring = nil ): boolean;

  { A typedef for the C++ map implementation. }
  type TMapHandle = Pointer;

  { A typedef for the objects that will be values in object maps. }
  type TObjectHandle = Pointer;


//-----------------------------------------------------------------------------
// IntegerObjectMap
//-----------------------------------------------------------------------------
  { The map itself }
  type TQIntegerObjectMap = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the TQIntegerObjectMap class.
      }
      _h: TMapHandle;

      // Properties
      //-----------
      { Is the map empty? }
      function getIsEmpty(): boolean;

      { How many objects are in the map? }
      function getSize(): integer;

      function GetItemByIndex( const idx: Integer ): TObject;
      function GetKeyByIndex( const idx: Integer ): integer;

    public
      constructor create(); overload; virtual;
      constructor create( const source: TQIntegerObjectMap ); overload;

      { Deletes (frees) the map.  Objects stored as values in the map are NOT deleted. }
      destructor destroy(); override;

      // Useful functions
      //------------------
      { Copys an existing map.  THIS FUNCTION SHOULD BE OVERRIDDEN TO ACTUALLY DO ANYTHING USEFUL. }
      procedure assign( Source: TObject ); virtual;

      { Inserts a new value into the map, with the specified key. }
      procedure insert( const key: integer; const val: TObject ); //reintroduce;
      procedure Add(const key: integer; const val: TObject );

      { Retrieves a value from the map based on the specified key. }
      function value( const key: integer ): TObject;

      { WARNING: these functions will NOT return the keys/values in the original insertion order!! }
      function keyAtIndex( const idx: integer ): integer;
      function itemAtIndex( const idx: integer ): TObject;

      { Retrieves the first value in the map. }
      function first(): TObject;

      { Removes a value from the map based on the key. }
      function remove( const key: integer ): integer;

      { Does the map contain a value with the specified key? }
      function contains( const key: integer ): boolean;
      function qHasKey( const key: integer ): boolean;

      { Removes all values from the map.  Objects stored in the map are NOT freed. }
      procedure clear();

      { Removes all values from the map, AND frees (deletes) them. }
      procedure deleteValues();

      procedure delete( const key: integer );

      // Properties
      //-----------
      { Is the map empty? }
      property isEmpty: boolean read getIsEmpty;

      { How many objects are in the map? }
      property size: integer read getSize;

      { Synonym for size. }
      property count: integer read getSize;

      property  Item[const Key: integer]: TObject read value write insert; default;

      { WARNING: These properties will NOT return the keys/values in the original insertion order!! }
       //property  values[idx: integer]: TObject read GetItemByIndex;
       //property  keys[idx: integer]: String read GetKeyByIndex;

      // Testing/debugging
      //------------------
      { Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used. }
      procedure test();
    end
  ;


  { An iterator for the map. }
  type TQIntegerObjectMapIterator = class
    protected
      _idx: integer;
      _map: TQIntegerObjectMap;

    public
      constructor create( const map: TQIntegerObjectMap );

      function key(): integer;
      function value(): TObject;

      procedure incr();
      procedure decr();
    end
  ;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// IntegerStringMap
//-----------------------------------------------------------------------------
  { The map itself }
  type TQIntegerStringMap = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the TQIntegerObjectMap class.
      }
      _h: TMapHandle;

      // Properties
      //-----------
      { Is the map empty? }
      function getIsEmpty(): boolean;

      { How many objects are in the map? }
      function getSize(): integer;

      function GetItemByIndex( const idx: Integer ): string;
      function GetKeyByIndex( const idx: Integer ): integer;

    public
      constructor create(); overload; virtual;
      constructor create( const source: TQIntegerStringMap ); overload;
      procedure assign( source: TQIntegerStringMap );
      
      { Deletes (frees) the map.  Objects stored as values in the map are NOT deleted. }
      destructor destroy(); override;

      // Useful functions
      //------------------
      { Inserts a new value into the map, with the specified key. }
      procedure insert( const key: integer; const val: string ); //reintroduce;
      procedure Add(const key: integer; const val: string );

      { Retrieves a value from the map based on the specified key. }
      function value( const key: integer ): string; virtual;

      { WARNING: these functions will NOT return the keys/values in the original insertion order!! }
      function keyAtIndex( const idx: integer ): integer;
      function itemAtIndex( const idx: integer ): string;

      { Retrieves the first value in the map. }
      function first(): string;

      { Removes a value from the map based on the key. }
      function remove( const key: integer ): integer;

      { Does the map contain a value with the specified key? }
      function contains( const key: integer ): boolean;
      function qHasKey( const key: integer ): boolean;

      { Removes all values from the map. }
      procedure clear();

      // Properties
      //-----------
      { Is the map empty? }
      property isEmpty: boolean read getIsEmpty;

      { How many objects are in the map? }
      property size: integer read getSize;

      { Synonym for size. }
      property count: integer read getSize;

      property  Item[const Key: integer]: string read value write insert; default;

      { WARNING: These properties will NOT return the keys/values in the original insertion order!! }
       //property  values[idx: integer]: string read GetItemByIndex;
       //property  keys[idx: integer]: integer read GetKeyByIndex;

      // Testing/debugging
      //------------------
      { Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used. }
      procedure test();
    end
  ;


  { An iterator for the map. }
  type TQIntegerStringMapIterator = class
    protected
      _idx: integer;
      _map: TQIntegerStringMap;

    public
      constructor create( const map: TQIntegerStringMap );

      function key(): integer;
      function value(): string;
      function Done(): Boolean;
      function isEmpty(): Boolean;
      
      procedure incr();
      procedure decr();
    end
  ;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// IntegerIntegerMap
//-----------------------------------------------------------------------------
  { The map itself }
  type TQIntegerIntegerMap = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the class.
      }
      _h: TMapHandle;

      // Properties
      //-----------
      { Is the map empty? }
      function getIsEmpty(): boolean;

      { How many objects are in the map? }
      function getSize(): integer;

      function GetItemByIndex( const idx: Integer ): integer;
      function GetKeyByIndex( const idx: Integer ): integer;

    public
      constructor create(); overload; virtual;
      constructor create( const source: TQIntegerIntegerMap ); overload;
      procedure assign( source: TQIntegerIntegerMap );
      
      { Deletes (frees) the map.  Objects stored as values in the map are NOT deleted. }
      destructor destroy(); override;

      // Useful functions
      //------------------
      { Inserts a new value into the map, with the specified key. }
      procedure insert( const key: integer; const val: integer ); //reintroduce;
      procedure Add(const key: integer; const val: integer );

      { Retrieves a value from the map based on the specified key. }
      function value( const key: integer ): integer; virtual;

      { WARNING: these functions will NOT return the keys/values in the original insertion order!! }
      function keyAtIndex( const idx: integer ): integer;
      function itemAtIndex( const idx: integer ): integer;

      { Retrieves the first value in the map.  This is NOT necessarily the first value inserted!! }
      function first(): integer;

      { Removes a value from the map based on the key. }
      function remove( const key: integer ): integer;

      { Does the map contain a value with the specified key? }
      function contains( const key: integer ): boolean;
      function qHasKey( const key: integer ): boolean;

      { Add or subtract 1 to/from the value with the specified key.  (0 is assumed if the key does not exist) }
      procedure incrAtKey( const key: integer );
      procedure decrAtKey( const key: integer );

      { Removes all values from the map. }
      procedure clear();

      { Writes contents of the map to the debug window. }
      procedure debug();

      // Properties
      //-----------
      { Is the map empty? }
      property isEmpty: boolean read getIsEmpty;

      { How many objects are in the map? }
      property size: integer read getSize;

      { Synonym for size. }
      property count: integer read getSize;

      property  Item[const Key: integer]: integer read value write insert; default;

      { WARNING: These properties will NOT return the keys/values in the original insertion order!! }
       //property  values[idx: integer]: integer read GetItemByIndex;
       //property  keys[idx: integer]: integer read GetKeyByIndex;

      // Testing/debugging
      //------------------
      { Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used. }
      procedure test();
    end
  ;


  { An iterator for the map. }
  type TQIntegerIntegerMapIterator = class
    protected
      _idx: integer;
      _map: TQIntegerIntegerMap;

    public
      constructor create( const map: TQIntegerIntegerMap );

      function key(): integer;
      function value(): integer;
      function Done(): Boolean;
      function isEmpty(): Boolean;
      
      procedure incr();
      procedure decr();
    end
  ;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// IntegerDoubleMap
//-----------------------------------------------------------------------------
  { The map itself }
  type TQIntegerDoubleMap = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the TQIntegerDoubleMap class.
      }
      _h: TMapHandle;

      // Properties
      //-----------
      { Is the map empty? }
      function getIsEmpty(): boolean;

      { How many objects are in the map? }
      function getSize(): integer;

      function GetItemByIndex( const idx: Integer ): double;
      function GetKeyByIndex( const idx: Integer ): integer;

    public
      constructor create(); overload; virtual;
      constructor create( const source: TQIntegerDoubleMap ); overload;

      { Deletes (frees) the map.  Doubles stored as values in the map are NOT deleted. }
      destructor destroy(); override;

      // Useful functions
      //------------------
      procedure assign( Source: TQIntegerDoubleMap ); virtual;

      { Inserts a new value into the map, with the specified key. }
      procedure insert( const key: integer; const val: double ); //reintroduce;
      procedure Add(const key: integer; const val: double );

      { Retrieves a value from the map based on the specified key. }
      function value( const key: integer ): double;

      { WARNING: these functions will NOT return the keys/values in the original insertion order!! }
      function keyAtIndex( const idx: integer ): integer;
      function itemAtIndex( const idx: integer ): double;

      { Retrieves the first value in the map. }
      function first(): double;

      { Removes a value from the map based on the key. }
      function remove( const key: integer ): integer;

      { Does the map contain a value with the specified key? }
      function contains( const key: integer ): boolean;

      { Removes all values from the map.}
      procedure clear();

      { Prints contents to the debugging window }
      procedure debug();

      // Properties
      //-----------
      { Is the map empty? }
      property isEmpty: boolean read getIsEmpty;

      { How many objects are in the map? }
      property size: integer read getSize;
      property count: integer read getSize;

      property  Item[const Key: integer]: double read value write insert; default;

      { WARNING: These properties will NOT return the keys/values in the original insertion order!! }
       //property  values[idx: integer]: double read GetItemByIndex;
       //property  keys[idx: integer]: String read GetKeyByIndex;

      // Testing/debugging
      //------------------
      { Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used. }
      procedure test();
    end
  ;


  { An iterator for the map. }
  type TQIntegerDoubleMapIterator = class
    protected
      _idx: integer;
      _map: TQIntegerDoubleMap;

    public
      constructor create( const map: TQIntegerDoubleMap );

      function key(): integer;
      function value(): double;
      function Done(): Boolean;
      function isEmpty(): Boolean;
      
      procedure incr();
      procedure decr();
    end
  ;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// IntUIntMap
//-----------------------------------------------------------------------------
  type TQIntUIntMap = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the class.
      }
      _h: TMapHandle;

      // Properties
      //-----------
      { Is the map empty? }
      function getIsEmpty(): boolean;

      { How many objects are in the map? }
      function getSize(): integer;

      function GetItemByIndex( const idx: Integer ): longword;
      function GetKeyByIndex( const idx: Integer ): integer;

    public
      constructor create(); overload; virtual;
      constructor create( const source: TQIntUIntMap ); overload;
      procedure assign( source: TQIntUIntMap );
      
      { Deletes (frees) the map.  Objects stored as values in the map are NOT deleted. }
      destructor destroy(); override;

      // Useful functions
      //------------------
      { Inserts a new value into the map, with the specified key. }
      procedure insert( const key: integer; const val: longword ); //reintroduce;
      procedure Add(const key: integer; const val: longword );

      { Retrieves a value from the map based on the specified key. }
      function value( const key: integer ): longword; virtual;

      { WARNING: these functions will NOT return the keys/values in the original insertion order!! }
      function keyAtIndex( const idx: integer ): integer;
      function itemAtIndex( const idx: integer ): longword;

      { Retrieves the first value in the map. }
      function first(): longword;

      { Removes a value from the map based on the key.  Returns the number of items removed. }
      function remove( const key: integer ): integer;

      { Does the map contain a value with the specified key? }
      function contains( const key: integer ): boolean;
      function qHasKey( const key: integer ): boolean;

      { Removes all values from the map. }
      procedure clear();

      // Properties
      //-----------
      { Is the map empty? }
      property isEmpty: boolean read getIsEmpty;

      { How many objects are in the map? }
      property size: integer read getSize;

      { Synonym for size. }
      property count: integer read getSize;

      property  Item[const Key: integer]: longword read value write insert; default;

      { WARNING: These properties will NOT return the keys/values in the original insertion order!! }
       //property  values[idx: integer]: integer read GetItemByIndex;
       //property  keys[idx: integer]: integer read GetKeyByIndex;

      // Testing/debugging
      //------------------
      { Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used. }
      procedure test();
    end
  ;


  { An iterator for the map. }
  type TQIntUIntMapIterator = class
    protected
      _idx: integer;
      _map: TQIntUIntMap;

    public
      constructor create( const map: TQIntUIntMap );

      function key(): integer;
      function value(): longword;
      function Done(): Boolean;
      function isEmpty(): Boolean;
      
      procedure incr();
      procedure decr();
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
    loadErrors: string;
    qIntegerObjectMapLoaded: boolean;
    qIntegerStringMapLoaded: boolean;
    qIntegerIntegerMapLoaded: boolean;
    qIntegerDoubleMapLoaded: boolean;
    qIntUIntMapLoaded: boolean;

//*****************************************************************************
// Checking the DLL
//*****************************************************************************
  function qIntegerMapsDllLoaded( msg: pstring = nil ): boolean;
    begin
      result :=
        qIntegerObjectMapLoaded
      and
        qIntegerStringMapLoaded
      and
        qIntegerIntegerMapLoaded
      and
        qIntegerDoubleMapLoaded
      and
        qIntUIntMapLoaded
      ;

      if( nil <> msg ) then
        msg^ := msg^ + loadErrors
      ;
    end
  ;
//*****************************************************************************



//*****************************************************************************
// IntegerObjectMap
//*****************************************************************************
  //---------------------------------------------------------------------------
  // Function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
  var
    // Map functions
    //--------------
    newIntegerObjectMap: function(): TMapHandle; cdecl;
    freeIntegerObjectMap: procedure( h: TMapHandle ); cdecl;

    integerObjectMapInsert: procedure( h: TMapHandle; key: integer; val: TObject ); cdecl;
    integerObjectMapValue: function( h: TMapHandle; key: integer ): TObject; cdecl;
    integerObjectMapItemAtIndex: function( h: TMapHandle; idx: integer): TObject; cdecl;
    integerObjectMapKeyAtIndex: function( h: TMapHandle; idx: integer): pchar; cdecl;
    integerObjectMapBegin: function( h: TMapHandle ): TObject; cdecl;
    integerObjectMapRemoveFirst: function( h: TMapHandle ): TObject; cdecl;

    integerObjectMapRemove: function( h: TMapHandle; key: integer ): integer; cdecl;
    integerObjectMapContains: function( h: TMapHandle; key: integer ): boolean; cdecl;
    integerObjectMapClear: procedure( h: TMapHandle ); cdecl;

    integerObjectMapIsEmpty: function( h: TMapHandle ): boolean; cdecl;
    integerObjectMapSize: function( h: TMapHandle ): integer; cdecl;

    integerObjectMapTest: procedure( h: TMapHandle ); cdecl;

    // Map iterator functions
    //-----------------------
    integerObjectMapIteratorKey: function( const h: TMapHandle; const idx: integer ): integer; cdecl;
    integerObjectMapIteratorValue: function( const h: TMapHandle; const idx: integer ): TObject; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerObjectMap: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQIntegerObjectMap.create();
      begin
        qIntegerObjectMapLoaded := qIntegerObjectMapLoaded;

        inherited create();
        if ( qIntegerObjectMapLoaded ) then
          begin
            _h := newIntegerObjectMap();

            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQIntegerObjectMap.create( const source: TQIntegerObjectMap );
      begin
        qIntegerObjectMapLoaded := qIntegerObjectMapLoaded;

        inherited create();
        if ( qIntegerObjectMapLoaded ) then
          begin
            _h := newIntegerObjectMap();

            self.assign( source );
            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
          end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end;
      end
    ;


    {*
      Deletes (frees) the map.  Objects stored as values in the map are not deleted.
      To delete the objects in the map, use deleteValues() first.
    }
    destructor TQIntegerObjectMap.destroy();
      begin
        freeIntegerObjectMap( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerObjectMap: Useful functions
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
    procedure TQIntegerObjectMap.assign( Source: TObject );
      var
        src: TQIntegerObjectMap;
        it: TQIntegerObjectMapIterator;
        newObj: TObject;
      begin
        // If this exception is raised, the programmer forgot to read the comment above.
        raise exception.Create( 'The "virtual abstract" function TQStringObjectMap.assign() has been called.' );

        src := source as TQIntegerObjectMap;
        it := TQIntegerObjectMapIterator.create( src );

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
    procedure TQIntegerObjectMap.insert( const key: integer; const val: TObject );
      begin
        integerObjectMapInsert( _h, key, val );
      end
    ;


    procedure TQIntegerObjectMap.Add(const key: integer; const val: TObject );
      begin
        insert( key, val );
      end
    ;


    function TQIntegerObjectMap.value( const key: integer ): TObject;
      begin
        result := integerObjectMapValue( _h, key );
      end
    ;


    function TQIntegerObjectMap.GetItemByIndex( const idx: Integer ): TObject;
      begin
        result := integerObjectMapItemAtIndex( _h, idx );
      end
    ;


    function TQIntegerObjectMap.GetKeyByIndex( const idx: Integer ): integer;
      begin
        result := integer( integerObjectMapKeyAtIndex( _h, idx ) );
      end
    ;


    function TQIntegerObjectMap.keyAtIndex( const idx: integer ): integer;
      begin
        result := GetKeyByIndex( idx );
      end
    ;


    function TQIntegerObjectMap.itemAtIndex( const idx: integer ): TObject;
      begin
        result := GetItemByIndex( idx );
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
    function TQIntegerObjectMap.first(): TObject;
      begin
        if( self.isEmpty ) then
          result := nil
        else
          result := integerObjectMapBegin( _h )
        ;
      end
    ;


    {*
      Removes a value from the map based on the key.  In Qt's QMap, remove() returns
      the number of values removed, which may be more than one if insertMulti() is allowed.
      Since insertMulti() is not (yet?) implemented here, remove() will return a maximum of 1.
    }
    function TQIntegerObjectMap.remove( const key: integer ): integer;
      begin
        result := integerObjectMapRemove( _h, key );
      end
    ;


    function TQIntegerObjectMap.contains( const key: integer ): boolean;
      begin
        result := integerObjectMapContains( _h, key );
      end
    ;


    function TQIntegerObjectMap.qHasKey( const key: integer ): boolean;
      begin
        result := self.contains( key );
      end
    ;


    {*
      Removes all values from the map.  Objects stored in the map are NOT freed.
    }
    procedure TQIntegerObjectMap.clear();
      begin
        integerObjectMapClear( _h );
      end
    ;


    {*
      Removes all values from the map, AND deletes (frees) objects stored in the map.
      There is no exact equivalent to deleteValues() in Qt's QMap, but erase() is close.
    }
    procedure TQIntegerObjectMap.deleteValues();
      var
        tempObj: TObject;
        itemFound: boolean;

        function removeFirst(): TObject;
          begin
            if( self.isEmpty ) then
              result := nil
            else
              result := integerObjectMapRemoveFirst( _h )
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


    procedure TQIntegerObjectMap.delete( const key: integer );
      var
        val: TObject;
      begin
        val := self.value( key );
        self.remove( key );
        val.Free();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerObjectMap: Properties
  //---------------------------------------------------------------------------
    function TQIntegerObjectMap.getIsEmpty(): boolean;
      begin
        result := integerObjectMapIsEmpty( _h );
      end
    ;


    function TQIntegerObjectMap.getSize(): integer;
      begin
        result := integerObjectMapSize( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerObjectMap: Testing/debugging
  //---------------------------------------------------------------------------
    {*
      Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used,
      otherwise test() won't do anything.

      Qt's QMap has no equivalent of test(), but it can be a handy little function.
    }
    procedure TQIntegerObjectMap.test();
      begin
        integerObjectMapTest( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerObjectMap iterator: Construction
  //---------------------------------------------------------------------------
    constructor TQIntegerObjectMapIterator.create( const map: TQIntegerObjectMap );
      begin
        inherited create();

        _map := map;
        _idx := 0;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerObjectMap iterator: Useful functions
  //---------------------------------------------------------------------------
    function TQIntegerObjectMapIterator.key(): integer;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := integerObjectMapIteratorKey( _map._h, _idx )
        else
          raise exception.Create( '_idx out of bounds in TQIntegerObjectMapIterator.key' )
        ;
      end
    ;


    function TQIntegerObjectMapIterator.value(): TObject;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := integerObjectMapIteratorValue( _map._h, _idx )
        else
          result := nil
        ;
      end
    ;


    procedure TQIntegerObjectMapIterator.incr();
      begin
        if( _map.count > _idx ) then inc( _idx );
      end
    ;


    procedure TQIntegerObjectMapIterator.decr();
      begin
        if( -1 < _idx ) then dec( _idx );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerObjectMap: load function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadIntegerObjectMapDLL( var dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadIntegerObjectMapDLL...', SHOWDEBUGMSG );

        newIntegerObjectMap := GetProcAddress( dllHandle, 'newIntegerObjectMap' );
        if( nil = @newIntegerObjectMap ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newIntegerObjectMap.' + endl;
            result := false;
          end
        ;

        freeIntegerObjectMap := GetProcAddress( dllHandle, 'freeIntegerObjectMap' );
        if( nil = @freeIntegerObjectMap ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: freeIntegerObjectMap.' + endl;
            result := false;
          end
        ;

        integerObjectMapInsert := GetProcAddress( dllHandle, 'integerObjectMapInsert' );
        if( nil = @integerObjectMapInsert ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapInsert.' + endl;
            result := false;
          end
        ;

        integerObjectMapValue := GetProcAddress( dllHandle, 'integerObjectMapValue' );
        if( nil = @integerObjectMapValue ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapValue.' + endl;
            result := false;
          end
        ;

        integerObjectMapItemAtIndex := GetProcAddress( dllHandle, 'integerObjectItemAtIndex' );
        if( nil = @integerObjectMapItemAtIndex ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapItemAtIndex.' + endl;
            result := false;
          end
        ;

        integerObjectMapKeyAtIndex := GetProcAddress( dllHandle, 'integerObjectKeyAtIndex' );
        if( nil = @integerObjectMapKeyAtIndex ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapKeyAtIndex.' + endl;
            result := false;
          end
        ;

        integerObjectMapBegin := GetProcAddress( dllHandle, 'integerObjectMapBegin' );
        if( nil = @integerObjectMapBegin ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapBegin.' + endl;
            result := false;
          end
        ;

        integerObjectMapRemoveFirst := GetProcAddress( dllHandle, 'integerObjectMapRemoveFirst' );
        if( nil = @integerObjectMapRemoveFirst ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapRemoveFirst.' + endl;
            result := false;
          end
        ;

        integerObjectMapRemove := GetProcAddress( dllHandle, 'integerObjectMapRemove' );
        if( nil = @integerObjectMapRemove ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapRemove.' + endl;
            result := false;
          end
        ;

        integerObjectMapContains := GetProcAddress( dllHandle, 'integerObjectMapContains' );
        if( nil = @integerObjectMapContains ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapContains.' + endl;
            result := false;
          end
        ;

        integerObjectMapClear := GetProcAddress( dllHandle, 'integerObjectMapClear' );
        if( nil = @integerObjectMapClear ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapClear.' + endl;
            result := false;
          end
        ;

        integerObjectMapIsEmpty := GetProcAddress( dllHandle, 'integerObjectMapIsEmpty' );
        if( nil = @integerObjectMapIsEmpty ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapIsEmpty.' + endl;
            result := false;
          end
        ;

        integerObjectMapSize := GetProcAddress( dllHandle, 'integerObjectMapSize' );
        if( nil = @integerObjectMapSize ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapSize.' + endl;
            result := false;
          end
        ;

        integerObjectMapTest := GetProcAddress( dllHandle, 'integerObjectMapTest' );
        if( nil = @integerObjectMapTest ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapTest.' + endl;
            result := false;
          end
        ;

        // Iterator functions
        //-------------------
        integerObjectMapIteratorKey := GetProcAddress( dllHandle, 'integerObjectMapIteratorKey' );
        if( nil = @integerObjectMapIteratorKey ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapIteratorKey.' + endl;
            result := false;
          end
        ;

        integerObjectMapIteratorValue := GetProcAddress( dllHandle, 'integerObjectMapIteratorValue' );
        if( nil = @integerObjectMapIteratorValue ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerObjectMapIteratorValue.' + endl;
            result := false;
          end
        ;

        qintegerObjectMapLoaded := result;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// IntegerStringMap
//*****************************************************************************
  //---------------------------------------------------------------------------
  // Function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
  var
    // Map functions
    //--------------
    newIntegerStringMap: function(): TMapHandle; cdecl;
    freeIntegerStringMap: procedure( h: TMapHandle ); cdecl;

    integerStringMapInsert: procedure( h: TMapHandle; key: integer; val: String ); cdecl;
    integerStringMapValue: function( h: TMapHandle; key: integer ): pchar; cdecl;
    integerStringMapItemAtIndex: function( h: TMapHandle; idx: integer): pchar; cdecl;
    integerStringMapKeyAtIndex: function( h: TMapHandle; idx: integer): pchar; cdecl;
    integerStringMapBegin: function( h: TMapHandle ): pchar; cdecl;
    integerStringMapRemoveFirst: function( h: TMapHandle ): pchar; cdecl;

    integerStringMapRemove: function( h: TMapHandle; key: integer ): integer; cdecl;
    integerStringMapContains: function( h: TMapHandle; key: integer ): boolean; cdecl;
    integerStringMapClear: procedure( h: TMapHandle ); cdecl;

    integerStringMapIsEmpty: function( h: TMapHandle ): boolean; cdecl;
    integerStringMapSize: function( h: TMapHandle ): integer; cdecl;

    integerStringMapTest: procedure( h: TMapHandle ); cdecl;

    // Map iterator functions
    //-----------------------
    integerStringMapIteratorKey: function( const h: TMapHandle; const idx: integer ): integer; cdecl;
    integerStringMapIteratorValue: function( const h: TMapHandle; const idx: integer ): pchar; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerStringMap: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQIntegerStringMap.create();
      begin
        qIntegerStringMapLoaded := qIntegerStringMapLoaded;

        inherited create();
        if ( qIntegerStringMapLoaded ) then
          begin
            _h := newIntegerStringMap();

            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQIntegerStringMap.create( const source: TQIntegerStringMap );
      begin
        qIntegerStringMapLoaded := qIntegerStringMapLoaded;

        inherited create();
        if ( qIntegerStringMapLoaded ) then
          begin
            _h := newIntegerStringMap();

            self.assign( source );
            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
          end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end;
      end
    ;


    {*
      Deletes (frees) the map.
    }
    destructor TQIntegerStringMap.destroy();
      begin
        freeIntegerStringMap( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerStringMap: Useful functions
  //---------------------------------------------------------------------------
    {*
      Copys an existing map.
    }
    procedure TQIntegerStringMap.assign( source: TQIntegerStringMap );
      var
        i: integer;
      begin
        for i := 0 to source.count - 1 do
          self.insert( source.keyAtIndex( i ), source.itemAtIndex( i ) )
        ;
      end
    ;


    {*
      Inserts a new value into the map, with the specified key.  In Qt's QMap, insert()
      returns an iterator that contains the newly inserted object.  Here, insert()
      has no return value.
    }
    procedure TQIntegerStringMap.insert( const key: integer; const val: String );
      begin
        integerStringMapInsert( _h, key, val );
      end
    ;


    procedure TQIntegerStringMap.Add(const key: integer; const val: String );
      begin
        insert( key, val );
      end
    ;


    function TQIntegerStringMap.value( const key: integer ): String;
      begin
        result := String( integerStringMapValue( _h, key ) );
      end
    ;


    function TQIntegerStringMap.GetItemByIndex( const idx: Integer ): String;
      begin
        result := String( integerStringMapItemAtIndex( _h, idx ) );
      end
    ;


    function TQIntegerStringMap.GetKeyByIndex( const idx: Integer ): integer;
      begin
        result := integer( integerStringMapKeyAtIndex( _h, idx ) );
      end
    ;


    function TQIntegerStringMap.keyAtIndex( const idx: integer ): integer;
      begin
        result := GetKeyByIndex( idx );
      end
    ;


    function TQIntegerStringMap.itemAtIndex( const idx: integer ): String;
      begin
        result := GetItemByIndex( idx );
      end
    ;


    {*
      Returns the first string in the map.  Renamed from begin() in QMap because
      "begin" is a reserved word in Delphi.  in QMap, begin() returns an iterator.
      Because iterators have not been fully reimplemented here, first() returns
      the string that is the first value in the map.  The key associated with this
      value is not available (although it could be stored in a char buffer, if
      needed).

      Returns '' if the map is empty.
    }
    function TQIntegerStringMap.first(): String;
      begin
        if( self.isEmpty ) then
          result := ''
        else
          result := String( integerStringMapBegin( _h ) )
        ;
      end
    ;


    {*
      Removes a value from the map based on the key.  In Qt's QMap, remove() returns
      the number of values removed, which may be more than one if insertMulti() is allowed.
      Since insertMulti() is not (yet?) implemented here, remove() will return a maximum of 1.
    }
    function TQIntegerStringMap.remove( const key: integer ): integer;
      begin
        result := integerStringMapRemove( _h, key );
      end
    ;


    function TQIntegerStringMap.contains( const key: integer ): boolean;
      begin
        result := integerStringMapContains( _h, key );
      end
    ;


    function TQIntegerStringMap.qHasKey( const key: integer ): boolean;
      begin
        result := self.contains( key );
      end
    ;


    {*
      Removes all values from the map.
    }
    procedure TQIntegerStringMap.clear();
      begin
        integerStringMapClear( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerStringMap: Properties
  //---------------------------------------------------------------------------
    function TQIntegerStringMap.getIsEmpty(): boolean;
      begin
        result := integerStringMapIsEmpty( _h );
      end
    ;


    function TQIntegerStringMap.getSize(): integer;
      begin
        result := integerStringMapSize( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerStringMap: Testing/debugging
  //---------------------------------------------------------------------------
    {*
      Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used,
      otherwise test() won't do anything.

      Qt's QMap has no equivalent of test(), but it can be a handy little function.
    }
    procedure TQIntegerStringMap.test();
      begin
        integerStringMapTest( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerStringMap iterator: Construction
  //---------------------------------------------------------------------------
    constructor TQIntegerStringMapIterator.create( const map: TQIntegerStringMap );
      begin
        inherited create();

        _map := map;
        _idx := 0;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerStringMap iterator: Useful functions
  //---------------------------------------------------------------------------
    function TQIntegerStringMapIterator.key(): integer;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := integerStringMapIteratorKey( _map._h, _idx )
        else
          raise exception.create( '_idx out of bounds in TQIntegerStringMapIterator.key' )
        ;
      end
    ;


    function TQIntegerStringMapIterator.value(): String;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := integerStringMapIteratorValue( _map._h, _idx )
        else
          result := ''
        ;
      end
    ;


    procedure TQIntegerStringMapIterator.incr();
      begin
        if( _map.count > _idx ) then inc( _idx );
      end
    ;


    procedure TQIntegerStringMapIterator.decr();
      begin
        if( -1 < _idx ) then dec( _idx );
      end
    ;


    function TQIntegerStringMapIterator.isEmpty(): Boolean;
      begin
        result := Done();
      end
    ;


    function TQIntegerStringMapIterator.Done(): Boolean;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
           result := false
         else
           result := true
         ;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerStringMap: load function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadIntegerStringMapDLL( var dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadIntegerStringMapDLL...', SHOWDEBUGMSG );

        newIntegerStringMap := GetProcAddress( dllHandle, 'newIntegerStringMap' );
        if( nil = @newIntegerStringMap ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newIntegerStringMap.' + endl;
            result := false;
          end
        ;

        freeIntegerStringMap := GetProcAddress( dllHandle, 'freeIntegerStringMap' );
        if( nil = @freeIntegerStringMap ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: freeIntegerStringMap.' + endl;
            result := false;
          end
        ;

        integerStringMapInsert := GetProcAddress( dllHandle, 'integerStringMapInsert' );
        if( nil = @integerStringMapInsert ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapInsert.' + endl;
            result := false;
          end
        ;

        integerStringMapValue := GetProcAddress( dllHandle, 'integerStringMapValue' );
        if( nil = @integerStringMapValue ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapValue.' + endl;
            result := false;
          end
        ;

        integerStringMapItemAtIndex := GetProcAddress( dllHandle, 'integerStringItemAtIndex' );
        if( nil = @integerStringMapItemAtIndex ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapItemAtIndex.' + endl;
            result := false;
          end
        ;

        integerStringMapKeyAtIndex := GetProcAddress( dllHandle, 'integerStringKeyAtIndex' );
        if( nil = @integerStringMapKeyAtIndex ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapKeyAtIndex.' + endl;
            result := false;
          end
        ;

        integerStringMapBegin := GetProcAddress( dllHandle, 'integerStringMapBegin' );
        if( nil = @integerStringMapBegin ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapBegin.' + endl;
            result := false;
          end
        ;

        integerStringMapRemoveFirst := GetProcAddress( dllHandle, 'integerStringMapRemoveFirst' );
        if( nil = @integerStringMapRemoveFirst ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapRemoveFirst.' + endl;
            result := false;
          end
        ;

        integerStringMapRemove := GetProcAddress( dllHandle, 'integerStringMapRemove' );
        if( nil = @integerStringMapRemove ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapRemove.' + endl;
            result := false;
          end
        ;

        integerStringMapContains := GetProcAddress( dllHandle, 'integerStringMapContains' );
        if( nil = @integerStringMapContains ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapContains.' + endl;
            result := false;
          end
        ;

        integerStringMapClear := GetProcAddress( dllHandle, 'integerStringMapClear' );
        if( nil = @integerStringMapClear ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapClear.' + endl;
            result := false;
          end
        ;

        integerStringMapIsEmpty := GetProcAddress( dllHandle, 'integerStringMapIsEmpty' );
        if( nil = @integerStringMapIsEmpty ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapIsEmpty.' + endl;
            result := false;
          end
        ;

        integerStringMapSize := GetProcAddress( dllHandle, 'integerStringMapSize' );
        if( nil = @integerStringMapSize ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapSize.' + endl;
            result := false;
          end
        ;

        integerStringMapTest := GetProcAddress( dllHandle, 'integerStringMapTest' );
        if( nil = @integerStringMapTest ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapTest.' + endl;
            result := false;
          end
        ;

        // Iterator functions
        //-------------------
        integerStringMapIteratorKey := GetProcAddress( dllHandle, 'integerStringMapIteratorKey' );
        if( nil = @integerStringMapIteratorKey ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapIteratorKey.' + endl;
            result := false;
          end
        ;

        integerStringMapIteratorValue := GetProcAddress( dllHandle, 'integerStringMapIteratorValue' );
        if( nil = @integerStringMapIteratorValue ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerStringMapIteratorValue.' + endl;
            result := false;
          end
        ;

        qintegerStringMapLoaded := result;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// IntegerIntegerMap
//*****************************************************************************
  //---------------------------------------------------------------------------
  // Function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
  var
    // Map functions
    //--------------
    newIntegerIntegerMap: function(): TMapHandle; cdecl;
    freeIntegerIntegerMap: procedure( h: TMapHandle ); cdecl;

    integerIntegerMapInsert: procedure( h: TMapHandle; key: integer; val: integer ); cdecl;
    integerIntegerMapValue: function( h: TMapHandle; key: integer ): integer; cdecl;
    integerIntegerMapItemAtIndex: function( h: TMapHandle; idx: integer): integer; cdecl;
    integerIntegerMapKeyAtIndex: function( h: TMapHandle; idx: integer): integer; cdecl;
    integerIntegerMapBegin: function( h: TMapHandle ): integer; cdecl;
    integerIntegerMapRemoveFirst: function( h: TMapHandle ): integer; cdecl;

    integerIntegerMapRemove: function( h: TMapHandle; key: integer ): integer; cdecl;
    integerIntegerMapContains: function( h: TMapHandle; key: integer ): boolean; cdecl;
    integerIntegerMapClear: procedure( h: TMapHandle ); cdecl;

    integerIntegerMapIsEmpty: function( h: TMapHandle ): boolean; cdecl;
    integerIntegerMapSize: function( h: TMapHandle ): integer; cdecl;

    integerIntegerMapTest: procedure( h: TMapHandle ); cdecl;

    // Map iterator functions
    //-----------------------
    integerIntegerMapIteratorKey: function( const h: TMapHandle; const idx: integer ): integer; cdecl;
    integerIntegerMapIteratorValue: function( const h: TMapHandle; const idx: integer ): integer; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerIntegerMap: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQIntegerIntegerMap.create();
      begin
        qIntegerIntegerMapLoaded := qIntegerIntegerMapLoaded;

        inherited create();
        if ( qIntegerIntegerMapLoaded ) then
          begin
            _h := newIntegerIntegerMap();

            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQIntegerIntegerMap.create( const source: TQIntegerIntegerMap );
      begin
        qIntegerIntegerMapLoaded := qIntegerIntegerMapLoaded;

        inherited create();
        if ( qIntegerIntegerMapLoaded ) then
          begin
            _h := newIntegerIntegerMap();

            self.assign( source );
            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
          end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end;
      end
    ;


    {*
      Deletes (frees) the map.
    }
    destructor TQIntegerIntegerMap.destroy();
      begin
        freeIntegerIntegerMap( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerIntegerMap: Useful functions
  //---------------------------------------------------------------------------
    {*
      Copys an existing map.
    }
    procedure TQIntegerIntegerMap.assign( source: TQIntegerIntegerMap );
      var
        i: integer;
      begin
        for i := 0 to source.count - 1 do
          self.insert( source.keyAtIndex( i ), source.itemAtIndex( i ) )
        ;
      end
    ;


    {*
      Inserts a new value into the map, with the specified key.  In Qt's QMap, insert()
      returns an iterator that contains the newly inserted object.  Here, insert()
      has no return value.
    }
    procedure TQIntegerIntegerMap.insert( const key: integer; const val: integer );
      begin
        integerIntegerMapInsert( _h, key, val );
      end
    ;


    procedure TQIntegerIntegerMap.Add(const key: integer; const val: integer );
      begin
        insert( key, val );
      end
    ;


    function TQIntegerIntegerMap.value( const key: integer ): integer;
      begin
        result := integer( integerIntegerMapValue( _h, key ) );
      end
    ;


    function TQIntegerIntegerMap.GetItemByIndex( const idx: Integer ): integer;
      begin
        result := integer( integerIntegerMapItemAtIndex( _h, idx ) );
      end
    ;


    function TQIntegerIntegerMap.GetKeyByIndex( const idx: Integer ): integer;
      begin
        result := integer( integerIntegerMapKeyAtIndex( _h, idx ) );
      end
    ;


    function TQIntegerIntegerMap.keyAtIndex( const idx: integer ): integer;
      begin
        result := GetKeyByIndex( idx );
      end
    ;


    function TQIntegerIntegerMap.itemAtIndex( const idx: integer ): integer;
      begin
        result := GetItemByIndex( idx );
      end
    ;


    {*
      Returns the first integer in the map.  Renamed from begin() in QMap because
      "begin" is a reserved word in Delphi.  in QMap, begin() returns an iterator.
      Because iterators have not been fully reimplemented here, first() returns
      the integer that is the first value in the map.  The key associated with this
      value is not available (although it could be stored in a char buffer, if
      needed).

      Returns '' if the map is empty.
    }
    function TQIntegerIntegerMap.first(): integer;
      begin
        if( self.isEmpty ) then
          raise exception.Create( 'Map is empty in TQIntegerIntegerMap.first' )
        else
          result := integerIntegerMapBegin( _h )
        ;
      end
    ;


    {*
      Removes a value from the map based on the key.  In Qt's QMap, remove() returns
      the number of values removed, which may be more than one if insertMulti() is allowed.
      Since insertMulti() is not (yet?) implemented here, remove() will return a maximum of 1.
    }
    function TQIntegerIntegerMap.remove( const key: integer ): integer;
      begin
        result := integerIntegerMapRemove( _h, key );
      end
    ;


    function TQIntegerIntegerMap.contains( const key: integer ): boolean;
      begin
        result := integerIntegerMapContains( _h, key );
      end
    ;


    function TQIntegerIntegerMap.qHasKey( const key: integer ): boolean;
      begin
        result := self.contains( key );
      end
    ;


    procedure TQIntegerIntegerMap.incrAtKey( const key: integer );
      begin
        if( not( contains( key ) ) ) then
          insert( key, 0 )
        ;
        item[key] := value( key ) + 1;
      end
    ;


    procedure TQIntegerIntegerMap.decrAtKey( const key: integer );
      begin
        if( not( contains( key ) ) ) then
          insert( key, 0 )
        ;
        item[key] := value( key ) - 1;
      end
    ;


    {*
      Removes all values from the map.
    }
    procedure TQIntegerIntegerMap.clear();
      begin
        integerIntegerMapClear( _h );
      end
    ;


    {*
      Writes contents of the map to the debug window.
    }
    procedure TQIntegerIntegerMap.debug();
      var
        i: integer;
      begin
        dbcout( '======== TQIntegerIntegerMap.debug:', true );
        for i := 0 to self.count - 1 do
          dbcout( 'Key: ' + intToStr( self.keyAtIndex( i ) ) + ', Value: ' + intToStr( self.itemAtIndex( i ) ), true )
        ;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerIntegerMap: Properties
  //---------------------------------------------------------------------------
    function TQIntegerIntegerMap.getIsEmpty(): boolean;
      begin
        result := integerIntegerMapIsEmpty( _h );
      end
    ;


    function TQIntegerIntegerMap.getSize(): integer;
      begin
        result := integerIntegerMapSize( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerIntegerMap: Testing/debugging
  //---------------------------------------------------------------------------
    {*
      Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used,
      otherwise test() won't do anything.

      Qt's QMap has no equivalent of test(), but it can be a handy little function.
    }
    procedure TQIntegerIntegerMap.test();
      begin
        integerIntegerMapTest( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerIntegerMap iterator: Construction
  //---------------------------------------------------------------------------
    constructor TQIntegerIntegerMapIterator.create( const map: TQIntegerIntegerMap );
      begin
        inherited create();

        _map := map;
        _idx := 0;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerIntegerMap iterator: Useful functions
  //---------------------------------------------------------------------------
    function TQIntegerIntegerMapIterator.key(): integer;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := integerIntegerMapIteratorKey( _map._h, _idx )
        else
          raise exception.Create( '_idx out of bounds in TQIntegerIntegerMapIterator.key()' )
        ;
      end
    ;


    function TQIntegerIntegerMapIterator.value(): integer;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := integerIntegerMapIteratorValue( _map._h, _idx )
        else
          raise exception.Create( 'Problem in TQIntegerIntegerMapIterator.value' )
        ;
      end
    ;


    procedure TQIntegerIntegerMapIterator.incr();
      begin
        if( _map.count > _idx ) then inc( _idx );
      end
    ;


    procedure TQIntegerIntegerMapIterator.decr();
      begin
        if( -1 < _idx ) then dec( _idx );
      end
    ;


    function TQIntegerIntegerMapIterator.isEmpty(): Boolean;
      begin
        result := Done();
      end
    ;


    function TQIntegerIntegerMapIterator.Done(): Boolean;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
           result := false
         else
           result := true
         ;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerIntegerMap: load function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadIntegerIntegerMapDLL( var dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadIntegerIntegerMapDLL...', SHOWDEBUGMSG );

        newIntegerIntegerMap := GetProcAddress( dllHandle, 'newIntegerIntegerMap' );
        if( nil = @newIntegerIntegerMap ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newIntegerIntegerMap.' + endl;
            result := false;
          end
        ;

        freeIntegerIntegerMap := GetProcAddress( dllHandle, 'freeIntegerIntegerMap' );
        if( nil = @freeIntegerIntegerMap ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: freeIntegerIntegerMap.' + endl;
            result := false;
          end
        ;

        integerIntegerMapInsert := GetProcAddress( dllHandle, 'integerIntegerMapInsert' );
        if( nil = @integerIntegerMapInsert ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapInsert.' + endl;
            result := false;
          end
        ;

        integerIntegerMapValue := GetProcAddress( dllHandle, 'integerIntegerMapValue' );
        if( nil = @integerIntegerMapValue ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapValue.' + endl;
            result := false;
          end
        ;

        integerIntegerMapItemAtIndex := GetProcAddress( dllHandle, 'integerIntegerItemAtIndex' );
        if( nil = @integerIntegerMapItemAtIndex ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapItemAtIndex.' + endl;
            result := false;
          end
        ;

        integerIntegerMapKeyAtIndex := GetProcAddress( dllHandle, 'integerIntegerKeyAtIndex' );
        if( nil = @integerIntegerMapKeyAtIndex ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapKeyAtIndex.' + endl;
            result := false;
          end
        ;

        integerIntegerMapBegin := GetProcAddress( dllHandle, 'integerIntegerMapBegin' );
        if( nil = @integerIntegerMapBegin ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapBegin.' + endl;
            result := false;
          end
        ;

        integerIntegerMapRemoveFirst := GetProcAddress( dllHandle, 'integerIntegerMapRemoveFirst' );
        if( nil = @integerIntegerMapRemoveFirst ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapRemoveFirst.' + endl;
            result := false;
          end
        ;

        integerIntegerMapRemove := GetProcAddress( dllHandle, 'integerIntegerMapRemove' );
        if( nil = @integerIntegerMapRemove ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapRemove.' + endl;
            result := false;
          end
        ;

        integerIntegerMapContains := GetProcAddress( dllHandle, 'integerIntegerMapContains' );
        if( nil = @integerIntegerMapContains ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapContains.' + endl;
            result := false;
          end
        ;

        integerIntegerMapClear := GetProcAddress( dllHandle, 'integerIntegerMapClear' );
        if( nil = @integerIntegerMapClear ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapClear.' + endl;
            result := false;
          end
        ;

        integerIntegerMapIsEmpty := GetProcAddress( dllHandle, 'integerIntegerMapIsEmpty' );
        if( nil = @integerIntegerMapIsEmpty ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapIsEmpty.' + endl;
            result := false;
          end
        ;

        integerIntegerMapSize := GetProcAddress( dllHandle, 'integerIntegerMapSize' );
        if( nil = @integerIntegerMapSize ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapSize.' + endl;
            result := false;
          end
        ;

        integerIntegerMapTest := GetProcAddress( dllHandle, 'integerIntegerMapTest' );
        if( nil = @integerIntegerMapTest ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapTest.' + endl;
            result := false;
          end
        ;

        // Iterator functions
        //-------------------
        integerIntegerMapIteratorKey := GetProcAddress( dllHandle, 'integerIntegerMapIteratorKey' );
        if( nil = @integerIntegerMapIteratorKey ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapIteratorKey.' + endl;
            result := false;
          end
        ;

        integerIntegerMapIteratorValue := GetProcAddress( dllHandle, 'integerIntegerMapIteratorValue' );
        if( nil = @integerIntegerMapIteratorValue ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerIntegerMapIteratorValue.' + endl;
            result := false;
          end
        ;

        qintegerIntegerMapLoaded := result;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************


//*****************************************************************************
// IntegerDoubleMap
//*****************************************************************************
  //---------------------------------------------------------------------------
  // Function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
  var
    // Map functions
    //--------------
    newIntegerDoubleMap: function(): TMapHandle; cdecl;
    freeIntegerDoubleMap: procedure( h: TMapHandle ); cdecl;

    integerDoubleMapInsert: procedure( h: TMapHandle; key: integer; val: double ); cdecl;
    integerDoubleMapValue: function( h: TMapHandle; key: integer ): double; cdecl;
    integerDoubleMapItemAtIndex: function( h: TMapHandle; idx: integer): double; cdecl;
    integerDoubleMapKeyAtIndex: function( h: TMapHandle; idx: integer): pchar; cdecl;
    integerDoubleMapBegin: function( h: TMapHandle ): double; cdecl;
    integerDoubleMapRemoveFirst: function( h: TMapHandle ): double; cdecl;

    integerDoubleMapRemove: function( h: TMapHandle; key: integer ): integer; cdecl;
    integerDoubleMapContains: function( h: TMapHandle; key: integer ): boolean; cdecl;
    integerDoubleMapClear: procedure( h: TMapHandle ); cdecl;

    integerDoubleMapIsEmpty: function( h: TMapHandle ): boolean; cdecl;
    integerDoubleMapSize: function( h: TMapHandle ): integer; cdecl;

    integerDoubleMapTest: procedure( h: TMapHandle ); cdecl;

    // Map iterator functions
    //-----------------------
    integerDoubleMapIteratorKey: function( const h: TMapHandle; const idx: integer ): integer; cdecl;
    integerDoubleMapIteratorValue: function( const h: TMapHandle; const idx: integer ): double; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerDoubleMap: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQIntegerDoubleMap.create();
      begin
        qIntegerDoubleMapLoaded := qIntegerDoubleMapLoaded;

        inherited create();
        if ( qIntegerDoubleMapLoaded ) then
          begin
            _h := newIntegerDoubleMap();

            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQIntegerDoubleMap.create( const source: TQIntegerDoubleMap );
      begin
        qIntegerDoubleMapLoaded := qIntegerDoubleMapLoaded;

        inherited create();
        if ( qIntegerDoubleMapLoaded ) then
          begin
            _h := newIntegerDoubleMap();

            self.assign( source );
            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
          end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end;
      end
    ;


    {*
      Deletes (frees) the map.  Doubles stored as values in the map are not deleted.
      To delete the objects in the map, use deleteValues() first.
    }
    destructor TQIntegerDoubleMap.destroy();
      begin
        freeIntegerDoubleMap( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerDoubleMap: Useful functions
  //---------------------------------------------------------------------------
    procedure TQIntegerDoubleMap.assign( Source: TQIntegerDoubleMap );
      var
        i: integer;
      begin
        for i := 0 to source.count - 1 do
          self.insert( source.keyAtIndex( i ), source.itemAtIndex( i ) )
        ;
      end
    ;


    {*
      Inserts a new value into the map, with the specified key.  In Qt's QMap, insert()
      returns an iterator that contains the newly inserted object.  Here, insert()
      has no return value.
    }
    procedure TQIntegerDoubleMap.insert( const key: integer; const val: double );
      begin
        integerDoubleMapInsert( _h, key, val );
      end
    ;


    procedure TQIntegerDoubleMap.Add(const key: integer; const val: double );
      begin
        insert( key, val );
      end
    ;


    function TQIntegerDoubleMap.value( const key: integer ): double;
      begin
        result := integerDoubleMapValue( _h, key );
      end
    ;


    function TQIntegerDoubleMap.GetItemByIndex( const idx: Integer ): double;
      begin
        result := integerDoubleMapItemAtIndex( _h, idx );
      end
    ;


    function TQIntegerDoubleMap.GetKeyByIndex( const idx: Integer ): integer;
      begin
        result := integer( integerDoubleMapKeyAtIndex( _h, idx ) );
      end
    ;


    function TQIntegerDoubleMap.keyAtIndex( const idx: integer ): integer;
      begin
        result := GetKeyByIndex( idx );
      end
    ;


    function TQIntegerDoubleMap.itemAtIndex( const idx: integer ): double;
      begin
        result := GetItemByIndex( idx );
      end
    ;


    {*
      Returns the first value in the map.  Renamed from begin() in QMap because
      "begin" is a reserved word in Delphi.  in QMap, begin() returns an iterator.
      Because iterators have not been fully reimplemented here, first() returns
      the object that is the first value in the map.  The key associated with this
      value is not available.

      Returns nil if the map is empty.
    }
    function TQIntegerDoubleMap.first(): double;
      begin
        if( self.isEmpty ) then
          raise exception.Create( 'Map is empty in TQIntegerDoubleMap.first' )
        else
          result := integerDoubleMapBegin( _h )
        ;
      end
    ;


    {*
      Removes a value from the map based on the key.  In Qt's QMap, remove() returns
      the number of values removed, which may be more than one if insertMulti() is allowed.
      Since insertMulti() is not (yet?) implemented here, remove() will return a maximum of 1.
    }
    function TQIntegerDoubleMap.remove( const key: integer ): integer;
      begin
        result := integerDoubleMapRemove( _h, key );
      end
    ;


    function TQIntegerDoubleMap.contains( const key: integer ): boolean;
      begin
        result := integerDoubleMapContains( _h, key );
      end
    ;


    {*
      Removes all values from the map.
    }
    procedure TQIntegerDoubleMap.clear();
      begin
        integerDoubleMapClear( _h );
      end
    ;


    procedure TQIntegerDoubleMap.debug();
      var
        i: integer;
      begin
        dbcout( endl + '==== TQIntegerDoubleMap.debug()', true );

        for i := 0 to self.count - 1 do
          dbcout( '  key: ' + intToStr( self.keyAtIndex( i ) ) + ', value: ' + usFloatToStr( self.itemAtIndex( i ) ), true )
        ;

        dbcout( '==== done.', true );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerDoubleMap: Properties
  //---------------------------------------------------------------------------
    function TQIntegerDoubleMap.getIsEmpty(): boolean;
      begin
        result := integerDoubleMapIsEmpty( _h );
      end
    ;


    function TQIntegerDoubleMap.getSize(): integer;
      begin
        result := integerDoubleMapSize( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerDoubleMap: Testing/debugging
  //---------------------------------------------------------------------------
    {*
      Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used,
      otherwise test() won't do anything.

      Qt's QMap has no equivalent of test(), but it can be a handy little function.
    }
    procedure TQIntegerDoubleMap.test();
      begin
        integerDoubleMapTest( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerDoubleMap iterator: Construction
  //---------------------------------------------------------------------------
    constructor TQIntegerDoubleMapIterator.create( const map: TQIntegerDoubleMap );
      begin
        inherited create();

        _map := map;
        _idx := 0;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerDoubleMap iterator: Useful functions
  //---------------------------------------------------------------------------
    function TQIntegerDoubleMapIterator.key(): integer;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := integerDoubleMapIteratorKey( _map._h, _idx )
        else
          raise exception.Create( '_idx out of bounds in TQIntegerDoubleMapIterator.key' )
        ;
      end
    ;


    function TQIntegerDoubleMapIterator.value(): double;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := integerDoubleMapIteratorValue( _map._h, _idx )
        else
          raise exception.Create( 'Problem in TQIntegerDoubleMapIterator.value' )
        ;
      end
    ;


    procedure TQIntegerDoubleMapIterator.incr();
      begin
        if( _map.count > _idx ) then inc( _idx );
      end
    ;


    procedure TQIntegerDoubleMapIterator.decr();
      begin
        if( -1 < _idx ) then dec( _idx );
      end
    ;


    function TQIntegerDoubleMapIterator.isEmpty(): Boolean;
      begin
        result := Done();
      end
    ;


    function TQIntegerDoubleMapIterator.Done(): Boolean;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
           result := false
         else
           result := true
         ;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerDoubleMap: load function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadIntegerDoubleMapDLL( var dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadIntegerDoubleMapDLL...', SHOWDEBUGMSG );

        newIntegerDoubleMap := GetProcAddress( dllHandle, 'newIntegerDoubleMap' );
        if( nil = @newIntegerDoubleMap ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newIntegerDoubleMap.' + endl;
            result := false;
          end
        ;

        freeIntegerDoubleMap := GetProcAddress( dllHandle, 'freeIntegerDoubleMap' );
        if( nil = @freeIntegerDoubleMap ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: freeIntegerDoubleMap.' + endl;
            result := false;
          end
        ;

        integerDoubleMapInsert := GetProcAddress( dllHandle, 'integerDoubleMapInsert' );
        if( nil = @integerDoubleMapInsert ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapInsert.' + endl;
            result := false;
          end
        ;

        integerDoubleMapValue := GetProcAddress( dllHandle, 'integerDoubleMapValue' );
        if( nil = @integerDoubleMapValue ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapValue.' + endl;
            result := false;
          end
        ;

        integerDoubleMapItemAtIndex := GetProcAddress( dllHandle, 'integerDoubleItemAtIndex' );
        if( nil = @integerDoubleMapItemAtIndex ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapItemAtIndex.' + endl;
            result := false;
          end
        ;

        integerDoubleMapKeyAtIndex := GetProcAddress( dllHandle, 'integerDoubleKeyAtIndex' );
        if( nil = @integerDoubleMapKeyAtIndex ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapKeyAtIndex.' + endl;
            result := false;
          end
        ;

        integerDoubleMapBegin := GetProcAddress( dllHandle, 'integerDoubleMapBegin' );
        if( nil = @integerDoubleMapBegin ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapBegin.' + endl;
            result := false;
          end
        ;

        integerDoubleMapRemoveFirst := GetProcAddress( dllHandle, 'integerDoubleMapRemoveFirst' );
        if( nil = @integerDoubleMapRemoveFirst ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapRemoveFirst.' + endl;
            result := false;
          end
        ;

        integerDoubleMapRemove := GetProcAddress( dllHandle, 'integerDoubleMapRemove' );
        if( nil = @integerDoubleMapRemove ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapRemove.' + endl;
            result := false;
          end
        ;

        integerDoubleMapContains := GetProcAddress( dllHandle, 'integerDoubleMapContains' );
        if( nil = @integerDoubleMapContains ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapContains.' + endl;
            result := false;
          end
        ;

        integerDoubleMapClear := GetProcAddress( dllHandle, 'integerDoubleMapClear' );
        if( nil = @integerDoubleMapClear ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapClear.' + endl;
            result := false;
          end
        ;

        integerDoubleMapIsEmpty := GetProcAddress( dllHandle, 'integerDoubleMapIsEmpty' );
        if( nil = @integerDoubleMapIsEmpty ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapIsEmpty.' + endl;
            result := false;
          end
        ;

        integerDoubleMapSize := GetProcAddress( dllHandle, 'integerDoubleMapSize' );
        if( nil = @integerDoubleMapSize ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapSize.' + endl;
            result := false;
          end
        ;

        integerDoubleMapTest := GetProcAddress( dllHandle, 'integerDoubleMapTest' );
        if( nil = @integerDoubleMapTest ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapTest.' + endl;
            result := false;
          end
        ;

        // Iterator functions
        //-------------------
        integerDoubleMapIteratorKey := GetProcAddress( dllHandle, 'integerDoubleMapIteratorKey' );
        if( nil = @integerDoubleMapIteratorKey ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapIteratorKey.' + endl;
            result := false;
          end
        ;

        integerDoubleMapIteratorValue := GetProcAddress( dllHandle, 'integerDoubleMapIteratorValue' );
        if( nil = @integerDoubleMapIteratorValue ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerDoubleMapIteratorValue.' + endl;
            result := false;
          end
        ;

        qintegerDoubleMapLoaded := result;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// IntUIntMap
//*****************************************************************************
  //---------------------------------------------------------------------------
  // Function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
  var
    // Map functions
    //--------------
    newIntUIntMap: function(): TMapHandle; cdecl;
    freeIntUIntMap: procedure( h: TMapHandle ); cdecl;

    intUIntMapInsert: procedure( h: TMapHandle; key: integer; val: longword ); cdecl;
    intUIntMapValue: function( h: TMapHandle; key: integer ): longword; cdecl;
    intUIntMapItemAtIndex: function( h: TMapHandle; idx: integer): longword; cdecl;
    intUIntMapKeyAtIndex: function( h: TMapHandle; idx: integer): integer; cdecl;
    intUIntMapBegin: function( h: TMapHandle ): longword; cdecl;
    intUIntMapRemoveFirst: function( h: TMapHandle ): integer; cdecl;

    intUIntMapRemove: function( h: TMapHandle; key: integer ): integer; cdecl;
    intUIntMapContains: function( h: TMapHandle; key: integer ): boolean; cdecl;
    intUIntMapClear: procedure( h: TMapHandle ); cdecl;

    intUIntMapIsEmpty: function( h: TMapHandle ): boolean; cdecl;
    intUIntMapSize: function( h: TMapHandle ): integer; cdecl;

    intUIntMapTest: procedure( h: TMapHandle ); cdecl;

    // Map iterator functions
    //-----------------------
    intUIntMapIteratorKey: function( const h: TMapHandle; const idx: integer ): integer; cdecl;
    intUIntMapIteratorValue: function( const h: TMapHandle; const idx: integer ): longword; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntUIntMap: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQIntUIntMap.create();
      begin
        qIntUIntMapLoaded := qIntUIntMapLoaded;

        inherited create();
        if ( qIntUIntMapLoaded ) then
          begin
            _h := newIntUIntMap();

            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQIntUIntMap.create( const source: TQIntUIntMap );
      begin
        qIntUIntMapLoaded := qIntUIntMapLoaded;

        inherited create();
        if ( qIntUIntMapLoaded ) then
          begin
            _h := newIntUIntMap();

            self.assign( source );
            dbcout( 'Internal map address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
          end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal map address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end;
      end
    ;


    {*
      Deletes (frees) the map.
    }
    destructor TQIntUIntMap.destroy();
      begin
        freeIntUIntMap( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntUIntMap: Useful functions
  //---------------------------------------------------------------------------
    {*
      Copys an existing map.
    }
    procedure TQIntUIntMap.assign( source: TQIntUIntMap );
      var
        i: integer;
      begin
        for i := 0 to source.count - 1 do
          self.insert( source.keyAtIndex( i ), source.itemAtIndex( i ) )
        ;
      end
    ;


    {*
      Inserts a new value into the map, with the specified key.  In Qt's QMap, insert()
      returns an iterator that contains the newly inserted object.  Here, insert()
      has no return value.
    }
    procedure TQIntUIntMap.insert( const key: integer; const val: longword );
      begin
        intUIntMapInsert( _h, key, val );
      end
    ;


    procedure TQIntUIntMap.Add(const key: integer; const val: longword );
      begin
        insert( key, val );
      end
    ;


    function TQIntUIntMap.value( const key: integer ): longword;
      begin
        result := intUIntMapValue( _h, key );
      end
    ;


    function TQIntUIntMap.GetItemByIndex( const idx: Integer ): longword;
      begin
        result := intUIntMapItemAtIndex( _h, idx );
      end
    ;


    function TQIntUIntMap.GetKeyByIndex( const idx: Integer ): integer;
      begin
        result := intUIntMapKeyAtIndex( _h, idx );
      end
    ;


    function TQIntUIntMap.keyAtIndex( const idx: integer ): integer;
      begin
        result := GetKeyByIndex( idx );
      end
    ;


    function TQIntUIntMap.itemAtIndex( const idx: integer ): longword;
      begin
        result := GetItemByIndex( idx );
      end
    ;


    {*
      Returns the first longword in the map.  Renamed from begin() in QMap because
      "begin" is a reserved word in Delphi.  in QMap, begin() returns an iterator.
      Because iterators have not been fully reimplemented here, first() returns
      the longword that is the first value in the map.  The key associated with this
      value is not available (although it could be stored in a char buffer, if
      needed).

      Returns '' if the map is empty.
    }
    function TQIntUIntMap.first(): longword;
      begin
        if( self.isEmpty ) then
          raise exception.Create( 'Map is empty in TQIntUIntMap.first' )
        else
          result := intUIntMapBegin( _h )
        ;
      end
    ;


    {*
      Removes a value from the map based on the key.  In Qt's QMap, remove() returns
      the number of values removed, which may be more than one if insertMulti() is allowed.
      Since insertMulti() is not (yet?) implemented here, remove() will return a maximum of 1.
    }
    function TQIntUIntMap.remove( const key: integer ): integer;
      begin
        result := intUIntMapRemove( _h, key );
      end
    ;


    function TQIntUIntMap.contains( const key: integer ): boolean;
      begin
        result := intUIntMapContains( _h, key );
      end
    ;


    function TQIntUIntMap.qHasKey( const key: integer ): boolean;
      begin
        result := self.contains( key );
      end
    ;


    {*
      Removes all values from the map.
    }
    procedure TQIntUIntMap.clear();
      begin
        intUIntMapClear( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntUIntMap: Properties
  //---------------------------------------------------------------------------
    function TQIntUIntMap.getIsEmpty(): boolean;
      begin
        result := intUIntMapIsEmpty( _h );
      end
    ;


    function TQIntUIntMap.getSize(): integer;
      begin
        result := intUIntMapSize( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntUIntMap: Testing/debugging
  //---------------------------------------------------------------------------
    {*
      Shows the complete contents of the map.  A DEBUG version of qclasses.dll must be used,
      otherwise test() won't do anything.

      Qt's QMap has no equivalent of test(), but it can be a handy little function.
    }
    procedure TQIntUIntMap.test();
      begin
        intUIntMapTest( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntUIntMap iterator: Construction
  //---------------------------------------------------------------------------
    constructor TQIntUIntMapIterator.create( const map: TQIntUIntMap );
      begin
        inherited create();

        _map := map;
        _idx := 0;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntUIntMap iterator: Useful functions
  //---------------------------------------------------------------------------
    function TQIntUIntMapIterator.key(): integer;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := intUIntMapIteratorKey( _map._h, _idx )
        else
          raise exception.Create( '_idx out of bounds in TQIntUIntMapIterator.key' )
        ;
      end
    ;


    function TQIntUIntMapIterator.value(): longword;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
          result := intUIntMapIteratorValue( _map._h, _idx )
        else
          raise exception.Create( 'Problem in TQIntUIntMapIterator.value' )
        ;
      end
    ;


    procedure TQIntUIntMapIterator.incr();
      begin
        if( _map.count > _idx ) then inc( _idx );
      end
    ;


    procedure TQIntUIntMapIterator.decr();
      begin
        if( -1 < _idx ) then dec( _idx );
      end
    ;


    function TQIntUIntMapIterator.isEmpty(): Boolean;
      begin
        result := Done();
      end
    ;


    function TQIntUIntMapIterator.Done(): Boolean;
      begin
        if( ( _map.count > _idx ) and ( 0 <= _idx ) ) then
           result := false
         else
           result := true
         ;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntUIntMap: load function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadIntUIntMapDLL( var dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadIntUIntMapDLL...', SHOWDEBUGMSG );

        newIntUIntMap := GetProcAddress( dllHandle, 'newIntUIntMap' );
        if( nil = @newIntUIntMap ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newIntUIntMap.' + endl;
            result := false;
          end
        ;

        freeIntUIntMap := GetProcAddress( dllHandle, 'freeIntUIntMap' );
        if( nil = @freeIntUIntMap ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: freeIntUIntMap.' + endl;
            result := false;
          end
        ;

        intUIntMapInsert := GetProcAddress( dllHandle, 'intUIntMapInsert' );
        if( nil = @intUIntMapInsert ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapInsert.' + endl;
            result := false;
          end
        ;

        intUIntMapValue := GetProcAddress( dllHandle, 'intUIntMapValue' );
        if( nil = @intUIntMapValue ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapValue.' + endl;
            result := false;
          end
        ;

        intUIntMapItemAtIndex := GetProcAddress( dllHandle, 'intUIntItemAtIndex' );
        if( nil = @intUIntMapItemAtIndex ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapItemAtIndex.' + endl;
            result := false;
          end
        ;

        intUIntMapKeyAtIndex := GetProcAddress( dllHandle, 'intUIntKeyAtIndex' );
        if( nil = @intUIntMapKeyAtIndex ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapKeyAtIndex.' + endl;
            result := false;
          end
        ;

        intUIntMapBegin := GetProcAddress( dllHandle, 'intUIntMapBegin' );
        if( nil = @intUIntMapBegin ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapBegin.' + endl;
            result := false;
          end
        ;

        intUIntMapRemoveFirst := GetProcAddress( dllHandle, 'intUIntMapRemoveFirst' );
        if( nil = @intUIntMapRemoveFirst ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapRemoveFirst.' + endl;
            result := false;
          end
        ;

        intUIntMapRemove := GetProcAddress( dllHandle, 'intUIntMapRemove' );
        if( nil = @intUIntMapRemove ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapRemove.' + endl;
            result := false;
          end
        ;

        intUIntMapContains := GetProcAddress( dllHandle, 'intUIntMapContains' );
        if( nil = @intUIntMapContains ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapContains.' + endl;
            result := false;
          end
        ;

        intUIntMapClear := GetProcAddress( dllHandle, 'intUIntMapClear' );
        if( nil = @intUIntMapClear ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapClear.' + endl;
            result := false;
          end
        ;

        intUIntMapIsEmpty := GetProcAddress( dllHandle, 'intUIntMapIsEmpty' );
        if( nil = @intUIntMapIsEmpty ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapIsEmpty.' + endl;
            result := false;
          end
        ;

        intUIntMapSize := GetProcAddress( dllHandle, 'intUIntMapSize' );
        if( nil = @intUIntMapSize ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapSize.' + endl;
            result := false;
          end
        ;

        intUIntMapTest := GetProcAddress( dllHandle, 'intUIntMapTest' );
        if( nil = @intUIntMapTest ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapTest.' + endl;
            result := false;
          end
        ;

        // Iterator functions
        //-------------------
        intUIntMapIteratorKey := GetProcAddress( dllHandle, 'intUIntMapIteratorKey' );
        if( nil = @intUIntMapIteratorKey ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapIteratorKey.' + endl;
            result := false;
          end
        ;

        intUIntMapIteratorValue := GetProcAddress( dllHandle, 'intUIntMapIteratorValue' );
        if( nil = @intUIntMapIteratorValue ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: intUIntMapIteratorValue.' + endl;
            result := false;
          end
        ;

        qintUIntMapLoaded := result;
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

      if( dllHandle >= 32 ) then //then // library was successfully loaded.  Assign function pointers now.
        begin
          loadIntegerObjectMapDLL( dllHandle );
          loadIntegerStringMapDLL( dllHandle );
          loadIntegerIntegerMapDLL( dllHandle );
          loadIntUIntMapDLL( dllHandle );
          loadIntegerDoubleMapDLL( dllHandle );
        end
      ;
    end
  ;
//*****************************************************************************


initialization

  loadErrors := '';

  qIntegerObjectMapLoaded := false;
  qIntegerStringMapLoaded := false;
  qIntegerIntegerMapLoaded := false;
  qIntegerDoubleMapLoaded := false;
  qIntUIntMapLoaded := false;

  loadDynamicDLL();


end.