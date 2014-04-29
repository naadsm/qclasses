/*
qclassesintegerdoublemap.h
--------------------------
Begin: 2009/01/29
Last revision: $Date: 2011-10-25 05:05:09 $ $Author: areeves $
Version: $Revision: 1.2 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2009 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*/

/**
  This file provides a "flattened" interface (accessible by a Delphi program)
  for Qt QMaps (see http://doc.trolltech.com/4.1/qmap.html) that use integer
  keys and accept integers as values.
  Syntax follows the QMap interface as closely as possible: see the
  file QIntegerMaps.pas for typical Delphi usage.

  For a detailed description of the methods used to create this DLL, please see
  the article "Writing Windows DLLs for use across languages and compilers",
  available at http://www.aaronreeves.com/windows-dlls-part-1.
*/


#ifndef _QCLASSESINTEGERDOUBLEMAP_H_
#define _QCLASSESINTEGERDOUBLEMAP_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif

/* A typedef for the map class itself */
typedef void* TIntegerDoubleMap;


// Map: Construction/Destruction
//------------------------------
/* Creates a new map. */
LIBSPEC TIntegerDoubleMap newIntegerDoubleMap( void );

/* Deletes (frees) and existing map. */
LIBSPEC void freeIntegerDoubleMap( const TIntegerDoubleMap h );



// Map: Useful functions
//----------------------
/* Inserts a new value into the map, with the specified key. */
LIBSPEC void integerDoubleMapInsert( const TIntegerDoubleMap h, const int key, const double val );

/* Retrieves a value from the map based on the specified key. */
LIBSPEC double integerDoubleMapValue( const TIntegerDoubleMap h, const int key );

/* Retrieves the first value in the map. */
LIBSPEC double integerDoubleMapBegin( const TIntegerDoubleMap h );

/* Retrieves the first value in the map, and then removes it from the map. */
LIBSPEC double integerDoubleMapRemoveFirst( const TIntegerDoubleMap h );

/* Removes a value from the map based on the key. */
LIBSPEC int integerDoubleMapRemove( const TIntegerDoubleMap h, const int key );

/* Does the map contain a value with the specified key? */
LIBSPEC bool integerDoubleMapContains( const TIntegerDoubleMap h, const int key );

/* Removes all values from the map. */
LIBSPEC void integerDoubleMapClear( const TIntegerDoubleMap h );

LIBSPEC double integerDoubleItemAtIndex( const TIntegerDoubleMap h, int index );
LIBSPEC int integerDoubleKeyAtIndex( const TIntegerDoubleMap h, int index );



// Map: Properties
//----------------
/* Is the map empty? */
LIBSPEC bool integerDoubleMapIsEmpty( const TIntegerDoubleMap h );

/* How many items are in the map? */
LIBSPEC int integerDoubleMapSize( const TIntegerDoubleMap h );



// Map: Testing/debugging
//-----------------------
/* Shows the complete contents of the map.  DEBUG must be defined. */
LIBSPEC void integerDoubleMapTest( const TIntegerDoubleMap h );



// Map iterator
//-------------
LIBSPEC int integerDoubleMapIteratorKey( TIntegerDoubleMap h, const int idx );
LIBSPEC double integerDoubleMapIteratorValue( TIntegerDoubleMap h, const int idx );



#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESINTEGERDOUBLEMAP_H_ */
