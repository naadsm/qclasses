unit QOrderedDictionaries;

(*
QOrderedDictionaries.pas
------------------------
Begin: 2007/01/18
Last revision: $Date: 2011-10-25 05:05:07 $ $Author: areeves $
Version: $Revision: 1.6 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2007 - 2010 Aaron Reeves

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

  Unlike items in a QMap, items in a QOrderedDictionary can be retrieved in the same
  order in which they were inserted into the dictionary.  (With QMap, retrieval order
  with an iterator or by index is based on the key.)
}

interface

  uses
    Classes,
    QStringMaps,
    QIntegerMaps,
    QLists
  ;

  type TQOrderedIntegerObjectDictionary = class
    protected
      _list: TQObjectList;
      _keys: TQIntegerIntegerMap;

      function getCount(): integer;
    public
      constructor create(); virtual;

      { Warning: objects in the dictionary will NOT be freed.  Use deleteValues() if that's what you want. }
      destructor destroy(); override;

      procedure clear();

      procedure freeItems();
      procedure deleteItems();
      procedure freeValues();
      procedure deleteValues();

      function getItemByIndex( const idx: integer ): TObject;
      function itemByIndex( const idx: integer ): TObject;
      function itemAtIndex( const idx: integer ): TObject;

      (*
      // FIX ME: for these functions to be implemented, the DLL will need to be changed.
      function getKeyByIndex( const idx: integer ): integer;
      function keyByIndex( const idx: integer ): integer;
      function keyAtIndex( const idx: integer ): integer;
      *)

      { Does the map contain a value with the specified key? }
      function contains( const key: integer ): boolean;

      function value( const key: integer ): TObject;
      procedure insert( const key: integer; val: TObject );
      
      property count: integer read getCount;
      property size: integer read getCount;
      property item[const key: integer]: TObject read value write insert; default;
    end
  ;


  type TQOrderedStringObjectDictionary = class
    protected
      _list: TQObjectList;
      _keys: TQStringIntMap;

      function getCount(): integer;
    public
      constructor create(); virtual;

      { Warning: objects in the dictionary will NOT be freed.  Use deleteValues() if that's what you want. }
      destructor destroy(); override;

      procedure clear();

      procedure freeItems();
      procedure deleteItems();
      procedure freeValues();
      procedure deleteValues();

      function getItemByIndex( const idx: integer ): TObject;
      function itemByIndex( const idx: integer ): TObject;
      function itemAtIndex( const idx: integer ): TObject;

      function getKeyByIndex( const idx: integer ): string;
      function keyByIndex( const idx: integer ): string;
      function keyAtIndex( const idx: integer ): string;

      function value( const key: string ): TObject;
      procedure insert( const key: string; val: TObject );
      
      property count: integer read getCount;
      property size: integer read getCount;
      property item[const key: String]: TObject read value write insert; default;
    end
  ;


  type TQOrderedStringStringDictionary = class
    protected
      _list: TQStringList;
      _keys: TQStringIntMap;

      function getCount(): integer;
    public
      constructor create(); virtual;
      destructor destroy(); override;

      procedure clear();

      function getItemByIndex( const idx: integer ): string;
      function itemByIndex( const idx: integer ): string;
      function itemAtIndex( const idx: integer ): string;

      function getKeyByIndex( const idx: integer ): string;
      function keyByIndex( const idx: integer ): string;
      function keyAtIndex( const idx: integer ): string;

      function value( const key: string ): string;
      procedure insert( const key: string; val: string );
      
      property count: integer read getCount;
      property size: integer read getCount;
      property item[const key: String]: string read value write insert; default;
    end
  ;

implementation

  uses
    SysUtils,
    
    DebugWindow
  ;

//{$DEFINE QORDEREDDICTIONARIES_DEBUG} // Define to enable debugging messages for this unit.
  
//*****************************************************************************
// TQOrderedIntegerObjectDictionary
//*****************************************************************************
  //---------------------------------------------------------------------------
  // TQOrderedIntegerObjectDictionary: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQOrderedIntegerObjectDictionary.create();
      begin
        inherited create();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedIntegerObjectDictionary.create()', true );
        {$ENDIF}

        _list := TQObjectList.create();
        _keys := TQIntegerIntegerMap.create();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedIntegerObjectDictionary.create()', true );
        {$ENDIF}
      end
    ;


    destructor TQOrderedIntegerObjectDictionary.destroy();
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedIntegerObjectDictionary.destroy()', true );
        {$ENDIF}

        freeAndNil( _list ); // Objects WILL NOT be deleted.
        freeAndNil( _keys );

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedIntegerObjectDictionary.destroy()', true );
        {$ENDIF}

        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------


  //---------------------------------------------------------------------------
  // TQOrderedStringObjectDictionary: Useful functions
  //---------------------------------------------------------------------------
    procedure TQOrderedIntegerObjectDictionary.clear();
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedIntegerObjectDictionary.clear()', true );
        {$ENDIF}

        _list.clear(); // Objects WILL NOT be deleted.
        _keys.clear();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedIntegerObjectDictionary.clear()', true );
        {$ENDIF}
      end
    ;


    function TQOrderedIntegerObjectDictionary.itemAtIndex( const idx: integer ): TObject;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedIntegerObjectDictionary.itemAtIndex()', true );
        {$ENDIF}

        if( _list.count > idx ) then
          result := _list.at( idx )
        else
          result := nil
        ;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedIntegerObjectDictionary.itemAtIndex()', true );
        {$ENDIF}
      end
    ;


    function TQOrderedIntegerObjectDictionary.getItemByIndex( const idx: integer ): TObject;
      begin
        result := itemAtIndex( idx );
      end
    ;


    function TQOrderedIntegerObjectDictionary.itemByIndex( const idx: integer ): TObject;
      begin
        result := itemAtIndex( idx );
      end
    ;

    
    (*
    function TQOrderedIntegerObjectDictionary.keyAtIndex( const idx: integer ): integer;
      begin
        if( _list.count > idx ) then
          result := _keys.key( idx ) // FIX ME: This function is missing from the DLL.
        else
          result := -1
        ;
      end
    ;


    function TQOrderedIntegerObjectDictionary.keyByIndex( const idx: integer ): integer;
      begin
        result := keyAtIndex( idx );
      end
    ;


    function TQOrderedIntegerObjectDictionary.getKeyByIndex( const idx: integer ): integer;
      begin
        result := keyAtIndex( idx );
      end
    ;
    *)


    function TQOrderedIntegerObjectDictionary.contains( const key: integer ): boolean;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedIntegerObjectDictionary.contains()', true );
        {$ENDIF}

        result := _keys.contains( key );

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedIntegerObjectDictionary.contains()', true );
        {$ENDIF}
      end
    ;


    function TQOrderedIntegerObjectDictionary.value( const key: integer ): TObject;
      var
        position: integer;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedIntegerObjectDictionary.value()', true );
        {$ENDIF}

        if( _keys.qHasKey( key ) ) then
          begin
            position := _keys.value( key );

            if( _list.count > position ) then
              result := _list.at( position )
            else
              result := nil
            ;
          end
        else
          result := nil
        ;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedIntegerObjectDictionary.value()', true );
        {$ENDIF}
      end
    ;


    procedure TQOrderedIntegerObjectDictionary.insert( const key: integer; val: TObject );
      var
        position: integer;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedIntegerObjectDictionary.insert()', true );
        {$ENDIF}

        // Put the item in the list, and record its position.
        _list.append( val );
        position := _list.count - 1;

        // Then put the key in the dictionary
        _keys.insert( key, position );

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedIntegerObjectDictionary.insert()', true );
        {$ENDIF}
      end
    ;


    procedure TQOrderedIntegerObjectDictionary.freeValues();
      var
        i: integer;
        obj: TObject;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedIntegerObjectDictionary.freeValues()', true );
        {$ENDIF}

        for i := 0 to _list.count - 1 do
          begin
            obj := _list.at(i);
            freeAndNil( obj );
          end
        ;

        _list.clear();
        _keys.clear();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedIntegerObjectDictionary.freeValues()', true );
        {$ENDIF}
      end
    ;


    procedure TQOrderedIntegerObjectDictionary.deleteValues();
      begin
        freeValues();
      end
    ;


    procedure TQOrderedIntegerObjectDictionary.freeItems();
      begin
        freeValues();
      end
    ;


    procedure TQOrderedIntegerObjectDictionary.deleteItems();
      begin
        freeValues();
      end
    ;
  //---------------------------------------------------------------------------


  //---------------------------------------------------------------------------
  // TQOrderedIntegerObjectDictionary: Properties
  //---------------------------------------------------------------------------
    function TQOrderedIntegerObjectDictionary.getCount(): integer;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedIntegerObjectDictionary.getCount()', true );
        {$ENDIF}

        result := _list.count;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedIntegerObjectDictionary.getCount()', true );
        {$ENDIF}
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// TQOrderedStringObjectDictionary
//*****************************************************************************
  //---------------------------------------------------------------------------
  // TQOrderedStringObjectDictionary: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQOrderedStringObjectDictionary.create();
      begin
        inherited create();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringObjectDictionary.create()', true );
        {$ENDIF}

        _list := TQObjectList.create();
        _keys := TQStringIntMap.create();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringObjectDictionary.create()', true );
        {$ENDIF}
      end
    ;


    destructor TQOrderedStringObjectDictionary.destroy();
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringObjectDictionary.destroy()', true );
        {$ENDIF}

        freeAndNil( _list ); // Objects WILL NOT be deleted.
        freeAndNil( _keys );

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringObjectDictionary.destroy()', true );
        {$ENDIF}

        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------


  //---------------------------------------------------------------------------
  // TQOrderedStringObjectDictionary: Useful functions
  //---------------------------------------------------------------------------
    procedure TQOrderedStringObjectDictionary.clear();
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringObjectDictionary.clear()', true );
        {$ENDIF}

        _list.clear(); // Objects WILL NOT be deleted.
        _keys.clear();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringObjectDictionary.clear()', true );
        {$ENDIF}
      end
    ;


    function TQOrderedStringObjectDictionary.itemAtIndex( const idx: integer ): TObject;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringObjectDictionary.itemAtIndex()', true );
        {$ENDIF}

        if( _list.count > idx ) then
          result := _list.at( idx )
        else
          result := nil
        ;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringObjectDictionary.itemAtIndex()', true );
        {$ENDIF}
      end
    ;


    function TQOrderedStringObjectDictionary.getItemByIndex( const idx: integer ): TObject;
      begin
        result := itemAtIndex( idx );
      end
    ;


    function TQOrderedStringObjectDictionary.itemByIndex( const idx: integer ): TObject;
      begin
        result := itemAtIndex( idx );
      end
    ;


    function TQOrderedStringObjectDictionary.keyAtIndex( const idx: integer ): string;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringObjectDictionary.keyAtIndex()', true );
        {$ENDIF}

        if( _list.count > idx ) then
          result := _keys.key( idx )
        else
          result := ''
        ;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringObjectDictionary.keyAtIndex()', true );
        {$ENDIF}
      end
    ;


    function TQOrderedStringObjectDictionary.keyByIndex( const idx: integer ): string;
      begin
        result := keyAtIndex( idx );
      end
    ;


    function TQOrderedStringObjectDictionary.getKeyByIndex( const idx: integer ): string;
      begin
        result := keyAtIndex( idx );
      end
    ;


    function TQOrderedStringObjectDictionary.value( const key: string ): TObject;
      var
        position: integer;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringObjectDictionary.value()', true );
        {$ENDIF}

        if( _keys.HasKey( key ) ) then
          begin
            position := _keys.value( key );

            if( _list.count > position ) then
              result := _list.at( position )
            else
              result := nil
            ;
          end
        else
          result := nil
        ;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringObjectDictionary.value()', true );
        {$ENDIF}
      end
    ;


    procedure TQOrderedStringObjectDictionary.insert( const key: string; val: TObject );
      var
        position: integer;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringObjectDictionary.insert()', true );
        {$ENDIF}

        // Put the item in the list, and record its position.
        _list.append( val );
        position := _list.count - 1;

        // Then put the key in the dictionary
        _keys.insert( key, position );

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringObjectDictionary.insert()', true );
        {$ENDIF}
      end
    ;


    procedure TQOrderedStringObjectDictionary.freeValues();
      var
        i: integer;
        obj: TObject;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringObjectDictionary.freeValues()', true );
        {$ENDIF}

        for i := 0 to _list.count - 1 do
          begin
            obj := _list.at(i);
            freeAndNil( obj );
          end
        ;

        _list.clear();
        _keys.clear();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringObjectDictionary.freeValues()', true );
        {$ENDIF}
      end
    ;


    procedure TQOrderedStringObjectDictionary.deleteValues();
      begin
        freeValues();
      end
    ;


    procedure TQOrderedStringObjectDictionary.freeItems();
      begin
        freeValues();
      end
    ;


    procedure TQOrderedStringObjectDictionary.deleteItems();
      begin
        freeValues();
      end
    ;
  //---------------------------------------------------------------------------


  //---------------------------------------------------------------------------
  // TQOrderedStringObjectDictionary: Properties
  //---------------------------------------------------------------------------
    function TQOrderedStringObjectDictionary.getCount(): integer;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringObjectDictionary.getCount()', true );
        {$ENDIF}

        result := _list.count;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringObjectDictionary.getCount()', true );
        {$ENDIF}
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// TQOrderedStringStringDictionary
//*****************************************************************************
  //---------------------------------------------------------------------------
  // TQOrderedStringStringDictionary: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQOrderedStringStringDictionary.create();
      begin
        inherited create();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringStringDictionary.create()', true );
        {$ENDIF}

        _list := TQStringList.create();
        _keys := TQStringIntMap.create();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringStringDictionary.create()', true );
        {$ENDIF}
      end
    ;


    destructor TQOrderedStringStringDictionary.destroy();
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringStringDictionary.destroy()', true );
        {$ENDIF}

        freeAndNil( _list );
        freeAndNil( _keys );

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringStringDictionary.destroy()', true );
        {$ENDIF}

        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------


  //---------------------------------------------------------------------------
  // TQOrderedStringStringDictionary: Useful functions
  //---------------------------------------------------------------------------
    procedure TQOrderedStringStringDictionary.clear();
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringStringDictionary.clear()', true );
        {$ENDIF}

        _list.clear();
        _keys.clear();

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringStringDictionary.clear()', true );
        {$ENDIF}
      end
    ;


    function TQOrderedStringStringDictionary.itemAtIndex( const idx: integer ): string;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringStringDictionary.itemAtIndex()', true );
        {$ENDIF}

        if
          ( _list.count > idx ) 
        and
          ( 0 <= idx )
        then
          result := _list.at( idx )
        else
          begin
            raise exception.create( 'index out of bounds in TQOrderedStringStringDictionary.itemAtIndex' ); 
            result := '';
          end
        ;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringStringDictionary.itemAtIndex()', true );
        {$ENDIF}
      end
    ;


    function TQOrderedStringStringDictionary.getItemByIndex( const idx: integer ): string;
      begin
        result := itemAtIndex( idx );
      end
    ;


    function TQOrderedStringStringDictionary.itemByIndex( const idx: integer ): string;
      begin
        result := itemAtIndex( idx );
      end
    ;


    function TQOrderedStringStringDictionary.keyAtIndex( const idx: integer ): string;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringStringDictionary.keyAtIndex()', true );
        {$ENDIF}

        if
          ( _list.count > idx ) 
        and
          ( 0 <= idx )
        then
          result := _keys.key( idx )
        else
          begin
            raise exception.create( 'index out of bounds in TQOrderedStringStringDictionary.keyAtIndex' ); 
            result := '';
          end
        ;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringStringDictionary.keyAtIndex()', true );
        {$ENDIF}
      end
    ;


    function TQOrderedStringStringDictionary.keyByIndex( const idx: integer ): string;
      begin
        result := keyAtIndex( idx );
      end
    ;


    function TQOrderedStringStringDictionary.getKeyByIndex( const idx: integer ): string;
      begin
        result := keyAtIndex( idx );
      end
    ;


    function TQOrderedStringStringDictionary.value( const key: string ): string;
      var
        position: integer;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringStringDictionary.value()', true );
        {$ENDIF}

        if( _keys.HasKey( key ) ) then
          begin
            position := _keys.value( key );

            if( _list.count > position ) then
              result := _list.at( position )
            else
              result := ''
            ;
          end
        else
          result := ''
        ;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringStringDictionary.value()', true );
        {$ENDIF}
      end
    ;


    procedure TQOrderedStringStringDictionary.insert( const key: string; val: string );
      var
        position: integer;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringStringDictionary.insert()', true );
        {$ENDIF}

        // Put the item in the list, and record its position.
        _list.append( val );
        position := _list.count - 1;

        // Then put the key in the dictionary
        _keys.insert( key, position );

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringStringDictionary.insert()', true );
        {$ENDIF}
      end
    ;
  //---------------------------------------------------------------------------


  //---------------------------------------------------------------------------
  // TQOrderedStringStringDictionary: Properties
  //---------------------------------------------------------------------------
    function TQOrderedStringStringDictionary.getCount(): integer;
      begin
        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'BEGIN TQOrderedStringStringDictionary.getCount()', true );
        {$ENDIF}

        result := _list.count;

        {$IFDEF QORDEREDDICTIONARIES_DEBUG}
          dbcout( 'END TQOrderedStringStringDictionary.getCount()', true );
        {$ENDIF}
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************


end.
