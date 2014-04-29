/*
qclassesstringlongintmap.cpp
----------------------------
Begin: 2006/07/11
Last revision: $Date: 2011-10-25 05:05:10 $ $Author: areeves $
Version: $Revision: 1.2 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
Author: Shaun Case <Shaun.Case@colostate.edu>
------------------------------------------------------
Copyright (C) 2006 - 2007 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*/


#include "debugging.h"
#include "qclassesstringlongintmap.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qmap.h>
#include <qstring.h>

typedef QMap<QString, long> QStringLongIntMap;
typedef QStringLongIntMap::iterator QStringLongIntMapIterator;

char* QStringLongIntBuffer = NULL;
unsigned long QStringLongIntBufferSize = 0;


/*
char* _qstring_object_map_getbuffer( QString myString ) {
   unsigned long Size = strlen( (char *)(myString.toAscii().data()) ) + 1;

  if ( QStringObjectBufferSize <  Size )
  {
     if ( QStringObjectBuffer != NULL )
     {
        delete QStringObjectBuffer;
        QStringObjectBuffer = NULL;
     }

     QStringObjectBuffer = new char[ Size ];
     QStringObjectBufferSize = Size;
  };

  memset( QStringObjectBuffer, 0, QStringObjectBufferSize );

  strcpy( QStringObjectBuffer, (char*)(myString.toAscii().data()) );

  return QStringObjectBuffer;
}
*/

char* _qstring_longint_map_getbuffer( QString myString ) {
   unsigned long Size = strlen( (char *)(myString.toAscii().data()) ) + 1;

  if ( QStringLongIntBufferSize <  Size )
  {
     if ( QStringLongIntBuffer != NULL )
     {
        delete QStringLongIntBuffer;
        QStringLongIntBuffer = NULL;
     }

     QStringLongIntBuffer = new char[ Size ];
     QStringLongIntBufferSize = Size;
  };

  memset( QStringLongIntBuffer, 0, QStringLongIntBufferSize );

  strcpy( QStringLongIntBuffer, (char*)(myString.toAscii().data()) );

  return QStringLongIntBuffer;
}



LIBSPEC TStringLongIntMap newStringLongIntMap( void ) {
  return new QStringLongIntMap();
}



LIBSPEC void freeStringLongIntMap( const TStringLongIntMap h ) {
  delete (QStringLongIntMap*)h;
}



LIBSPEC void stringLongIntMapInsert( const TStringLongIntMap h, const char* key, const long val ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    sprintf( msg, "Inserting key: '%s', val: %d", key, val );
    dbcout( msg );
  #endif

  ((QStringLongIntMap*)h)->insert( QString( key ), val );
}



LIBSPEC long stringLongIntMapValue( const TStringLongIntMap h, const char* key ) {
  return ((QStringLongIntMap*)h)->value( QString( key ) );
}



LIBSPEC int stringLongIntMapItemAtIndex( const TStringLongIntMap h, int index ) {
  QStringLongIntMapIterator j;
  int temp = -1;

  if (  ((QStringLongIntMap*)h)->count() > index )
  {
    j = ((QStringLongIntMap*)h)->begin();
    j += index;

    temp = j.value();
  };

  return temp;
}



LIBSPEC char* stringLongIntMapKeyAtIndex( const TStringLongIntMap h, int index ) {
  QStringLongIntMapIterator j;
  char* temp = NULL;

  if (  ((QStringLongIntMap*)h)->count() > index )
  {
    j = ((QStringLongIntMap*)h)->begin();
    j += index;

    temp = _qstring_longint_map_getbuffer( j.key() );
  };

  return temp;
}



LIBSPEC char* stringLongIntMapKey( const TStringLongIntMap h, const int val ) {
  QString key;
  char* temp = NULL;

  key = ((QStringLongIntMap*)h)->key( val );

  temp = _qstring_longint_map_getbuffer( key );

  return temp;
}



LIBSPEC long stringLongIntMapBegin( const TStringLongIntMap h ) {
  QStringLongIntMap::iterator i;

  i = ((QStringLongIntMap*)h)->begin();

  return i.value();
}



LIBSPEC long stringLongIntMapRemoveFirst( const TStringLongIntMap h ) {
  QStringLongIntMap* map = (QStringLongIntMap*)h;
  QStringLongIntMap::iterator i;
  long result;

  i = map->begin();

  result = i.value();

  map->erase( i );

  return result;
}



LIBSPEC int stringLongIntMapRemove( const TStringLongIntMap h, const char* key ) {
  return ((QStringLongIntMap*)h)->remove( QString( key ) );
}



LIBSPEC bool stringLongIntMapContains( const TStringLongIntMap h, const char* key ) {
  return ((QStringLongIntMap*)h)->contains( QString( key ) );
}



LIBSPEC void stringLongIntMapClear( const TStringLongIntMap h ) {
  ((QStringLongIntMap*)h)->clear();
}



LIBSPEC bool stringLongIntMapIsEmpty( const TStringLongIntMap h ) {
  return ((QStringLongIntMap*)h)->isEmpty();
}



LIBSPEC int stringLongIntMapSize( const TStringLongIntMap h ) {
  return ((QStringLongIntMap*)h)->size();
}



LIBSPEC void stringLongIntMapTest( const TStringLongIntMap h ) {
  #ifdef DEBUG
    QStringLongIntMap* map = (QStringLongIntMap*)h;
    QStringLongIntMap::iterator i;
    char msg[1024];

    sprintf( msg, "Long Int Map address: %d", h );
    dbcout( msg );

    dbcout( "" );
    dbcout( "Testing Long Int map" );

    for (i = map->begin(); i != map->end(); ++i) {
      sprintf( msg, "retrieving key: '%s', val: %d", i.key().toAscii().data(), i.value() );
      dbcout( msg );
    }

    dbcout( "Done with test" );
    dbcout( "" );
  #endif
}



LIBSPEC void stringLongIntMapIteratorKey( TStringLongIntMap h, const int idx, char* buf ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QStringLongIntMapIterator j;
  j = ((QStringLongIntMap*)h)->begin();

  j += idx;

  #ifdef DEBUG
    sprintf( msg, "Index: %d  Iterator key: '%s'", idx, j.key().toAscii().data() );
    dbcout( msg );
  #endif

  strcpy( buf, j.key().toAscii().data() );
}



LIBSPEC long stringLongIntMapIteratorValue( TStringLongIntMap h, const int idx ) {
  QStringLongIntMapIterator j;

  j = ((QStringLongIntMap*)h)->begin();
  j += idx;

  return j.value();
}






