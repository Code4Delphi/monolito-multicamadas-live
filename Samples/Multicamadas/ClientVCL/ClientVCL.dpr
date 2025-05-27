program ClientVCL;

uses
  Vcl.Forms,
  ClientVCL.Main.View in 'Src\ClientVCL.Main.View.pas' {ClientVCLMainView},
  Produtos.Buscar.ViewOLD in 'Src\Produtos\Produtos.Buscar.ViewOLD.pas' {ProdutosBuscarViewOLD},
  Produtos.DTO in '..\..\Common\Produtos.DTO.pas',
  ProdutosService in '..\..\Common\ProdutosService.pas',
  Produtos.Buscar.View in 'Src\Produtos\Produtos.Buscar.View.pas' {ProdutosBuscarView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClientVCLMainView, ClientVCLMainView);
  Application.Run;
end.
