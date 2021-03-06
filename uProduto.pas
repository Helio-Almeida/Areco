unit uProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Vcl.ExtCtrls, Classe_Produto, uDM, Vcl.Buttons;

type
  TfrmProduto = class(TForm)
    pnlSuperior: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    edtEstoque: TEdit;
    pnlInferior: TPanel;
    btnNovo: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnFechar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    oProduto: TProduto;
  public
    { Public declarations }
    procedure habilita;
    procedure desabilita;
  end;

var
  frmProduto: TfrmProduto;

implementation

{$R *.dfm}

procedure TfrmProduto.FormCreate(Sender: TObject);
begin
  oProduto := TProduto.Create;
end;

procedure TfrmProduto.FormShow(Sender: TObject);
begin
  edtCodigo.Text := DM.qryProduto.Fieldbyname('codigo').AsString;

  if Trim(edtCodigo.Text) = '' then
    exit;

  if oProduto.Busca(Trim(edtCodigo.Text)) then
  begin
    edtDescricao.Text := oProduto.Descricao;
    edtEstoque.Text := IntToStr(oProduto.Estoque);
  end;

end;

procedure TfrmProduto.habilita;
begin
  pnlSuperior.Enabled := True;
  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
  btnFechar.Enabled := False;
  btnCancelar.Enabled := True;
  edtCodigo.Color := clWindow;
  edtDescricao.Color := clWindow;
  edtEstoque.Color := clWindow;
end;

procedure TfrmProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(oProduto);
  Action := caFree;
end;

procedure TfrmProduto.btnNovoClick(Sender: TObject);
begin
  habilita;
  edtCodigo.Text := '';
  edtDescricao.Text := '';
  edtEstoque.Text := '';
  edtCodigo.Setfocus;
end;

procedure TfrmProduto.desabilita;
begin
  pnlSuperior.Enabled := False;
  btnNovo.Enabled := True;
  btnGravar.Enabled := False;
  btnAlterar.Enabled := True;
  btnExcluir.Enabled := True;
  btnFechar.Enabled := True;
  btnCancelar.Enabled := False;
  edtCodigo.Color := clBtnFace;
  edtDescricao.Color := clBtnFace;
  edtEstoque.Color := clBtnFace;
end;

procedure TfrmProduto.edtCodigoExit(Sender: TObject);
begin
  if Trim(edtCodigo.Text) = '' then
    exit;

  if oProduto.Busca(Trim(edtCodigo.Text)) then
  begin
    edtDescricao.Text := oProduto.Descricao;
    edtEstoque.Text := IntToStr(oProduto.Estoque);
  end;

end;

procedure TfrmProduto.btnAlterarClick(Sender: TObject);
begin
  if Trim(edtCodigo.Text) = '' then
    exit;

  habilita;
  edtCodigo.Setfocus;
end;

procedure TfrmProduto.btnCancelarClick(Sender: TObject);
begin
  desabilita;
end;

procedure TfrmProduto.btnExcluirClick(Sender: TObject);
begin
  if Trim(edtCodigo.Text) = '' then
    exit;

  if Application.MessageBox('Deseja excluir esse registro?', 'Excluir',
    MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = id_yes then
  begin
    DM.ExcluiProduto(edtCodigo.Text);
    DM.qryProduto.Close;
    DM.qryProduto.Open;
    edtCodigo.Text := '';
    edtDescricao.Text := '';
    edtEstoque.Text := '';
  end;
end;

procedure TfrmProduto.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProduto.btnGravarClick(Sender: TObject);
begin
  if (Trim(edtCodigo.Text) <> '') and (Trim(edtDescricao.Text) <> '') then
  begin
    oProduto.Codigo := edtCodigo.Text;
    oProduto.Descricao := edtDescricao.Text;
    oProduto.Estoque := StrToInt(edtEstoque.Text);

    if oProduto.Grava then
    begin
      oProduto.ClearInformacao;
    end
    else
      edtDescricao.Setfocus;
  end
  else
    Showmessage('Campos Inválidos');

  DM.qryProduto.Close;
  DM.qryProduto.Open;
  desabilita;
end;

end.
