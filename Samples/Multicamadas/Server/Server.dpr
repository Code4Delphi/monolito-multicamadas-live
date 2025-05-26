program Server;

uses
  Vcl.Forms,
  Main.View in 'Src\Main.View.pas' {MainView},
  XData.DM in 'Src\XData.DM.pas' {XDataDM: TDataModule},
  ProdutosService in 'Src\Produtos\ProdutosService.pas',
  ProdutosServiceImplementation in 'Src\Produtos\ProdutosServiceImplementation.pas',
  Conexao.DM in 'Src\Conexao\Conexao.DM.pas' {ConexaoDM: TDataModule},
  Produtos.DM in 'Src\Produtos\Produtos.DM.pas' {ProdutosDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.CreateForm(TXDataDM, XDataDM);
  Application.CreateForm(TConexaoDM, ConexaoDM);
  Application.CreateForm(TProdutosDM, ProdutosDM);
  Application.Run;
end.
