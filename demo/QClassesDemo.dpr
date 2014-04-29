program QClassesDemo;

(*
QClassesDemo.dpr
----------------
Begin: 2006/07/11
Last revision: $Date: 2011-10-29 00:32:26 $ $Author: areeves $
Version: $Revision: 1.4 $
Project: QClasses for Delphi (Demo application)
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2006 - 2007 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*)

(*
  This program demonstrates the use of the QClasses for Delphi collection.
*)


uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Fruit in 'Fruit.pas',

  DebugWindow,

  QIntegerMaps,
  QStringMaps,
  QVectors,
  QLists,
  QOrderedDictionaries,
  QClassesDebugging
;

{$R *.res}

begin
  setDebugging( true );

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
