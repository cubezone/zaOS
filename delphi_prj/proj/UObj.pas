unit UObj;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,math,Contnrs,ComCtrls, ToolWin, IdGlobal,IniFiles,
  ExtCtrls;
type
  ptobj = TCanvas;
  TObj = class
  public
     m_name :string;
     m_sourcename : string;
     m_targetname : string;
     m_canvas : TCanvas;
     m_sx :integer;
     m_sy :integer;
     m_x :integer;
     m_y :integer;
     m_tx :integer;
     m_ty :integer;
     m_mousedown :integer;
     m_selected :integer;
     m_resizenode :integer;
     m_list :TclassList;
     m_desc:string;
     m_code:string;
     m_color:TColor;
  constructor Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
  procedure Draw();virtual;
  procedure setstat(x:integer;y:integer);virtual;
  function Ptin(x:integer;y:integer):bool;virtual;
  procedure ResizeXY(x:integer;y:integer);virtual;
  procedure MoveXY(x:integer;y:integer);virtual;
  procedure SavetoFile(i:integer;FileHandle:TIniFile);virtual;
  procedure LoadfromFile(i:integer; FileHandle: TIniFile);virtual;
  end;

  TLink = class(TObj)
  public
  constructor Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
  procedure Draw();override ;
  function Ptin(x,y:integer):bool;override;
  end;

  TComm = class(TObj)
  public
  constructor Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
  procedure Draw();override ;
  function Ptin(x,y:integer):bool;override;
  end;
implementation

constructor Tobj.Create(can :TCanvas;sx: integer;sy :integer; x: integer; y :integer);
begin
    m_selected := 2;
    m_sx :=sx;
    m_sy :=sy;
    m_x :=x;
    m_y :=y;
    m_tx := x;
    m_ty := y;
    m_canvas:=can;
    m_resizenode:=0;
end;

procedure Tobj.Draw();
begin
end;

procedure Tobj.SavetoFile(i:integer; FileHandle:TIniFile);
begin
    FileHandle.WriteString(inttostr(i),'classname',classname);
    FileHandle.Writeinteger(inttostr(i),'m_x',m_x);
    FileHandle.Writeinteger(inttostr(i),'m_y',m_y);
    FileHandle.Writeinteger(inttostr(i),'m_sx',m_sx);
    FileHandle.Writeinteger(inttostr(i),'m_sy',m_sy);
    FileHandle.Writeinteger(inttostr(i),'m_tx',m_tx);
    FileHandle.Writeinteger(inttostr(i),'m_ty',m_ty);
    FileHandle.Writeinteger(inttostr(i),'m_selected',m_selected);
    FileHandle.WriteString(inttostr(i),'m_name',m_name);
    FileHandle.WriteString(inttostr(i),'m_sourcename',m_sourcename);
    FileHandle.WriteString(inttostr(i),'m_targetname',m_targetname);
    FileHandle.WriteString(inttostr(i),'m_desc',m_desc);
    FileHandle.WriteString(inttostr(i),'m_code',m_code);
end;

procedure Tobj.LoadFromFile(i:integer;FileHandle:TIniFile);
begin
   m_sx := filehandle.ReadInteger(inttostr(i),'m_sx',0);
   m_sy := filehandle.ReadInteger(inttostr(i),'m_sy',0);
   m_x := filehandle.ReadInteger(inttostr(i),'m_x',0);
   m_y := filehandle.ReadInteger(inttostr(i),'m_y',0);
   m_tx := filehandle.ReadInteger(inttostr(i),'m_tx',0);
   m_ty := filehandle.ReadInteger(inttostr(i),'m_ty',0);
   m_selected := filehandle.ReadInteger(inttostr(i),'m_selected',0);
   m_targetname:= filehandle.ReadString(inttostr(i),'m_targetname','');
   m_sourcename:= filehandle.ReadString(inttostr(i),'m_sourcename','');
   m_desc:= filehandle.ReadString(inttostr(i),'m_desc','');
   m_code:= filehandle.ReadString(inttostr(i),'m_code','');
end;

procedure Tobj.SetStat(x:integer;y:integer);
var
   p :Tpoint;
   r,r2 :Trect;
begin
   if (m_mousedown = 1) then
   begin
      m_tx:= x;
      m_ty:= y;
   end;

   p.X := x;
   p.y := y;
   r.Left := m_x -3;
   r.Right := m_x +3;
   r.Top := m_y -3;
   r.Bottom := m_y +3;

   r2.Left := m_sx -3;
   r2.Right := m_sx +3;
   r2.Top := m_sy -3;
   r2.Bottom := m_sy +3;

   if m_mousedown =1 then
   begin
        begin//move
        m_selected := 3;
        screen.Cursor := crDrag;
        end;
        if  ptinrect(r2,p) then //resize
        begin
         m_selected := 2;
         m_resizenode := 0;
         screen.Cursor := crSizeNESW;
        end;
        if  ptinrect(r,p) then //resize
        begin
         m_selected := 2;
         m_resizenode := 1;
         screen.Cursor := crSizeNESW;
        end;
   end
   else
   begin
      if (m_selected = 1) then
      begin
          if ptinrect(r,p) or ptinrect(r2,p) then //resize
            screen.Cursor := crSizeNESW
          else if  ptinrect(r,p) or ptinrect(r2,p) then
               screen.Cursor := crDrag
             else
               screen.Cursor := 0;
      end
      else
         screen.Cursor := 0;
   end
end;

function TObj.Ptin(x:integer;y:integer):bool ;
begin
   ptin:=false;
end;

procedure Tobj.ResizeXY(x:integer;y:integer);
begin
    if (m_resizenode = 1 ) then
    begin m_x:= x; m_y:=y; end
   else
    begin m_sx:= x; m_sy:=y end;
end;

procedure Tobj.MoveXY(x:integer;y:integer);
begin
     m_sx:= m_sx + x - m_tx;
     m_sy:= m_sy + y - m_ty;
     m_x := m_x + x - m_tx;
     m_y := m_y + y - m_ty;
     m_tx := x;
     m_ty := y;
end;

constructor TLink.Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
begin
     inherited ;
     m_color:=clblack;
end;

procedure TLink.Draw();
var
//    i :integer;
//    draw :integer;
//    t : Trect;
    l_x ,l_y : integer;
begin
   m_Canvas.Pen.Color := m_color;
   m_Canvas.MoveTo( m_sx, m_sy );
   l_x := m_x;
   l_y := m_y;
   m_Canvas.LineTo( m_x,m_y);

   if m_sx-m_x <> 0 then
   begin
       m_Canvas.MoveTo( l_x, l_y);
       if m_x -m_sx < 0 then
        begin
           m_Canvas.LineTo(
        l_x + round(-10*cos(arctan((m_y-m_sy)/(m_x-m_sx)) + 5*pi/6)),
        l_y + round(-10*sin(arctan((m_y-m_sy)/(m_x-m_sx)) + 5*pi/6)) );
       m_Canvas.MoveTo( l_x, l_y );
       m_Canvas.LineTo(
        l_x + round(10*cos(arctan((m_y-m_sy)/(m_x-m_sx)) + pi/6)),
        l_y + round(10*sin(arctan((m_y-m_sy)/(m_x-m_sx)) + pi/6)) );
        end
        else
        begin
       m_Canvas.LineTo(
        l_x + round(-10*cos(arctan((m_y-m_sy)/(m_x-m_sx)) - pi/6)),
        l_y + round(-10*sin(arctan((m_y-m_sy)/(m_x-m_sx)) - pi/6)) );
         m_Canvas.MoveTo( l_x, l_y );
       m_Canvas.LineTo(
        l_x + round(10*cos(arctan((m_y-m_sy)/(m_x-m_sx)) -5*pi/6)),
        l_y + round(10*sin(arctan((m_y-m_sy)/(m_x-m_sx)) -5*pi/6)) );
       end;
     end;
   if m_selected = 1 then
   begin
   m_Canvas.pen.color := clred  ;
   m_Canvas.Brush.Style := bssolid;
   m_Canvas.Brush.Color:=clblack;
   m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
   m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);
   m_Canvas.Brush.Color:=clwhite;
   end;
   m_canvas.Font.Color := clOlive;  
   m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*5,round((m_sy+m_y)/2) -5,m_desc);
end;

function TLink.Ptin(x:integer;y:integer):bool ;
var
   r,r1:Trect;
   point:Tpoint;
   tdis:Extended;
begin
   tdis := power((x-m_x)*(x-m_x) + (y-m_y)*(y-m_y),0.5) +
   + power((x-m_sx)*(x-m_sx) + (y-m_sy)*(y-m_sy),0.5)
   - power((m_x-m_sx)*(m_x-m_sx) + (m_y-m_sy)*(m_y-m_sy),0.5);
   point.X := x;
   point.Y := y;
   r.Left :=m_x-3;
   r.Right :=m_x+3;
   r.Top:= m_y-3;
   r.Bottom:=m_y+3;
   r1.Left :=m_sx-3;
   r1.Right :=m_sx+3;
   r1.Top:= m_sy-3;
   r1.Bottom:=m_sy+3;
   ptin:= (tdis < 0.3) or ptinrect(r,point) or ptinrect(r1,point);
end;

constructor TComm.Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
begin
    inherited Create(can,sx,sy,x,y);
    m_color := clBlue;
end;

procedure TComm.Draw();
begin
   m_Canvas.Pen.Color := TColor($E0E0E0) ;
   m_Canvas.Rectangle(m_sx+3,m_sy+3,m_x+3,m_y+3);
   m_Canvas.Pen.Color := TColor($B0B0B0) ;
   m_Canvas.Rectangle(m_sx+2,m_sy+2,m_x+2,m_y+2);
   m_Canvas.Pen.Color := TColor($808080) ;
   m_Canvas.Rectangle(m_sx+1,m_sy+1,m_x+1,m_y+1);
   m_Canvas.Pen.Color := m_color ;
   m_Canvas.Rectangle(m_sx,m_sy,m_x,m_y);
   if m_selected = 1 then
   begin
   m_Canvas.Pen.Color := clred  ;
   m_Canvas.Brush.Color:=clblack;
   m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
   m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);
   m_Canvas.Brush.Color:=clwhite;
   end;
   m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*3,round((m_sy+m_y)/2) -5,m_desc);
end;

function TComm.Ptin(x:integer;y:integer):bool ;
var
   rect,r,r1:Trect;
   point:Tpoint;
begin
   if abs(m_sx- m_x)>4 then
   begin
     rect.Left := min(m_sx,m_x);
     rect.Right := max(m_sx,m_x);
   end
   else
   begin
     rect.Left := m_sx -3;
     rect.right := m_x +3;
   end;
   if abs(m_sy-m_y)>4 then
   begin
     rect.Top := min(m_sy,m_y);
     rect.Bottom := max(m_sy,m_y);
   end
   else
   begin
     rect.Top := m_y -3;
     rect.bottom := m_sy + 3;
   end;
   point.X := x;
   point.Y := y;
   r.Left :=m_x-3;
   r.Right :=m_x+3;
   r.Top:= m_y-3;
   r.Bottom:=m_y+3;

   r1.Left :=m_sx-3;
   r1.Right :=m_sx+3;
   r1.Top:= m_sy-3;
   r1.Bottom:=m_sy+3;
   ptin:= ptinrect(rect,point) or ptinrect(r,point) or ptinrect(r1,point);
end;
end.
