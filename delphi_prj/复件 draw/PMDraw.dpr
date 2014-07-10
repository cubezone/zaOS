program PMDraw;

uses
  Forms,
  Mdraw in 'Mdraw.pas' {Form1},
  MEvent in 'MEvent.pas',
  MCBtn in '..\..\Lib\MCBtn.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'NFSa230';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
