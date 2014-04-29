/*
qclassesintuintmap.cpp
----------------------
Begin: 2006/02/04
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
#include "qclassesintuintmap.h"
#include "stringhandling.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qmap.h>

typedef QMap<int, unsigned int> QIntUIntMap;

typedef QIntUIntMap::iterator QIntUIntMapIterator;


// Map: Construction/Destruction
//------------------------------
LIBSPEC TIntUIntMap newIntUIntMap( void ) {
  return new QIntUIntMap();
}


LIBSPEC void freeIntUIntMap( const TIntUIntMap h ) {
  delete (QIntUIntMap*)h;
}



// Map: Useful functions
//----------------------
LIBSPEC void intUIntMapInsert( const TIntUIntMap h, const int key, const unsigned int val ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    sprintf( msg, "Inserting key: '%d', val: %s", key, val );
    dbcout( msg );
  #endif

  ((QIntUIntMap*)h)->insert( key, val );
}



LIBSPEC unsigned int intUIntMapValue( const TIntUIntMap h, const int key ) {
  return ((QIntUIntMap*)h)->value( key );
}



LIBSPEC unsigned int intUIntItemAtIndex( const TIntUIntMap h, int index )
{
  QIntUIntMapIterator j; 

  if( ((QIntUIntMap*)h)->count() > index ) {
    j = ((QIntUIntMap*)h)->begin();
    j += index;
  }

  return j.value();
}



LIBSPEC int intUIntKeyAtIndex( const TIntUIntMap h, int index )
{
  QIntUIntMapIterator j;

  if( ((QIntUIntMap*)h)->count() > index ) {
    j = ((QIntUIntMap*)h)->begin();
    j += index;
  }

  return j.key();
}



LIBSPEC unsigned int intUIntMapBegin( const TIntUIntMap h ) {
  #ifdef DEBUG
    char msg[1024];    
  #endif
  QIntUIntMapIterator i;

  #ifdef DEBUG
    sprintf( msg, "Attempting intUIntMapBegin on map at address %d", h );
    dbcout( msg ); 
  #endif


  i = ((QIntUIntMap*)h)->begin();
    
  #ifdef DEBUG
    dbcout( "Got i in intUIntMapBegin" );
    sprintf( msg, "intUIntMapBegin should return %d", i.value() );
    dbcout( msg ); 
  #endif

  return i.value();
}



LIBSPEC unsigned int intUIntMapRemoveFirst( const TIntUIntMap h ) {
  QIntUIntMap* map = (QIntUIntMap*)h;
  QIntUIntMapIterator i;
  unsigned int result;

  i = map->begin();

  result = i.value();

  map->erase( i );

  return result;
}



LIBSPEC int intUIntMapRemove( const TIntUIntMap h, const int key ) {
  return ((QIntUIntMap*)h)->remove( key ); // FIX ME: Delete the item?
}



LIBSPEC bool intUIntMapContains( const TIntUIntMap h, const int key ) {
  return ((QIntUIntMap*)h)->contains( key );
}



LIBSPEC void intUIntMapClear( const TIntUIntMap h ) {
  ((QIntUIntMap*)h)->clear();
}



// Map: Properties
//----------------
LIBSPEC bool intUIntMapIsEmpty( const TIntUIntMap h ) {
  #ifdef DEBUG  
    char msg[1024];

    sprintf( msg, "Checking isEmpty on map at address: %d", h );
    dbcout( msg );
  #endif 
  
  return ((QIntUIntMap*)h)->isEmpty();
}



LIBSPEC int intUIntMapSize( const TIntUIntMap h ) {
  #ifdef DEBUG  
    char msg[1024];

    sprintf( msg, "Checking size of map at address: %d", h );
    dbcout( msg );
  #endif 

  return ((QIntUIntMap*)h)->size();
}



// Map: Testing/debugging
//-----------------------
LIBSPEC void intUIntMapTest( const TIntUIntMap h ) {
  #ifdef DEBUG
    QIntUIntMap* map = (QIntUIntMap*)h;
    QIntUIntMapIterator i;
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
LIBSPEC int intUIntMapIteratorKey( TIntUIntMap h, const int idx ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntUIntMapIterator j;
  j = ((QIntUIntMap*)h)->begin();

  j += idx;

  #ifdef DEBUG
    sprintf( msg, "Index: %d  Iterator key: '%d'", idx, j.key() );
    dbcout( msg );
  #endif

  return j.key();
}



LIBSPEC unsigned int intUIntMapIteratorValue( TIntUIntMap h, const int idx ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntUIntMapIterator j;

  j = ((QIntUIntMap*)h)->begin();
  j += idx;

  #ifdef DEBUG
    sprintf( msg, "intUIntMapIteratorValue should return %d", j.value() );
    dbcout( msg ); 
  #endif

  return j.value();
}


