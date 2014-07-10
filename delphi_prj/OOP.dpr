program OOP;

uses
  Forms,
  OOB in 'OOB.pas' {Main},
  UObj in 'UObj.pas',
  UFormInfo in '..\Lib\UFormInfo.pas' {FormInfo},
  UMysql in 'UMysql.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TFormInfo, FormInfo);
  Application.Run;
end.
