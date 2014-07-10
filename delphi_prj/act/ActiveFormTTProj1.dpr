library ActiveFormTTProj1;

uses
  ComServ,
  ActiveFormTTProj1_TLB in 'ActiveFormTTProj1_TLB.pas',
  ActiveFormTTImpl1 in 'ActiveFormTTImpl1.pas' {ActiveFormTTX: TActiveForm} {ActiveFormTTX: CoClass};

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
