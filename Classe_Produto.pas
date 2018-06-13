unit Classe_Produto;

interface

Uses Classes, DB;

Type
  TProduto = Class
  protected
    Fid: Integer;
    FCodigo: String;
    FDescricao: String;
    FEstoque: Integer;

    procedure SetEstoque(estoque: Integer);
  public
    Constructor Create;
    procedure ClearInformacao;
    Function Grava: Boolean;
    Function Busca(sCodigo: String): Boolean;

    property Id: Integer read Fid;
    property Codigo: String read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property estoque: Integer read FEstoque Write SetEstoque;

    class function FiltrarProduto(Nome: String): TDataSource;
    class function ListarProduto: TDataSource;
  end;

implementation

{ TProduto }

uses uDM;

function TProduto.Busca(sCodigo: String): Boolean;
var
  vid: Integer;
begin
  if DM.BuscaProduto(sCodigo, Self, vid) then
  begin
    Fid := vid;
    Result := True;
  end
  else
    Result := False;
end;

constructor TProduto.Create;
begin
  ClearInformacao;
end;

class function TProduto.FiltrarProduto(Nome: String): TDataSource;
begin
  Result := DM.FiltrarProduto(Nome);
end;

class function TProduto.ListarProduto: TDataSource;
begin
  Result := DM.ListarProduto();
end;

procedure TProduto.SetEstoque(estoque: Integer);
begin
  if estoque >= 0 then
    FEstoque := estoque
  else
    FEstoque := 0;
end;

procedure TProduto.ClearInformacao;
begin
  Fid := 0;
  FCodigo := '';
  FDescricao := '';
  FEstoque := 0;
end;

function TProduto.Grava: Boolean;
begin
  Result := DM.GravaProduto(Self);
end;

end.
