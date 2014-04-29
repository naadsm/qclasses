/*
qclassesstringstringmap.h
-------------------------
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


#ifndef _QCLASSESSTRINGSTRINGMAP_H_
#define _QCLASSESSTRINGSTRINGMAP_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif

/* A typedef for the map class itself */
typedef void* TStringStringMap;


// Map: Construction/Destruction
//------------------------------
/* Creates a new map. */
LIBSPEC TStringStringMap newStringStringMap( void );

/* Deletes (frees) and existing map.  Strings stored as values in the map are not deleted. */
LIBSPEC void freeStringStringMap( const TStringStringMap h );


// Map: Useful functions
//----------------------
/* Inserts a new value into the map, with the specified key. */
LIBSPEC void stringStringMapInsert( const TStringStringMap h, const char* key, const char* val );

/* Retrieves a value from the map based on the specified key. */
LIBSPEC char *stringStringMapValue( const TStringStringMap h, const char* key );

LIBSPEC char *stringStringItemAtIndex( const TStringStringMap h, int index );
LIBSPEC char *stringStringKeyAtIndex( const TStringStringMap h, int index );

/* What is the key associated with the specified value? */
LIBSPEC char* stringStringMapKey( const TStringStringMap h, const char* val );

/* Retrieves the first value in the map. */
LIBSPEC char  *stringStringMapBegin( const TStringStringMap h );

/* Retrieves the first value in the map, and then removes it from the map. */
LIBSPEC char  *stringStringMapRemoveFirst( const TStringStringMap h );

/* Removes a value from the map based on the key. */
LIBSPEC int stringStringMapRemove( const TStringStringMap h, const char* key );

/* Does the map contain a value with the specified key? */
LIBSPEC bool stringStringMapContains( const TStringStringMap h, const char* key );

/* Removes all values from the map.  Strings stored in the map are NOT freed. */
LIBSPEC void stringStringMapClear( const TStringStringMap h );

// Map: Properties
//----------------
/* Is the map empty? */
LIBSPEC bool stringStringMapIsEmpty( const TStringStringMap h );

/* How many Strings are in the map? */
LIBSPEC int stringStringMapSize( const TStringStringMap h );


// Map: Testing/debugging
//-----------------------
/* Shows the complete contents of the map.  DEBUG must be defined. */
LIBSPEC void stringStringMapTest( const TStringStringMap h );


// Iterator
//---------
LIBSPEC void stringStringMapIteratorKey( TStringStringMap h, const int idx, char* buf );
LIBSPEC char *stringStringMapIteratorValue( TStringStringMap h, const int idx );





#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESSTRINGSTRINGMAP_H_ */
