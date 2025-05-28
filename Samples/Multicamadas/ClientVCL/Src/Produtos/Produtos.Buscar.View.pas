unit Produtos.Buscar.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
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
  XData.Client,
  Aurelius.Bind.BaseDataset,
  Aurelius.Bind.Dataset,
  Produtos.DTO,
  ProdutosService;

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
    AureliusDataset1: TAureliusDataset;
    btnAtualizar: TBitBtn;
    btnExcluir: TBitBtn;
    AureliusDataset1Nome: TStringField;
    AureliusDataset1Id: TIntegerField;
    AureliusDataset1Estoque: TFloatField;
    AureliusDataset1Preco: TFloatField;
    AureliusDataset1Registro: TIntegerField;
    BitBtn1: TBitBtn;
    procedure edtBuscarChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure AureliusDataset1ObjectRemove(Dataset: TDataSet; AObject: TObject);
  private
    FXDataClient: TXDataClient;
    FList: TList<TProduto>;
    procedure ListarDados;
    procedure ChamarTelaCadastrar(const AId: Integer = 0);
  public

  end;

var
  ProdutosBuscarView: TProdutosBuscarView;

implementation

{$R *.dfm}

procedure TProdutosBuscarView.FormCreate(Sender: TObject);
begin
  FXDataClient := TXDataClient.Create;
  FXDataClient.Uri := 'http://localhost:2001/tms/xdata/';

  FList := TList<TProduto>.Create;
end;

procedure TProdutosBuscarView.FormDestroy(Sender: TObject);
begin
  FList.Free;
  FXDataClient.Free;
end;

procedure TProdutosBuscarView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F4:
    begin
      if ssAlt in Shift then
        Key := 0;
    end;
    VK_F5:
      Self.ListarDados;
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
  Self.ListarDados;
end;

procedure TProdutosBuscarView.btnFecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TProdutosBuscarView.btnAtualizarClick(Sender: TObject);
begin
  Self.ListarDados;
end;

procedure TProdutosBuscarView.ListarDados;
var
  LStrBuscar: string;
  LProdutosService: IProdutosService;
  LFiltros: TProdutoFiltros;
begin
  AureliusDataset1.Close;
  LProdutosService := FXDataClient.Service<IProdutosService>;
  FreeAndNil(FList);

  LFiltros := TProdutoFiltros.Create;
  try
    case rdGroupFiltros.ItemIndex of
      0: LFiltros.Id := StrToIntDef(edtBuscar.Text, 0);
      1: LFiltros.Nome := edtBuscar.Text;
      2: LFiltros.Registro := StrToIntDef(edtBuscar.Text, 0);
    end;

    FList := LProdutosService.List(LFiltros);
  finally
    LFiltros.Free;
  end;

  AureliusDataset1.SetSourceList(FList);
  AureliusDataset1.Open;

  lbTotal.Caption := FormatFloat('000000', DataSource1.DataSet.RecordCount);
end;

procedure TProdutosBuscarView.DBGrid1DblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TProdutosBuscarView.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_DELETE) then
    Key := 0;
end;

procedure TProdutosBuscarView.btnExcluirClick(Sender: TObject);
begin
  if AureliusDataset1.IsEmpty then
    raise Exception.Create('Selecione um registro para continuar');

  if MessageDlg('Deseja realmente excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  AureliusDataset1.Delete;
end;

procedure TProdutosBuscarView.AureliusDataset1ObjectRemove(Dataset: TDataSet; AObject: TObject);
var
  LProdutosService: IProdutosService;
begin
  LProdutosService := FXDataClient.Service<IProdutosService>;
  LProdutosService.Delete(TProduto(AObject).Id);
end;

procedure TProdutosBuscarView.btnCadastrarClick(Sender: TObject);
begin
  Self.ChamarTelaCadastrar;
end;

procedure TProdutosBuscarView.btnAlterarClick(Sender: TObject);
begin
  if AureliusDataset1.IsEmpty then
    raise Exception.Create('Selecione um registro para continuar');

  Self.ChamarTelaCadastrar(AureliusDataset1Id.AsInteger);
end;

procedure TProdutosBuscarView.ChamarTelaCadastrar(const AId: Integer = 0);
begin
//  var LView := TProdutosCadastrarView.Create(nil);
//  try
//    LView.IdAlterar := AId;
//    if LView.ShowModal <> mrOk then
//      Exit;
//
//    Self.ListarDados;
//    ProdutosDm.QListar.Locate('id', LView.IdSelecionado, [loCaseInsensitive]);
//  finally
//    LView.Free;
//  end;
end;

end.
