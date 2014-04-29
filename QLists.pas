unit QLists;

(*
QLists.pas
-----------
Begin: 2007/01/18
Last revision: $Date: 2011-10-25 05:05:07 $ $Author: areeves $
Version: $Revision: 1.12 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2007 - 2013 Aaron Reeves

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

  This unit implements classes similar to Qt QLists (see
  http://doc.trolltech.com/4.1/qmap.html.  Syntax follows the QList interface
  as closely as possible: any deviations are noted in the comments in the
  implementation section.
}


interface

  uses
    Classes
  ;

  { If this function returns false, the DLL didn't load and these classes cannot be used. }
  function qListsDllLoaded( msg: pstring = nil ): boolean;


//-----------------------------------------------------------------------------
// ObjectList
//-----------------------------------------------------------------------------
  { A typedef for the C++ map implementation. }
  type TObjectListHandle = Pointer;

  { The list itself. }
  type TQObjectList = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the class.
      }
      _h: TObjectListHandle;

      function getCount(): integer;
      function getIsEmpty(): boolean;

    public
      constructor create(); virtual;

      { Objects (values) WILL NOT be deleted!  Use freeAllValues if that's what you want. }
      destructor destroy(); override;

      procedure append( const val: TObject );
      procedure prepend( const val: TObject );
      procedure insert( const idx: integer; const val: TObject );
      procedure replace( const idx: integer; const val: TObject );

      function at( const idx: integer ): TObject;

      function contains( const val: TObject ): boolean;

      { Objects (values) WILL NOT be deleted! }
      procedure clear();
      procedure debug();
      
      { Objects (values) WILL NOT be deleted! }
      procedure removeAt( const idx: integer );

      { Objects (values) WILL be deleted! }
      procedure freeAllValues();

      property count: integer read getCount;
      property isEmpty: boolean read getIsEmpty;
    end
  ;
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// StringList
//-----------------------------------------------------------------------------
  { A typedef for the C++ map implementation. }
  type TStringListHandle = Pointer;

  { The list itself. }
  type TQStringList = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the class.
      }
      _h: TStringListHandle;

      function getCount(): integer;
      function getIsEmpty(): boolean;

    public
      constructor create(); overload; virtual;
      constructor create( src: TQStringList ); overload;

      // FIX ME: This function won't handle delimiters inside quotes!
      constructor create( str: string; const delimiter: char; const includeDelimiter: boolean = false ); overload;

      destructor destroy(); override;

      procedure merge( src: TQStringList );

      function join( const separator: string ): string;

      procedure append( const val: string );
      procedure prepend( const val: string );
      procedure insert( const idx: integer; const val: string );
      procedure replace( const idx: integer; const val: string );

      function at( const idx: integer ): string;

      function contains( const val: string ): boolean;

      procedure clear();
      procedure debug();

      procedure removeAt( const idx: integer );

      property count: integer read getCount;
      property isEmpty: boolean read getIsEmpty;
    end
  ;
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// IntegerList
//-----------------------------------------------------------------------------
  { A typedef for the C++ map implementation. }
  type TIntegerListHandle = Pointer;

  { The list itself. }
  type TQIntegerList = class
    protected
      { The instance of the C++ class, which is wrapped by the Delphi class.
        Ignore this if all you want to do is use the class.
      }
      _h: TIntegerListHandle;

      function getCount(): integer;
      function getIsEmpty(): boolean;

    public
      constructor create(); overload; virtual;
      constructor create( src: TQIntegerList ); overload;
      destructor destroy(); override;

      procedure assign( src: TQIntegerList );
      
      procedure append( const val: integer );
      procedure prepend( const val: integer );
      procedure insert( const idx: integer; const val: integer );
      procedure replace( const idx: integer; const val: integer );

      function at( const idx: integer ): integer;

      { Add or subtract 1 to/from the value at the specified index }
      procedure incrAt( const idx: integer );
      procedure decrAt( const idx: integer );

      function contains( const val: integer ): boolean;

      function asString( const separator: string = ',' ): string;
      procedure setFromString( str: string; const separator: char = ',' );
      function sum(): integer;

      procedure clear();
      procedure debug();

      procedure removeAt( const idx: integer );

      property count: integer read getCount;
      property isEmpty: boolean read getIsEmpty;
    end
  ;
//-----------------------------------------------------------------------------

implementation

  uses
    SysUtils,
    StrUtils,
    Windows,

    CStringList,
    DebugWindow,
    MyStrUtils
  ;

  const
    SHOWDEBUGMSG: boolean = false; // set to true to enable debugging messages for this unit.

  var
    loadErrors: string;

    qObjectListLoaded: boolean;
    qStringListLoaded: boolean;
    qIntegerListLoaded: boolean;


//*****************************************************************************
// Checking the DLL
//*****************************************************************************
  function qListsDllLoaded( msg: pstring = nil ): boolean;
    begin
      result :=
        qObjectListLoaded
      and
        qStringListLoaded
      and
        qIntegerListLoaded
      ;

      if( nil <> msg ) then
        msg^ := msg^ + loadErrors
      ;
    end
  ;
//*****************************************************************************



//*****************************************************************************
// ObjectList
//*****************************************************************************
  //---------------------------------------------------------------------------
  // ObjectList function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
    var
      // List functions
      //------------------
      newObjectList: function(): TObjectListHandle; cdecl;
      freeObjectList: procedure( const h: TObjectListHandle ); cdecl;

      objectListAppend: procedure( const h: TObjectListHandle; const val: TObject ); cdecl;
      objectListPrepend: procedure( const h: TObjectListHandle; const val: TObject ); cdecl;
      objectListInsert: procedure( const h: TObjectListHandle; const idx: integer; const val: TObject ); cdecl;
      objectListAt: function( const h: TObjectListHandle; const idx: integer ): TObject; cdecl;
      objectListContains: function (const h: TObjectListHandle; const val: TObject ): boolean; cdecl;
      objectListClear: procedure( const h: TObjectListHandle ); cdecl;
      objectListRemoveAt: procedure( const h: TObjectListHandle; const idx: integer ); cdecl;
      objectListReplace: procedure( const h: TObjectListHandle; const idx: integer; const val: TObject ); cdecl;
      objectListTakeFirst: function( const h: TObjectListHandle ): TObject; cdecl;

      objectListIsEmpty: function( const h: TObjectListHandle ): boolean; cdecl;
      objectListCount: function( const h: TObjectListHandle ): integer; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // ObjectList: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQObjectList.create();
      begin
        inherited create();

        if ( qObjectListLoaded ) then
          begin
            _h := newObjectList();

            dbcout( 'Internal list address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal list address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    destructor TQObjectList.destroy();
      begin
        freeObjectList( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // ObjectList: Major functions
  //---------------------------------------------------------------------------
    procedure TQObjectList.append( const val: TObject );
      begin
        objectListAppend( _h, val );
      end
    ;


    procedure TQObjectList.prepend( const val: TObject );
      begin
        objectListPrepend( _h, val );
      end
    ;


    procedure TQObjectList.insert( const idx: integer; const val: TObject );
      begin
        objectListInsert( _h, idx, val );
      end
    ;


    procedure TQObjectList.replace( const idx: integer; const val: TObject );
      begin
        objectListReplace( _h, idx, val );
      end
    ;


    function TQObjectList.at( const idx: integer ): TObject;
      begin
        result := objectListAt( _h, idx );
      end
    ;


    function TQObjectList.contains( const val: TObject ): boolean;
      begin
        result := objectListContains( _h, val );
      end
    ;


    { Warning: objects are not freed! }
    procedure TQObjectList.clear();
      begin
        objectListClear( _h );
      end
    ;


    procedure TQObjectList.debug();
      var
        i: integer;
        o: TObject;
      begin
        dbcout( '--- TQObjectList debug.  Count: ' + intToStr( self.count ), true );
        for i := 0 to self.count - 1 do
          begin
            o := self.at( i );
            dbcout( integer( addr( o ) ), true );
          end
        ;
      end
    ;


    { Warning: the object at the indicated position is not freed! }
    procedure TQObjectList.removeAt( const idx: integer );
      begin
        objectListRemoveAt( _h, idx );
      end
    ;


    procedure TQObjectList.freeAllValues();
      var
        val: TObject;
        i: integer;
      begin
        for i := 0 to self.count - 1 do
          begin
            val := objectListTakeFirst( _h );
            freeAndNil( val );
          end
        ;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // ObjectList: Properties
  //---------------------------------------------------------------------------
    function TQObjectList.getCount(): integer;
      begin
        result := objectListCount( _h );
      end
    ;


    function TQObjectList.getIsEmpty(): boolean;
      begin
        result := objectListIsEmpty( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // ObjectList: Loading function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadObjectListDLL( dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadObjectListDLL...', SHOWDEBUGMSG );

        newObjectList := GetProcAddress( dllHandle, 'newObjectList' );
        if( nil = @newObjectList ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newObjectList.' + endl;
            result := false;
          end
        ;

        freeObjectList := GetProcAddress( dllHandle, 'freeObjectList' );
        if( nil = @freeObjectList ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: freeObjectList.' + endl;
            result := false;
          end
        ;

        objectListAppend := GetProcAddress( dllHandle, 'objectListAppend' );
        if( nil = @objectListAppend ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListAppend.' + endl;
            result := false;
          end
        ;

        objectListPrepend := GetProcAddress( dllHandle, 'objectListPrepend' );
        if( nil = @objectListPrepend ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListPrepend.' + endl;
            result := false;
          end
        ;

        objectListInsert := GetProcAddress( dllHandle, 'objectListInsert' );
        if( nil = @objectListInsert ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListInsert.' + endl;
            result := false;
          end
        ;

        objectListAt := GetProcAddress( dllHandle, 'objectListAt' );
        if( nil = @objectListAt ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListAt.' + endl;
            result := false;
          end
        ;

        objectListContains := GetProcAddress( dllHandle, 'objectListContains' );
        if( nil = @objectListContains ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListContains.' + endl;
            result := false;
          end
        ;

        objectListClear := GetProcAddress( dllHandle, 'objectListClear' );
        if( nil = @objectListClear ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListClear.' + endl;
            result := false;
          end
        ;

        objectListRemoveAt := GetProcAddress( dllHandle, 'objectListRemoveAt' );
        if( nil = @objectListRemoveAt ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListRemoveAt.' + endl;
            result := false;
          end
        ;

        objectListReplace := GetProcAddress( dllHandle, 'objectListReplace' );
        if( nil = @objectListReplace ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListReplace.' + endl;
            result := false;
          end
        ;

        objectListIsEmpty := GetProcAddress( dllHandle, 'objectListIsEmpty' );
        if( nil = @objectListIsEmpty ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListIsEmpty.' + endl;
            result := false;
          end
        ;

        objectListCount := GetProcAddress( dllHandle, 'objectListCount' );
        if( nil = @objectListCount ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListCount.' + endl;
            result := false;
          end
        ;

        objectListTakeFirst := GetProcAddress( dllHandle, 'objectListTakeFirst' );
        if( nil = @objectListTakeFirst ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: objectListTakeFirst.' + endl;
            result := false;
          end
        ;

        qObjectListLoaded := result;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// StringList
//*****************************************************************************
  //---------------------------------------------------------------------------
  // StringList function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
    var
      // List functions
      //------------------
      newStringList: function(): TStringListHandle; cdecl;
      freeStringList: procedure( const h: TStringListHandle ); cdecl;

      stringListAppend: procedure( const h: TStringListHandle; const val: string ); cdecl;
      stringListPrepend: procedure( const h: TStringListHandle; const val: string ); cdecl;
      stringListInsert: procedure( const h: TStringListHandle; const idx: integer; const val: string ); cdecl;
      stringListAt: function( const h: TStringListHandle; const idx: integer ): pchar; cdecl;
      stringListContains: function( const h: TStringListHandle; const val: string ): boolean; cdecl;
      stringListClear: procedure( const h: TStringListHandle ); cdecl;
      stringListRemoveAt: procedure( const h: TStringListHandle; const idx: integer ); cdecl;
      stringListReplace: procedure( const h: TStringListHandle; const idx: integer; const val: string ); cdecl;
      //stringListTakeFirst: function( const h: TStringListHandle ): TObject; cdecl;

      stringListIsEmpty: function( const h: TStringListHandle ): boolean; cdecl;
      stringListCount: function( const h: TStringListHandle ): integer; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringList: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQStringList.create();
      begin
        inherited create();

        if ( qStringListLoaded ) then
          begin
            _h := newStringList();

            dbcout( 'Internal list address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal list address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQStringList.create( src: TQStringList );
      var
        i: integer;
      begin
        inherited create();

        if ( qStringListLoaded ) then
          begin
            _h := newStringList();

            dbcout( 'Internal list address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );

            for i := 0 to src.count - 1 do
              self.append( src.at(i) )
            ;
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal list address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQStringList.create( str: string; const delimiter: char; const includeDelimiter: boolean = false );
      var
        pos: word;
        substr: string;
      begin
        inherited create();

        if ( qStringListLoaded ) then
          begin
            _h := newStringList();

            dbcout( 'Internal list address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal list address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;

        if( nil <> _h ) then
          begin
            repeat
              pos := ansiPos( delimiter, str );

              if( 0 = pos ) then
                substr := str
              else if( includeDelimiter ) then
                substr := leftStr( str, pos )
              else
                substr := leftStr( str, pos - 1 )
              ;

              str := rightStr( str, length( str ) - pos );

              self.append( trim( substr ) );
            until pos = 0;
          end
        ;

      end
    ;


    destructor TQStringList.destroy();
      begin
        freeStringList( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringList: Major functions
  //---------------------------------------------------------------------------
    function TQStringList.join( const separator: string ): string;
      var
        i: integer;
      begin
        result := '';

        for i := 0 to self.count - 1 do
          begin
            result := result + self.at( i );

            if( i < self.count - 1 ) then
              result := result + separator
            ;
          end
        ;

      end
    ;

    procedure TQStringList.merge( src: TQStringList );
      var
        i: integer;
      begin
        for i := 0 to src.count - 1 do
          self.append( src.at( i ) )
        ;
      end
    ;


    procedure TQStringList.append( const val: string );
      begin
        stringListAppend( _h, val );
      end
    ;


    procedure TQStringList.prepend( const val: string );
      begin
        stringListPrepend( _h, val );
      end
    ;


    procedure TQStringList.insert( const idx: integer; const val: string );
      begin
        stringListInsert( _h, idx, val );
      end
    ;


    procedure TQStringList.replace( const idx: integer; const val: string );
      begin
        stringListReplace( _h, idx, val );
      end
    ;


    function TQStringList.at( const idx: integer ): string;
      begin
        result := string( stringListAt( _h, idx ) );
      end
    ;


    function TQStringList.contains( const val: string ): boolean;
      begin
        result := stringListContains( _h, val );
      end
    ;


    procedure TQStringList.clear();
      begin
        stringListClear( _h );
      end
    ;


    procedure TQStringList.removeAt( const idx: integer );
      begin
        stringListRemoveAt( _h, idx );
      end
    ;


    procedure TQStringList.debug();
      var
        i: integer;
      begin
        dbcout( '--- TQStringList debug.  Count: ' + intToStr( self.count ), true );
        for i := 0 to self.count - 1 do
          dbcout( self.at( i ), true )
        ;
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringList: Properties
  //---------------------------------------------------------------------------
    function TQStringList.getCount(): integer;
      begin
        result := stringListCount( _h );
      end
    ;


    function TQStringList.getIsEmpty(): boolean;
      begin
        result := stringListIsEmpty( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // StringList: Loading function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadStringListDLL( dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadStringListDLL...', SHOWDEBUGMSG );

        newStringList := GetProcAddress( dllHandle, 'newStringList' );
        if( nil = @newStringList ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newStringList.' + endl;
            result := false;
          end
        ;

        freeStringList := GetProcAddress( dllHandle, 'freeStringList' );
        if( nil = @freeStringList ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: freeStringList.' + endl;
            result := false;
          end
        ;

        stringListAppend := GetProcAddress( dllHandle, 'stringListAppend' );
        if( nil = @stringListAppend ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListAppend.' + endl;
            result := false;
          end
        ;

        stringListPrepend := GetProcAddress( dllHandle, 'stringListPrepend' );
        if( nil = @stringListPrepend ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListPrepend.' + endl;
            result := false;
          end
        ;

        stringListInsert := GetProcAddress( dllHandle, 'stringListInsert' );
        if( nil = @stringListInsert ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListInsert.' + endl;
            result := false;
          end
        ;

        stringListAt := GetProcAddress( dllHandle, 'stringListAt' );
        if( nil = @stringListAt ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListAt.' + endl;
            result := false;
          end
        ;

        stringListContains := GetProcAddress( dllHandle, 'stringListContains' );
        if( nil = @stringListContains ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListContains.' + endl;
            result := false;
          end
        ;

        stringListClear := GetProcAddress( dllHandle, 'stringListClear' );
        if( nil = @stringListClear ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListClear.' + endl;
            result := false;
          end
        ;

        stringListRemoveAt := GetProcAddress( dllHandle, 'stringListRemoveAt' );
        if( nil = @stringListRemoveAt ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListRemoveAt.' + endl;
            result := false;
          end
        ;

        stringListReplace := GetProcAddress( dllHandle, 'stringListReplace' );
        if( nil = @stringListReplace ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListReplace.' + endl;
            result := false;
          end
        ;

        stringListIsEmpty := GetProcAddress( dllHandle, 'stringListIsEmpty' );
        if( nil = @stringListIsEmpty ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListIsEmpty.' + endl;
            result := false;
          end
        ;

        stringListCount := GetProcAddress( dllHandle, 'stringListCount' );
        if( nil = @stringListCount ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListCount.' + endl;
            result := false;
          end
        ;

        (*
        stringListTakeFirst := GetProcAddress( dllHandle, 'stringListTakeFirst' );
        if( nil = @stringListTakeFirst ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: stringListTakeFirst.' + endl;
            result := false;
          end
        ;
        *)
        qStringListLoaded := result;
      end
    ;
  //---------------------------------------------------------------------------
//*****************************************************************************



//*****************************************************************************
// IntegerList
//*****************************************************************************
  //---------------------------------------------------------------------------
  // IntegerList function pointers, loaded from qclasses.dll by loadDynamicDLL()
  //---------------------------------------------------------------------------
    var
      // List functions
      //------------------
      newIntegerList: function(): TIntegerListHandle; cdecl;
      freeIntegerList: procedure( const h: TIntegerListHandle ); cdecl;

      integerListAppend: procedure( const h: TIntegerListHandle; const val: integer ); cdecl;
      integerListPrepend: procedure( const h: TIntegerListHandle; const val: integer ); cdecl;
      integerListInsert: procedure( const h: TIntegerListHandle; const idx: integer; const val: integer ); cdecl;
      integerListAt: function( const h: TIntegerListHandle; const idx: integer ): integer; cdecl;
      integerListContains: function( const h: TIntegerListHandle; const val: integer ): boolean; cdecl;
      integerListClear: procedure( const h: TIntegerListHandle ); cdecl;
      integerListRemoveAt: procedure( const h: TIntegerListHandle; const idx: integer ); cdecl;
      integerListReplace: procedure( const h: TIntegerListHandle; const idx: integer; const val: integer ); cdecl;
      //integerListTakeFirst: function( const h: TIntegerListHandle ): TObject; cdecl;

      integerListIsEmpty: function( const h: TIntegerListHandle ): boolean; cdecl;
      integerListCount: function( const h: TIntegerListHandle ): integer; cdecl;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerList: Construction/destruction
  //---------------------------------------------------------------------------
    constructor TQIntegerList.create();
      begin
        inherited create();

        if ( qIntegerListLoaded ) then
          begin
            _h := newIntegerList();

            dbcout( 'Internal list address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal list address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;
      end
    ;


    constructor TQIntegerList.create( src: TQIntegerList );
      var
        i: integer;
      begin
        inherited create();

        if ( qIntegerListLoaded ) then
          begin
            _h := newIntegerList();

            dbcout( 'Internal list address: ' + intToStr( Int64(_h) ), SHOWDEBUGMSG );
        end
        else
          begin
            _h := nil;
            raise exception.create( 'Internal list address: ' + intToStr( Int64(_h) ) + ' DLL is not yet loaded!!!' );
          end
        ;

        for i := 0 to src.count - 1 do
          self.append( src.at(i) )
        ;
      end
    ;


    destructor TQIntegerList.destroy();
      begin
        freeIntegerList( _h );
        inherited destroy();
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerList: Major functions
  //---------------------------------------------------------------------------
    procedure TQIntegerList.assign( src: TQIntegerList );
      var
        i: integer;
      begin
        self.clear();

        for i := 0 to src.count - 1 do
          self.append( src.at(i) )
        ;
      end
    ;


    procedure TQIntegerList.append( const val: integer );
      begin
        integerListAppend( _h, val );
      end
    ;


    procedure TQIntegerList.prepend( const val: integer );
      begin
        integerListPrepend( _h, val );
      end
    ;


    procedure TQIntegerList.insert( const idx: integer; const val: integer );
      begin
        integerListInsert( _h, idx, val );
      end
    ;


    procedure TQIntegerList.replace( const idx: integer; const val: integer );
      begin
        integerListReplace( _h, idx, val );
      end
    ;


    function TQIntegerList.at( const idx: integer ): integer;
      begin
        result := integerListAt( _h, idx );
      end
    ;


    procedure TQIntegerList.incrAt( const idx: integer );
      begin
        replace( idx, at(idx) + 1 );
      end
    ;


    procedure TQIntegerList.decrAt( const idx: integer );
      begin
        replace( idx, at(idx) - 1 );
      end
    ;

    
    function TQIntegerList.contains( const val: integer ): boolean;
      begin
        result := integerListContains( _h, val );
      end
    ;

    function TQIntegerList.asString( const separator: string = ',' ): string;
      var
        i: integer;
      begin
        if( 0 = self.count ) then
          result := ''
        else
          begin
            result := '';
            for i := 0 to self.count - 1 do
              begin
                result := result + intToStr( self.at( i ) );
                if( i < self.count - 1 ) then
                  result := result + ','
                ;
              end
            ;
          end
        ;
      end
    ;


    procedure TQIntegerList.setFromString( str: string; const separator: char = ',' );
      var
        list: TCStringList;
        i: integer;
      begin
        self.clear();

        str := fixup( str );
        if( 0 = length( str ) ) then
          exit
        ;

        list := TCStringList.create( str, separator );


        for i := 0 to list.Count - 1 do
          self.append( strToInt( list.at(i) ) )
        ;

        list.Free();
      end
    ;


    function TQIntegerList.sum(): integer;
      var
        i: integer;
      begin
        result := 0;

        for i := 0 to self.count - 1 do
          result := result + self.at(i)
        ;
      end
    ;

    
    procedure TQIntegerList.clear();
      begin
        integerListClear( _h );
      end
    ;


    procedure TQIntegerList.debug();
      var
        i: integer;
      begin
        dbcout( '--- TQIntegerList debug.  Count: ' + intToStr( self.count ), true );
        for i := 0 to self.count - 1 do
          dbcout( self.at( i ), true )
        ;
      end
    ;


    procedure TQIntegerList.removeAt( const idx: integer );
      begin
        integerListRemoveAt( _h, idx );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerList: Properties
  //---------------------------------------------------------------------------
    function TQIntegerList.getCount(): integer;
      begin
        result := integerListCount( _h );
      end
    ;


    function TQIntegerList.getIsEmpty(): boolean;
      begin
        result := integerListIsEmpty( _h );
      end
    ;
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // IntegerList: Loading function pointers from the DLL
  //---------------------------------------------------------------------------
    procedure loadIntegerListDLL( dllHandle: THandle );
      var
        result: boolean;
      begin
        result := true;

        dbcout( 'Attempting to set function pointers in loadIntegerListDLL...', SHOWDEBUGMSG );

        newIntegerList := GetProcAddress( dllHandle, 'newIntegerList' );
        if( nil = @newIntegerList ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: newIntegerList.' + endl;
            result := false;
          end
        ;

        freeIntegerList := GetProcAddress( dllHandle, 'freeIntegerList' );
        if( nil = @freeIntegerList ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: freeIntegerList.' + endl;
            result := false;
          end
        ;

        integerListAppend := GetProcAddress( dllHandle, 'integerListAppend' );
        if( nil = @integerListAppend ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListAppend.' + endl;
            result := false;
          end
        ;

        integerListPrepend := GetProcAddress( dllHandle, 'integerListPrepend' );
        if( nil = @integerListPrepend ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListPrepend.' + endl;
            result := false;
          end
        ;

        integerListInsert := GetProcAddress( dllHandle, 'integerListInsert' );
        if( nil = @integerListInsert ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListInsert.' + endl;
            result := false;
          end
        ;

        integerListAt := GetProcAddress( dllHandle, 'integerListAt' );
        if( nil = @integerListAt ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListAt.' + endl;
            result := false;
          end
        ;

        integerListContains := GetProcAddress( dllHandle, 'integerListContains' );
        if( nil = @integerListContains ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListContains.' + endl;
            result := false;
          end
        ;

        integerListClear := GetProcAddress( dllHandle, 'integerListClear' );
        if( nil = @integerListClear ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListClear.' + endl;
            result := false;
          end
        ;

        integerListRemoveAt := GetProcAddress( dllHandle, 'integerListRemoveAt' );
        if( nil = @integerListRemoveAt ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListRemoveAt.' + endl;
            result := false;
          end
        ;

        integerListReplace := GetProcAddress( dllHandle, 'integerListReplace' );
        if( nil = @integerListReplace ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListReplace.' + endl;
            result := false;
          end
        ;

        integerListIsEmpty := GetProcAddress( dllHandle, 'integerListIsEmpty' );
        if( nil = @integerListIsEmpty ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListIsEmpty.' + endl;
            result := false;
          end
        ;

        integerListCount := GetProcAddress( dllHandle, 'integerListCount' );
        if( nil = @integerListCount ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListCount.' + endl;
            result := false;
          end
        ;

        (*
        integerListTakeFirst := GetProcAddress( dllHandle, 'integerListTakeFirst' );
        if( nil = @integerListTakeFirst ) then
          begin
            loadErrors := loadErrors + 'MISSING FUNCTION: integerListTakeFirst.' + endl;
            result := false;
          end
        ;
        *)
        qIntegerListLoaded := result;
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
          loadObjectListDLL( dllHandle );
          loadStringListDLL( dllHandle );
          loadIntegerListDLL( dllHandle );
        end
      ;
    end
  ;
//*****************************************************************************

initialization
  loadErrors := '';

  qObjectListLoaded := false;
  qStringListLoaded := false;
  qIntegerListLoaded := false;

  loadDynamicDLL();

end.



