object DM: TDM
  OldCreateOrder = False
  Height = 285
  Width = 553
  object IBConexao: TIBDatabase
    DatabaseName = 'C:\ARECO\ARECO.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    DefaultTransaction = IBTrans
    ServerType = 'IBServer'
    Left = 64
    Top = 32
  end
  object IBTrans: TIBTransaction
    DefaultDatabase = IBConexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 144
    Top = 32
  end
  object qryTemp: TIBQuery
    Database = IBConexao
    Transaction = IBTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 368
    Top = 40
  end
  object dsFiltroProduto: TDataSource
    AutoEdit = False
    DataSet = qryFiltroProduto
    Left = 184
    Top = 144
  end
  object qryFiltroProduto: TIBQuery
    Database = IBConexao
    Transaction = IBTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 64
    Top = 144
  end
  object qryProduto: TIBQuery
    Database = IBConexao
    Transaction = IBTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 64
    Top = 200
  end
  object dsProduto: TDataSource
    AutoEdit = False
    DataSet = qryProduto
    Left = 184
    Top = 200
  end
end
