program Server;

uses
  Vcl.Forms,
  Main.View in 'Src\Main.View.pas' {MainView},
  XData.DM in 'Src\XData.DM.pas' {XDataDM: TDataModule},
  ProdutosService in 'Src\Produtos\ProdutosService.pas',
  ProdutosServiceImplementation in 'Src\Produtos\ProdutosServiceImplementation.pas',
  Produtos.DM in 'Src\Produtos\Produtos.DM.pas' {ProdutosDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TXDataDM, XDataDM);
  Application.CreateForm(TProdutosDM, ProdutosDM);
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
