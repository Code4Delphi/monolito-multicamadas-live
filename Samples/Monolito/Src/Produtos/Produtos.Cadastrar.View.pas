unit Produtos.Cadastrar.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.ExtCtrls,
  Vcl.DBCtrls,
  Vcl.Buttons,
  Produtos.DM, Data.DB;

type
  TProdutosCadastrarView = class(TForm)
    pnRodape: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    pnDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtCodigo: TDBEdit;
    edtNome: TDBEdit;
    edtDescricao: TDBEdit;
    edtPreco: TDBEdit;
    Label5: TLabel;
    edtLCM: TDBEdit;
    DataSource1: TDataSource;
  private

  public

  end;


implementation

{$R *.dfm}

end.
