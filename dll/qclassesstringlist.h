/*
qclassesstringlist.h
--------------------
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
  for a Qt QStringList (see http://doc.trolltech.com/4.1/qstringlist.html).
  Syntax follows the QList interface as closely as possible: see the file
  QLists.pas for typical Delphi usage.

  For a detailed description of the methods used to create this DLL, please see
  the article "Writing Windows DLLs for use across languages and compilers",
  available at http://www.aaronreeves.com/windows-dlls-part-1.
*/


#ifndef _QCLASSESSTRINGLIST_H_
#define _QCLASSESSTRINGLIST_H_

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
  extern "C" {
#endif

/* A typedef for the map class itself */
typedef void* TStringList;


// List: Construction/Destruction
//-------------------------------
/* Creates a new list. */
LIBSPEC TStringList newStringList( void );

/* Deletes (frees) and existing list.  Strings stored as values in the list are not deleted. */
LIBSPEC void freeStringList( const TStringList h );



// List: Useful functions
//-----------------------
LIBSPEC void stringListAppend( const TStringList h, const char* val );

LIBSPEC void stringListPrepend( const TStringList h, const char* val );

LIBSPEC void stringListInsert( const TStringList h, const int i, const char* val );

LIBSPEC char* stringListAt( const TStringList h, const int i );

LIBSPEC bool stringListContains( const TStringList h, const char* val );

//LIBSPEC char* stringListTakeFirst( const TStringList h );

LIBSPEC void stringListClear( const TStringList h );

LIBSPEC void stringListRemoveAt( const TStringList h, const int i );

LIBSPEC void stringListReplace( const TStringList h, const int i, const char* val );



// List: Properties
//-----------------
LIBSPEC bool stringListIsEmpty( const TStringList h );

LIBSPEC int stringListCount( const TStringList h );



#ifdef __cplusplus
  }
#endif


#endif /* _QCLASSESSTRINGLIST_H_ */
