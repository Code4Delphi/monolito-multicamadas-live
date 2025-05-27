unit Produtos.Buscar.ViewOLD;

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
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Data.DB,
  Produtos.DTO,
  ProdutosService,
  XData.Client,
  Aurelius.Bind.BaseDataset,
  Aurelius.Bind.Dataset;

type
  TProdutosBuscarViewOLD = class(TForm)
    btnPost: TButton;
    btnListar: TButton;
    btnGet: TButton;
    Memo1: TMemo;
    AureliusDataset1: TAureliusDataset;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    btnListDataSet: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure btnListDataSetClick(Sender: TObject);
  private
    FXDataClient: TXDataClient;
    FList: TList<TProduto>;
  public

  end;

implementation

{$R *.dfm}

procedure TProdutosBuscarViewOLD.FormCreate(Sender: TObject);
begin
  FXDataClient := TXDataClient.Create;
  FXDataClient.Uri := 'http://localhost:2001/tms/xdata/';

  FList := TList<TProduto>.Create;
end;

procedure TProdutosBuscarViewOLD.FormDestroy(Sender: TObject);
begin
  FList.Free;
  FXDataClient.Free;
end;

procedure TProdutosBuscarViewOLD.btnPostClick(Sender: TObject);
var
  LProduto: TProduto;
  LProdutosService: IProdutosService;
  LIdInserido: Integer;
begin
  LProduto := TProduto.Create;
  try
    LProduto.Nome := 'Nome teste client 001';
    LProduto.Estoque := 10;
    LProduto.Preco := 5;

    LProdutosService := FXDataClient.Service<IProdutosService>;
    LIdInserido := LProdutosService.Post(LProduto);
    ShowMessage('Id inserido: ' + LIdInserido.ToString);
  finally
    LProduto.Free;
  end;
end;

procedure TProdutosBuscarViewOLD.btnGetClick(Sender: TObject);
var
  LProduto: TProduto;
  LProdutosService: IProdutosService;
begin
  LProdutosService := FXDataClient.Service<IProdutosService>;
  LProduto := LProdutosService.Get(2);
  ShowMessage('Id inserido: ' + LProduto.Nome);
end;

procedure TProdutosBuscarViewOLD.btnListarClick(Sender: TObject);
var
  LList: TList<TProduto>;
  LProduto: TProduto;
  LProdutosService: IProdutosService;
begin
  LProdutosService := FXDataClient.Service<IProdutosService>;
  LList := LProdutosService.List(nil);
  try
    for LProduto in LList do
    begin
      Memo1.Lines.Add('Id inserido: ' + LProduto.Nome);
    end;
  finally
    LList.Free;
  end;
end;

procedure TProdutosBuscarViewOLD.btnListDataSetClick(Sender: TObject);
var
  LProdutosService: IProdutosService;
  LList: TList<TProduto>;
begin
  AureliusDataset1.Close;

  LProdutosService := FXDataClient.Service<IProdutosService>;
  LList := LProdutosService.List(nil);
  try
    AureliusDataset1.SetSourceList(LList);
    AureliusDataset1.Open;
  finally
    LList.Free;
  end;
end;

end.
