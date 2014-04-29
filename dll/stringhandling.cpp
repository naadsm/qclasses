/*
stringhandling.cpp
------------------
Begin: 2007/01/18
Last revision: $Date: 2011-10-25 05:05:10 $ $Author: areeves $
Version: $Revision: 1.3 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
Author: Shaun Case <Shaun.Case@colostate.edu>
------------------------------------------------------
Copyright (C) 2007 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*/


#include "stringhandling.h"


char* buffer = NULL;
unsigned long bufferSize = 0;



char* charPtrFromQString( QString myString ) {
   unsigned long Size = strlen( (char *)(myString.toAscii().data()) ) + 1;
  
  if ( bufferSize <  Size )
  {
     if ( buffer != NULL )
     {
        delete buffer;
        buffer = NULL;
     }

     buffer = new char[ Size ];
     bufferSize = Size;
  };
  
  memset( buffer, 0, bufferSize );
  
  strcpy( buffer, (char*)(myString.toAscii().data()) );     
  
  return buffer;
}


void freeStringBuffer( void ) {
  delete buffer;
  buffer = NULL;
  bufferSize = 0;   
}
