program p_bluemedia;

uses
  Forms,
  f_bluemedia in 'f_bluemedia.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
