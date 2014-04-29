# qclasses.pro
# ------------
# Begin: 2011/10/28
# Last revision: $Date: 2011-10-29 00:32:27 $ $Author: areeves $
# Version: $Revision: 1.2 $
# Project: QClasses for Delphi
# Website: http://www.aaronreeves.com/qclasses
# Author: Aaron Reeves <aaron@aaronreeves.com>
# ------------------------------------------------------
# Copyright (C) 2011 Aaron Reeves
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#

QT       -= gui

TARGET = qclasses
TEMPLATE = lib

DEFINES += BUILDING_DLL

SOURCES += \
    ../qclassesintvector.cpp \
    ../dllmain.cpp \
    ../stringhandling.cpp \
    ../debugging.cpp \
    ../qclassesstringstringmap.cpp \
    ../qclassesstringobjectmap.cpp \
    ../qclassesstringlongintmap.cpp \
    ../qclassesstringlist.cpp \
    ../qclassesobjectlist.cpp \
    ../qclassesintuintmap.cpp \
    ../qclassesintegerstringmap.cpp \
    ../qclassesintegerobjectmap.cpp \
    ../qclassesintegerlist.cpp \
    ../qclassesintegerintegermap.cpp \
    ../qclassesintegedoublemap.cpp \
    ../qclassesdoublevector.cpp \
    ../qclassesboolvector.cpp

HEADERS += \
    ../qclassesintvector.h \
    ../debugging.h \
    ../stringhandling.h \
    ../qclassesstringstringmap.h \
    ../qclassesstringobjectmap.h \
    ../qclassesstringlongintmap.h \
    ../qclassesstringlist.h \
    ../qclassesobjectlist.h \
    ../qclassesintuintmap.h \
    ../qclassesintegerstringmap.h \
    ../qclassesintegerobjectmap.h \
    ../qclassesintegerlist.h \
    ../qclassesintegerintegermap.h \
    ../qclassesintegerdoublemap.h \
    ../qclassesdoublevector.h \
    ../qclassesboolvector.h

win32:RC_FILE = ../qclasses_private.rc










