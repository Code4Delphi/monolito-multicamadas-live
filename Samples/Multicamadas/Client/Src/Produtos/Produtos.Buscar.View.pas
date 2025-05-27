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
  XData.Client,
  Vcl.StdCtrls,
  Produtos.DTO,
  ProdutosService, Data.DB, Aurelius.Bind.BaseDataset, Aurelius.Bind.Dataset, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TProdutosBuscarView = class(TForm)
    btnPost: TButton;
    btnListar: TButton;
    btnGet: TButton;
    Memo1: TMemo;
    AureliusDataset1: TAureliusDataset;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    btnListDataSet: TButton;
    Button1: TButton;
    FDMemTable1: TFDMemTable;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    FDMemTable1Id: TIntegerField;
    FDMemTable1Name: TStringField;
    FDMemTable1Preco: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure btnListDataSetClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FXDataClient: TXDataClient;
    FList: TList<TProduto>;
  public

  end;

implementation

{$R *.dfm}

procedure TProdutosBuscarView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  FXDataClient := TXDataClient.Create;
  FXDataClient.Uri := 'http://localhost:2001/tms/xdata/';

  FList := TList<TProduto>.Create;
end;

procedure TProdutosBuscarView.FormDestroy(Sender: TObject);
begin
  FList.Free;
  FXDataClient.Free;
end;

procedure TProdutosBuscarView.btnPostClick(Sender: TObject);
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

procedure TProdutosBuscarView.btnGetClick(Sender: TObject);
var
  LProduto: TProduto;
  LProdutosService: IProdutosService;
begin
  LProdutosService := FXDataClient.Service<IProdutosService>;
  LProduto := LProdutosService.Get(2);
  ShowMessage('Id inserido: ' + LProduto.Nome);
end;

procedure TProdutosBuscarView.btnListarClick(Sender: TObject);
var
  LList: TList<TProduto>;
  LProduto: TProduto;
  LProdutosService: IProdutosService;
begin
  LProdutosService := FXDataClient.Service<IProdutosService>;
  LList := LProdutosService.List;
  try
    for LProduto in LList do
    begin
      Memo1.Lines.Add('Id inserido: ' + LProduto.Nome);
    end;
  finally
    LList.Free;
  end;
end;

//procedure TProdutosBuscarView.btnListDataSetClick(Sender: TObject);
//var
//  LProduto: TProduto;
//  LProdutosService: IProdutosService;
//begin
//  AureliusDataset1.Close;
//  LProdutosService := FXDataClient.Service<IProdutosService>;
//  FreeAndNil(FList);
//  FList := LProdutosService.List;
//  AureliusDataset1.SetSourceList(FList);
//  AureliusDataset1.Open;
//end;

procedure TProdutosBuscarView.btnListDataSetClick(Sender: TObject);
var
  LProduto: TProduto;
  LProdutosService: IProdutosService;
  LList: TList<TProduto>;
begin
  AureliusDataset1.Close;

  LProdutosService := FXDataClient.Service<IProdutosService>;
  LList := LProdutosService.List;
  try
    AureliusDataset1.SetSourceList(LList);
    AureliusDataset1.Open;
  finally
    LList.Free;
  end;
end;

procedure TProdutosBuscarView.Button1Click(Sender: TObject);
var
  LProduto: TProduto;
  LProdutosService: IProdutosService;
  LList: TList<TProduto>;
begin
  FDMemTable1.Close;
  FDMemTable1.Open;

  LProdutosService := FXDataClient.Service<IProdutosService>;
  LList := LProdutosService.List;
  try
    for LProduto in LList do
    begin
      FDMemTable1.Append;
      FDMemTable1Id.AsInteger := LProduto.Id;
      FDMemTable1Name.AsString := LProduto.Nome;
      FDMemTable1Preco.AsFloat := LProduto.Preco;
      FDMemTable1.Post;
    end;
  finally
    LList.Free;
  end;
end;

end.
