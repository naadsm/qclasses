object Form1: TForm1
  Left = 79
  Top = 11
  Width = 665
  Height = 357
  Caption = 'QClasses for Delphi'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object gbxQStringObjectMap: TGroupBox
    Left = 8
    Top = 40
    Width = 121
    Height = 281
    Caption = 'QStringXMaps  '
    TabOrder = 0
    object btnLoadMap: TButton
      Left = 8
      Top = 16
      Width = 105
      Height = 25
      Caption = 'Load map'
      TabOrder = 0
      OnClick = btnLoadMapClick
    end
    object btnTestMap: TButton
      Left = 8
      Top = 48
      Width = 105
      Height = 25
      Caption = 'Test map'
      TabOrder = 1
      OnClick = btnTestMapClick
    end
    object btnShowMapValues: TButton
      Left = 8
      Top = 80
      Width = 105
      Height = 25
      Caption = 'Show map values'
      TabOrder = 2
      OnClick = btnShowMapValuesClick
    end
    object btnDeleteValues: TButton
      Left = 8
      Top = 184
      Width = 105
      Height = 25
      Caption = 'Delete values'
      TabOrder = 3
      OnClick = btnDeleteValuesClick
    end
    object btnShowFirstValue: TButton
      Left = 8
      Top = 112
      Width = 105
      Height = 25
      Caption = 'Show first value'
      TabOrder = 4
      OnClick = btnShowFirstValueClick
    end
    object btnIterate: TButton
      Left = 8
      Top = 144
      Width = 105
      Height = 33
      Caption = 'Iterate over map values'
      TabOrder = 5
      WordWrap = True
      OnClick = btnIterateClick
    end
    object btnCopy: TButton
      Left = 8
      Top = 216
      Width = 105
      Height = 25
      Caption = 'Create a copy'
      TabOrder = 6
      OnClick = btnCopyClick
    end
    object btnMapKeyByIndex: TButton
      Left = 8
      Top = 248
      Width = 105
      Height = 25
      Caption = 'Show keys by index'
      TabOrder = 7
      OnClick = btnMapKeyByIndexClick
    end
  end
  object gbxQXVector: TGroupBox
    Left = 264
    Top = 40
    Width = 121
    Height = 281
    Caption = 'QXVectors  '
    TabOrder = 1
    object btnLoadVector: TButton
      Left = 8
      Top = 16
      Width = 105
      Height = 25
      Caption = 'Load vector'
      TabOrder = 0
      OnClick = btnLoadVectorClick
    end
    object btnShowVectorValues: TButton
      Left = 8
      Top = 48
      Width = 105
      Height = 25
      Caption = 'Show vector values'
      TabOrder = 1
      OnClick = btnShowVectorValuesClick
    end
    object btnVectorCapacity: TButton
      Left = 8
      Top = 112
      Width = 105
      Height = 25
      Caption = 'Vector capacity'
      TabOrder = 2
      OnClick = btnVectorCapacityClick
    end
    object btnVectorSize: TButton
      Left = 8
      Top = 80
      Width = 105
      Height = 25
      Caption = 'Vector size'
      TabOrder = 3
      OnClick = btnVectorSizeClick
    end
    object btnResizeVector: TButton
      Left = 8
      Top = 144
      Width = 105
      Height = 25
      Caption = 'Resize vector'
      TabOrder = 4
      OnClick = btnResizeVectorClick
    end
    object btnClearVector: TButton
      Left = 8
      Top = 176
      Width = 105
      Height = 25
      Caption = 'Clear vector'
      TabOrder = 5
      OnClick = btnClearVectorClick
    end
    object btnCopyVector: TButton
      Left = 8
      Top = 208
      Width = 105
      Height = 25
      Caption = 'Create a copy'
      TabOrder = 6
      OnClick = btnCopyVectorClick
    end
    object btnSortVector: TButton
      Left = 8
      Top = 240
      Width = 105
      Height = 25
      Caption = 'Sort'
      TabOrder = 7
      OnClick = btnSortVectorClick
    end
  end
  object btnCheckDLL: TButton
    Left = 8
    Top = 8
    Width = 129
    Height = 25
    Caption = 'Check DLL'
    TabOrder = 2
    OnClick = btnCheckDLLClick
  end
  object gbxOrderedDictionary: TGroupBox
    Left = 392
    Top = 40
    Width = 153
    Height = 281
    Caption = 'QOrderedStringXDictionaries  '
    TabOrder = 3
    object btnLoadOrderedDict: TButton
      Left = 8
      Top = 16
      Width = 137
      Height = 25
      Caption = 'Load ordered dictionary'
      TabOrder = 0
      OnClick = btnLoadOrderedDictClick
    end
    object btnShowOrderedDict: TButton
      Left = 8
      Top = 48
      Width = 137
      Height = 25
      Caption = 'Show values in order'
      TabOrder = 1
      OnClick = btnShowOrderedDictClick
    end
    object btnShowOrderedDictBackwards: TButton
      Left = 8
      Top = 80
      Width = 137
      Height = 33
      Caption = 'Show values in reverse order'
      TabOrder = 2
      WordWrap = True
      OnClick = btnShowOrderedDictBackwardsClick
    end
    object btnOrderedDictSize: TButton
      Left = 8
      Top = 184
      Width = 137
      Height = 25
      Caption = 'Dictionary size'
      TabOrder = 3
      OnClick = btnOrderedDictSizeClick
    end
    object btnOrderedDictDeleteVals: TButton
      Left = 8
      Top = 216
      Width = 137
      Height = 25
      Caption = 'Delete values'
      TabOrder = 4
      OnClick = btnOrderedDictDeleteValsClick
    end
    object btnOrderedDictionaryKeys: TButton
      Left = 8
      Top = 120
      Width = 137
      Height = 25
      Caption = 'Show keys by index'
      TabOrder = 5
      OnClick = btnOrderedDictionaryKeysClick
    end
    object btnOrderedDictionaryKeysBackwards: TButton
      Left = 8
      Top = 152
      Width = 137
      Height = 25
      Caption = 'Show keys in reverse'
      TabOrder = 6
      OnClick = btnOrderedDictionaryKeysBackwardsClick
    end
  end
  object gbxQLists: TGroupBox
    Left = 552
    Top = 40
    Width = 97
    Height = 281
    Caption = 'QXLists  '
    TabOrder = 4
    object btnLoadLists: TButton
      Left = 8
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Load lists'
      TabOrder = 0
      OnClick = btnLoadListsClick
    end
    object btnShowListValues: TButton
      Left = 8
      Top = 48
      Width = 75
      Height = 25
      Caption = 'Show values'
      TabOrder = 1
      OnClick = btnShowListValuesClick
    end
    object btnListSizes: TButton
      Left = 8
      Top = 80
      Width = 75
      Height = 25
      Caption = 'List sizes'
      TabOrder = 2
      OnClick = btnListSizesClick
    end
    object btnClearLists: TButton
      Left = 8
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Clear lists'
      TabOrder = 3
      OnClick = btnClearListsClick
    end
  end
  object gbxQIntegerXMap: TGroupBox
    Left = 136
    Top = 40
    Width = 121
    Height = 281
    Caption = 'QIntegerXMaps  '
    TabOrder = 5
    object btnLoadIntegerMap: TButton
      Left = 8
      Top = 16
      Width = 105
      Height = 25
      Caption = 'Load map'
      TabOrder = 0
      OnClick = btnLoadIntegerMapClick
    end
    object btnTestIntegerMap: TButton
      Left = 8
      Top = 48
      Width = 105
      Height = 25
      Caption = 'Test map'
      TabOrder = 1
      OnClick = btnTestIntegerMapClick
    end
    object btnShowIntegerMapValues: TButton
      Left = 8
      Top = 80
      Width = 105
      Height = 25
      Caption = 'Show map values'
      TabOrder = 2
      OnClick = btnShowIntegerMapValuesClick
    end
    object btnDeleteIntegerMapValues: TButton
      Left = 8
      Top = 184
      Width = 105
      Height = 25
      Caption = 'Delete values'
      TabOrder = 3
      OnClick = btnDeleteIntegerMapValuesClick
    end
    object btnShowFirstIntegerMapValue: TButton
      Left = 8
      Top = 112
      Width = 105
      Height = 25
      Caption = 'Show first value'
      TabOrder = 4
      OnClick = btnShowFirstIntegerMapValueClick
    end
    object btnIterateIntegerMap: TButton
      Left = 8
      Top = 144
      Width = 105
      Height = 33
      Caption = 'Iterate over map values'
      TabOrder = 5
      WordWrap = True
      OnClick = btnIterateIntegerMapClick
    end
    object btnCopyIntegerMap: TButton
      Left = 8
      Top = 216
      Width = 105
      Height = 25
      Caption = 'Create a copy'
      TabOrder = 6
      OnClick = btnCopyIntegerMapClick
    end
    object btnIntegerMapKeyByIndex: TButton
      Left = 8
      Top = 248
      Width = 105
      Height = 25
      Caption = 'Show keys by index'
      TabOrder = 7
      OnClick = btnIntegerMapKeyByIndexClick
    end
  end
end
