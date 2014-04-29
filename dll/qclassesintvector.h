/*
qclassesintvector.h
-------------------
Begin: 2007/01/13
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
  for a Qt QVector (see http://doc.trolltech.com/4.1/qmap.html) that
  takes integers as values.  Syntax follows the QVector interface as closely as
  possible: see the file QVectors.pas for typical Delphi usage.

  For a detailed description of the methods used to create this DLL, please see
  the article "Writing Windows DLLs for use across languages and compilers",
  available at http://www.aaronreeves.com/windows-dlls-part-1.
*/


#ifndef _QCLASSESINTVECTOR_H_
#define _QCLASSESINTVECTOR_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif


/* A typedef for the vector class itself */
typedef void* TIntVector;


// Construction/Destruction
//-------------------------
/* Creates a new vector. */
LIBSPEC TIntVector newIntegerVector( void );

/* Deletes (frees) and existing vector. */
LIBSPEC void freeIntegerVector( const TIntVector h );


// Useful functions
//-----------------
/* Removes all values from the vector. */
LIBSPEC void integerVectorClear( const TIntVector h );

/* Does the vector contain the specified value? */
LIBSPEC bool integerVectorContains( const TIntVector h, const int val );

/* Add to the end of the vector. */
LIBSPEC void integerVectorAppend( const TIntVector h, const int val );

/* Specify the vector size. */
LIBSPEC void integerVectorResize( const TIntVector h, const int newSize );

/* How many elements will the vector hold? */
LIBSPEC int integerVectorCapacity(  const TIntVector h );

/* How many elements are in the vector? */
LIBSPEC int integerVectorCount( const TIntVector h );

/* What is the value at the specified position? */
LIBSPEC int integerVectorAt( const TIntVector h, const int idx );

/* Set the value at the specified position. */
LIBSPEC void integerVectorSetAt( const TIntVector h, const int idx, const int val );

/* Sort the items in the vector. */
LIBSPEC void integerVectorSort( const TIntVector h );

/* Fill all array items with the specified value. */
LIBSPEC void integerVectorFill( const TIntVector h, const int val );


#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESINTVECTOR_H_ */
