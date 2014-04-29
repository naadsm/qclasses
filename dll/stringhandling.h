/*
stringhandling.h
----------------
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


#ifndef _STRINGHANDLING_H_
#define _STRINGHANDLING_H_

#include <qstring.h>

char* charPtrFromQString( QString myString );
void freeStringBuffer( void );


#endif /* _STRINGHANDLING_H_ */

