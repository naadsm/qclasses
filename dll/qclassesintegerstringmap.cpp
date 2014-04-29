/*
qclassesintegerstringmap.cpp
----------------------------
Begin: 2006/02/01
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
#include "qclassesintegerstringmap.h"
#include "stringhandling.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qmap.h>
#include <qchar.h>

typedef QMap<int, QString> QIntegerStringMap;

typedef QIntegerStringMap::iterator QIntegerStringMapIterator;


// Map: Construction/Destruction
//------------------------------
LIBSPEC TIntegerStringMap newIntegerStringMap( void ) {
  return new QIntegerStringMap();
}


LIBSPEC void freeIntegerStringMap( const TIntegerStringMap h ) {
  delete (QIntegerStringMap*)h;
}



// Map: Useful functions
//----------------------
LIBSPEC void integerStringMapInsert( const TIntegerStringMap h, const int key, const char* val ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    sprintf( msg, "Inserting key: '%d', val: %s", key, val );
    dbcout( msg );
  #endif

  ((QIntegerStringMap*)h)->insert( key, QString( val ) );
}



LIBSPEC char* integerStringMapValue( const TIntegerStringMap h, const int key ) {
  char* temp = charPtrFromQString( ((QIntegerStringMap*)h)->value( key ) );
  
  return temp;
}



LIBSPEC char* integerStringItemAtIndex( const TIntegerStringMap h, int index )
{
  QIntegerStringMapIterator j; 
  char* temp = NULL;

  if (  ((QIntegerStringMap*)h)->count() > index )
  {
    j = ((QIntegerStringMap*)h)->begin();
    j += index;

    temp = charPtrFromQString( j.value() );
  };

  return temp;
}



LIBSPEC int integerStringKeyAtIndex( const TIntegerStringMap h, int index )
{
  int temp = -9999;
  QIntegerStringMapIterator j;

  if (  ((QIntegerStringMap*)h)->count() > index )
  {
    j = ((QIntegerStringMap*)h)->begin();
    j += index;

    temp = j.key();
  };

  return temp;
}



LIBSPEC char* integerStringMapBegin( const TIntegerStringMap h ) {
  #ifdef DEBUG
    char msg[1024];    
  #endif
  QIntegerStringMapIterator i;

  #ifdef DEBUG
    sprintf( msg, "Attempting integerStringMapBegin on map at address %d", h );
    dbcout( msg ); 
  #endif


  i = ((QIntegerStringMap*)h)->begin();
    
  #ifdef DEBUG
    dbcout( "Got i in integerStringMapBegin" );
    sprintf( msg, "integerStringMapBegin should return %s", i.value().toAscii().data() );
    dbcout( msg ); 
  #endif

  return charPtrFromQString( i.value() );
}



LIBSPEC char* integerStringMapRemoveFirst( const TIntegerStringMap h ) {
  QIntegerStringMap* map = (QIntegerStringMap*)h;
  QIntegerStringMapIterator i;
  char* result;

  i = map->begin();

  result = charPtrFromQString( i.value() );

  map->erase( i );

  return result;
}



LIBSPEC int integerStringMapRemove( const TIntegerStringMap h, const int key ) {
  return ((QIntegerStringMap*)h)->remove( key ); // FIX ME: Delete the item?
}



LIBSPEC bool integerStringMapContains( const TIntegerStringMap h, const int key ) {
  return ((QIntegerStringMap*)h)->contains( key );
}



LIBSPEC void integerStringMapClear( const TIntegerStringMap h ) {
  ((QIntegerStringMap*)h)->clear();
}



// Map: Properties
//----------------
LIBSPEC bool integerStringMapIsEmpty( const TIntegerStringMap h ) {
  #ifdef DEBUG  
    char msg[1024];

    sprintf( msg, "Checking isEmpty on map at address: %d", h );
    dbcout( msg );
  #endif 
  
  return ((QIntegerStringMap*)h)->isEmpty();
}



LIBSPEC int integerStringMapSize( const TIntegerStringMap h ) {
  #ifdef DEBUG  
    char msg[1024];

    sprintf( msg, "Checking size of map at address: %d", h );
    dbcout( msg );
  #endif 

  return ((QIntegerStringMap*)h)->size();
}



// Map: Testing/debugging
//-----------------------
LIBSPEC void integerStringMapTest( const TIntegerStringMap h ) {
  #ifdef DEBUG
    QIntegerStringMap* map = (QIntegerStringMap*)h;
    QIntegerStringMapIterator i;
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    dbcout( "" );
    dbcout( "Testing map" );

    for (i = map->begin(); i != map->end(); ++i) {
      sprintf( msg, "retrieving key: '%d', val: %s", i.key(), i.value().toAscii().data() );
      dbcout( msg );
    }

    dbcout( "Done with test" );
    dbcout( "" );
  #endif
}



// Iterator
//---------
LIBSPEC int integerStringMapIteratorKey( TIntegerStringMap h, const int idx ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntegerStringMapIterator j;
  j = ((QIntegerStringMap*)h)->begin();

  j += idx;

  #ifdef DEBUG
    sprintf( msg, "Index: %d  Iterator key: '%d'", idx, j.key() );
    dbcout( msg );
  #endif

  return j.key();
}



LIBSPEC char* integerStringMapIteratorValue( TIntegerStringMap h, const int idx ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QIntegerStringMapIterator j;

  j = ((QIntegerStringMap*)h)->begin();
  j += idx;

  #ifdef DEBUG
    sprintf( msg, "integerStringMapIteratorValue should return %s", j.value().toAscii().data() );
    dbcout( msg ); 
  #endif

  return charPtrFromQString( j.value() );
}


