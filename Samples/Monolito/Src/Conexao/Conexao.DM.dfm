object ConexaoDM: TConexaoDM
  Height = 435
  Width = 385
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 136
    Top = 120
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 136
    Top = 192
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Code4D\Palestras\De-frente-com-a-Mel\Samples\DB\dado' +
        's.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 136
    Top = 56
  end
end
