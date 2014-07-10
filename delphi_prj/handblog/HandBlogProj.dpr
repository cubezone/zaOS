library HandBlogProj;

uses
  ComServ,
  HandBlogProj_TLB in 'HandBlogProj_TLB.pas',
  Unit2 in 'Unit2.pas' {FormFull},
  About1 in 'About1.pas' {HandBlogAbout},
  HandBlogImpl in 'HandBlogImpl.pas' {HandBlog: TActiveForm};

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
