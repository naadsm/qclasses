/*
qclassesintvector.cpp
---------------------
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


#include "debugging.h"
#include "qclassesintvector.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qvector.h>

typedef QVector<int> QIntVector;


// Construction/Destruction
//-------------------------
/* Creates a new vector. */
LIBSPEC TIntVector newIntegerVector( void ) {
  return new QIntVector();
}


/* Deletes (frees) and existing vector. */
LIBSPEC void freeIntegerVector( const TIntVector h ) {
  delete (QIntVector*)h;
}


// Useful functions
//-----------------
/* Removes all values from the vector. */
LIBSPEC void integerVectorClear( const TIntVector h ) {
  ((QIntVector*)h)->clear();
}


/* Does the vector contain the specified value? */
LIBSPEC bool integerVectorContains( const TIntVector h, const int val ) {
  return( ((QIntVector*)h)->contains( val ) );
}


/* Add to the end of the vector. */
LIBSPEC void integerVectorAppend( const TIntVector h, const int val ) {
  ((QIntVector*)h)->append( val );
}


/* Specify the vector size. */
LIBSPEC void integerVectorResize( const TIntVector h, const int newSize ) {
  ((QIntVector*)h)->resize( newSize );
}


/* How many elements will the vector hold? */
LIBSPEC int integerVectorCapacity(  const TIntVector h ) {
  return( ((QIntVector*)h)->capacity() );
}


/* How many elements are in the vector? */
LIBSPEC int integerVectorCount( const TIntVector h ) {
  return( ((QIntVector*)h)->count() );
}


/* What is the value at the specified position? */
LIBSPEC int integerVectorAt( const TIntVector h, const int idx ) {
  return( ((QIntVector*)h)->at( idx ) );
}


/* Set the value at the specified position. */
LIBSPEC void integerVectorSetAt( const TIntVector h, const int idx, const int val ) {
  (*((QIntVector*)h))[idx] = val; 
}


/* Sort the items in the vector. */
LIBSPEC void integerVectorSort( const TIntVector h ) {
  qSort( *((QIntVector*)h) );  
}

/* Fill all array items with the specified value. */
LIBSPEC void integerVectorFill( const TIntVector h, const int val ) {
 QIntVector* v = (QIntVector*)h;
 
 qFill( v->begin(), v->end(), val );  
}





