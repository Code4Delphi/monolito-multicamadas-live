unit ProdutosServiceImplementation;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
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
    FDm: TProdutosDM;
    function GetEstoque(id: Integer): Double;
    function Get(Id: Integer): TProduto;
    function List: TList<TProduto>;
    function Post(Produto: TProduto): Integer;
    procedure Alterar(Id: Integer; Produto: TProduto);
    procedure Delete(Id: Integer);
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TProdutosService.Create;
begin
  FDm := TProdutosDM.Create(nil);
end;

destructor TProdutosService.Destroy;
begin
  FDm.Free;
  inherited;
end;

function TProdutosService.GetEstoque(id: Integer): Double;
begin
  FDm.Listar('where id = ' + id.ToString);
  Result := FDm.QListarestoque.AsFloat;
end;

function TProdutosService.Get(Id: Integer): TProduto;
begin
  FDm.Listar('where id = ' + id.ToString);

  if FDm.QListar.IsEmpty then
    Exit(nil);

  Result := TProduto.Create;
  Result.Id := FDm.QListarid.AsInteger;
  Result.Nome := FDm.QListarnome.AsString;
  Result.Descricao := FDm.QListardescricao.AsString;
  Result.Estoque := FDm.QListarestoque.AsFloat;
  Result.Preco := FDm.QListarpreco.AsFloat;
end;

function TProdutosService.List: TList<TProduto>;
var
  LObsProduto: TProduto;
begin
  Result := TList<TProduto>.Create;

  FDm.Listar('');

  if FDm.QListar.IsEmpty then
    Exit(nil);

  FDm.QListar.First;
  while not FDm.QListar.Eof do
  begin
    LObsProduto := TProduto.Create;
    LObsProduto.Id := FDm.QListarid.AsInteger;
    LObsProduto.Nome := FDm.QListarnome.AsString;
    LObsProduto.Descricao := FDm.QListardescricao.AsString;
    LObsProduto.Estoque := FDm.QListarestoque.AsFloat;
    LObsProduto.Preco := FDm.QListarpreco.AsFloat;
    Result.Add(LObsProduto);

    FDm.QListar.Next;
  end;
end;

function TProdutosService.Post(Produto: TProduto): Integer;
begin
  FDm.Cadastrar(0);
  FDm.QCadastrar.Append;
  FDm.QCadastrarid.AsInteger := Produto.Id;
  FDm.QCadastrarnome.AsString := Produto.Nome;
  FDm.QCadastrardescricao.AsString := Produto.Descricao;
  FDm.QCadastrarestoque.AsFloat := Produto.Estoque;
  FDm.QCadastrarpreco.AsFloat := Produto.Preco;
  FDm.QCadastrar.Post;

  Result := FDm.QCadastrarid.AsInteger;
end;

procedure TProdutosService.Alterar(Id: Integer; Produto: TProduto);
begin
  FDm.Cadastrar(Id);

  if FDm.QCadastrar.IsEmpty then
    raise Exception.Create('Produto não encontrado para alteração');

  FDm.QCadastrar.Edit;
  FDm.QCadastrarid_grupo.AsInteger := Produto.id_grupo;
  FDm.QCadastrarnome.AsString := Produto.Nome;
  FDm.QCadastrardescricao.AsString := Produto.Descricao;
  FDm.QCadastrarestoque.AsFloat := Produto.Estoque;
  FDm.QCadastrarpreco.AsFloat := Produto.Preco;
  FDm.QCadastrar.Post;
end;

procedure TProdutosService.Delete(Id: Integer);
begin
  FDm.Cadastrar(Id);

  if FDm.QCadastrar.IsEmpty then
    raise Exception.Create('Produto não encontrado para exclusão');

  FDm.QCadastrar.Delete;
end;

initialization
  RegisterServiceType(TProdutosService);

end.
