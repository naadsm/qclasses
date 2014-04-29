/*
qclassesboolvector.cpp
----------------------
Begin: 2007/05/11
Last revision: $Date: 2011-10-25 05:05:08 $ $Author: areeves $
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


#include "debugging.h"
#include "qclassesboolvector.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qvector.h>

typedef QVector<bool> QBooleanVector;


// Construction/Destruction
//-------------------------
/* Creates a new vector. */
LIBSPEC TBooleanVector newBooleanVector( void ) {
  return new QBooleanVector();
}


/* Deletes (frees) and existing vector. */
LIBSPEC void freeBooleanVector( const TBooleanVector h ) {
  delete (QBooleanVector*)h;
}


// Useful functions
//-----------------
/* Removes all values from the vector. */
LIBSPEC void booleanVectorClear( const TBooleanVector h ) {
  ((QBooleanVector*)h)->clear();
}


/* Does the vector contain the specified value? */
LIBSPEC bool booleanVectorContains( const TBooleanVector h, const bool val ) {
  return( ((QBooleanVector*)h)->contains( val ) );
}


/* Add to the end of the vector. */
LIBSPEC void booleanVectorAppend( const TBooleanVector h, const bool val ) {
  ((QBooleanVector*)h)->append( val );
}


/* Specify the vector size. */
LIBSPEC void booleanVectorResize( const TBooleanVector h, const int newSize ) {
  ((QBooleanVector*)h)->resize( newSize );
}


/* How many elements will the vector hold? */
LIBSPEC int booleanVectorCapacity(  const TBooleanVector h ) {
  return( ((QBooleanVector*)h)->capacity() );
}


/* How many elements are in the vector? */
LIBSPEC int booleanVectorCount( const TBooleanVector h ) {
  return( ((QBooleanVector*)h)->count() );
}


/* What is the value at the specified position? */
LIBSPEC bool booleanVectorAt( const TBooleanVector h, const int idx ) {
  return( ((QBooleanVector*)h)->at( idx ) );
}


/* Set the value at the specified position. */
LIBSPEC void booleanVectorSetAt( const TBooleanVector h, const int idx, const bool val ) {
  (*((QBooleanVector*)h))[idx] = val; 
}


/* Fill all array items with the specified value. */
LIBSPEC void booleanVectorFill( const TBooleanVector h, const bool val ) {
 QBooleanVector* v = (QBooleanVector*)h;
 
 qFill( v->begin(), v->end(), val );  
}




