/*
qclassesintegerobjectmap.cpp
----------------------------
Begin: 2006/07/11
Last revision: $Date: 2011-10-25 05:05:09 $ $Author: areeves $
Version: $Revision: 1.3 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2006 - 2007 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*/


#include "debugging.h"
#include "qclassesintegerobjectmap.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qmap.h>

typedef QMap<int, TObject> QIntegerObjectMap;

typedef QIntegerObjectMap::iterator QIntegerObjectMapIterator;


// Map: Construction/Destruction
//------------------------------
LIBSPEC TIntegerObjectMap newIntegerObjectMap( void ) {
  return new QIntegerObjectMap();
}


LIBSPEC void freeIntegerObjectMap( const TIntegerObjectMap h ) {
  delete (QIntegerObjectMap*)h;
}



// Map: Useful functions
//----------------------
LIBSPEC void integerObjectMapInsert( const TIntegerObjectMap h, const int key, const TObject val ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    sprintf( msg, "Inserting key: '%d', val: %d", key, val );
    dbcout( msg );
  #endif

  ((QIntegerObjectMap*)h)->insert( key, val );
}



LIBSPEC TObject integerObjectMapValue( const TIntegerObjectMap h, const int key ) {
  return ((QIntegerObjectMap*)h)->value( key );
}



LIBSPEC TObject integerObjectItemAtIndex( const TIntegerObjectMap h, int index )
{
  QIntegerObjectMapIterator j;
  TObject temp = NULL;

  if (  ((QIntegerObjectMap*)h)->count() > index )
  {
    j = ((QIntegerObjectMap*)h)->begin();
    j += index;

    temp = j.value();
  };

  return temp;
}



LIBSPEC int integerObjectKeyAtIndex( const TIntegerObjectMap h, int index )
{
  int temp = -9999;
  QIntegerObjectMapIterator j;

  if (  ((QIntegerObjectMap*)h)->count() > index )
  {
    j = ((QIntegerObjectMap*)h)->begin();
    j += index;

    temp = j.key();
  };

  return temp;
}



LIBSPEC TObject integerObjectMapBegin( const TIntegerObjectMap h ) {
  QIntegerObjectMap::iterator i;

  i = ((QIntegerObjectMap*)h)->begin();

  return i.value();
}



LIBSPEC TObject integerObjectMapRemoveFirst( const TIntegerObjectMap h ) {
  QIntegerObjectMap* map = (QIntegerObjectMap*)h;
  QIntegerObjectMap::iterator i;
  TObject result;

  i = map->begin();

  result = i.value();

  map->erase( i );

  return result;
}



LIBSPEC int integerObjectMapRemove( const TIntegerObjectMap h, const int key ) {
  return ((QIntegerObjectMap*)h)->remove( key );
}



LIBSPEC bool integerObjectMapContains( const TIntegerObjectMap h, const int key ) {
  return ((QIntegerObjectMap*)h)->contains( key );
}



LIBSPEC void integerObjectMapClear( const TIntegerObjectMap h ) {
  ((QIntegerObjectMap*)h)->clear();
}



// Map: Properties
//----------------
LIBSPEC bool integerObjectMapIsEmpty( const TIntegerObjectMap h ) {
  return ((QIntegerObjectMap*)h)->isEmpty();
}



LIBSPEC int integerObjectMapSize( const TIntegerObjectMap h ) {
  return ((QIntegerObjectMap*)h)->size();
}



// Map: Testing/debugging
//-----------------------
LIBSPEC void integerObjectMapTest( const TIntegerObjectMap h ) {
  #ifdef DEBUG
    QIntegerObjectMap* map = (QIntegerObjectMap*)h;
    QIntegerObjectMap::iterator i;
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    dbcout( "" );
    dbcout( "Testing map" );

    for (i = map->begin(); i != map->end(); ++i) {
      sprintf( msg, "retrieving key: '%d', val: %d", i.key(), i.value() );
      dbcout( msg );
    }

    dbcout( "Done with test" );
    dbcout( "" );
  #endif
}



// Iterator
//---------
LIBSPEC int integerObjectMapIteratorKey( TIntegerObjectMap h, const int idx ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntegerObjectMapIterator j;
  j = ((QIntegerObjectMap*)h)->begin();

  j += idx;

  #ifdef DEBUG
    sprintf( msg, "Index: %d  Iterator key: '%d'", idx, j.key() );
    dbcout( msg );
  #endif

  return j.key();
}



LIBSPEC TObject integerObjectMapIteratorValue( TIntegerObjectMap h, const int idx ) {
  QIntegerObjectMapIterator j;

  j = ((QIntegerObjectMap*)h)->begin();
  j += idx;

  return j.value();
}


