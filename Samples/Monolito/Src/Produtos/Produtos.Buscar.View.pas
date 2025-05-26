unit Produtos.Buscar.View;

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
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Produtos.Cadastrar.View,
  Produtos.DM;

type
  TProdutosBuscarView = class(TForm)
    pnTopo: TPanel;
    Label1: TLabel;
    edtBuscar: TEdit;
    pnRodape: TPanel;
    rdGroupFiltros: TRadioGroup;
    btnCadastrar: TBitBtn;
    btnFechar: TBitBtn;
    btnAlterar: TBitBtn;
    pnTotal: TPanel;
    lbTotal: TLabel;
    pnGrid: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Label2: TLabel;
    procedure edtBuscarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
  private
    procedure BuscarDados;

  public

  end;

var
  ProdutosBuscarView: TProdutosBuscarView;

implementation

{$R *.dfm}

procedure TProdutosBuscarView.FormCreate(Sender: TObject);
begin
  ProdutosDM := TProdutosDM.Create(nil);
end;

procedure TProdutosBuscarView.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ProdutosDM);
end;

procedure TProdutosBuscarView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F4:
    begin
      if ssAlt in Shift then
        Key := 0;
    end;
    VK_ESCAPE:
      btnFechar.Click;
  end;

  if Key in[VK_F1..VK_F12] then
  begin
    if rdGroupFiltros.Items.Count >= Key - VK_F1 then
      rdGroupFiltros.ItemIndex := Key - VK_F1;
  end;
end;

procedure TProdutosBuscarView.edtBuscarChange(Sender: TObject);
begin
  Self.BuscarDados;
end;

procedure TProdutosBuscarView.btnFecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TProdutosBuscarView.BuscarDados;
var
  LStrBuscar: string;
  LCondicao: string;
begin
  LStrBuscar := QuotedStr('%'+ edtBuscar.Text +'%');
  LCondicao := '';
  case rdGroupFiltros.ItemIndex of
    0: LCondicao := 'where id like ' + LStrBuscar;
    1: LCondicao := 'where nome like ' + LStrBuscar;
    2: LCondicao := 'where preco like ' + LStrBuscar;
  end;

  LCondicao := '';
  ProdutosDM.List(LCondicao);

  lbTotal.Caption := '000000';
  if DataSource1.DataSet.IsEmpty then
    Exit;

  lbTotal.Caption := FormatFloat('000000', DataSource1.DataSet.RecordCount);
end;

procedure TProdutosBuscarView.btnCadastrarClick(Sender: TObject);
begin
  var LView := TProdutosCadastrarView.Create(nil);
  try
    LView.ShowModal;
  finally
    LView.Free;
  end;
end;

end.
