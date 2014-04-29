/*
debugging.h
------------
Begin: 2006/07/11
Last revision: $Date: 2011-10-25 05:05:08 $ $Author: areeves $
Version: $Revision: 1.4 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2006 - 2007 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under 
the terms of the GNU General Public License as published by the Free Software 
Foundation; either version 2 of the License, or (at your option) any later 
version.
*/

/*
  This file declares functions that can be used to display debugging
  information generated by the DLL in the calling executable.   The executable
  must provide a pointer to a function that takes a char* as a parameter. This
  function pointer is called by the DLL to display a string which contains 
  debugging information.  If the function pointer is not explicitly set (see 
  setDebugFunction), nothing happens.
  
  For debugging functions to work, the DLL must be compiled with the symbol
  DEBUG defined.  (When DEBUG is defined, the resulting DLL file is 
  considerably larger.)
*/


#ifndef _DEBUGGING_H_
#define _DEBUGGING_H_


// Define this symbol to enable debugging messages.  See comment above.
//#define DEBUG

#if BUILDING_DLL
# define LIBSPEC __declspec (dllexport)
#else
# define LIBSPEC __declspec (dllimport)
#endif

#ifdef __cplusplus
	extern "C" {
#endif

/* A typedef for the function pointer from the executable. 
   The function must accept a single char* parameter, 
   and has no return value. 
*/
typedef void( *TFnVoid_1_CharP )( char* );

/* The variable that stores the function pointer from the executable. */
extern TFnVoid_1_CharP debugFunction;

/* Used to set the function pointer from the executable. */
LIBSPEC void setDebugFunction( TFnVoid_1_CharP fn );

#ifdef DEBUG
/* Used internally by the DLL.  Calls debugFunction, if it is set. */
void dbcout( char* msg );
#endif

#ifdef __cplusplus
	}
#endif

#endif /* _DEBUGGING_H_ */

