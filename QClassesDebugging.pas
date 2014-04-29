unit QClassesDebugging;

(*
QClassesDebugging.pas
---------------------
Begin: 2006/07/12
Last revision: $Date: 2011-10-25 05:05:07 $ $Author: areeves $
Version: $Revision: 1.7 $
Project: QClasses for Delphi
Website: http://www.aaronreeves.com/qclasses
Author: Shaun Case <Shaun.Case@colostate.edu>
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2006 - 2007 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*)


{*
  The QClasses for Delphi collection is a set of useful data structures and
  container classes for the Delphi programming language (see
  http://www.codegear.com/products/delphi). Rather than reimplementing these data
  structures in "pure" Delphi, QClasses provides a set of wrappers for classes
  and functions written in C++ using the excellent Qt toolkit from Trolltech
  (see http://www.trolltech.com/products/qt).  These classes and functions are
  made available via a dynamically loaded library (qclasses.dll) and can be
  used with Delphi applications.

  This unit implements functionality to ease the process of debugging from the DLL.
  It is most useful to developers who might modify the C++ source code of the DLL:
  it is not necessary for ordinary use of the Delphi classes.
}

interface

	type TCFnVoid_1_CharP = procedure( msg: pchar ); cdecl;

  var
    qClassesDebuggingLoaded: boolean;


implementation

  uses
    Windows,

    MyStrUtils,
    DebugWindow
  ;


  const
    DBSHOWMSG: boolean = false; // set to true to enable debugging messages for this unit.


  var
    setDebugFunction: procedure( fn: TCFnVoid_1_CharP ); cdecl;


  procedure debugFunction( msg: pchar ); cdecl;
  	begin
  		dbcout( 'QCLASSES: ' + msg, true );
    end
  ;


  function loadDynamicDLL(): boolean;
    var
      dllHandle: THandle; //Handle used to open the DLL.  Defined in unit Windows.
    begin
      try
        dllHandle := loadLibrary( 'qclasses.dll' );
        dbcout( 'loadLibrary qclasses.dll successful.', DBSHOWMSG );
      except
        dbcout( 'loadLibrary qclasses.dll failed.', DBSHOWMSG );
        result := false;
        exit;
      end;

      if( dllHandle >= 32 ) then // library was successfully loaded.  Assign function pointers now.
        begin
          dbcout( 'Library qclasses.dll was successfully loaded.', DBSHOWMSG );

          dbcout( 'Attempting to set function pointers...', DBSHOWMSG );

          setDebugFunction := GetProcAddress( dllHandle, 'setDebugFunction' );
          if( nil <> @setDebugFunction ) then
            begin
              setDebugFunction( @debugFunction );
              result := true;
            end
          else
            begin
              dbcout( 'MISSING FUNCTION: setDebugFunction.', DBSHOWMSG );
              result := false;
            end
          ;
        end
      else
        begin
          dbcout( 'qclasses.dll is missing.', DBSHOWMSG );
          result := false;
        end
      ;
    end
  ;


initialization

  // Activate the debugging window
  setDEBUGGING( DBSHOWMSG );

  // Dynamically load the library functions
  dbcout( 'Attempting to set debugFunction', DBSHOWMSG );
  qClassesDebuggingLoaded := loadDynamicDLL();
  dbcout( 'Done successfully: ' + usBoolToText( qClassesDebuggingLoaded ), DBSHOWMSG );

end.
