unit Produtos.Buscar.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  XData.Client, Vcl.StdCtrls,
  Produtos.DTO,
  ProdutosService;

type
  TProdutosBuscarView = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FXDataClient: TXDataClient;
  public

  end;

implementation

{$R *.dfm}

procedure TProdutosBuscarView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  FXDataClient := TXDataClient.Create;
  FXDataClient.Uri := 'http://localhost:2001/tms/xdata/ProdutosService/';
end;

procedure TProdutosBuscarView.FormDestroy(Sender: TObject);
begin
  FXDataClient.Free;
end;

procedure TProdutosBuscarView.Button1Click(Sender: TObject);
var
  LProduto: TProduto;
  LMyService: IProdutosService;
  LIdInserido: Integer;
begin
  LProduto := TProduto.Create;
  LProduto.Nome := 'Nome teste client 001';
  LProduto.Estoque := 10;
  LProduto.Preco := 5;

  LMyService := FXDataClient.Service<IProdutosService>;
  LIdInserido := LMyService.Post(LProduto);
  ShowMessage('Id inserido: ' + LIdInserido.ToString);
end;

end.
