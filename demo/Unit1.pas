unit Unit1;

(*
Unit1.pas
---------
Begin: 2006/07/11
Last revision: $Date: 2011-10-29 00:32:26 $ $Author: areeves $
Version: $Revision: 1.15 $
Project: QClasses for Delphi (Demo application)
Website: http://www.aaronreeves.com/qclasses
Author: Aaron Reeves <aaron@aaronreeves.com>
Author: Shaun Case <Shaun.Case@colostate.edu>
------------------------------------------------------
Copyright (C) 2006 - 2011 Aaron Reeves

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
*)

interface

  uses
    Windows,
    Messages,
    SysUtils,
    Variants,
    Classes,
    Graphics,
    Controls,
    Types,
    Forms,
    Dialogs,
    StdCtrls,

    QStringMaps,
    QIntegerMaps,
    QVectors,
    QLists,
    QOrderedDictionaries
  ;

  type TForm1 = class(TForm)
      btnCheckDLL: TButton;

      gbxQStringObjectMap: TGroupBox;
      btnLoadMap: TButton;
      btnTestMap: TButton;
      btnShowMapValues: TButton;
      btnDeleteValues: TButton;
      btnShowFirstValue: TButton;
      btnIterate: TButton;
      btnCopy: TButton;
      btnMapKeyByIndex: TButton;

      gbxQIntegerXMap: TGroupBox;
      btnLoadIntegerMap: TButton;
      btnTestIntegerMap: TButton;
      btnShowIntegerMapValues: TButton;
      btnDeleteIntegerMapValues: TButton;
      btnShowFirstIntegerMapValue: TButton;
      btnIterateIntegerMap: TButton;
      btnCopyIntegerMap: TButton;
      btnIntegerMapKeyByIndex: TButton;
      gbxQXVector: TGroupBox;
      btnLoadVector: TButton;
      btnShowVectorValues: TButton;
      btnVectorCapacity: TButton;
      btnVectorSize: TButton;
      btnResizeVector: TButton;
      btnClearVector: TButton;
      btnCopyVector: TButton;
      btnSortVector: TButton;

      gbxOrderedDictionary: TGroupBox;
      btnLoadOrderedDict: TButton;
      btnShowOrderedDict: TButton;
      btnShowOrderedDictBackwards: TButton;
      btnOrderedDictSize: TButton;
      btnOrderedDictDeleteVals: TButton;
      btnOrderedDictionaryKeys: TButton;
      btnOrderedDictionaryKeysBackwards: TButton;

      gbxQLists: TGroupBox;
      btnLoadLists: TButton;
      btnShowListValues: TButton;
      btnListSizes: TButton;
      btnClearLists: TButton;

      procedure btnCheckDLLClick(Sender: TObject);

      procedure btnLoadMapClick(Sender: TObject);
      procedure btnTestMapClick(Sender: TObject);
      procedure btnShowMapValuesClick(Sender: TObject);
      procedure btnDeleteValuesClick(Sender: TObject);
      procedure btnShowFirstValueClick(Sender: TObject);
      procedure btnIterateClick(Sender: TObject);
      procedure btnCopyClick(Sender: TObject);
      procedure btnMapKeyByIndexClick(Sender: TObject);

      procedure btnLoadVectorClick(Sender: TObject);
      procedure btnShowVectorValuesClick(Sender: TObject);
      procedure btnVectorSizeClick(Sender: TObject);
      procedure btnVectorCapacityClick(Sender: TObject);
      procedure btnResizeVectorClick(Sender: TObject);
      procedure btnClearVectorClick(Sender: TObject);
      procedure btnCopyVectorClick(Sender: TObject);

      procedure btnLoadOrderedDictClick(Sender: TObject);
      procedure btnShowOrderedDictClick(Sender: TObject);
      procedure btnShowOrderedDictBackwardsClick(Sender: TObject);
      procedure btnOrderedDictSizeClick(Sender: TObject);
      procedure btnOrderedDictDeleteValsClick(Sender: TObject);
      procedure btnOrderedDictionaryKeysClick(Sender: TObject);

      procedure btnOrderedDictionaryKeysBackwardsClick(Sender: TObject);
      procedure btnLoadListsClick(Sender: TObject);
      procedure btnShowListValuesClick(Sender: TObject);
      procedure btnListSizesClick(Sender: TObject);
      procedure btnClearListsClick(Sender: TObject);

      procedure btnLoadIntegerMapClick(Sender: TObject);
      procedure btnTestIntegerMapClick(Sender: TObject);
      procedure btnShowIntegerMapValuesClick(Sender: TObject);
      procedure btnShowFirstIntegerMapValueClick(Sender: TObject);
      procedure btnIterateIntegerMapClick(Sender: TObject);
      procedure btnDeleteIntegerMapValuesClick(Sender: TObject);
      procedure btnCopyIntegerMapClick(Sender: TObject);
      procedure btnIntegerMapKeyByIndexClick(Sender: TObject);
    procedure btnSortVectorClick(Sender: TObject);

    protected
      fruitMap: TQStringObjectMap;
      numberMap: TQStringLongIntMap;
      stringMap: TQStringStringMap;

      intFruitMap: TQIntegerObjectMap;
      intStringMap: TQIntegerStringMap;
      intDoubleMap: TQIntegerDoubleMap;

      stringList: TQStringList;
      intList: TQIntegerList;

      intVector: TQIntegerVector;
      doubleVector: TQDoubleVector;

      fruitDictionary: TQOrderedStringObjectDictionary;
      stringDictionary: TQOrderedStringStringDictionary;

      procedure getFruit( fruitName: string ); overload;
      procedure getFruit( fruitNumber: integer ); overload;

    public
      constructor create( AOwner: TComponent ); override;
      destructor destroy(); override;

    end
  ;

  var
    Form1: TForm1;


implementation

{$R *.dfm}

  uses
    Math,

    MyDialogs,
    DebugWindow,
    MyStrUtils,

    Fruit
  ;

  constructor TForm1.create( AOwner: TComponent );
    begin
      inherited create( AOwner );

      fruitMap := TQStringObjectMap.create();
      numberMap := TQStringLongIntMap.create();
      stringMap := TQStringStringMap.create();


      intFruitMap := TQIntegerObjectMap.create();
      intStringMap := TQIntegerStringMap.create();
      intDoubleMap := TQIntegerDoubleMap.create();

      stringList := TQStringList.create();
      intList := TQIntegerList.create();

      intVector := TQIntegerVector.create();
      doubleVector := TQDoubleVector.create();

      fruitDictionary := TQOrderedStringObjectDictionary.create();
      stringDictionary := TQOrderedStringStringDictionary.create();

      randomize();
    end
  ;

  destructor TForm1.destroy();
    begin
      freeAndNil( fruitMap );
      freeAndNil( numberMap );
      freeAndNil( stringMap );

      freeAndNil( intFruitMap );
      freeAndNil( intStringMap );
      freeAndNil( intDoubleMap );

      freeAndNil( stringList );
      freeAndNil( intList );

      freeAndNil( intVector );
      freeAndNil( doubleVector );

      freeAndNil( fruitDictionary );
      freeAndNil( stringDictionary );

      inherited destroy();
    end
  ;


//-----------------------------------------------------------------------------
// See if the DLL loaded
//-----------------------------------------------------------------------------
  procedure TForm1.btnCheckDLLClick(Sender: TObject);
    var
      msg: string;
    begin
      qStringMapsDllLoaded( @msg );

      dbcout( 'QStringMaps loaded: ' + usBoolToText( qStringMapsDllLoaded( @msg ) ), true );
      dbcout( 'QIntegerMaps loaded: ' + usBoolToText( qIntegerMapsDllLoaded( @msg ) ), true );
      dbcout( 'QVectors loaded: ' + usBoolToText( qVectorsDllLoaded( @msg ) ), true );
      dbcout( 'QLists loaded: ' + usBoolToText( qListsDllLoaded( @msg ) ), true );

      dbcout( msg, true );
    end
  ;
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// Testing the string object map
//-----------------------------------------------------------------------------
  procedure TForm1.btnLoadMapClick(Sender: TObject);
    var
      fruit: TFruit;
    begin
      fruit := TFruit.create( 'apple', 'roundish', 'red' );
      dbcout( 'Address of "apple": ' + intToStr( cardinal( fruit ) ) , true);
      fruitMap.insert( fruit.name, fruit );

      stringMap[ fruit.name ] := fruit.name + ' this is a string';
      numberMap[ fruit.name ] := 3;


      fruit := TFruit.create( 'orange', 'round', 'orange' );
      dbcout( 'Address of "orange": ' + intToStr( cardinal( fruit ) ), true );
      fruitMap.insert( fruit.name, fruit );

      stringMap[ fruit.name ] := fruit.name + ' this is another string';
      numberMap.insert( fruit.name, 2 );

      fruit := TFruit.create( 'banana', 'funny', 'yellow' );
      dbcout( 'Address of "banana": ' + intToStr( cardinal( fruit ) ), true );
      fruitMap.insert( fruit.name, fruit );

      stringMap[ fruit.name ] := fruit.name + ' this is finally a string';
      numberMap.insert( fruit.name, -1 );
    end
  ;


  procedure TForm1.btnTestMapClick(Sender: TObject);
    begin
      dbcout( 'Map is empty:', true );
      dbcout( fruitMap.isEmpty, true );
      dbcout( 'Map count:', true );
      dbcout( fruitMap.count , true);

      dbcout( 'Long Int Map is empty:', true );
      dbcout( numberMap.isEmpty, true );
      dbcout( 'LongInt Map count:', true );
      dbcout( numberMap.count , true);

      dbcout( 'String Map is empty:', true );
      dbcout( stringMap.isEmpty, true );
      dbcout( 'String Map count:', true );
      dbcout( stringMap.count , true);

      fruitMap.test();

      numberMap.test();

      stringMap.test();
    end
  ;


  procedure TForm1.getFruit( fruitName: string );
    var
      fruit: TFruit;
    begin
      dbcout('=================================================', true);
      dbcout('-------------------------------------------------', true);
      dbcout('           ' + fruitName, true );
      dbcout('-------------------------------------------------', true);
      dbcout( 'Fruit "' + fruitName + '" found: ' + usBoolToText( fruitMap.contains( fruitName ) ), true );

      fruit := fruitMap.value( fruitName ) as TFruit;
      dbcout( 'Address of "' + fruitName + '": ' + intToStr( cardinal( fruit ) ), true );

      if( nil = fruit ) then
        dbcout( 'fruit "' + fruitName + '" is nil!', true )
      else
        begin
          fruit.debug();
          if ( numberMap.contains( fruit.name ) ) then
            dbcout( fruit.name + ' number in long int map is: ' + IntToStr(numberMap[ fruit.name ]) , true );
          if ( stringMap.contains( fruit.name ) ) then
              dbcout( fruit.name + ' string map is: ' + stringMap[ fruit.name ], true );
        end;
      ;
      dbcout('=================================================', true);
      dbcout( endl, true );
      dbcout( endl, true );
    end
  ;


  procedure TForm1.btnShowMapValuesClick(Sender: TObject);
    begin
      getFruit( 'orange' );
      getFruit( 'banana' );
      getFruit( 'apple' );
      getFruit( 'pear' );
    end
  ;


  procedure TForm1.btnDeleteValuesClick(Sender: TObject);
    begin
      fruitMap.deleteValues();
      numberMap.deleteValues();
      stringMap.deleteValues();
    end
  ;


  procedure TForm1.btnShowFirstValueClick(Sender: TObject);
    var
      fruit: TFruit;
    begin
      fruit := fruitMap.first() as TFruit;

      if( nil <> fruit ) then
        fruit.debug()
      else
        dbcout( 'There is no first fruit!', true )
      ;

      dbcout( 'First Number in Number Map is: ' + IntToStr(numberMap.first()), true );
      dbcout( 'First String in String Map is: ' + stringMap.first(), true );
    end
  ;


  procedure TForm1.btnIterateClick(Sender: TObject);
    var
      it: TQStringObjectMapIterator;
      itI: TQStringLongIntMapIterator;
      itS: TQStringStringMapIterator;
      fruit: TFruit;
      I: Integer;
    begin
      it := TQStringObjectMapIterator.create( fruitMap );
      
      dbcout( endl, true );
      repeat
        dbcout( nil = it.value() , true);

        if( nil <> it.value() ) then
          begin
            dbcout( 'Getting key...', true );
            dbcout( 'Key: ' + it.key() , true);
            dbcout( 'Done getting key.', true );

            dbcout( 'Value: ' + intToStr( cardinal( it.value() ) ), true );
            fruit := it.value() as TFruit;
            fruit.debug();
          end
        ;

        it.incr();
      until ( nil = it.value() );

      dbcout( endl, true );

      it.Free();

      itI := TQStringLongIntMapIterator.create( numberMap );

      if ( not itI.isEmpty() ) then
        begin
          repeat
            dbcout( 'Getting key...', true );
            dbcout( 'Key: ' + itI.key() , true);
            dbcout( 'Done getting key.', true );
            dbcout( 'Value: ' + intToStr( itI.value() ), true );

            itI.incr();
          until ( itI.Done() );

          dbcout( endl, true );
      end;

      itI.Free();


      itS := TQStringStringMapIterator.create( stringMap );
      I := 0;
      if ( not itS.isEmpty() ) then
        begin
          repeat
            dbcout( 'Getting key...', true );
            dbcout( 'Key: ' + itS.key() , true);
            dbcout( 'Done getting key.', true );

            dbcout( 'Value: ' +  stringMap.GetItemByIndex( I ), true );

            I := I + 1;
            itS.incr();
          until ( itS.Done() );

          dbcout( endl, true );
        end;

      itS.Free();
    end
  ;


  procedure TForm1.btnCopyClick(Sender: TObject);
    var
      newMap: TFruitMap;
      newNumberMap: TQStringLongIntMap;
    begin
      newMap := TFruitMap.create( fruitMap );
      dbcout( endl, true );
      dbcout( 'New map properties: ', true );

      dbcout( 'Map is empty:', true );
      dbcout( newMap.isEmpty, true );
      dbcout( 'Map count:', true );
      dbcout( newMap.count , true);

      dbcout( 'Testing new map...', true );
      newMap.test();
      dbcout( 'Done with test.', true );

      newMap.deleteValues();
      newMap.Free();
      dbcout( endl, true );

      //
      newNumberMap := TQStringLongIntMap.create( numberMap );
      dbcout( endl, true );
      dbcout( 'New Number map properties: ', true );

      dbcout( 'Number Map is empty:', true );
      dbcout( newNumberMap.isEmpty, true );
      dbcout( 'Number Map count:', true );
      dbcout( newNumberMap.count , true);

      dbcout( 'Testing new Number Map...', true );
      newNumberMap.test();
      dbcout( 'Done with test.', true );

      newNumberMap.deleteValues();
      newNumberMap.Free();
      dbcout( endl, true );
    end
  ;


  procedure TForm1.btnMapKeyByIndexClick(Sender: TObject);
    var
      i: integer;
    begin
      dbcout( endl, true );

      for i := 0 to fruitMap.count - 1 do
        dbcout( fruitMap.keyAtIndex( i ), true )
      ;

      dbcout( endl, true );

      for i := 0 to numberMap.count - 1 do
        dbcout( numberMap.keyAtIndex( i ), true )
      ;

      dbcout( endl, true );

      for i := 0 to stringMap.count - 1 do
        dbcout( stringMap.keyAtIndex( i ), true )
      ;

      dbcout( endl, true );
    end
  ;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// Testing the vectors
//-----------------------------------------------------------------------------
  procedure TForm1.btnLoadVectorClick(Sender: TObject);
    var
      i: integer;
      val: integer;
      val2: double;
    begin
      dbcout( 'Int vector size: ' + intToStr( intVector.size ), true );
      dbcout( 'Int vector capacity: ' + intToStr( intVector.capacity ), true );

      dbcout( 'Double vector size: ' + intToStr( doubleVector.size ), true );
      dbcout( 'Double vector capacity: ' + intToStr( doubleVector.capacity ), true );

      dbcout( 'Loading vectors...', true );

      for i := 0 to 49 do
        begin
          val := randomRange( 0 , 1000 );
          dbcout( 'Int vector position ' + intToStr( i ) + ': ' + intToStr( val ), true );
          intVector.append( val );
          val2 := val + i / 15.0;
          dbcout( 'Double vector position ' + intToStr( i ) + ': ' + usFloatToStr( val2 ), true );
          doubleVector.append( val2 );
        end
      ;

      dbcout( 'Int vector size: ' + intToStr( intVector.size ), true );
      dbcout( 'Int vector capacity: ' + intToStr( intVector.capacity ), true );

      dbcout( 'Double vector size: ' + intToStr( doubleVector.size ), true );
      dbcout( 'Double vector capacity: ' + intToStr( doubleVector.capacity ), true );

      dbcout( 'Done.' + endl + endl, true );
    end
  ;


  procedure TForm1.btnShowVectorValuesClick(Sender: TObject);
    var
      i: integer;
    begin
      dbcout( 'Int vector size: ' + intToStr( intVector.size ), true );
      dbcout( 'Contents of intVector:', true );

      for i := 0 to intVector.count - 1 do
        dbcout( intVector[i], true )
      ;
      dbcout( endl, true );

      dbcout( 'Double vector size: ' + intToStr( intVector.size ), true );
      dbcout( 'Contents of doubleVector:', true );

      for i := 0 to doubleVector.count - 1 do
        dbcout( doubleVector[i], true )
      ;

      dbcout( 'Done.' + endl + endl, true );
    end
  ;


  procedure TForm1.btnVectorSizeClick(Sender: TObject);
    begin
      dbcout( 'Size of intVector: ' + intToStr( intVector.size ), true );
      dbcout( 'Size of doubleVector: ' + intToStr( doubleVector.size ), true );
    end
  ;


  procedure TForm1.btnVectorCapacityClick(Sender: TObject);
    begin
      dbcout( 'Capacity of intVector: ' + intToStr( intVector.capacity ), true );
      dbcout( 'Capacity of doubleVector: ' + intToStr( doubleVector.capacity ), true );
    end
  ;


  procedure TForm1.btnResizeVectorClick(Sender: TObject);
    begin
      intVector.resize( 75 );
      doubleVector.resize( 75 );
    end
  ;


  procedure TForm1.btnClearVectorClick(Sender: TObject);
    begin
      intVector.clear();
      doubleVector.clear();
    end
  ;


  procedure TForm1.btnCopyVectorClick(Sender: TObject);
    var
      i: integer;
      v: TQIntegerVector;
      dv: TQDoubleVector;
    begin
      v := TQIntegerVector.create( intVector );
      dv := TQDoubleVector.create( doubleVector );

      dbcout( 'Contents of v: ', true );
      for i := 0 to v.count - 1 do
        dbcout( v[i], true )
      ;

      dbcout( endl + 'Contents of dv: ', true );
      for i := 0 to dv.count - 1 do
        dbcout( dv[i], true )
      ;

      dbcout( 'Done.' + endl + endl, true );
    end
  ;


  procedure TForm1.btnSortVectorClick(Sender: TObject);
    begin
      dbcout( 'Sorting int vector...', true );
      intVector.sort();
      dbcout( 'Done.', true );
      dbcout( 'Sorting double vector...', true );
      doubleVector.sort();
      dbcout( 'Done!', true );
    end
  ;
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// Testing the ordered string object dictionary
//-----------------------------------------------------------------------------
  procedure TForm1.btnLoadOrderedDictClick(Sender: TObject);
    var
      fruit: TFruit;
    begin
      fruit := TFruit.create( 'apple', 'roundish', 'red' );
      dbcout( 'Address of "apple": ' + intToStr( cardinal( fruit ) ) , true);
      fruitDictionary.insert( fruit.name, fruit );

      fruit := TFruit.create( 'banana', 'funny', 'yellow' );
      dbcout( 'Address of "banana": ' + intToStr( cardinal( fruit ) ), true );
      fruitDictionary.insert( fruit.name, fruit );

      fruit := TFruit.create( 'orange', 'round', 'orange' );
      dbcout( 'Address of "orange": ' + intToStr( cardinal( fruit ) ), true );
      fruitDictionary.insert( fruit.name, fruit );

      stringDictionary.insert( 'apple', 'a roundish red fruit' );
      stringDictionary.insert( 'banana', 'a funny yellow fruit' );
      stringDictionary.insert( 'kumquat', 'a small, orange, oblong fruit' );
      stringDictionary.insert( 'orange', 'a round orange fruit' );
    end
  ;


  procedure TForm1.btnShowOrderedDictClick(Sender: TObject);
    var
      i: integer;
      f: TFruit;
      str, key: string;
    begin
      dbcout( endl + '------- Dictionary items in order', true );

      for i := 0 to fruitDictionary.count - 1 do
        begin
          f := fruitDictionary.itemByIndex( i ) as TFruit;
          f.debug();
        end
      ;

      dbcout( endl, true );

      for i := 0 to stringDictionary.count - 1 do
        begin
          str := stringDictionary.itemByIndex( i );
          key := stringDictionary.keyByIndex( i );

          dbcout( key + ': ' + str, true );
        end
      ;

      dbcout( '------- Done.' + endl, true );
    end
  ;


  procedure TForm1.btnShowOrderedDictBackwardsClick(Sender: TObject);
    var
      i: integer;
      f: TFruit;
      str, key: string;
    begin
      dbcout( endl + '------- Dictionary items in reverse order', true );

      for i := fruitDictionary.count - 1 downto 0 do
        begin
          f := fruitDictionary.itemByIndex( i ) as TFruit;
          f.debug();
        end
      ;
      dbcout( endl, true );

      for i := stringDictionary.count - 1 downto 0 do
        begin
          str := stringDictionary.itemByIndex( i );
          key := stringDictionary.keyByIndex( i );

          dbcout( key + ': ' + str, true );
        end
      ;


      dbcout( '------- Done.' + endl, true );
    end
  ;


  procedure TForm1.btnOrderedDictionaryKeysClick(Sender: TObject);
    var
      i: integer;
    begin
      dbcout( endl, true );

      for i := 0 to fruitDictionary.count - 1 do
        dbcout( fruitDictionary.keyByIndex( i ), true )
      ;

      dbcout( endl, true );

      for i := 0 to stringDictionary.count - 1 do
        dbcout( stringDictionary.keyByIndex( i ), true )
      ;

      dbcout( endl, true );
    end
  ;


  procedure TForm1.btnOrderedDictionaryKeysBackwardsClick(Sender: TObject);
    var
      i: integer;
    begin
      dbcout( endl, true );

      for i := fruitDictionary.count - 1 downto 0 do
        dbcout( fruitDictionary.keyByIndex( i ), true )
      ;

      dbcout( endl, true );

      for i := stringDictionary.count - 1 downto 0 do
        dbcout( stringDictionary.keyByIndex( i ), true )
      ;

      dbcout( endl, true );
    end
  ;


  procedure TForm1.btnOrderedDictSizeClick(Sender: TObject);
    begin
      dbcout( 'fruitDictionary size: ' + intToStr( fruitDictionary.size ), true );
      dbcout( 'stringDictionary size: ' + intToStr( stringDictionary.size ), true );
    end
  ;


  procedure TForm1.btnOrderedDictDeleteValsClick(Sender: TObject);
    begin
      fruitDictionary.freeValues();
      stringDictionary.clear();
    end
  ;
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// Testing the lists
//-----------------------------------------------------------------------------
  procedure TForm1.btnLoadListsClick(Sender: TObject);
    var
      i: integer;
    begin
      stringList.append( 'A banana is a funny looking fruit.' );
      stringList.append( 'An apple is a roundish fruit.' );
      stringList.append( 'An orange is a round fruit.' );

      for i := 1 to 10 do
        intList.append( i )
      ;
    end
  ;


  procedure TForm1.btnShowListValuesClick(Sender: TObject);
    var
      i: integer;
    begin
      dbcout( endl, true );

      for i := 0 to stringList.count - 1 do
        dbcout( stringList.at(i), true )
      ;

      dbcout( endl, true );

      for i := 0 to intList.count - 1 do
        dbcout( intToStr( intList.at(i) ), true )
      ;

      dbcout( endl, true );
    end
  ;


  procedure TForm1.btnListSizesClick(Sender: TObject);
    begin
      dbcout( 'stringList size: ' + intToStr( stringList.count ), true );
      dbcout( 'intList size: ' + intToStr( intList.count ), true );
    end
  ;


  procedure TForm1.btnClearListsClick(Sender: TObject);
    begin
      stringList.clear();
      intList.clear();
    end
  ;
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// Testing the integer x maps
//-----------------------------------------------------------------------------
  procedure TForm1.btnLoadIntegerMapClick(Sender: TObject);
    var
      fruit: TFruit;
    begin
      fruit := TFruit.create( 'apple', 'roundish', 'red' );
      dbcout( 'Address of "apple": ' + intToStr( cardinal( fruit ) ) , true);
      intFruitMap.insert( 1, fruit );

      fruit := TFruit.create( 'orange', 'round', 'orange' );
      dbcout( 'Address of "orange": ' + intToStr( cardinal( fruit ) ), true );
      intFruitMap.insert( 2, fruit );

      fruit := TFruit.create( 'banana', 'funny', 'yellow' );
      dbcout( 'Address of "banana": ' + intToStr( cardinal( fruit ) ), true );
      intFruitMap.insert( 17, fruit );

      intStringMap[ 1 ] := 'This is an apple string';
      intStringMap[ 2 ] := 'This is an orange string';
      intStringMap[ 17 ] := 'Finally, this is a banana string';

      intDoubleMap[ 10 ] := 10.25;
      intDoubleMap[ 1027 ] := 1027.25;
      intDoubleMap[ 8790 ] := 8790.25;
    end
  ;


  procedure TForm1.btnTestIntegerMapClick(Sender: TObject);
    begin
      (*
      dbcout( 'Int object map is empty:', true );
      dbcout( intFruitMap.isEmpty, true );
      dbcout( 'Int object map count:', true );
      dbcout( intFruitMap.count , true);

      dbcout( endl + 'Running the internal test for intFruitMap:', true );
      intFruitMap.test();
      *)

      dbcout( 'intString Map is empty:', true );
      dbcout( intStringMap.isEmpty, true );
      dbcout( 'intString Map count:', true );
      dbcout( intStringMap.count , true);

      dbcout( endl + 'Running the internal test for intStringMap:', true );
      intStringMap.test();

      dbcout( 'intDouble Map is empty:', true );
      dbcout( intDoubleMap.isEmpty, true );
      dbcout( 'intDouble Map count:', true );
      dbcout( intDoubleMap.count , true);

      dbcout( endl + 'Running the internal test for intDoubleMap:', true );
      intDoubleMap.test();
    end
  ;


  procedure TForm1.getFruit( fruitNumber: integer );
    var
      fruit: TFruit;
    begin
      dbcout('=================================================', true);
      dbcout('-------------------------------------------------', true);
      dbcout('           ' + intToStr( fruitNumber ), true );
      dbcout('-------------------------------------------------', true);
      dbcout( 'Fruit #' + intToStr( fruitNumber ) + ' found: ' + usBoolToText( intFruitMap.contains( fruitNumber ) ), true );

      fruit := intFruitMap.value( fruitNumber ) as TFruit;
      dbcout( 'Address of fruit #' + intToStr( fruitNumber ) + ': ' + intToStr( cardinal( fruit ) ), true );

      if( nil = fruit ) then
        dbcout( 'fruit #' + intToStr( fruitNumber ) + ' is nil!', true )
      else
        fruit.debug()
      ;
      dbcout('=================================================', true);
      dbcout( endl, true );
      dbcout( endl, true );
    end
  ;


  procedure TForm1.btnShowIntegerMapValuesClick(Sender: TObject);
    begin
      getFruit( 2 );
      getFruit( 17 );
      getFruit( 1 );
      getFruit( 34 );
    end
  ;


  procedure TForm1.btnDeleteIntegerMapValuesClick(Sender: TObject);
    begin
      intFruitMap.deleteValues();
      intStringMap.clear();
      intDoubleMap.clear();
    end
  ;


  procedure TForm1.btnShowFirstIntegerMapValueClick(Sender: TObject);
    var
      fruit: TFruit;
    begin
      fruit := intFruitMap.first() as TFruit;

      if( nil <> fruit ) then
        fruit.debug()
      else
        dbcout( 'There is no first fruit!', true )
      ;

      dbcout( 'First String in Int string Map is: ' + intStringMap.first(), true );
      dbcout( 'First double in intDoubleMap is: ' + usFloatToStr( intDoubleMap.first() ), true );
    end
  ;


  procedure TForm1.btnIterateIntegerMapClick(Sender: TObject);
    var
      it: TQIntegerObjectMapIterator;
      itS: TQIntegerStringMapIterator;
      itD: TQIntegerDoubleMapIterator;
      fruit: TFruit;
    begin
      it := TQIntegerObjectMapIterator.create( intFruitMap );
      
      dbcout( endl, true );
      repeat
        dbcout( nil = it.value() , true);

        if( nil <> it.value() ) then
          begin
            dbcout( 'Getting key...', true );
            dbcout( 'Key: ' + intToStr( it.key() ), true);
            dbcout( 'Done getting key.', true );

            dbcout( 'Value: ' + intToStr( cardinal( it.value() ) ), true );
            fruit := it.value() as TFruit;
            fruit.debug();
          end
        ;

        it.incr();
      until ( nil = it.value() );

      dbcout( endl, true );

      it.Free();


      itS := TQIntegerStringMapIterator.create( intStringMap );

      if ( not itS.isEmpty() ) then
        begin
          repeat
            dbcout( 'Getting key...', true );
            dbcout( 'Key: ' + intToStr( itS.key() ), true);
            dbcout( 'Done getting key.', true );

            dbcout( 'Value: ' +  itS.value(), true );

            itS.incr();
          until ( itS.Done() );

          dbcout( endl, true );
        end
      ;

      itS.Free();


      itD := TQIntegerDoubleMapIterator.create( intDoubleMap );

      if( not( itD.isEmpty() ) ) then
        begin
          repeat
            dbcout( 'Getting key...', true );
            dbcout( 'Key: ' + intToStr( itD.key() ), true);
            dbcout( 'Done getting key.', true );

            dbcout( 'Value: ' +  usFloatToStr( itD.value() ), true );

            itD.incr();
          until itD.Done();

          dbcout( endl, true );
        end
      ;

      itD.Free();
    end
  ;


  procedure TForm1.btnCopyIntegerMapClick(Sender: TObject);
    var
      newMap: TIntFruitMap;
      newNumberMap: TQIntegerStringMap;
      newDoubleMap: TQIntegerDoubleMap;
    begin
      newMap := TIntFruitMap.create( intFruitMap );
      dbcout( endl, true );
      dbcout( 'New map properties: ', true );

      dbcout( 'Map is empty:', true );
      dbcout( newMap.isEmpty, true );
      dbcout( 'Map count:', true );
      dbcout( newMap.count , true);

      dbcout( 'Testing new map...', true );
      newMap.test();
      dbcout( 'Done with test.', true );

      newMap.deleteValues();
      newMap.Free();
      dbcout( endl, true );

      //
      newNumberMap := TQIntegerStringMap.create( intStringMap );
      dbcout( endl, true );
      dbcout( 'New Number map properties: ', true );

      dbcout( 'Number Map is empty:', true );
      dbcout( newNumberMap.isEmpty, true );
      dbcout( 'Number Map count:', true );
      dbcout( newNumberMap.count , true);

      dbcout( 'Testing new Number Map...', true );
      newNumberMap.test();
      dbcout( 'Done with test.', true );

      newNumberMap.clear();
      newNumberMap.Free();
      dbcout( endl, true );

      //
      newDoubleMap := TQIntegerDoubleMap.create( intDoubleMap );
      dbcout( endl, true );
      dbcout( 'newDoubleMap properties: ', true );

      dbcout( 'newDoubleMap is empty:', true );
      dbcout( newDoubleMap.isEmpty, true );
      dbcout( 'newDoubleMap count:', true );
      dbcout( newDoubleMap.count , true);

      dbcout( 'Testing newDoubleMap...', true );
      newDoubleMap.test();
      dbcout( 'Done with test.', true );

      newDoubleMap.clear();
      newDoubleMap.Free();
      dbcout( endl, true );
    end
  ;


  procedure TForm1.btnIntegerMapKeyByIndexClick(Sender: TObject);
    var
      i: integer;
    begin
      dbcout( endl, true );

      for i := 0 to intFruitMap.count - 1 do
        dbcout( intToStr( intFruitMap.keyAtIndex( i ) ), true )
      ;

      dbcout( endl, true );

      for i := 0 to intStringMap.count - 1 do
        dbcout( intToStr( intStringMap.keyAtIndex( i ) ), true )
      ;

      dbcout( endl, true );

      for i := 0 to intDoubleMap.count - 1 do
        dbcout( intToStr( intDoubleMap.keyAtIndex( i ) ), true )
      ;

      dbcout( endl, true );
    end
  ;
//-----------------------------------------------------------------------------



end.
