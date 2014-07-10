program RA_APP;

uses
  Forms,
  RA in 'RA.pas' {Form1},
  RA_Process in 'RA_Process.pas' {Form2},
  RA_3 in 'RA_3.pas' {Form3},
  RA_cdr_log in 'RA_cdr_log.pas' {Form4},
  RA_Monitor in 'RA_Monitor.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
