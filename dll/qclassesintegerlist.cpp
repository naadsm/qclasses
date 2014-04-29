/*
qclassesintegerlist.cpp
----------------------
Begin: 2009/01/23
Last revision: $Date: 2011-10-25 05:05:09 $ $Author: areeves $
Version: $Revision: 1.2 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2009 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*/

#include "qclassesintegerlist.h"
#include "debugging.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qlist.h>
#include <qstring.h>

typedef QList<int> QIntegerList;


// List: Construction/Destruction
//-------------------------------
LIBSPEC TIntegerList newIntegerList( void ) {
  return new QIntegerList();
}


LIBSPEC void freeIntegerList( const TIntegerList h ) {
  delete (QIntegerList*)h;
}



// List: Useful functions
//-----------------------
LIBSPEC void integerListAppend( const TIntegerList h, const int val ) {
  ((QIntegerList*)h)->append( val );
}


LIBSPEC void integerListPrepend( const TIntegerList h, const int val ) {
  ((QIntegerList*)h)->prepend( val );
}


LIBSPEC void integerListInsert( const TIntegerList h, const int i, const int val ) {
  ((QIntegerList*)h)->insert( i, val );
}


LIBSPEC int integerListAt( const TIntegerList h, const int i ) {
  return ((QIntegerList*)h)->at( i );
}

LIBSPEC bool integerListContains( const TIntegerList h, const int val ) {
  return ((QIntegerList*)h)->contains( val );
}


LIBSPEC void integerListClear( const TIntegerList h ) {
  ((QIntegerList*)h)->clear();
}


LIBSPEC void integerListRemoveAt( const TIntegerList h, const int i ) {
  ((QIntegerList*)h)->removeAt( i );
}


LIBSPEC void integerListReplace( const TIntegerList h, const int i, const int val ) {
  ((QIntegerList*)h)->replace( i, val );
}



// List: Properties
//-----------------
LIBSPEC bool integerListIsEmpty( const TIntegerList h ) {
  return ((QIntegerList*)h)->isEmpty();
}


LIBSPEC int integerListCount( const TIntegerList h ) {
  return ((QIntegerList*)h)->count();
}






