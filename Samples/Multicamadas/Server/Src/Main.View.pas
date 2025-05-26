unit Main.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  XData.DM;

type
  TMainView = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.Button1Click(Sender: TObject);
begin
  XDataDM.SparkleHttpSysDispatcher1.Active := True;
  Memo1.Lines.Add('## Conectado');
  Memo1.Lines.Add(XDataDM.XDataServer1.BaseUrl);
end;

procedure TMainView.Button2Click(Sender: TObject);
begin
  XDataDM.SparkleHttpSysDispatcher1.Active := False;
  Memo1.Lines.Add('## Desconectado ##');
end;

end.
