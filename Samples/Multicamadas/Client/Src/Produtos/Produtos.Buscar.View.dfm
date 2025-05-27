object ProdutosBuscarView: TProdutosBuscarView
  Left = 0
  Top = 0
  Caption = 'Buscar produtos'
  ClientHeight = 604
  ClientWidth = 1113
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object btnPost: TButton
    Left = 144
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Post'
    TabOrder = 0
    OnClick = btnPostClick
  end
  object btnListar: TButton
    Left = 168
    Top = 160
    Width = 75
    Height = 25
    Caption = 'btnListar'
    TabOrder = 1
    OnClick = btnListarClick
  end
  object btnGet: TButton
    Left = 240
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 2
    OnClick = btnGetClick
  end
  object Memo1: TMemo
    Left = 32
    Top = 231
    Width = 337
    Height = 273
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object DBGrid1: TDBGrid
    Left = 375
    Top = 256
    Width = 385
    Height = 225
    DataSource = DataSource1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnListDataSet: TButton
    Left = 440
    Top = 200
    Width = 75
    Height = 25
    Caption = 'List com Data set'
    TabOrder = 5
    OnClick = btnListDataSetClick
  end
  object Button1: TButton
    Left = 800
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 6
    OnClick = Button1Click
  end
  object DBGrid2: TDBGrid
    Left = 766
    Top = 256
    Width = 385
    Height = 225
    DataSource = DataSource2
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object AureliusDataset1: TAureliusDataset
    FieldDefs = <>
    Left = 416
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = AureliusDataset1
    Left = 528
    Top = 136
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 792
    Top = 192
    object FDMemTable1Id: TIntegerField
      FieldName = 'Id'
    end
    object FDMemTable1Name: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object FDMemTable1Preco: TFloatField
      FieldName = 'Preco'
    end
  end
  object DataSource2: TDataSource
    DataSet = FDMemTable1
    Left = 872
    Top = 200
  end
end
