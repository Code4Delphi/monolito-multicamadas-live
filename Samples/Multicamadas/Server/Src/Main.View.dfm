object MainView: TMainView
  Left = 0
  Top = 0
  Caption = 'MainView'
  ClientHeight = 378
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Button1: TButton
    Left = 32
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 128
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 32
    Top = 72
    Width = 489
    Height = 261
    TabOrder = 2
  end
end
