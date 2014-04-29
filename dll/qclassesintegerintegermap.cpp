/*
qclassesintegerintegermap.cpp
-----------------------------
Begin: 2006/02/04
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
#include "qclassesintegerintegermap.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qmap.h>

typedef QMap<int, int> QIntegerIntegerMap;

typedef QIntegerIntegerMap::iterator QIntegerIntegerMapIterator;


// Map: Construction/Destruction
//------------------------------
LIBSPEC TIntegerIntegerMap newIntegerIntegerMap( void ) {
  return new QIntegerIntegerMap();
}


LIBSPEC void freeIntegerIntegerMap( const TIntegerIntegerMap h ) {
  delete (QIntegerIntegerMap*)h;
}



// Map: Useful functions
//----------------------
LIBSPEC void integerIntegerMapInsert( const TIntegerIntegerMap h, const int key, const int val ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    sprintf( msg, "Inserting key: '%d', val: %s", key, val );
    dbcout( msg );
  #endif

  ((QIntegerIntegerMap*)h)->insert( key, val );
}



LIBSPEC int integerIntegerMapValue( const TIntegerIntegerMap h, const int key ) {
  return ((QIntegerIntegerMap*)h)->value( key );
}



LIBSPEC int integerIntegerItemAtIndex( const TIntegerIntegerMap h, int index )
{
  QIntegerIntegerMapIterator j;

  if (  ((QIntegerIntegerMap*)h)->count() > index )
  {
    j = ((QIntegerIntegerMap*)h)->begin();
    j += index;
  };

  return j.value();
}



LIBSPEC int integerIntegerKeyAtIndex( const TIntegerIntegerMap h, int index )
{
  int temp = -9999;
  QIntegerIntegerMapIterator j;

  if (  ((QIntegerIntegerMap*)h)->count() > index )
  {
    j = ((QIntegerIntegerMap*)h)->begin();
    j += index;

    temp = j.key();
  };

  return temp;
}



LIBSPEC int integerIntegerMapBegin( const TIntegerIntegerMap h ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntegerIntegerMapIterator i;

  #ifdef DEBUG
    sprintf( msg, "Attempting integerIntegerMapBegin on map at address %d", h );
    dbcout( msg );
  #endif


  i = ((QIntegerIntegerMap*)h)->begin();

  #ifdef DEBUG
    dbcout( "Got i in integerIntegerMapBegin" );
    sprintf( msg, "integerIntegerMapBegin should return %d", i.value() );
    dbcout( msg );
  #endif

  return i.value();
}



LIBSPEC int integerIntegerMapRemoveFirst( const TIntegerIntegerMap h ) {
  QIntegerIntegerMap* map = (QIntegerIntegerMap*)h;
  QIntegerIntegerMapIterator i;
  int result;

  i = map->begin();

  result = i.value();

  map->erase( i );

  return result;
}



LIBSPEC int integerIntegerMapRemove( const TIntegerIntegerMap h, const int key ) {
  return ((QIntegerIntegerMap*)h)->remove( key ); // FIX ME: Delete the item?
}



LIBSPEC bool integerIntegerMapContains( const TIntegerIntegerMap h, const int key ) {
  return ((QIntegerIntegerMap*)h)->contains( key );
}



LIBSPEC void integerIntegerMapClear( const TIntegerIntegerMap h ) {
  ((QIntegerIntegerMap*)h)->clear();
}



// Map: Properties
//----------------
LIBSPEC bool integerIntegerMapIsEmpty( const TIntegerIntegerMap h ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Checking isEmpty on map at address: %d", h );
    dbcout( msg );
  #endif

  return ((QIntegerIntegerMap*)h)->isEmpty();
}



LIBSPEC int integerIntegerMapSize( const TIntegerIntegerMap h ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Checking size of map at address: %d", h );
    dbcout( msg );
  #endif

  return ((QIntegerIntegerMap*)h)->size();
}



// Map: Testing/debugging
//-----------------------
LIBSPEC void integerIntegerMapTest( const TIntegerIntegerMap h ) {
  #ifdef DEBUG
    QIntegerIntegerMap* map = (QIntegerIntegerMap*)h;
    QIntegerIntegerMapIterator i;
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    dbcout( "" );
    dbcout( "Testing map" );

    for (i = map->begin(); i != map->end(); ++i) {
      sprintf( msg, "retrieving key: '%d', val: %d", i.key() );
      dbcout( msg );
    }

    dbcout( "Done with test" );
    dbcout( "" );
  #endif
}



// Iterator
//---------
LIBSPEC int integerIntegerMapIteratorKey( TIntegerIntegerMap h, const int idx ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntegerIntegerMapIterator j;
  j = ((QIntegerIntegerMap*)h)->begin();

  j += idx;

  #ifdef DEBUG
    sprintf( msg, "Index: %d  Iterator key: '%d'", idx, j.key() );
    dbcout( msg );
  #endif

  return j.key();
}



LIBSPEC int integerIntegerMapIteratorValue( TIntegerIntegerMap h, const int idx ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntegerIntegerMapIterator j;

  j = ((QIntegerIntegerMap*)h)->begin();
  j += idx;

  #ifdef DEBUG
    sprintf( msg, "integerIntegerMapIteratorValue should return %d", j.value() );
    dbcout( msg );
  #endif

  return j.value();
}


