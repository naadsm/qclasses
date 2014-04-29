/*
qclassesobjectlist.cpp
----------------------
Begin: 2007/01/18
Last revision: $Date: 2011-10-25 05:05:09 $ $Author: areeves $
Version: $Revision: 1.3 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2007 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*/


#include "debugging.h"
#include "qclassesobjectlist.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qlist.h>

typedef QList<TObject> QObjectList;


// List: Construction/Destruction
//-------------------------------
LIBSPEC TObjectList newObjectList( void ) {
  return new QObjectList();
}


LIBSPEC void freeObjectList( const TObjectList h ) {
  delete (QObjectList*)h;
}



// List: Useful functions
//-----------------------
LIBSPEC void objectListAppend( const TObjectList h, const TObject val ) {
  ((QObjectList*)h)->append( val );
}


LIBSPEC void objectListPrepend( const TObjectList h, const TObject val ) {
  ((QObjectList*)h)->prepend( val );
}


LIBSPEC void objectListInsert( const TObjectList h, const int i, const TObject val ) {
  ((QObjectList*)h)->insert( i, val );
}


LIBSPEC TObject objectListAt( const TObjectList h, const int i ) {
  return ((QObjectList*)h)->at( i );
}

LIBSPEC bool objectListContains( const TObjectList h, const TObject val ) {
  return ((QObjectList*)h)->contains( val );  
}

LIBSPEC TObject objectListTakeFirst( const TObjectList h ) {
  return ((QObjectList*)h)->takeFirst();
}

LIBSPEC void objectListClear( const TObjectList h ) {
  ((QObjectList*)h)->clear();
}


LIBSPEC void objectListRemoveAt( const TObjectList h, const int i ) {
  ((QObjectList*)h)->removeAt( i );
}


LIBSPEC void objectListReplace( const TObjectList h, const int i, const TObject val ) {
  ((QObjectList*)h)->replace( i, val );
}



// List: Properties
//-----------------
LIBSPEC bool objectListIsEmpty( const TObjectList h ) {
  return ((QObjectList*)h)->isEmpty();
}


LIBSPEC int objectListCount( const TObjectList h ) {
  return ((QObjectList*)h)->count();
}






