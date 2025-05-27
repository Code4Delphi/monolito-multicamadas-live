program Client;

uses
  Vcl.Forms,
  Main.View in 'Src\Main.View.pas' {MainView},
  Produtos.Buscar.View in 'Src\Produtos\Produtos.Buscar.View.pas' {ProdutosBuscarView},
  Produtos.DTO in '..\..\Common\Produtos.DTO.pas',
  ProdutosService in '..\..\Common\ProdutosService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
