/*
qclassesstringobjectmap.cpp
---------------------------
Begin: 2006/07/11
Last revision: $Date: 2011-10-25 05:05:10 $ $Author: areeves $
Version: $Revision: 1.2 $
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
#include "qclassesstringobjectmap.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qmap.h>
#include <qstring.h>

typedef QMap<QString, TObject> QStringObjectMap;
typedef QStringObjectMap::iterator QStringObjectMapIterator;

char* QStringObjectBuffer = NULL;
unsigned long QStringObjectBufferSize = 0;



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



LIBSPEC TStringObjectMap newStringObjectMap( void ) {
  return new QStringObjectMap();
}



LIBSPEC void freeStringObjectMap( const TStringObjectMap h ) {
  delete (QStringObjectMap*)h;
}



LIBSPEC void stringObjectMapInsert( const TStringObjectMap h, const char* key, const TObject val ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    sprintf( msg, "Inserting key: '%s', val: %d", key, val );
    dbcout( msg );
  #endif

  ((QStringObjectMap*)h)->insert( QString( key ), val );
}



LIBSPEC TObject stringObjectMapValue( const TStringObjectMap h, const char* key ) {
  return ((QStringObjectMap*)h)->value( QString( key ) );
}



LIBSPEC TObject stringObjectMapItemAtIndex( const TStringObjectMap h, int index ) {
  QStringObjectMapIterator j;
  TObject temp = NULL;

  if (  ((QStringObjectMap*)h)->count() > index )
  {
    j = ((QStringObjectMap*)h)->begin();
    j += index;

    temp = j.value();
  };

  return temp;
}



LIBSPEC char *stringObjectMapKeyAtIndex( const TStringObjectMap h, int index ) {
  QStringObjectMapIterator j;
  char* temp = NULL;

  if (  ((QStringObjectMap*)h)->count() > index )
  {
    j = ((QStringObjectMap*)h)->begin();
    j += index;

    temp = _qstring_object_map_getbuffer( j.key() );
  };

  return temp;
}



LIBSPEC char* stringObjectMapKey( const TStringObjectMap h, const TObject val ) {
  QString key;
  char* temp = NULL;

  key = ((QStringObjectMap*)h)->key( val );

  temp = _qstring_object_map_getbuffer( key );

  return temp;
}



LIBSPEC TObject stringObjectMapBegin( const TStringObjectMap h ) {
  QStringObjectMap::iterator i;

  i = ((QStringObjectMap*)h)->begin();

  return i.value();
}



LIBSPEC TObject stringObjectMapRemoveFirst( const TStringObjectMap h ) {
  QStringObjectMap* map = (QStringObjectMap*)h;
  QStringObjectMap::iterator i;
  TObject result;

  i = map->begin();

  result = i.value();

  map->erase( i );

  return result;
}



LIBSPEC int stringObjectMapRemove( const TStringObjectMap h, const char* key ) {
  return ((QStringObjectMap*)h)->remove( QString( key ) );
}



LIBSPEC bool stringObjectMapContains( const TStringObjectMap h, const char* key ) {
  return ((QStringObjectMap*)h)->contains( QString( key ) );
}



LIBSPEC void stringObjectMapClear( const TStringObjectMap h ) {
  ((QStringObjectMap*)h)->clear();
}



LIBSPEC bool stringObjectMapIsEmpty( const TStringObjectMap h ) {
  return ((QStringObjectMap*)h)->isEmpty();
}



LIBSPEC int stringObjectMapSize( const TStringObjectMap h ) {
  return ((QStringObjectMap*)h)->size();
}



LIBSPEC void stringObjectMapTest( const TStringObjectMap h ) {
  #ifdef DEBUG
    QStringObjectMap* map = (QStringObjectMap*)h;
    QStringObjectMap::iterator i;
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    dbcout( "" );
    dbcout( "Testing map" );

    for (i = map->begin(); i != map->end(); ++i) {
      sprintf( msg, "retrieving key: '%s', val: %d", i.key().toAscii().data(), i.value() );
      dbcout( msg );
    }

    dbcout( "Done with test" );
    dbcout( "" );
  #endif
}



LIBSPEC void stringObjectMapIteratorKey( TStringObjectMap h, const int idx, char* buf ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QStringObjectMapIterator j;
  j = ((QStringObjectMap*)h)->begin();

  j += idx;

  #ifdef DEBUG
    sprintf( msg, "Index: %d  Iterator key: '%s'", idx, j.key().toAscii().data() );
    dbcout( msg );
  #endif

  strcpy( buf, j.key().toAscii().data() );
}



LIBSPEC TObject stringObjectMapIteratorValue( TStringObjectMap h, const int idx ) {
  QStringObjectMapIterator j;

  j = ((QStringObjectMap*)h)->begin();
  j += idx;

  return j.value();
}



