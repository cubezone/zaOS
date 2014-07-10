unit MCBtn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShellAPI,StdCtrls,ExtCtrls;

type
  TMCBtn = class(TPanel)
  private
      m_CColor :TColor;
      FTempColor: TColor;
      i_down : integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure CMMouseEnter(var Message: TMessage);  message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUp;
  published
    { Published declarations }
    procedure SetCColor(lcolor: TColor);
  property CColorr : TColor Read m_CColor Write SetCColor default clblack;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMCBtn]);
end;

procedure TMCBtn.SetCColor(lcolor: TColor);
begin
   m_CColor:= lcolor;
end;

procedure TMCBtn.CMMouseEnter(var Message: TMessage);
begin
  if (Font.Color <> m_CColor) then
  begin
 	FTempColor:= Font.Color;
 	Font.Color := m_CColor;
 end;
 if i_down = 1 then
  self.BevelInner := bvLowered
  else
  self.BevelInner := bvRaised;
end;

procedure TMCBtn.WMLButtonDown(var Message: TWMLButtonDown);
begin
    inherited;
   self.BevelInner := bvLowered;
   i_down := 1;
end;

procedure TMCBtn.WMLButtonUP(var Message: TWMLButtonUP);
var
   l_p :TPoint;
begin
   inherited;
   l_p.X :=  Message.XPos;
   l_p.Y :=  Message.YPos;

   if ptinrect(self.ClientRect,l_p ) then
      self.BevelInner := bvRaised
   else
      self.BevelInner := bvNone;
   i_down := 0;
end;

procedure TMCBtn.CMMouseLeave(var Message: TMessage);
begin
  Font.Color := FTempColor;
  self.BevelInner := bvNone;
end;


end.

