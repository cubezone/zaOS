program PMDraw;

uses
  Forms,
  Mdraw in 'Mdraw.pas' {Form1},
  MEvent in 'MEvent.pas',
  Unit2 in 'Unit2.pas' {FormFull};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'NFSa230';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormFull, FormFull);
  Application.Run;
end.
