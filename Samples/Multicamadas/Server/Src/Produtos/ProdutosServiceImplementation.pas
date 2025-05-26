unit ProdutosServiceImplementation;

interface

uses
  System.SysUtils,
  XData.Server.Module,
  XData.Service.Common,
  ProdutosService,
  Produtos.DM;

type
  [ServiceImplementation]
  TProdutosService = class(TInterfacedObject, IProdutosService)
  private
    function GetEstoque(const id: Integer): Double;
  end;

implementation

function TProdutosService.GetEstoque(const id: Integer): Double;
begin
  ProdutosDM.List('where id = ' + id.ToString);
  Result := ProdutosDM.QListarestoque.AsFloat;
end;

initialization
  RegisterServiceType(TProdutosService);

end.
