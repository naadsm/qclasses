/*
dllmain.cpp
-----------
Begin: 2006/07/11
Last revision: $Date: 2011-10-25 05:05:08 $ $Author: areeves $
Version: $Revision: 1.3 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2006 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under 
the terms of the GNU General Public License as published by the Free Software 
Foundation; either version 2 of the License, or (at your option) any later 
version.
*/

/**
  The QClasses for Delphi collection is (or will be) a set of useful data
  structures and container classes for the Delphi programming language (see
  http://bdn.borland.com/delphi). Rather than reimplementing these data
  structures in "pure" Delphi, QClasses provides a set of wrappers for classes
  and functions written in C++ using the excellent Qt toolkit from Trolltech
  (see http://www.trolltech.com/products/qt).  These classes and functions are
  made available via a dynamically loaded library (qclasses.dll) and can be
  used with Delphi applications.
  
  QClasses for Delphi emphasizes simplicity, convenience, and adherence to
  typical Qt style rather than performance: for high performance applications,
  a native Delphi implementation of these data structures might be preferable.

  QClasses for Delphi is in its very early stages of development: it is likely
  that many more classes will be added, as the need arises.  In the mean time,
  existing code provides an example for other developers who might want to 
  take advantage of other data structures offered by Qt.

  Two native Delphi alternatives are Delphi Fundamentals 
  (http://fundementals.sourceforge.net/about.html) and Delphi Standard 
  Libraries (http://www.partow.net/programming/dsl/index.html).  While these
  two open source packages are both very nice, they are released under 
  terms which are not compatible with the GNU General Public License.

  This file contains the main function for qclasses.dll.  For a detailed 
  description of the methods used to create this DLL, please see the article
  "Writing Windows DLLs for use across languages and compilers", available at
  http://www.aaronreeves.com/windows-dlls-part-1.
*/


#include <windows.h>

#include "debugging.h"
#include "stringhandling.h"


/** The main function for the DLL */
BOOL APIENTRY DllMain (HINSTANCE hInst     /* Library instance handle. */ ,
                       DWORD reason        /* Reason this function is being called. */ ,
                       LPVOID reserved     /* Not used. */ )
{
    switch (reason)
    {
      case DLL_PROCESS_ATTACH:
          setDebugFunction( NULL ); /* The user must explicitly set this function pointer to use it: see debugging.h. */
        break;

      case DLL_PROCESS_DETACH:
          freeStringBuffer();
        break;

      case DLL_THREAD_ATTACH:
          setDebugFunction( NULL ); /* The user must explicitly set this function pointer to use it: see debugging.h. */
        break;

      case DLL_THREAD_DETACH:
          freeStringBuffer();
        break;
    }

    /* Returns TRUE on success, FALSE on failure */
    return TRUE;
}



