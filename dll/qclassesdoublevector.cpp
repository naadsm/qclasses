/*
qclassesdoublevector.cpp
------------------------
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


#include "debugging.h"
#include "qclassesdoublevector.h"

#ifdef DEBUG
  #include <iostream>
#endif

#include <qvector.h>

typedef QVector<double> QDoubleVector;


// Construction/Destruction
//-------------------------
/* Creates a new vector. */
LIBSPEC TDoubleVector newDoubleVector( void ) {
  return new QDoubleVector();
}


/* Deletes (frees) and existing vector. */
LIBSPEC void freeDoubleVector( const TDoubleVector h ) {
  delete (QDoubleVector*)h;
}


// Useful functions
//-----------------
/* Removes all values from the vector. */
LIBSPEC void doubleVectorClear( const TDoubleVector h ) {
  ((QDoubleVector*)h)->clear();
}


/* Does the vector contain the specified value? */
LIBSPEC bool doubleVectorContains( const TDoubleVector h, const double val ) {
  return( ((QDoubleVector*)h)->contains( val ) );
}


/* Add to the end of the vector. */
LIBSPEC void doubleVectorAppend( const TDoubleVector h, const double val ) {
  ((QDoubleVector*)h)->append( val );
}


/* Specify the vector size. */
LIBSPEC void doubleVectorResize( const TDoubleVector h, const int newSize ) {
  ((QDoubleVector*)h)->resize( newSize );
}


/* How many elements will the vector hold? */
LIBSPEC int doubleVectorCapacity(  const TDoubleVector h ) {
  return( ((QDoubleVector*)h)->capacity() );
}


/* How many elements are in the vector? */
LIBSPEC int doubleVectorCount( const TDoubleVector h ) {
  return( ((QDoubleVector*)h)->count() );
}


/* What is the value at the specified position? */
LIBSPEC double doubleVectorAt( const TDoubleVector h, const int idx ) {
  return( ((QDoubleVector*)h)->at( idx ) );
}


/* Set the value at the specified position. */
LIBSPEC void doubleVectorSetAt( const TDoubleVector h, const int idx, const double val ) {
  (*((QDoubleVector*)h))[idx] = val; 
}


/* Sort the items in the vector. */
LIBSPEC void doubleVectorSort( const TDoubleVector h ) {
  QDoubleVector* v = (QDoubleVector*)h;
  
  qSort( *v );  
}


/* Fill all array items with the specified value. */
LIBSPEC void doubleVectorFill( const TDoubleVector h, const double val ) {
 QDoubleVector* v = (QDoubleVector*)h;
 
 qFill( v->begin(), v->end(), val );  
}


