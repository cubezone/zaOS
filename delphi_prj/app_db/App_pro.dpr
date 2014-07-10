program App_pro;

uses
  Forms,
  Appdb in 'Appdb.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
