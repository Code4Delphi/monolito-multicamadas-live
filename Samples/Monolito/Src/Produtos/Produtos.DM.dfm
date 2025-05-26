object ProdutosDM: TProdutosDM
  Height = 362
  Width = 482
  object QCadastrar: TFDQuery
    Connection = ConexaoDM.FDConnection1
    SQL.Strings = (
      'select * '
      'from produtos'
      'where id = :ID'
      'limit 1')
    Left = 112
    Top = 72
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QCadastrarid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
      DisplayFormat = '000000'
    end
    object QCadastrarnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 50
    end
    object QCadastrardescricao: TWideMemoField
      FieldName = 'descricao'
      Origin = 'descricao'
      BlobType = ftWideMemo
    end
    object QCadastrarpreco: TFloatField
      FieldName = 'preco'
      Origin = 'preco'
      DisplayFormat = ',,0.00'
    end
    object QCadastrarncm: TIntegerField
      FieldName = 'ncm'
      Origin = 'ncm'
    end
  end
  object QBuscar: TFDQuery
    Connection = ConexaoDM.FDConnection1
    SQL.Strings = (
      'select * from produtos')
    Left = 200
    Top = 80
    object QBuscarid: TFDAutoIncField
      FieldName = 'id'
      ReadOnly = False
    end
    object QBuscarnome: TWideStringField
      FieldName = 'nome'
      Size = 50
    end
    object QBuscardescricao: TWideMemoField
      FieldName = 'descricao'
      BlobType = ftWideMemo
    end
    object QBuscarpreco: TFloatField
      FieldName = 'preco'
    end
    object QBuscarncm: TIntegerField
      FieldName = 'ncm'
    end
  end
end
