unit UObj;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,math,Contnrs,ComCtrls, ToolWin, IdGlobal,IniFiles,
  ExtCtrls,Grids,Types, xmldom, XMLIntf, msxmldom,
  XMLDoc;
type
  ptobj = TCanvas;
  TObj = class
  public
     m_name :string;
     m_dstyle:integer;
     m_sourcename : string;
     m_targetname : string;
     m_canvas : TCanvas;
     m_sx,m_sy,m_x,m_y :integer;
     m_osx,m_osy,m_ox,m_oy :integer;
     m_tx :integer;
     m_ty :integer;
     m_mousedown :integer;
     m_selected :integer;
     m_oselected :integer;
     m_resizenode :integer;
     m_shadow :integer;
     m_list :TclassList;
     m_desc:string;
     m_code:string;
     //m_vx :integer;
     //m_vy :integer;
     m_color:TColor;
     m_fillcolor:Tcolor;

  constructor Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
  procedure Draw();virtual;

  function IsLink(): bool;
  procedure SetStat(x:integer;y:integer);virtual;
  function Ptin(x:integer;y:integer):bool;virtual;
  procedure ResizeXY(x:integer;y:integer);virtual;
  procedure MoveXY(x:integer;y:integer);virtual;
  procedure SavetoFile(i:integer;FileHandle:TXMLDocument);virtual;
  procedure LoadfromFile(i:integer; FileHandle: TXMLDocument);virtual;
  private
        m_drect: Trect;      
  end;

  TLink = class(TObj)
  public
  constructor Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
  procedure Draw();override ;
  function Ptin(x,y:integer):bool;override;
  function SetDRect(r,r1:TRect):bool;virtual;
  end;

  TLine = class(TLink)
  public
  procedure Draw();override ;
  end;

  TIF = class(TObj)
  public
  constructor Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
  procedure Draw();override ;
  function Ptin(x,y:integer):bool;override;
  end;

  TComm = class(TObj)
  public
  constructor Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
  procedure Draw();override ;
  procedure CommDraw();
  procedure EcllipseDraw();
  procedure RoundDraw();
  procedure ImageDraw();
  procedure TextDraw();
  procedure ResizeXY(x:integer;y:integer);override;
  function Ptin(x,y:integer):bool;override;
  end;

  TTable = class(TComm)
  public
  m_data : TStringlist;
  constructor Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
  procedure Draw();override ;
  function Ptin(x,y:integer):bool;override;
// function Ptin(x,y:integer):bool;override;
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
    m_shadow := 0;
    m_fillcolor :=TColor($aaffff);;
end;


Function Tobj.isLink():bool;
begin
        if  (ClassName = 'TLink') or
        (classname = 'TLine') then
           isLink := true
        else
           isLink := false;
end;


procedure Tobj.Draw();
begin
end;

procedure Tobj.SavetoFile(i:integer; FileHandle:Txmldocument);
var
    vnode,vsubnode : ixmlnode;
begin
   vnode := FileHandle.DocumentElement.AddChild('obj');
   vsubnode := vnode.AddChild('m_name');
   vsubnode.Text := m_name;
   vsubnode := vnode.AddChild('classname');
   vsubnode.Text := classname;
   vsubnode := vnode.AddChild('m_x');
   vsubnode.Text := inttostr(m_x);
   vsubnode := vnode.AddChild('m_y');
   vsubnode.Text := inttostr(m_y);
   vsubnode := vnode.AddChild('m_sx');
   vsubnode.Text := inttostr(m_sx);
   vsubnode := vnode.AddChild('m_sy');
   vsubnode.Text := inttostr(m_sy);
   vsubnode := vnode.AddChild('m_tx');
   vsubnode.Text := inttostr(m_tx);
   vsubnode := vnode.AddChild('m_ty');
   vsubnode.Text := inttostr(m_ty);
   vsubnode := vnode.AddChild('m_dstyle');
   vsubnode.Text := inttostr(m_dstyle);
   vsubnode := vnode.AddChild('m_fillcolor');
   vsubnode.Text := inttostr(m_fillcolor);
   vsubnode := vnode.AddChild('m_selected');
   vsubnode.Text := inttostr(m_selected);
   vsubnode := vnode.AddChild('m_shadow');
   vsubnode.Text := inttostr(m_shadow);
   vsubnode := vnode.AddChild('m_sourcename');
   vsubnode.Text := m_sourcename;
   vsubnode := vnode.AddChild('m_targetname');
   vsubnode.Text := m_targetname;
   vsubnode := vnode.AddChild('m_desc');
   vsubnode.Text := m_desc;
   vsubnode := vnode.AddChild('m_code');
   vsubnode.Text := m_code;

   {
    FileHandle.WriteString(inttostr(i),'classname',classname);
    FileHandle.Writeinteger(inttostr(i),'m_x',m_x);
    FileHandle.Writeinteger(inttostr(i),'m_y',m_y);
    FileHandle.Writeinteger(inttostr(i),'m_sx',m_sx);
    FileHandle.Writeinteger(inttostr(i),'m_sy',m_sy);
    FileHandle.Writeinteger(inttostr(i),'m_tx',m_tx);
    FileHandle.Writeinteger(inttostr(i),'m_ty',m_ty);
    FileHandle.Writeinteger(inttostr(i),'m_dstyle',m_dstyle);
    FileHandle.Writeinteger(inttostr(i),'m_fillcolor',m_fillcolor);
    FileHandle.Writeinteger(inttostr(i),'m_selected',m_selected);
    FileHandle.Writeinteger(inttostr(i),'m_shadow',m_shadow);
    FileHandle.WriteString(inttostr(i),'m_name',m_name);
    FileHandle.WriteString(inttostr(i),'m_sourcename',m_sourcename);
    FileHandle.WriteString(inttostr(i),'m_targetname',m_targetname);
    FileHandle.WriteString(inttostr(i),'m_desc',m_desc);
    FileHandle.WriteString(inttostr(i),'m_code',m_code);
}
end;

procedure Tobj.LoadFromFile(i:integer;FileHandle:TXMLDocument);
var vnode :IXMLNODE;
begin
   vnode := FileHandle.DocumentElement.ChildNodes[i];
   m_sx := strtoint(vnode.ChildNodes['m_sx'].text);
   m_sy := strtoint(vnode.ChildNodes['m_sy'].text);
   m_x := strtoint(vnode.ChildNodes['m_x'].text);
   m_y := strtoint(vnode.ChildNodes['m_y'].text);
   m_tx := strtoint(vnode.ChildNodes['m_tx'].text);
   m_ty := strtoint(vnode.ChildNodes['m_ty'].text);
   m_dstyle := strtoint(vnode.ChildNodes['m_dstyle'].text);
   m_fillcolor := strtoint(vnode.ChildNodes['m_fillcolor'].text);
   m_selected := strtoint(vnode.ChildNodes['m_selected'].text);
   m_shadow := strtoint(vnode.ChildNodes['m_shadow'].text);
   m_targetname:= vnode.ChildNodes['m_targetname'].text;
   m_sourcename:= vnode.ChildNodes['m_sourcename'].text;
   m_desc:= vnode.ChildNodes['m_desc'].text;
   m_code:= vnode.ChildNodes['m_code'].text;

{
   m_sx := filehandle.ReadInteger(inttostr(i),'m_sx',0);
   m_sy := filehandle.ReadInteger(inttostr(i),'m_sy',0);
   m_x := filehandle.ReadInteger(inttostr(i),'m_x',0);
   m_y := filehandle.ReadInteger(inttostr(i),'m_y',0);
   m_tx := filehandle.ReadInteger(inttostr(i),'m_tx',0);
   m_ty := filehandle.ReadInteger(inttostr(i),'m_ty',0);
   m_dstyle := filehandle.ReadInteger(inttostr(i),'m_dstyle',0);
   m_fillcolor := filehandle.ReadInteger(inttostr(i),'m_fillcolor',$88ffff);
   m_selected := filehandle.ReadInteger(inttostr(i),'m_selected',0);
   m_shadow := filehandle.ReadInteger(inttostr(i),'m_shadow',0);
   m_targetname:= filehandle.ReadString(inttostr(i),'m_targetname','');
   m_sourcename:= filehandle.ReadString(inttostr(i),'m_sourcename','');
   m_desc:= filehandle.ReadString(inttostr(i),'m_desc','');
   m_code:= filehandle.ReadString(inttostr(i),'m_code','');

}
end;

procedure Tobj.SetStat(x:integer;y:integer);
var
   p :Tpoint;
   r,r1,r2,r3,r4 :Trect;
begin
   if (m_mousedown = 1) then
   begin
      m_tx:= x;
      m_ty:= y;
   end;
   p.X := x;
   p.y := y;

   r1.Left := m_sx ;
   r1.Right := m_x;
   r1.Top := m_sy;
   r1.Bottom := m_y;

   r1.Left := m_x -3;
   r1.Right := m_x +3;
   r1.Top := m_y -3;
   r1.Bottom := m_y +3;

   r2.Left := m_sx -3;
   r2.Right := m_sx +3;
   r2.Top := m_sy -3;
   r2.Bottom := m_sy +3;

   r3.Left := m_sx -3;
   r3.Right := m_sx +3;
   r3.Top := m_y -3;
   r3.Bottom := m_y +3;

   r4.Left := m_x -3;
   r4.Right := m_x +3;
   r4.Top := m_sy -3;
   r4.Bottom := m_sy +3;
  // if m_mousedown = 1 then
   if (m_selected = 2) then
   begin
        begin//move
        m_selected := 3;
        screen.Cursor := crDrag;
        end;
        if  ptinrect(r2,p) then //resize
        begin
         m_selected := 2;
         m_resizenode := 0;
         screen.Cursor := crSizeNWSE;
        end;
        if  ptinrect(r1,p) then //resize
        begin
         m_selected := 2;
         m_resizenode := 1;
         screen.Cursor := crSizeNWSE;
        end;
         if  ptinrect(r3,p) then //resize
        begin
         m_selected := 2;
         m_resizenode := 3;
         screen.Cursor := crSizeNESW;
        end;
         if  ptinrect(r4,p) then //resize
        begin
         m_selected := 2;
         m_resizenode := 4;
         screen.Cursor := crSizeNESW;
        end;
   end
   else
   begin
      if (m_selected = 1) then
      begin
          if ptinrect(r1,p) or ptinrect(r2,p) then //resize
            screen.Cursor := crSizeNWSE
          else if ptinrect(r3,p) or ptinrect(r4,p) then //resize
            screen.Cursor := crSizeNESW
          else if  ptinrect(r,p) and (m_mousedown = 1 )then
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
    if islink then
    begin
     if (m_sx = m_x) then
     begin
       if m_resizenode = 4 then
         m_resizenode := 0
       else
         m_resizenode := 1;
     end;
     
     if (m_sy = m_y) then
       if m_resizenode = 3 then
         m_resizenode := 0
       else
         m_resizenode := 1;

     if (m_resizenode = 1 ) then
       begin   m_x := x ; m_y := y; end
     else if (m_resizenode = 0 ) then
       begin m_sx := x; m_sy := y end

    end
    else
    // 对象resize大小的限制
    if (m_resizenode = 1 ) then
    begin
       m_x := max(x,m_sx+20);
       m_y := max(y,m_sy+20);
    end
    else if (m_resizenode = 0 ) then
    begin
       m_sx := min(x,m_x-20);
       m_sy := min(y,m_y-20);
    end
    else if (m_resizenode = 3 ) then
    begin
       m_sx := min(x,m_x-20);
       m_y := max(y,m_sy+20);
    end
    else if (m_resizenode = 4 ) then
    begin
       m_x := max(x,m_sx+20);
       m_sy := min(y,m_y-20);
    end;

    m_sx := max(0,m_sx);
    m_sy := max(0,m_sy);    
end;

procedure Tobj.MoveXY(x:integer;y:integer);
begin
     if m_tx - m_sx >  x then x := m_tx-m_sx;
     if m_ty - m_sy >  y then y := m_ty-m_sy;
     m_sx:= m_sx + x - m_tx;
     m_sy:= m_sy + y - m_ty ;
     m_x := m_x + x - m_tx;
     m_y := m_y + y - m_ty;
     m_drect.Left := m_drect.Left  + x - m_tx;
     m_drect.Top := m_drect.Top  + y - m_ty;
     m_drect.Right := m_drect.Right  + x - m_tx;
     m_drect.Bottom := m_drect.Bottom  + y - m_ty;

     m_tx := x;
     m_ty := y;
end;

constructor TLink.Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
begin
     inherited ;
     m_color:=clblack;
end;


function TLink.SetDRect(r,r1:TRect):bool;
var
   a,b :Extended;
begin
 
    m_drect.Top  := m_sy;
    m_drect.Left  := m_sx;

    m_drect.Bottom  := m_y;
    m_drect.Right  := m_x;

    if (m_x = m_sx) then
       a := 0
    else
       a :=  arctan(-(m_y-m_sy)/(m_x-m_sx));

    if (m_x-m_sx < 0) then
      a:= a+pi;
    if (-(m_y - m_sy) < 0) and  (m_x-m_sx > 0) then
      a:= a+2*pi;
    b:= 0;

    if not ((r.Top = 0) and  (r.Right = 0) and (r.Left = 0) and (r.Bottom = 0)) then
    begin
    m_sx := CenterPoint(r).X;
    m_drect.Left  := m_sx;
    m_sy := CenterPoint(r).y;
    m_drect.Top  := m_sy;

    if r.Right-r.Left <> 0 then
    b :=  arctan((r.Bottom-r.Top)/(r.Right-r.Left));

    if  ( a > b) and (a <= pi -b ) then
     //r_sy
    begin
     m_drect.Top := r.Top;
     if (m_y-m_sy = 0) then
     m_drect.Right := round((r.Left + r.Right)/2)
     else
     m_drect.Left :=  round(-(m_x-m_sx)*(r.Top-m_sy) /-(m_y-m_sy)) + m_sx
    end;
    if  ( a > pi - b) and (a <= pi + b ) then
     //r_sx
    begin
     m_drect.Left := r.Left;
     if (abs(m_x-m_sx) > 3) then
     m_drect.Top :=  round(-(m_sx-r.Left)*(m_y-m_sy) /(m_x-m_sx)) + m_sy
     else
     begin
      m_drect.Left := round((r.Right + r.Left)/2);
          if (m_y > m_sy) then
       m_drect.top := r.Top
      else
      begin
       m_drect.Top := r.Bottom
       end;
     end;
    end;
    if  ( a > pi + b) and (a <= 2*pi - b ) then
     //r_y
     begin
     m_drect.Top := r.Bottom;
     if (m_y-m_sy <> 0) then
     m_drect.Left :=  round((m_x-m_sx)*(m_sy-r.Bottom)/-(m_y-m_sy)) + m_sx;
    end;
     if  ( a > 2*pi -b) or (a <= b ) then
     //r_x
    begin
     m_drect.Left := r.Right;
     if (abs(m_x-m_sx) > 3) then
     m_drect.Top :=  round(-(m_sx-r.Right)*(m_y-m_sy) /(m_x-m_sx)) + m_sy
     else
     begin
     m_drect.Left := round((r.Right + r.Left)/2);
     if (m_y > m_sy) then
       m_drect.top := r.Bottom
      else
      begin
       m_drect.Top := r.Top
       end;
     end;
    end;
   end; // end if 0,0,0,0


    if not ((r1.Top = 0) and  (r1.Right = 0) and (r1.Left = 0) and (r1.Bottom = 0)) then
    begin

    m_x := CenterPoint(r1).X;
    m_drect.Right  := m_x;
    m_y := CenterPoint(r1).y;
    m_drect.Bottom  := m_y;

    if r1.Right-r1.Left <> 0 then
    b :=  arctan((r1.Bottom-r1.Top)/(r1.Right-r1.Left));

    if  ( a > b) and (a <= pi -b ) then
     //r_sy
    begin
     m_drect.Bottom := r1.Bottom;
     if (m_y-m_sy = 0) then
     m_drect.Right := round((r.Left + r.Right)/2)
     else
     m_drect.Right :=  round(-(m_x-m_sx)*(r1.Bottom-m_y) /-(m_y-m_sy)) + m_x
    end;
    if  ( a > pi - b) and (a <= pi + b ) then
     //r_sx
    begin
     m_drect.Right := r1.Right;
     if (abs(m_x-m_sx) > 3) then
       m_drect.Bottom :=  round(-(m_x-r1.Right)*(m_y-m_sy) /(m_x-m_sx)) + m_y
     else
     begin
      m_drect.Right := round((r1.Right + r1.Left)/2);
      if (m_y > m_sy) then
       m_drect.Bottom := r1.Top
      else
      begin
       m_drect.Bottom := r1.Bottom
      end;
     end;
    end;
    if  ( a > pi + b) and (a <= 2*pi - b ) then
     //r_y
     begin
     m_drect.Bottom := r1.Top;
     if (m_y-m_sy <> 0) then
     m_drect.Right :=  round((m_x-m_sx)*(m_y-r1.Top)/-(m_y-m_sy)) + m_x;
    end;

    if  ( a > 2*pi -b) or (a <= b ) then
     //r_x
    begin
     m_drect.Right := r1.Left;
     if (abs(m_x-m_sx) > 3) then
     m_drect.Bottom :=  round(-(m_x-r1.Left)*(m_y-m_sy) /(m_x-m_sx)) + m_y
     else
     begin
      m_drect.Right := round((r1.Right + r1.Left)/2);
      if (m_y > m_sy) then
       m_drect.Bottom := r1.Top
      else
      begin
       m_drect.Bottom := r1.Bottom
       end;
     end;
    end;
    end;//if 0,0,0,0
    SetDRect := true;
end;

procedure TLink.Draw();
var
    l_x ,l_y : integer;
    t :trect;
begin
   if (m_selected = 3) then
     m_Canvas.Pen.Style := psDot
   else
     m_Canvas.Pen.Style := psSolid;
   m_Canvas.Pen.Color := m_color;

   t.Top:= m_sy;
   t.Left:= m_sx;
   t.Right := m_x;
   t.Bottom := m_y;

   m_sx := m_drect.Left;
   m_sy := m_drect.Top;
   m_x := m_drect.Right;
   m_y := m_drect.Bottom;

   m_Canvas.MoveTo( m_sx, m_sy);
   l_x := m_x;
   l_y := m_y;
   m_Canvas.LineTo( m_x,m_y);
{
   m_Canvas.MoveTo( m_sx,m_sy+2);
   m_Canvas.LineTo( m_x-3,m_y+2);
}
   if m_sx-m_x <> 0 then
   begin
       m_Canvas.MoveTo( l_x, l_y);
       if m_x - m_sx < 0 then
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
   end
   else
   begin
       m_Canvas.MoveTo( l_x, l_y);
       if m_y > m_sy then
        begin
        m_Canvas.LineTo(
        l_x + 5,
        l_y -10);
       m_Canvas.MoveTo( l_x, l_y );
       m_Canvas.LineTo(
        l_x - 5,
        l_y - 10);
        end
        else
        begin
       m_Canvas.LineTo(
        l_x + 5 ,
        l_y + 10 );
         m_Canvas.MoveTo( l_x, l_y );
       m_Canvas.LineTo(
        l_x -5,
        l_y + 10);
       end;

   end;
   if m_selected = 1 then
   begin
   m_Canvas.pen.color := clred  ;
   m_Canvas.Brush.Style := bssolid;
   m_Canvas.Brush.Color:=clgray;
   m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
   m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);
   m_Canvas.Brush.Color:= m_fillcolor;
   end;
   m_canvas.Font.Color := clOlive;
   m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*5,round((m_sy+m_y)/2) -5,m_desc);
   m_Canvas.Pen.Style := psSolid;
 {   m_sy:= t.Top;
    m_sx:= t.Left;
    m_x := t.Right;
    m_y := t.Bottom;
 }
 end;

procedure TLine.Draw();
var
    t :trect;
begin
   if (m_selected = 3) then
     m_Canvas.Pen.Style := psDot
   else
     m_Canvas.Pen.Style := psSolid;
   m_Canvas.Pen.Color := m_color;
   m_Canvas.Brush.Color:=m_fillcolor;
   t.Top:= m_sy;
   t.Left:= m_sx;
   t.Right := m_x;
   t.Bottom := m_y;

   m_sx := m_drect.Left;
   m_sy := m_drect.Top;
   m_x := m_drect.Right;
   m_y := m_drect.Bottom;

    m_Canvas.MoveTo( m_sx, m_sy );
    m_Canvas.LineTo( m_x,m_y);

   if m_selected = 1 then
   begin
   m_Canvas.pen.color := clred  ;
   m_Canvas.Brush.Style := bssolid;
   m_Canvas.Brush.Color:=clgray;
   m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
   m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);

   end;
   m_canvas.Font.Color := clOlive;
   m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*5,round((m_sy+m_y)/2) -5,m_desc);
   m_Canvas.Pen.Style := psSolid;
 {   m_sy:= t.Top;
    m_sx:= t.Left;
    m_x := t.Right;
    m_y := t.Bottom;
 }
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
  if m_dstyle = 1 then
    CommDraw
  else if  m_dstyle = 2 then
    EcllipseDraw
  else  if  m_dstyle = 3 then
    RoundDraw
  else  if  m_dstyle = 4 then
    ImageDraw
  else  if  m_dstyle = 5 then
    TextDraw;
end;

procedure TComm.CommDraw();
var
   l_ico :Ticon;
begin
   l_ico :=Ticon.Create;
//   l_ico.LoadFromFile('c:\earth.ico');
   if (m_selected = 3) then
     m_Canvas.Pen.Style := psDot
   else
     m_Canvas.Pen.Style := psSolid;
   m_Canvas.Brush.Color:=m_fillcolor;
   if m_shadow = 1 then
   begin
   m_Canvas.Pen.Color := TColor($E0E0E0) ;
   m_Canvas.Rectangle(m_sx+3,m_sy+3,m_x+3,m_y+3);
   m_Canvas.Pen.Color := TColor($B0B0B0) ;
   m_Canvas.Rectangle(m_sx+2,m_sy+2,m_x+2,m_y+2);
   m_Canvas.Pen.Color := TColor($808080) ;
   m_Canvas.Rectangle(m_sx+1,m_sy+1,m_x+1,m_y+1);
   end;
   m_Canvas.Pen.Color := m_color ;
   m_Canvas.Rectangle(m_sx,m_sy,m_x,m_y);
   if m_selected = 1 then
   begin
   m_Canvas.Pen.Color := clred  ;
   m_Canvas.Brush.Color:=clgray;
   m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
   m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);
   m_Canvas.Rectangle(m_sx-3,m_y-3,m_sx+3,m_y+3);
   m_Canvas.Rectangle(m_x-3,m_sy-3,m_x+3,m_sy+3);
   m_Canvas.Brush.Color := m_fillcolor;
   end;
   m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*3,round((m_sy+m_y)/2) -5,m_desc);
   m_Canvas.Pen.Style := psSolid;
   if not l_ico.Empty then
       m_Canvas.Draw(m_sx,m_sy,l_ico);
   l_ico.Free;
end;

procedure TComm.TextDraw();
var
   l_ico :Ticon;
begin
   l_ico :=Ticon.Create;
//   l_ico.LoadFromFile('c:\earth.ico');
   if (m_selected = 3) then
     m_Canvas.Pen.Style := psDot
   else
     m_Canvas.Pen.Style := psSolid;
   m_Canvas.Brush.Color:=m_fillcolor;
{   if m_shadow = 1 then
   begin
   m_Canvas.Pen.Color := TColor($E0E0E0) ;
   m_Canvas.Rectangle(m_sx+3,m_sy+3,m_x+3,m_y+3);
   m_Canvas.Pen.Color := TColor($B0B0B0) ;
   m_Canvas.Rectangle(m_sx+2,m_sy+2,m_x+2,m_y+2);
   m_Canvas.Pen.Color := TColor($808080) ;
   m_Canvas.Rectangle(m_sx+1,m_sy+1,m_x+1,m_y+1);
   end;
   m_Canvas.Pen.Color := m_color ;
   m_Canvas.Rectangle(m_sx,m_sy,m_x,m_y);
}
   if m_selected = 1 then
   begin
   m_Canvas.Pen.Color := clred  ;
   m_Canvas.Brush.Color:=clgray;
   m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
   m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);
   m_Canvas.Rectangle(m_sx-3,m_y-3,m_sx+3,m_y+3);
   m_Canvas.Rectangle(m_x-3,m_sy-3,m_x+3,m_sy+3);
   
   m_Canvas.Brush.Color := m_fillcolor;
   end;

   m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*3,round((m_sy+m_y)/2) -5,m_desc);
   m_Canvas.Pen.Style := psSolid;
   if not l_ico.Empty then
       m_Canvas.Draw(m_sx,m_sy,l_ico);
   l_ico.Free;
end;


procedure TComm.EcllipseDraw();
var
   l_ico :Ticon;
begin
   l_ico :=Ticon.Create;
//   l_ico.LoadFromFile('c:\earth.ico');
   if (m_selected = 3) then
     m_Canvas.Pen.Style := psDot
   else
     m_Canvas.Pen.Style := psSolid;
   m_Canvas.Brush.Color:=m_fillcolor;
   if m_shadow = 1 then
   begin
   m_Canvas.Pen.Color := TColor($E0E0E0) ;
   m_Canvas.Ellipse(m_sx+3,m_sy+3,m_x+3,m_y+3);
   m_Canvas.Pen.Color := TColor($B0B0B0) ;
   m_Canvas.Ellipse(m_sx+2,m_sy+2,m_x+2,m_y+2);
   m_Canvas.Pen.Color := TColor($808080) ;
   m_Canvas.Ellipse(m_sx+1,m_sy+1,m_x+1,m_y+1);
   end;
   m_Canvas.Pen.Color := m_color ;
   m_Canvas.Ellipse(m_sx,m_sy,m_x,m_y);
   if m_selected = 1 then
   begin
   m_Canvas.Pen.Color := clred  ;
   m_Canvas.Brush.Color:=clgray;
   m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
   m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);
   m_Canvas.Rectangle(m_sx-3,m_y-3,m_sx+3,m_y+3);
   m_Canvas.Rectangle(m_x-3,m_sy-3,m_x+3,m_sy+3);
   
   m_Canvas.Brush.Color := m_fillcolor;
   end;
   m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*3,round((m_sy+m_y)/2) -5,m_desc);
   m_Canvas.Pen.Style := psSolid;
   if not l_ico.Empty then
       m_Canvas.Draw(m_sx,m_sy,l_ico);
   l_ico.Free;
end;

procedure TComm.RoundDraw();
var
   l_ico :Ticon;
begin
   l_ico :=Ticon.Create;
//   l_ico.LoadFromFile('c:\earth.ico');
   if (m_selected = 3) then
     m_Canvas.Pen.Style := psDot
   else
     m_Canvas.Pen.Style := psSolid;
   m_Canvas.Brush.Color:=m_fillcolor;
   if m_shadow = 1 then
   begin
   m_Canvas.Pen.Color := TColor($E0E0E0) ;
   m_Canvas.RoundRect(m_sx+3,m_sy+3,m_x+3,m_y+3,(m_x-m_sx) div 3,m_y-m_sy );
   m_Canvas.Pen.Color := TColor($B0B0B0) ;
   m_Canvas.RoundRect(m_sx+2,m_sy+2,m_x+2,m_y+2,(m_x-m_sx) div 3,m_y-m_sy );
   m_Canvas.Pen.Color := TColor($808080) ;
   m_Canvas.RoundRect(m_sx+1,m_sy+1,m_x+1,m_y+1,(m_x-m_sx) div 3,m_y-m_sy );
   end;
   m_Canvas.Pen.Color := m_color ;
   m_Canvas.RoundRect(m_sx,m_sy,m_x,m_y,(m_x-m_sx) div 3,m_y-m_sy );
   if m_selected = 1 then
   begin
   m_Canvas.Pen.Color := clred  ;
   m_Canvas.Brush.Color:=clgray;
   m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
   m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);
   m_Canvas.Rectangle(m_sx-3,m_y-3,m_sx+3,m_y+3);
   m_Canvas.Rectangle(m_x-3,m_sy-3,m_x+3,m_sy+3);
   
   m_Canvas.Brush.Color := m_fillcolor;
   end;
   m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*3,round((m_sy+m_y)/2) -5,m_desc);
   m_Canvas.Pen.Style := psSolid;
   if not l_ico.Empty then
       m_Canvas.Draw(m_sx,m_sy,l_ico);
   l_ico.Free;
end;

procedure TComm.ImageDraw();
var
   l_ico :Ticon;
begin
   l_ico :=Ticon.Create;
   l_ico.LoadFromFile('c:\earth.ico');
    if m_selected > 0 then
    begin
    m_Canvas.Pen.Color := clblue;
    m_Canvas.Pen.Style := psDot;
    m_Canvas.Rectangle(m_sx,m_sy,m_x,m_y);
    m_Canvas.Pen.Color := clred;
    m_Canvas.Brush.Color:=clgray;
    m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
    m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);
   m_Canvas.Rectangle(m_sx-3,m_y-3,m_sx+3,m_y+3);
   m_Canvas.Rectangle(m_x-3,m_sy-3,m_x+3,m_sy+3);
    
    end;
    m_Canvas.Brush.Color := clwhite;
    m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*3,round(m_y + 10 ),m_desc);
    m_Canvas.Pen.Style := psSolid;
    if not l_ico.Empty then
        m_Canvas.Draw(m_sx,m_sy,l_ico);
    l_ico.Free;
end;

function TComm.Ptin(x:integer;y:integer):bool ;
var
   rect,r2,r1,r3,r4:Trect;
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
   r2.Left :=m_x-3;
   r2.Right :=m_x+3;
   r2.Top:= m_y-3;
   r2.Bottom:=m_y+3;

   r1.Left :=m_sx-3;
   r1.Right :=m_sx+3;
   r1.Top:= m_sy-3;
   r1.Bottom:=m_sy+3;

   r3.Left := m_sx -3;
   r3.Right := m_sx +3;
   r3.Top := m_y -3;
   r3.Bottom := m_y +3;

   r4.Left := m_x -3;
   r4.Right := m_x +3;
   r4.Top := m_sy -3;
   r4.Bottom := m_sy +3;

   ptin:= ptinrect(rect,point)
   or ptinrect(r2,point) or ptinrect(r1,point)
   or ptinrect(r4,point) or ptinrect(r3,point);
end;

constructor TTABLE.Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
begin
     inherited Create(can,sx,sy,x,y);
      m_color := cllime;
     m_data := TStringlist.Create;
     m_data.Add('aaaa  aaaa');
     m_data.Add('bbbb bbbbb');
     m_data.Add('ccccc cccc');
     m_data.Add('FFFFFF FFFF');

end;

procedure TTABLE.Draw();
var
  i :integer;
begin

   if (m_selected = 3) then
     m_Canvas.Pen.Style := psDot
   else
     m_Canvas.Pen.Style := psSolid;
   m_Canvas.Brush.Color:=m_fillcolor;
   if m_shadow = 1 then
   begin
   m_Canvas.Pen.Color := TColor($E0E0E0) ;
   m_Canvas.Rectangle(m_sx+3,m_sy+3,m_x+3,m_y+3);
   m_Canvas.Pen.Color := TColor($B0B0B0) ;
   m_Canvas.Rectangle(m_sx+2,m_sy+2,m_x+2,m_y+2);
   m_Canvas.Pen.Color := TColor($808080) ;
   m_Canvas.Rectangle(m_sx+1,m_sy+1,m_x+1,m_y+1);
   end;
   m_Canvas.Pen.Color := m_color ;
   m_Canvas.Rectangle(m_sx,m_sy,m_x,m_y);
   if m_selected = 1 then
   begin
   m_Canvas.Pen.Color := clred  ;
   m_Canvas.Brush.Color:=clgray;
   m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
   m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);
   m_Canvas.Rectangle(m_sx-3,m_y-3,m_sx+3,m_y+3);
   m_Canvas.Rectangle(m_x-3,m_sy-3,m_x+3,m_sy+3);
   
   m_Canvas.Brush.Color:=m_fillcolor;
   end;
   m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*3,m_sy+1,m_desc);
 //  for i := 0 to m_data.Count - 1 do
   i:= 0;
   repeat
   begin
       m_Canvas.Pen.Color := m_color ;
       if ( m_sy+ 14 + 20*i+20 <= m_y -20)  then
       begin
       m_Canvas.TextOut(m_sx+4,m_sy+ 14 + 20*i +3,m_data[i]);
       m_Canvas.MoveTo(m_sx+4,m_sy+ 14 + 20*i+20 );
       m_Canvas.LineTo(m_sx+4 + m_x - m_sx -10 ,m_sy+ 14 + 20*i+20 );
       end
       else
       begin
       m_Canvas.TextOut(m_sx+4,m_sy+ 14 + 20*i +3,'... ');
       break;
       end;
       inc(i);
   end;
   until (i > m_data.Count - 1 );
   m_Canvas.Pen.Style := psSolid;
end;

procedure TIF.Draw();
begin

   m_Canvas.Pen.Style := psSolid;
   m_Canvas.Brush.Color:=m_fillcolor;
{   if m_shadow = 1 then
   begin
   m_Canvas.Pen.Color := TColor($E0E0E0) ;
   m_Canvas.Rectangle(m_sx+3,m_sy+3,m_x+3,m_y+3);
   m_Canvas.Pen.Color := TColor($B0B0B0) ;
   m_Canvas.Rectangle(m_sx+2,m_sy+2,m_x+2,m_y+2);
   m_Canvas.Pen.Color := TColor($808080) ;
   m_Canvas.Rectangle(m_sx+1,m_sy+1,m_x+1,m_y+1);
   m_Canvas.Brush.Color:=m_fillcolor;
   end;
}
   m_Canvas.Pen.Color := m_color ;
   m_canvas.MoveTo(round((m_sx+m_x)/2),m_sy);
   m_canvas.LineTo(m_sx,round((m_sy+m_y)/2));
   m_canvas.LineTo(round((m_sx+m_x)/2),m_y);
   m_canvas.LineTo(m_x,round((m_sy+m_y)/2));
   m_canvas.LineTo(round((m_sx+m_x)/2),m_sy);
   m_canvas.FloodFill(round((m_sx+m_x)/2),round((m_sy+m_y)/2),
   m_color,fsBorder);

   if (m_selected = 3) then
   begin
     m_Canvas.Pen.Style := psDot;
     m_Canvas.Pen.Color := m_color ;
     m_canvas.MoveTo(round((m_sx+m_x)/2),m_sy);
     m_canvas.LineTo(m_sx,round((m_sy+m_y)/2));
     m_canvas.LineTo(round((m_sx+m_x)/2),m_y);
     m_canvas.LineTo(m_x,round((m_sy+m_y)/2));
     m_canvas.LineTo(round((m_sx+m_x)/2),m_sy);
   end;
//   m_Canvas.Rectangle(m_sx,m_sy,m_x,m_y);
   if m_selected = 1 then
   begin
   m_Canvas.Pen.Color := clred  ;
   m_Canvas.Brush.Color:=clgray;
   m_Canvas.Rectangle(m_x-3,m_y-3,m_x+3,m_y+3);
   m_Canvas.Rectangle(m_sx-3,m_sy-3,m_sx+3,m_sy+3);
   m_Canvas.Rectangle(m_sx-3,m_y-3,m_sx+3,m_y+3);
   m_Canvas.Rectangle(m_x-3,m_sy-3,m_x+3,m_sy+3);
   
   m_Canvas.Brush.Color:=m_fillcolor;
   end;
   m_canvas.TextOut(round((m_sx+m_x)/2)- length(m_desc)*3,round((m_sy+m_y)/2) -5,m_desc);
   m_Canvas.Pen.Style := psSolid;
end;

function TTABLE.Ptin(x:integer;y:integer):bool ;
var
   rect,r,r1,r3,r4:Trect;
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

     r3.Left := m_sx -3;
   r3.Right := m_sx +3;
   r3.Top := m_y -3;
   r3.Bottom := m_y +3;

   r4.Left := m_x -3;
   r4.Right := m_x +3;
   r4.Top := m_sy -3;
   r4.Bottom := m_sy +3;

   ptin:= ptinrect(rect,point) or ptinrect(r,point) or ptinrect(r1,point);
end;


constructor TIF.Create(can:ptobj;sx: integer;sy :integer; x: integer; y :integer);
begin
     inherited ;
     m_color:=clblue;
end;

function TIF.Ptin(x:integer;y:integer):bool ;
var
   rect,r,r1,r3,r4:Trect;
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

   r3.Left := m_sx -3;
   r3.Right := m_sx +3;
   r3.Top := m_y -3;
   r3.Bottom := m_y +3;

   r4.Left := m_x -3;
   r4.Right := m_x +3;
   r4.Top := m_sy -3;
   r4.Bottom := m_sy +3;

   ptin:= ptinrect(rect,point) or ptinrect(r,point) or ptinrect(r1,point);
end;

procedure TComm.ResizeXY(x:integer;y:integer);
begin
  if m_dstyle <> 4 then
  inherited ResizeXY(x,y);
 {  else
  begin
 
    if self.ClassName = 'TLink' then
    begin
     if (m_resizenode = 1 ) then
       begin  m_x := x;m_y := y; end
     else
       begin  m_sx := x; m_sy := y end;
    end
    else
    // 对象resize大小的限制
    if (m_resizenode = 1 ) then
    begin
       if (x > m_sx + 40)then m_x := x ;
    end
    else
    begin
       if (x < m_x - 40) then m_sx := x;
    end;
    end;
   }

    end;
end.
