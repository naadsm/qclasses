/*
qclassesstringstringmap.cpp
---------------------------
Begin: 2006/07/11
Last revision: $Date: 2011-10-25 05:05:10 $ $Author: areeves $
Version: $Revision: 1.3 $
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


#include "qclassesstringstringmap.h"

#include "debugging.h"
#include "stringhandling.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qmap.h>
#include <qstring.h>

typedef QMap<QString, QString>QStringStringMap;
typedef QStringStringMap::iterator QStringStringMapIterator;

/*
char* QStringStringBuffer = NULL;
unsigned long QStringStringBufferSize = 0;



char* _qstring_string_map_getbuffer( QString myString ) {
   unsigned long Size = strlen( (char *)(myString.toAscii().data()) ) + 1;

  if ( QStringStringBufferSize <  Size )
  {
     if ( QStringStringBuffer != NULL )
     {
        delete QStringStringBuffer;
        QStringStringBuffer = NULL;
     }

     QStringStringBuffer = new char[ Size ];
     QStringStringBufferSize = Size;
  };

  memset( QStringStringBuffer, 0, QStringStringBufferSize );

  strcpy( QStringStringBuffer, (char*)(myString.toAscii().data()) );

  return QStringStringBuffer;
}
*/


LIBSPEC TStringStringMap newStringStringMap( void ) {
  return new QStringStringMap();
}



LIBSPEC void freeStringStringMap( const TStringStringMap h ) {
  delete (QStringStringMap*)h;
  //delete QStringStringBuffer;
  //QStringStringBuffer = NULL;
  //QStringStringBufferSize = 0;
}



LIBSPEC void stringStringMapInsert( const TStringStringMap h, const char* key, const char* val ) {
  #ifdef DEBUG
    char msg[1024];

    sprintf( msg, "Map address: %d", h );
    dbcout( msg );

    sprintf( msg, "Inserting key: '%s', val: %s", key, val );
    dbcout( msg );
  #endif

  ((QStringStringMap*)h)->insert( QString( key ), QString( val ) );
}



LIBSPEC char* stringStringMapValue( const TStringStringMap h, const char* key ) {
  char* temp = charPtrFromQString/*_qstring_string_map_getbuffer*/( ((QStringStringMap*)h)->value( QString( key ) ) );

  return temp;
}



LIBSPEC char *stringStringItemAtIndex( const TStringStringMap h, int index ) {
  QStringStringMapIterator j;
  char* temp = NULL;

  if (  ((QStringStringMap*)h)->count() > index )
  {
    j = ((QStringStringMap*)h)->begin();
    j += index;

    temp = charPtrFromQString/*_qstring_string_map_getbuffer*/( j.value() );
  };

  return temp;
}



LIBSPEC char *stringStringKeyAtIndex( const TStringStringMap h, int index ) {
  QStringStringMapIterator j;
  char* temp = NULL;

  if (  ((QStringStringMap*)h)->count() > index )
  {
    j = ((QStringStringMap*)h)->begin();
    j += index;

    temp = charPtrFromQString/*_qstring_string_map_getbuffer*/( j.key() );
  };

  return temp;
}



LIBSPEC char* stringStringMapKey( const TStringStringMap h, const char* val ) {
  QString key;
  char* temp = NULL;

  key = ((QStringStringMap*)h)->key( val );

  temp = charPtrFromQString/*_qstring_string_map_getbuffer*/( key );

  return temp;
}



LIBSPEC char* stringStringMapBegin( const TStringStringMap h ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QStringStringMap::iterator i;

  i = ((QStringStringMap*)h)->begin();
  
  #ifdef DEBUG
    sprintf( msg, "stringStringMapBegin should return %s", i.value().toAscii().data() );
    dbcout( msg ); 
  #endif

  return charPtrFromQString/*_qstring_string_map_getbuffer*/( i.value() );
}



LIBSPEC char* stringStringMapRemoveFirst( const TStringStringMap h ) {
  QStringStringMap* map = (QStringStringMap*)h;
  QStringStringMap::iterator i;
  char *result;

  i = map->begin();

  result = charPtrFromQString/*_qstring_string_map_getbuffer*/( i.value() );

  map->erase( i );

  return result;
}



LIBSPEC int stringStringMapRemove( const TStringStringMap h, const char* key ) {
  return ((QStringStringMap*)h)->remove( QString( key ) );
}



LIBSPEC bool stringStringMapContains( const TStringStringMap h, const char* key ) {
#ifdef DEBUG
  dbcout( (char *)key );
#endif
  return ((QStringStringMap*)h)->contains( QString( key ) );
}



LIBSPEC void stringStringMapClear( const TStringStringMap h ) {
  ((QStringStringMap*)h)->clear();
}



LIBSPEC bool stringStringMapIsEmpty( const TStringStringMap h ) {
  return ((QStringStringMap*)h)->isEmpty();
}



LIBSPEC int stringStringMapSize( const TStringStringMap h ) {
  return ((QStringStringMap*)h)->size();
}



LIBSPEC void stringStringMapTest( const TStringStringMap h ) {
  #ifdef DEBUG
    QStringStringMap* map = (QStringStringMap*)h;
    QStringStringMap::iterator i;
    char msg[1024];

    sprintf( msg, "String Map address: %d", h );
    dbcout( msg );

    dbcout( "" );
    dbcout( "Testing String map" );

    for (i = map->begin(); i != map->end(); ++i) {
      sprintf( msg, "retrieving key: '%s', val: %s", i.key().toAscii().data(), i.value().toAscii().data() );
      dbcout( msg );
    }

    dbcout( "Done with test" );
    dbcout( "" );
  #endif
}



LIBSPEC char *stringStringMapIteratorValue( TStringStringMap h, const int idx ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QStringStringMapIterator j;

  j = ((QStringStringMap*)h)->begin();
  j += idx;

  #ifdef DEBUG
    sprintf( msg, "stringStringMapIteratorValue should return %s", j.value().toAscii().data() );
    dbcout( msg ); 
  #endif

  return charPtrFromQString/*_qstring_string_map_getbuffer*/( j.value() );
}



LIBSPEC void stringStringMapIteratorKey( TStringStringMap h, const int idx, char* buf ) {
  #ifdef DEBUG
    char msg[1024];
  #endif
  QStringStringMapIterator j;
  j = ((QStringStringMap*)h)->begin();

  j += idx;

  #ifdef DEBUG
    sprintf( msg, "Index: %d  Iterator key: '%s'", idx, j.key().toAscii().data() );
    dbcout( msg );
  #endif

  strcpy( buf, j.key().toAscii().data() );
}








