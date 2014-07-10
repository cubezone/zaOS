unit QCBtn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShellAPI,QControls, QStdCtrls;

type
  TCBtn = class(TLabel)
  private
      m_CColor :TColor;
      FTempColor: TColor;
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure CMMouseEnter(var Message: TMessage);  message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  published
    { Published declarations }
    procedure SetCColor(lcolor: TColor);
  property CColorr : TColor Read m_CColor Write SetCColor default clblue;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TCBtn]);
end;

procedure TCBtn.SetCColor(lcolor: TColor);
begin
   m_CColor:= lcolor;
end;

procedure TCBtn.CMMouseEnter(var Message: TMessage);
begin

 FTempColor:= Font.Color;
 Font.Color := m_CColor;
end;

procedure TCBtn.CMMouseLeave(var Message: TMessage);
begin
  Color := FTempColor;
end;


end.
