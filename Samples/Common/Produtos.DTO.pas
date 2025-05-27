unit Produtos.DTO;

interface

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

implementation

end.
