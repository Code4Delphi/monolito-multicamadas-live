unit ProdutosService;

interface

uses
  XData.Service.Common;

type
  TProduto = class
  private
    FId: Integer;
    Fid_grupo: Integer;
    FNome: string;
    FDescricao: string;
    FEstoque: Double;
    FPreco: Double;
  public
    property Id: Integer read FId write FId;
    property id_grupo: Integer read Fid_grupo write Fid_grupo;
    property Nome: string read FNome write FNome;
    property Descricao: string read FDescricao write FDescricao;
    property Estoque: Double read FEstoque write FEstoque;
    property Preco: Double read FPreco write FPreco;
  end;

  [ServiceContract]
  IProdutosService = interface(IInvokable)
    ['{DECC5B93-5FAF-4166-9985-D72518081EF0}']
    [HttpGet]
    function GetEstoque(id: Integer): Double;
    [HttpGet, Route('{id}')]
    function Get(Id: Integer): TProduto;
    [HttpPost, Route('')]
    function Post(Produto: TProduto): Integer;
    [HttpPut, Route('{id}')]
    procedure Alterar(Id: Integer; Produto: TProduto);
    [HttpDelete, Router('{id}')]
    procedure Delete(Id: Integer);
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IProdutosService));

end.
