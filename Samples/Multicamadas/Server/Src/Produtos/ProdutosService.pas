unit ProdutosService;

interface

uses
  XData.Service.Common;

type
  [ServiceContract]
  IProdutosService = interface(IInvokable)
    ['{DECC5B93-5FAF-4166-9985-D72518081EF0}']
    [HttpGet]
    function GetEstoque(const id: Integer): Double;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IProdutosService));

end.
