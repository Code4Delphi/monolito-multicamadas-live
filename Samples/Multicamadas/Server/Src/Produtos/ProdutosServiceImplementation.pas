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
    function List([FromQuery] Filtros: TProdutoFiltros): TList<TProduto>;
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
  Result.Estoque := FDm.QListarestoque.AsFloat;
  Result.Preco := FDm.QListarpreco.AsFloat;
  Result.num_item := FDm.QListarnum_item.AsInteger;
end;

function TProdutosService.List([FromQuery] Filtros: TProdutoFiltros): TList<TProduto>;
begin
  Result := TList<TProduto>.Create;

  FDm.QListar.Close;
  FDm.QListar.SQL.Add('where 1 = 1');

  if Filtros.Id > 0 then
  begin
    FDm.QListar.SQL.Add('and produtos.id = :Id');
    FDm.QListar.ParamByName('Id').AsInteger := Filtros.Id;
  end;

  if not Filtros.Nome.IsEmpty then
  begin
    FDm.QListar.SQL.Add('and produtos.nome like :Nome');
    FDm.QListar.ParamByName('Nome').AsString := '%' + Filtros.Nome + '%';
  end;

  if Filtros.NumItem > 0 then
  begin
    FDm.QListar.SQL.Add('and produtos.num_item like :NumItem');
    FDm.QListar.ParamByName('NumItem').AsString := '%' + Filtros.NumItem.ToString + '%';
  end;

  FDm.QListar.Open;

  if FDm.QListar.IsEmpty then
    Exit(nil);

  FDm.QListar.First;
  while not FDm.QListar.Eof do
  begin
    var LProduto := TProduto.Create;
    LProduto.Id := FDm.QListarid.AsInteger;
    LProduto.Nome := FDm.QListarnome.AsString;
    LProduto.Estoque := FDm.QListarestoque.AsFloat;
    LProduto.Preco := FDm.QListarpreco.AsFloat;
    LProduto.NumItem := FDm.QListarnum_item.AsInteger;
    Result.Add(LProduto);

    FDm.QListar.Next;
  end;
end;

function TProdutosService.Post(Produto: TProduto): Integer;
begin
  FDm.Cadastrar(0);
  FDm.QCadastrar.Append;
  FDm.QCadastrarid.AsInteger := Produto.Id;
  FDm.QCadastrarnome.AsString := Produto.Nome;
  FDm.QCadastrarestoque.AsFloat := Produto.Estoque;
  FDm.QCadastrarpreco.AsFloat := Produto.Preco;
  FDm.QCadastrarnum_item.AsInteger := Produto.NumItem;
  FDm.QCadastrar.Post;

  Result := FDm.QCadastrarid.AsInteger;
end;

procedure TProdutosService.Alterar(Id: Integer; Produto: TProduto);
begin
  FDm.Cadastrar(Id);

  if FDm.QCadastrar.IsEmpty then
    raise Exception.Create('Produto não encontrado para alteração');

  FDm.QCadastrar.Edit;
  FDm.QCadastrarnome.AsString := Produto.Nome;
  FDm.QCadastrarestoque.AsFloat := Produto.Estoque;
  FDm.QCadastrarpreco.AsFloat := Produto.Preco;
  FDm.QCadastrarnum_item.AsFloat := Produto.NumItem;
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
