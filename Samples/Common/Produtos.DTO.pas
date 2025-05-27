unit Produtos.DTO;

interface

type
  TProduto = class
  private
    FId: Integer;
    FNome: string;
    FEstoque: Double;
    FPreco: Double;
    FNumItem: Integer;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Estoque: Double read FEstoque write FEstoque;
    property Preco: Double read FPreco write FPreco;
    property num_item: Integer read FNumItem write FNumItem;
  end;

implementation

end.
