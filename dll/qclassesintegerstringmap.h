/*
qclassesintegerstringmap.h
--------------------------
Begin: 2007/02/01
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

/**
  This file provides a "flattened" interface (accessible by a Delphi program)
  for Qt QMaps (see http://doc.trolltech.com/4.1/qmap.html) that use integer
  keys and accept strings as values.  
  Syntax follows the QMap interface as closely as possible: see the
  file QIntegerMaps.pas for typical Delphi usage.

  For a detailed description of the methods used to create this DLL, please see
  the article "Writing Windows DLLs for use across languages and compilers",
  available at http://www.aaronreeves.com/windows-dlls-part-1.
*/


#ifndef _QCLASSESINTEGERSTRINGMAP_H_
#define _QCLASSESINTEGERSTRINGMAP_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif

/* A typedef for the map class itself */
typedef void* TIntegerStringMap;


// Map: Construction/Destruction
//------------------------------
/* Creates a new map. */
LIBSPEC TIntegerStringMap newIntegerStringMap( void );

/* Deletes (frees) and existing map. */
LIBSPEC void freeIntegerStringMap( const TIntegerStringMap h );



// Map: Useful functions
//----------------------
/* Inserts a new value into the map, with the specified key. */
LIBSPEC void integerStringMapInsert( const TIntegerStringMap h, const int key, const char* val );

/* Retrieves a value from the map based on the specified key. */
LIBSPEC char* integerStringMapValue( const TIntegerStringMap h, const int key );

/* Retrieves the first value in the map. */
LIBSPEC char* integerStringMapBegin( const TIntegerStringMap h );

/* Retrieves the first value in the map, and then removes it from the map. */
LIBSPEC char* integerStringMapRemoveFirst( const TIntegerStringMap h );

/* Removes a value from the map based on the key. */
LIBSPEC int integerStringMapRemove( const TIntegerStringMap h, const int key );

/* Does the map contain a value with the specified key? */
LIBSPEC bool integerStringMapContains( const TIntegerStringMap h, const int key );

/* Removes all values from the map. */
LIBSPEC void integerStringMapClear( const TIntegerStringMap h );

LIBSPEC char* integerStringItemAtIndex( const TIntegerStringMap h, int index );
LIBSPEC int integerStringKeyAtIndex( const TIntegerStringMap h, int index );



// Map: Properties
//----------------
/* Is the map empty? */
LIBSPEC bool integerStringMapIsEmpty( const TIntegerStringMap h );

/* How many strings are in the map? */
LIBSPEC int integerStringMapSize( const TIntegerStringMap h );



// Map: Testing/debugging
//-----------------------
/* Shows the complete contents of the map.  DEBUG must be defined. */
LIBSPEC void integerStringMapTest( const TIntegerStringMap h );



// Map iterator
//-------------
LIBSPEC int integerStringMapIteratorKey( TIntegerStringMap h, const int idx );
LIBSPEC char* integerStringMapIteratorValue( TIntegerStringMap h, const int idx );



#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESINTEGERSTRINGMAP_H_ */
