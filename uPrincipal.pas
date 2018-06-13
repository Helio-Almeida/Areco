unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Classe_Produto, Vcl.StdCtrls;

type
  TFriendly = class(TCustomDBGrid);

  TfrmPrincipal = class(TForm)
    GroupBox1: TGroupBox;
    DBGridProdutos: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure DBGridProdutosDblClick(Sender: TObject);
    procedure DBGridProdutosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uProduto, uDM;

procedure TfrmPrincipal.DBGridProdutosDblClick(Sender: TObject);
begin
  frmProduto := TfrmProduto.Create(Self);
  frmProduto.Show;
end;

procedure TfrmPrincipal.DBGridProdutosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if odd(DM.qryProduto.RecNo) then
  begin
    DBGridProdutos.Canvas.Font.Color := clBlack;
    DBGridProdutos.Canvas.Brush.Color := $00F5F5F5;
  end
  else
  begin
    DBGridProdutos.Canvas.Font.Color := clBlack;
    DBGridProdutos.Canvas.Brush.Color := clWhite;
  end;

  with TFriendly(DBGridProdutos) do
  begin
    if DataLink.ActiveRecord = (Row - 1) then
    begin
      DBGridProdutos.Canvas.Brush.Color := clNavy;
      DBGridProdutos.Canvas.Font.Color := clWhite;
    end;
  end;

  DBGridProdutos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  DBGridProdutos.DataSource := TProduto.ListarProduto();
end;

end.
