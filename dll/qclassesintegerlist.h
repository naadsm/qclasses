/*
qclassesintegerlist.h
--------------------
Begin: 2009/01/23
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
  for a Qt QIntegerList (see http://doc.trolltech.com/4.1/qintegerlist.html).
  Syntax follows the QList interface as closely as possible: see the file
  QLists.pas for typical Delphi usage.

  For a detailed description of the methods used to create this DLL, please see
  the article "Writing Windows DLLs for use across languages and compilers",
  available at http://www.aaronreeves.com/windows-dlls-part-1.
*/


#ifndef _QCLASSESINTEGERLIST_H_
#define _QCLASSESINTEGERLIST_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif

/* A typedef for the map class itself */
typedef void* TIntegerList;


// List: Construction/Destruction
//-------------------------------
/* Creates a new list. */
LIBSPEC TIntegerList newIntegerList( void );

/* Deletes (frees) and existing list.  Integers stored as values in the list are not deleted. */
LIBSPEC void freeIntegerList( const TIntegerList h );



// List: Useful functions
//-----------------------
LIBSPEC void integerListAppend( const TIntegerList h, const int val );

LIBSPEC void integerListPrepend( const TIntegerList h, const int val );

LIBSPEC void integerListInsert( const TIntegerList h, const int i, const int val );

LIBSPEC int integerListAt( const TIntegerList h, const int i );

LIBSPEC bool integerListContains( const TIntegerList h, const int val );

LIBSPEC void integerListClear( const TIntegerList h );

LIBSPEC void integerListRemoveAt( const TIntegerList h, const int i );

LIBSPEC void integerListReplace( const TIntegerList h, const int i, const int val );



// List: Properties
//-----------------
LIBSPEC bool integerListIsEmpty( const TIntegerList h );

LIBSPEC int integerListCount( const TIntegerList h );



#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESINTEGERLIST_H_ */
