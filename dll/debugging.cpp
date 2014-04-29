/*
debugging.cpp
-------------
Begin: 2006/07/11
Last revision: $Date: 2011-10-25 05:05:08 $ $Author: areeves $
Version: $Revision: 1.2 $
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


#include "debugging.h"

#include <stdio.h>

TFnVoid_1_CharP debugFunction;

LIBSPEC void setDebugFunction( TFnVoid_1_CharP fn ) {
  debugFunction = fn;
}

#ifdef DEBUG
void dbcout( char* msg ) {
  if( NULL != debugFunction ) debugFunction( msg );
}
#endif

