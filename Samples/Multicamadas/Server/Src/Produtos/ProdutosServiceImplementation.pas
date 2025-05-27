unit ProdutosServiceImplementation;

interface

uses
  System.SysUtils,
  Data.DB,
  XData.Server.Module,
  XData.Service.Common,
  ProdutosService,
  Produtos.DM,
  Produtos.DTO;

type
  [ServiceImplementation]
  TProdutosService = class(TInterfacedObject, IProdutosService)
  private
    function GetEstoque(id: Integer): Double;
    function Get(Id: Integer): TProduto;
    function Post(Produto: TProduto): Integer;
    procedure Alterar(Id: Integer; Produto: TProduto);
    procedure Delete(Id: Integer);
  end;

implementation

function TProdutosService.GetEstoque(id: Integer): Double;
begin
  ProdutosDM.Listar('where id = ' + id.ToString);
  Result := ProdutosDM.QListarestoque.AsFloat;
end;

function TProdutosService.Get(Id: Integer): TProduto;
begin
  ProdutosDM.Listar('where id = ' + id.ToString);

  if ProdutosDm.QListar.IsEmpty then
    Exit(nil);

  Result := TProduto.Create;
  Result.Id := ProdutosDm.QListarid.AsInteger;
  Result.Nome := ProdutosDm.QListarnome.AsString;
  Result.Descricao := ProdutosDm.QListardescricao.AsString;
  Result.Estoque := ProdutosDm.QListarestoque.AsFloat;
  Result.Preco := ProdutosDm.QListarpreco.AsFloat;
end;

function TProdutosService.Post(Produto: TProduto): Integer;
begin
  ProdutosDM.Cadastrar(0);
  ProdutosDm.QCadastrar.Append;
  ProdutosDm.QCadastrarid.AsInteger := Produto.Id;
  ProdutosDm.QCadastrarnome.AsString := Produto.Nome;
  ProdutosDm.QCadastrardescricao.AsString := Produto.Descricao;
  ProdutosDm.QCadastrarestoque.AsFloat := Produto.Estoque;
  ProdutosDm.QCadastrarpreco.AsFloat := Produto.Preco;
  ProdutosDm.QCadastrar.Post;

  Result := ProdutosDm.QCadastrarid.AsInteger;
end;

procedure TProdutosService.Alterar(Id: Integer; Produto: TProduto);
begin
  ProdutosDM.Cadastrar(Id);

  if ProdutosDm.QCadastrar.IsEmpty then
    raise Exception.Create('Produto não encontrado para alteração');

  ProdutosDm.QCadastrar.Edit;
  ProdutosDm.QCadastrarid_grupo.AsInteger := Produto.id_grupo;
  ProdutosDm.QCadastrarnome.AsString := Produto.Nome;
  ProdutosDm.QCadastrardescricao.AsString := Produto.Descricao;
  ProdutosDm.QCadastrarestoque.AsFloat := Produto.Estoque;
  ProdutosDm.QCadastrarpreco.AsFloat := Produto.Preco;
  ProdutosDm.QCadastrar.Post;
end;

procedure TProdutosService.Delete(Id: Integer);
begin
  ProdutosDM.Cadastrar(Id);

  if ProdutosDm.QCadastrar.IsEmpty then
    raise Exception.Create('Produto não encontrado para exclusão');

  ProdutosDm.QCadastrar.Delete;
end;

initialization
  RegisterServiceType(TProdutosService);

end.
