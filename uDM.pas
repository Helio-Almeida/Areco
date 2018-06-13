unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery,
  IBX.IBDatabase, Classe_Produto;

type
  TDM = class(TDataModule)
    IBConexao: TIBDatabase;
    IBTrans: TIBTransaction;
    qryTemp: TIBQuery;
    dsFiltroProduto: TDataSource;
    qryFiltroProduto: TIBQuery;
    qryProduto: TIBQuery;
    dsProduto: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    function BuscaProduto(sCodigo: String; oProduto: TProduto;
      var Id: Integer): Boolean;
    function GravaProduto(oProduto: TProduto): Boolean;
    function FiltrarProduto(Codigo: String): TDataSource;
    function ListarProduto: TDataSource;
    function ExcluiProduto(Codigo: String): Boolean;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TDM }

function TDM.ExcluiProduto(Codigo: String): Boolean;
var
  sSql: String;
begin
  try
    Result := False;
    if not IBConexao.Connected then
      IBConexao.Connected := true;
    sSql := ' delete from PRODUTOS ' + ' Where Codigo in (' + Codigo + ')';
    qryFiltroProduto.Close;
    qryFiltroProduto.SQL.Clear;
    qryFiltroProduto.SQL.aDD(sSql);
    qryFiltroProduto.ExecSQL;
    Result := true;
  except
    On E: Exception do
    begin
      raise Exception.Create('Erro: ' + E.Message)
    end;
  end;
end;

function TDM.FiltrarProduto(Codigo: String): TDataSource;
var
  sSql: String;
begin
  try
    if not IBConexao.Connected then
      IBConexao.Connected := true;
    sSql := ' select * from PRODUTOS ' + ' Where Codigo in (' + Codigo + ')';
    qryFiltroProduto.Close;
    qryFiltroProduto.SQL.Clear;
    qryFiltroProduto.SQL.aDD(sSql);
    qryFiltroProduto.Open;
    Result := dsFiltroProduto;
  except
    On E: Exception do
    begin
      raise Exception.Create('Erro: ' + E.Message)
    end;
  end;
end;

function TDM.ListarProduto: TDataSource;
var
  sSql: String;
begin
  try
    if not IBConexao.Connected then
      IBConexao.Connected := true;
    sSql := ' select idproduto, codigo, descricao, estoque from PRODUTOS ' +
      ' order by descricao ';
    qryProduto.Close;
    qryProduto.SQL.Clear;
    qryProduto.SQL.aDD(sSql);
    qryProduto.Open;
    Result := dsProduto;
  except
    On E: Exception do
    begin
      raise Exception.Create('Erro: ' + E.Message)
    end;
  end;
end;

function TDM.GravaProduto(oProduto: TProduto): Boolean;
var
  sSql: String;
begin
  try
    if Not IBConexao.Connected then
      IBConexao.Connected := true;
    qryTemp.Close;
    qryTemp.Close;
    qryTemp.SQL.Clear;
    if oProduto.Id <> 0 then
    begin
      sSql := 'Update Produtos set Codigo = :pCodigo,' +
        ' Descricao = :pDescricao, ' + ' Estoque = :pEstoque ' +
        ' where IDProduto = :pId ';
      qryTemp.SQL.aDD(sSql);
      qryTemp.ParamByname('pid').value := oProduto.Id;
      qryTemp.ParamByname('pCodigo').value := oProduto.Codigo;
      qryTemp.ParamByname('pDescricao').value := oProduto.Descricao;
      qryTemp.ParamByname('pEstoque').value := oProduto.Estoque;
    end
    else
    begin
      sSql := 'Insert into Produtos (Codigo, Descricao, Estoque) ' + ' Values '
        + ' (:pCodigo, :pDescricao, :pEstoque)';
      qryTemp.SQL.aDD(sSql);
      qryTemp.ParamByname('pCodigo').value := oProduto.Codigo;
      qryTemp.ParamByname('pDescricao').value := oProduto.Descricao;
      qryTemp.ParamByname('pEstoque').value := oProduto.Estoque;
    end;
    qryTemp.ExecSQL;
    Result := true;
  except
    Result := False;
    Raise Exception.Create('Erro ao Gravar Produto.');
  end;
end;

function TDM.BuscaProduto(sCodigo: String; oProduto: TProduto;
  var Id: Integer): Boolean;
var
  sSql: String;
begin
  try
    Result := False;
    if Not IBConexao.Connected then
      IBConexao.Connected := true;

    qryTemp.Close;
    qryTemp.SQL.Clear;
    sSql := 'Select idproduto, codigo, descricao, estoque ' + ' from produtos '
      + ' where codigo = :pCodigo ';
    qryTemp.SQL.aDD(sSql);
    qryTemp.ParamByname('pCodigo').value := sCodigo;
    qryTemp.Open;
    if not qryTemp.IsEmpty then
    begin
      oProduto.Codigo := qryTemp.FieldByname('Codigo').AsString;
      oProduto.Descricao := qryTemp.FieldByname('Descricao').AsString;
      oProduto.Estoque := qryTemp.FieldByname('Estoque').AsInteger;
      Id := qryTemp.FieldByname('idProduto').AsInteger;
      Result := true;
    end;
  except
    Result := False;
    Raise Exception.Create('Erro ao Buscar Produto.');
  end;

end;

end.
