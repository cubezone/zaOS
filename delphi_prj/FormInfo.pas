unit FormInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit,Uobj;

type
  TFormInfo = class(TForm)
    ValueListEditor1: TValueListEditor;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowObjInfo(obj:Tobj);
  end;

var
  FormInfo: TFormInfo;

implementation

{$R *.dfm}

procedure TFormInfo.ShowObjInfo(obj:Tobj);
begin
end;
end.
