/*
qclassesintuintmap.h
---------------------
Begin: 2007/02/04
Last revision: $Date: 2011-10-25 05:05:09 $ $Author: areeves $
Version: $Revision: 1.2 $
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


#ifndef _QCLASSESINTUINTMAP_H_
#define _QCLASSESINTUINTMAP_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif

/* A typedef for the map class itself */
typedef void* TIntUIntMap;


// Map: Construction/Destruction
//------------------------------
/* Creates a new map. */
LIBSPEC TIntUIntMap newIntUIntMap( void );

/* Deletes (frees) and existing map. */
LIBSPEC void freeIntUIntMap( const TIntUIntMap h );



// Map: Useful functions
//----------------------
/* Inserts a new value into the map, with the specified key. */
LIBSPEC void intUIntMapInsert( const TIntUIntMap h, const int key, const unsigned int val );

/* Retrieves a value from the map based on the specified key. */
LIBSPEC unsigned int intUIntMapValue( const TIntUIntMap h, const int key );

/* Retrieves the first value in the map. */
LIBSPEC unsigned int intUIntMapBegin( const TIntUIntMap h );

/* Retrieves the first value in the map, and then removes it from the map. */
LIBSPEC unsigned int intUIntMapRemoveFirst( const TIntUIntMap h );

/* Removes a value from the map based on the key. */
LIBSPEC int intUIntMapRemove( const TIntUIntMap h, const int key );

/* Does the map contain a value with the specified key? */
LIBSPEC bool intUIntMapContains( const TIntUIntMap h, const int key );

/* Removes all values from the map. */
LIBSPEC void intUIntMapClear( const TIntUIntMap h );

LIBSPEC unsigned int intUIntItemAtIndex( const TIntUIntMap h, int index );
LIBSPEC int intUIntKeyAtIndex( const TIntUIntMap h, int index );



// Map: Properties
//----------------
/* Is the map empty? */
LIBSPEC bool intUIntMapIsEmpty( const TIntUIntMap h );

/* How many strings are in the map? */
LIBSPEC int intUIntMapSize( const TIntUIntMap h );



// Map: Testing/debugging
//-----------------------
/* Shows the complete contents of the map.  DEBUG must be defined. */
LIBSPEC void intUIntMapTest( const TIntUIntMap h );



// Map iterator
//-------------
LIBSPEC int intUIntMapIteratorKey( TIntUIntMap h, const int idx );
LIBSPEC unsigned int intUIntMapIteratorValue( TIntUIntMap h, const int idx );



#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESINTUINTMAP_H_ */
