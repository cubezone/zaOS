library Mp3Proj;

uses
  ComServ,
  MP3Proj_TLB in 'MP3Proj_TLB.pas',
  Mp3Impl in 'MP3Impl.pas' {Mp3: TActiveForm} {Mp3: CoClass},
  Unit2 in 'Unit2.pas' {FormFull},
  MEvent in 'MEvent.pas',
  WebFtpImpl1 in '..\WebFtp\WebFtpImpl1.pas' {WebFtp: TActiveForm} {WebFtp: CoClass};

{$E ocx}

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
