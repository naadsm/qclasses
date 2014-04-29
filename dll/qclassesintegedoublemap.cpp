/*
qclassesintegerdoublemap.cpp
----------------------------
Begin: 2009/01/29
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


#include "debugging.h"
#include "qclassesintegerdoublemap.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qmap.h>

typedef QMap<int, double> QIntegerDoubleMap;

typedef QIntegerDoubleMap::iterator QIntegerDoubleMapIterator;


// Map: Construction/Destruction
//------------------------------
LIBSPEC TIntegerDoubleMap newIntegerDoubleMap( void ) {
  return new QIntegerDoubleMap();
}


LIBSPEC void freeIntegerDoubleMap( const TIntegerDoubleMap h ) {
  delete (QIntegerDoubleMap*)h;
}



// Map: Useful functions
//----------------------
LIBSPEC void integerDoubleMapInsert( const TIntegerDoubleMap h, const int key, const double val ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    sprintf( msg, "Inserting key: '%d', val: %s", key, val );
    dbcout( msg );
  #endif

  ((QIntegerDoubleMap*)h)->insert( key, val );
}



LIBSPEC double integerDoubleMapValue( const TIntegerDoubleMap h, const int key ) {
  return ((QIntegerDoubleMap*)h)->value( key );
}



LIBSPEC double integerDoubleItemAtIndex( const TIntegerDoubleMap h, int index ) {
  QIntegerDoubleMapIterator j;

  if (  ((QIntegerDoubleMap*)h)->count() > index )
  {
    j = ((QIntegerDoubleMap*)h)->begin();
    j += index;
  };

  return j.value();
}



LIBSPEC int integerDoubleKeyAtIndex( const TIntegerDoubleMap h, int index )
{
  int temp = -9999;
  QIntegerDoubleMapIterator j;

  if (  ((QIntegerDoubleMap*)h)->count() > index )
  {
    j = ((QIntegerDoubleMap*)h)->begin();
    j += index;

    temp = j.key();
  };

  return temp;
}



LIBSPEC double integerDoubleMapBegin( const TIntegerDoubleMap h ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntegerDoubleMapIterator i;

  #ifdef DEBUG
    sprintf( msg, "Attempting integerDoubleMapBegin on map at address %d", h );
    dbcout( msg );
  #endif


  i = ((QIntegerDoubleMap*)h)->begin();

  #ifdef DEBUG
    dbcout( "Got i in integerDoubleMapBegin" );
    sprintf( msg, "integerDoubleMapBegin should return %d", i.value() );
    dbcout( msg );
  #endif

  return i.value();
}



LIBSPEC double integerDoubleMapRemoveFirst( const TIntegerDoubleMap h ) {
  QIntegerDoubleMap* map = (QIntegerDoubleMap*)h;
  QIntegerDoubleMapIterator i;
  double result;

  i = map->begin();

  result = i.value();

  map->erase( i );

  return result;
}



LIBSPEC int integerDoubleMapRemove( const TIntegerDoubleMap h, const int key ) {
  return ((QIntegerDoubleMap*)h)->remove( key ); // FIX ME: Delete the item?
}



LIBSPEC bool integerDoubleMapContains( const TIntegerDoubleMap h, const int key ) {
  return ((QIntegerDoubleMap*)h)->contains( key );
}



LIBSPEC void integerDoubleMapClear( const TIntegerDoubleMap h ) {
  ((QIntegerDoubleMap*)h)->clear();
}



// Map: Properties
//----------------
LIBSPEC bool integerDoubleMapIsEmpty( const TIntegerDoubleMap h ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Checking isEmpty on map at address: %d", h );
    dbcout( msg );
  #endif

  return ((QIntegerDoubleMap*)h)->isEmpty();
}



LIBSPEC int integerDoubleMapSize( const TIntegerDoubleMap h ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Checking size of map at address: %d", h );
    dbcout( msg );
  #endif

  return ((QIntegerDoubleMap*)h)->size();
}



// Map: Testing/debugging
//-----------------------
LIBSPEC void integerDoubleMapTest( const TIntegerDoubleMap h ) {
  #ifdef DEBUG
    QIntegerDoubleMap* map = (QIntegerDoubleMap*)h;
    QIntegerDoubleMapIterator i;
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    dbcout( "" );
    dbcout( "Testing map" );

    for (i = map->begin(); i != map->end(); ++i) {
      sprintf( msg, "retrieving key: '%d', val: %f", i.key(), i.value() );
      dbcout( msg );
    }

    dbcout( "Done with test" );
    dbcout( "" );
  #endif
}



// Iterator
//---------
LIBSPEC int integerDoubleMapIteratorKey( TIntegerDoubleMap h, const int idx ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntegerDoubleMapIterator j;
  j = ((QIntegerDoubleMap*)h)->begin();

  j += idx;

  #ifdef DEBUG
    sprintf( msg, "Index: %d  Iterator key: '%d'", idx, j.key() );
    dbcout( msg );
  #endif

  return j.key();
}



LIBSPEC double integerDoubleMapIteratorValue( TIntegerDoubleMap h, const int idx ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntegerDoubleMapIterator j;

  j = ((QIntegerDoubleMap*)h)->begin();
  j += idx;

  #ifdef DEBUG
    sprintf( msg, "integerDoubleMapIteratorValue should return %d", j.value() );
    dbcout( msg );
  #endif

  return j.value();
}


