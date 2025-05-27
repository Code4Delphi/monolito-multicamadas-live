object ProdutosBuscarView: TProdutosBuscarView
  Left = 0
  Top = 0
  Caption = 'Buscar produtos'
  ClientHeight = 587
  ClientWidth = 755
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
  object Button1: TButton
    Left = 144
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Post'
    TabOrder = 0
    OnClick = Button1Click
  end
end
