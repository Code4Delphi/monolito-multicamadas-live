unit ProdutosService;

interface

uses
  System.Generics.Collections,
  XData.Service.Common,
  //Bcl.Types.Assignable,
  XData.Json.Serializer,
  Produtos.DTO;

type
  TProdutoFiltros = class
  public
    //Id: Assignable<Integer>;
    //Nome: Assignable<string>;
    //NumItem: Assignable<Integer>;
    Id: Integer;
    Nome: string;
    [JSONName('num_item')]
    NumItem: Integer;
  end;

  [ServiceContract]
  IProdutosService = interface(IInvokable)
    ['{DECC5B93-5FAF-4166-9985-D72518081EF0}']
    [HttpGet]
    function GetEstoque(id: Integer): Double;
    [HttpGet, Route('{id}')]
    function Get(Id: Integer): TProduto;
    [HttpGet]
    function List([FromQuery] Filtros: TProdutoFiltros): TList<TProduto>;
    [HttpPost, Route('')]
    function Post(Produto: TProduto): Integer;
    [HttpPut, Route('{id}')]
    procedure Alterar(Id: Integer; Produto: TProduto);
    [HttpDelete, Route('{id}')]
    procedure Delete(Id: Integer);
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IProdutosService));

end.
