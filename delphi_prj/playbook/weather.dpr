program weather;

uses
  Forms,
  weatherlayout in 'weatherlayout.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
