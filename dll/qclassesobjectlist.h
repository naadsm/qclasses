/*
qclassesobjectlist.h
---------------------
Begin: 2007/01/18
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
  for a Qt QList (see http://doc.trolltech.com/4.1/qlist.html) that stores
  objects (instances of Delphi classes) as values.  Syntax
  follows the QList interface as closely as possible: see the file
  QLists.pas for typical Delphi usage.

  For a detailed description of the methods used to create this DLL, please see
  the article "Writing Windows DLLs for use across languages and compilers",
  available at http://www.aaronreeves.com/windows-dlls-part-1.
*/


#ifndef _QCLASSESOBJECTLIST_H_
#define _QCLASSESOBJECTLIST_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif

/* A typedef for the map class itself */
typedef void* TObjectList;

/* A typedef for the objects that will be values in the list */
typedef void* TObject;


// List: Construction/Destruction
//-------------------------------
/* Creates a new list. */
LIBSPEC TObjectList newObjectList( void );

/* Deletes (frees) and existing list.  Objects stored as values in the list are not deleted. */
LIBSPEC void freeObjectList( const TObjectList h );



// List: Useful functions
//-----------------------
LIBSPEC void objectListAppend( const TObjectList h, const TObject val );

LIBSPEC void objectListPrepend( const TObjectList h, const TObject val );

LIBSPEC void objectListInsert( const TObjectList h, const int i, const TObject val );

LIBSPEC TObject objectListAt( const TObjectList h, const int i );

LIBSPEC bool objectListContains( const TObjectList h, const TObject val );

LIBSPEC TObject objectListTakeFirst( const TObjectList h );

LIBSPEC void objectListClear( const TObjectList h );

LIBSPEC void objectListRemoveAt( const TObjectList h, const int i );

LIBSPEC void objectListReplace( const TObjectList h, const int i, const TObject val );



// List: Properties
//-----------------
LIBSPEC bool objectListIsEmpty( const TObjectList h );

LIBSPEC int objectListCount( const TObjectList h );



#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESOBJECTLIST_H_ */
