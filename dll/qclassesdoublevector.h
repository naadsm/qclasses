/*
qclassesdoublevector.h
----------------------
Begin: 2007/05/11
Last revision: $Date: 2011-10-25 05:05:08 $ $Author: areeves $
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
  takes doubles as values.  Syntax follows the QVector interface as closely as
  possible: see the file QVectors.pas for typical Delphi usage.

  For a detailed description of the methods used to create this DLL, please see
  the article "Writing Windows DLLs for use across languages and compilers",
  available at http://www.aaronreeves.com/windows-dlls-part-1.
*/


#ifndef _QCLASSESDOUBLEVECTOR_H_
#define _QCLASSESDOUBLEVECTOR_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif


/* A typedef for the vector class itself */
typedef void* TDoubleVector;


// Construction/Destruction
//-------------------------
/* Creates a new vector. */
LIBSPEC TDoubleVector newDoubleVector( void );

/* Deletes (frees) and existing vector. */
LIBSPEC void freeDoubleVector( const TDoubleVector h );


// Useful functions
//-----------------
/* Removes all values from the vector. */
LIBSPEC void doubleVectorClear( const TDoubleVector h );

/* Does the vector contain the specified value? */
LIBSPEC bool doubleVectorContains( const TDoubleVector h, const double val );

/* Add to the end of the vector. */
LIBSPEC void doubleVectorAppend( const TDoubleVector h, const double val );

/* Specify the vector size. */
LIBSPEC void doubleVectorResize( const TDoubleVector h, const int newSize );

/* How many elements will the vector hold? */
LIBSPEC int doubleVectorCapacity(  const TDoubleVector h );

/* How many elements are in the vector? */
LIBSPEC int doubleVectorCount( const TDoubleVector h );

/* What is the value at the specified position? */
LIBSPEC double doubleVectorAt( const TDoubleVector h, const int idx );

/* Set the value at the specified position. */
LIBSPEC void doubleVectorSetAt( const TDoubleVector h, const int idx, const double val );

/* Sort the items in the vector. */
LIBSPEC void doubleVectorSort( const TDoubleVector h );

/* Fill all array items with the specified value. */
LIBSPEC void doubleVectorFill( const TDoubleVector h, const double val );

#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESDOUBLEVECTOR_H_ */
