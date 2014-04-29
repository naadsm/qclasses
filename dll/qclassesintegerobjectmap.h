/*
qclassesintegerobjectmap.h
--------------------------
Begin: 2006/12/20
Last revision: $Date: 2011-10-25 05:05:09 $ $Author: areeves $
Version: $Revision: 1.3 $
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
  for Qt QMaps (see http://doc.trolltech.com/4.1/qmap.html) that use integer
  keys and accept objects (instances of Delphi classes) or other variable types
  as values.  Syntax follows the QMap interface as closely as possible: see the
  file QIntegerMaps.pas for typical Delphi usage.

  For a detailed description of the methods used to create this DLL, please see
  the article "Writing Windows DLLs for use across languages and compilers",
  available at http://www.aaronreeves.com/windows-dlls-part-1.
*/


#ifndef _QCLASSESINTEGEROBJECTMAP_H_
#define _QCLASSESINTEGEROBJECTMAP_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif

/* A typedef for the map class itself */
typedef void* TIntegerObjectMap;

/* A typedef for the objects that will be values in the map */
typedef void* TObject;


// Map: Construction/Destruction
//------------------------------
/* Creates a new map. */
LIBSPEC TIntegerObjectMap newIntegerObjectMap( void );

/* Deletes (frees) and existing map.  Objects stored as values in the map are not deleted. */
LIBSPEC void freeIntegerObjectMap( const TIntegerObjectMap h );



// Map: Useful functions
//----------------------
/* Inserts a new value into the map, with the specified key. */
LIBSPEC void integerObjectMapInsert( const TIntegerObjectMap h, const int key, const TObject val );

/* Retrieves a value from the map based on the specified key. */
LIBSPEC TObject integerObjectMapValue( const TIntegerObjectMap h, const int key );

/* Retrieves the first value in the map. */
LIBSPEC TObject integerObjectMapBegin( const TIntegerObjectMap h );

/* Retrieves the first value in the map, and then removes it from the map. */
LIBSPEC TObject integerObjectMapRemoveFirst( const TIntegerObjectMap h );

/* Removes a value from the map based on the key. */
LIBSPEC int integerObjectMapRemove( const TIntegerObjectMap h, const int key );

/* Does the map contain a value with the specified key? */
LIBSPEC bool integerObjectMapContains( const TIntegerObjectMap h, const int key );

/* Removes all values from the map.  Objects stored in the map are NOT freed. */
LIBSPEC void integerObjectMapClear( const TIntegerObjectMap h );

LIBSPEC TObject integerObjectItemAtIndex( const TIntegerObjectMap h, int index );
LIBSPEC int integerObjectKeyAtIndex( const TIntegerObjectMap h, int index );



// Map: Properties
//----------------
/* Is the map empty? */
LIBSPEC bool integerObjectMapIsEmpty( const TIntegerObjectMap h );

/* How many objects are in the map? */
LIBSPEC int integerObjectMapSize( const TIntegerObjectMap h );



// Map: Testing/debugging
//-----------------------
/* Shows the complete contents of the map.  DEBUG must be defined. */
LIBSPEC void integerObjectMapTest( const TIntegerObjectMap h );



// Map iterator
//-------------
LIBSPEC int integerObjectMapIteratorKey( TIntegerObjectMap h, const int idx );
LIBSPEC TObject integerObjectMapIteratorValue( TIntegerObjectMap h, const int idx );



#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESINTEGEROBJECTMAP_H_ */
