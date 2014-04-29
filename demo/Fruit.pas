unit Fruit;

(*
Fruit.pas
----------
Begin: 2006/07/11
Last revision: $Date: 2011-10-25 05:05:08 $ $Author: areeves $
Version: $Revision: 1.6 $
Project: QClasses for Delphi (Demo application)
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
------------------------------------------------------
Copyright (C) 2006 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*)

(*
  This unit implements a very simple object for demonstration purposes.
*)

interface
  uses
    Classes,

    QStringMaps,
    QIntegerMaps
  ;

  
  type TFruit = class( TObject )
    public
      name: string;
      shape: string;
      color: string;

      constructor create( fruitName, fruitShape, fruitColor: string ); overload;
      constructor create( const source: TFruit ); overload;
      destructor destroy(); override;

      procedure assign( Source: TObject ); 

      procedure debug();
    end
  ;


  type TFruitMap = class (TQStringObjectMap )
    public
      { Copys an existing map. }
      procedure assign( Source: TObject ); override;
    end
  ;

  type TIntFruitMap = class( TQIntegerObjectMap )
    public
      { Copys an existing map. }
      procedure assign( Source: TObject ); override;
    end
  ;

implementation

  uses
    DebugWindow,
    MyStrUtils
  ;

  constructor TFruit.create( fruitName, fruitShape, fruitColor: string );
    begin
      inherited create();

      name := fruitName;
      shape := fruitShape;
      color := fruitColor;
    end
  ;

  constructor TFruit.create( const source: TFruit );
    begin
      inherited create();

      self.assign( source );
    end
  ;

  destructor TFruit.destroy();
    begin
      dbcout( 'Fruit "' + name + '" is being destroyed.', true );
      inherited destroy();
    end
  ;

  procedure TFruit.assign( Source: TObject );
    var
      src: TFruit;
    begin
      src := Source as TFruit;

      self.name := src.name;
      self.shape := src.shape;
      self.color := src.color;
    end
  ;

  procedure TFruit.debug();
    begin
      dbcout( '+++ Debugging a fruit...', true );
      dbcout( 'Name: ' + self.name , true);
      dbcout( 'Shape: ' + self.shape, true );
      dbcout( 'Color: ' + self.color, true );
      dbcout( '--- Done.' + endl + endl, true );
    end
  ;



  procedure TFruitMap.assign( Source: TObject );
    var
      src: TQStringObjectMap;
      it: TQStringObjectMapIterator;
      newObj: TFruit;
    begin
      dbcout( '+++ Begin TFruitMap.assign', true );
      src := source as TQStringObjectMap;
      it := TQStringObjectMapIterator.create( src );

      repeat
        if( nil <> it.value() ) then
          begin
            newObj := TFruit.Create( it.value() as TFruit );
            self.insert( it.key(), newObj );
          end
        ;

        it.incr();
      until ( nil = it.value() );

      it.Free();

      dbcout( '--- Done TFruitMap.assign', true );
    end
  ;



  procedure TIntFruitMap.assign( Source: TObject );
    var
      src: TQIntegerObjectMap;
      it: TQIntegerObjectMapIterator;
      newObj: TFruit;
    begin
      dbcout( '+++ Begin TIntFruitMap.assign', true );
      src := source as TQIntegerObjectMap;
      it := TQIntegerObjectMapIterator.create( src );

      repeat
        if( nil <> it.value() ) then
          begin
            newObj := TFruit.Create( it.value() as TFruit );
            self.insert( it.key(), newObj );
          end
        ;

        it.incr();
      until ( nil = it.value() );

      it.Free();

      dbcout( '--- Done TIntFruitMap.assign', true );
    end
  ;

end.
