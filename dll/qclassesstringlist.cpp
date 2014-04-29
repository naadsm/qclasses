/*
qclassesstringlist.cpp
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

#include "qclassesstringlist.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qstring.h>
#include <qstringlist.h>

#include "debugging.h"
#include "stringhandling.h"


// List: Construction/Destruction
//-------------------------------
LIBSPEC TStringList newStringList( void ) {
  return new QStringList();
}


LIBSPEC void freeStringList( const TStringList h ) {
  // FIX ME: do the values need to be freed?  If so, how?

  delete (QStringList*)h;
}



// List: Useful functions
//-----------------------
LIBSPEC void stringListAppend( const TStringList h, const char* val ) {
  ((QStringList*)h)->append( val );
}


LIBSPEC void stringListPrepend( const TStringList h, const char* val ) {
  ((QStringList*)h)->prepend( val );
}


LIBSPEC void stringListInsert( const TStringList h, const int i, const char* val ) {
  ((QStringList*)h)->insert( i, val );
}


LIBSPEC char* stringListAt( const TStringList h, const int i ) {
  return charPtrFromQString ( ((QStringList*)h)->at( i ) );
}

LIBSPEC bool stringListContains( const TStringList h, const char* val ) {
  return ((QStringList*)h)->contains( val ); 
}

/*
LIBSPEC char* stringListTakeFirst( const TStringList h ) {
  return ((TStringList*)h)->takeFirst();
}
*/

LIBSPEC void stringListClear( const TStringList h ) {
  ((QStringList*)h)->clear();
}


LIBSPEC void stringListRemoveAt( const TStringList h, const int i ) {
  ((QStringList*)h)->removeAt( i );
}


LIBSPEC void stringListReplace( const TStringList h, const int i, const char* val ) {
  ((QStringList*)h)->replace( i, val );
}



// List: Properties
//-----------------
LIBSPEC bool stringListIsEmpty( const TStringList h ) {
  return ((QStringList*)h)->isEmpty();
}


LIBSPEC int stringListCount( const TStringList h ) {
  return ((QStringList*)h)->count();
}






