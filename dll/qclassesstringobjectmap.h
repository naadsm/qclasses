/*
qclassesstringobjectmap.h
-------------------------
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

/**
  This file provides a "flattened" interface (accessible by a Delphi program)
  for Qt QMaps (see http://doc.trolltech.com/4.1/qmap.html) that use string
  keys and accept objects (instances of Delphi classes) or other variable types
  as values.  Syntax follows the QMap interface as closely as possible: see the
  file QStringMaps.pas for typical Delphi usage.

  For a detailed description of the methods used to create this DLL, please see
  the article "Writing Windows DLLs for use across languages and compilers",
  available at http://www.aaronreeves.com/windows-dlls-part-1.
*/


#ifndef _QCLASSESSTRINGOBJECTMAP_H_
#define _QCLASSESSTRINGOBJECTMAP_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif

/* A typedef for the map class itself */
typedef void* TStringObjectMap;


/* A typedef for the objects that will be values in the map */
typedef void* TObject;


// Map: Construction/Destruction
//------------------------------
/* Creates a new map. */
LIBSPEC TStringObjectMap newStringObjectMap( void );

/* Deletes (frees) and existing map.  Objects stored as values in the map are not deleted. */
LIBSPEC void freeStringObjectMap( const TStringObjectMap h );


// Map: Useful functions
//----------------------
/* Inserts a new value into the map, with the specified key. */
LIBSPEC void stringObjectMapInsert( const TStringObjectMap h, const char* key, const TObject val );

/* Retrieves a value from the map based on the specified key. */
LIBSPEC TObject stringObjectMapValue( const TStringObjectMap h, const char* key );

/* Retrieves the first value in the map. */
LIBSPEC TObject stringObjectMapBegin( const TStringObjectMap h );

/* Retrieves the first value in the map, and then removes it from the map. */
LIBSPEC TObject stringObjectMapRemoveFirst( const TStringObjectMap h );

/* Removes a value from the map based on the key. */
LIBSPEC int stringObjectMapRemove( const TStringObjectMap h, const char* key );

/* Does the map contain a value with the specified key? */
LIBSPEC bool stringObjectMapContains( const TStringObjectMap h, const char* key );

/* Removes all values from the map.  Objects stored in the map are NOT freed. */
LIBSPEC void stringObjectMapClear( const TStringObjectMap h );

LIBSPEC TObject stringObjectMapItemAtIndex( const TStringObjectMap h, int index );
LIBSPEC char* stringObjectMapKeyAtIndex( const TStringObjectMap h, int index );

/* What is the key associated with the specified value? */
LIBSPEC char* stringObjectMapKey( const TStringObjectMap h, const TObject val );


// Map: Properties
//----------------
/* Is the map empty? */
LIBSPEC bool stringObjectMapIsEmpty( const TStringObjectMap h );

/* How many objects are in the map? */
LIBSPEC int stringObjectMapSize( const TStringObjectMap h );


// Map: Testing/debugging
//-----------------------
/* Shows the complete contents of the map.  DEBUG must be defined. */
LIBSPEC void stringObjectMapTest( const TStringObjectMap h );


// Iterator
//---------
LIBSPEC void stringObjectMapIteratorKey( TStringObjectMap h, const int idx, char* buf );
LIBSPEC TObject stringObjectMapIteratorValue( TStringObjectMap h, const int idx );



#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESSTRINGOBJECTMAP_H_ */
