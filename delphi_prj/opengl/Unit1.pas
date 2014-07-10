unit Unit1;

interface

uses
  Windows, Forms, OpenGL, Classes, ExtCtrls, Messages,Graphics, Controls,SysUtils;

type
  TMainForm = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cube();
    procedure wall();
    procedure FormPaint(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    RC    : HGLRC;
    Angle : double;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  end;

var
  MainForm: TMainForm;
 bmp:tbitmap;
 m_x,m_y,m_z,m_r :single;
 m_rx,m_ry,m_rz:single;
 m_po,m_pn:tpoint;
  m_e,m_c,m_u :single;
  m_msg :string;
  m_mt :string;
implementation

uses Dialogs;

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
var i :integer;
begin // initialize OpenGL and create a context for rendering
  RC:=CreateRenderingContext(Canvas.Handle,[opDoubleBuffered],32,0);
     bmp := TBitmap.create();
 //    bmp.LoadFromFile('c:\\earth.bmp');
     m_x := 0;   m_y := 0;m_z := 0;  m_r := 0;
     m_rx :=0;     m_ry :=0;     m_rz :=0;
     m_e:=1;m_c:=0;m_u:=1;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin // destroy the rendering context
  DestroyRenderingContext(RC);
  bmp.Free;
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin // draw somthing useful
  ActivateRenderingContext(Canvas.Handle,RC); // make context drawable
  glClearColor(0.1,0.1,0.2, 0.5); // background color of the context
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // clear background and depth buffer
//glMatrixMode(GL_MODELVIEW); // activate the transformation matrix
  glMatrixMode(GL_MODELVIEW); // activate the transformation matrix
  glLoadIdentity;             // set it to initial state
//  gluLookAt(5+angle/10*3,-3,6,0,0,0,0,1,0); // set up a viewer position and view point
  gluLookAt(5,4,0,1*m_c,1*m_c,1*m_c,0,0.2,0); // set up a viewer position and view point
//glTranslatef((angle-360)/30,0,0);

   glTranslatef(0,m_y,m_z);
//   glRotatef(2*Angle,4*angle,4*angle,4*angle); // do rotation around axis (x:0;y:1;z:0)
//    glRotatef(20*m_x,40*m_x,60*m_y,80*m_z); // do rotation around axis (x:0;y:1;z:0)
// if m_msg ='x' then  glRotatef(15*m_rx,1*m_rx,0,0); // do rotation around axis (x:0;y:1;z:0)

    glRotatef(15*m_rx,1,0,0);
    glRotatef(15*m_ry,0,1,0);
    glRotatef(15*m_rz,0,0,1);
//   glRotatef(15,1*m_rx,1*m_ry,1*m_rz);
 //if m_msg ='y' then  glRotatef(m_ry*15,0,1,0); // do rotation around axis (x:0;y:1;z:0)
 //if m_msg ='z' then  glRotatef(m_rz*15,0,0,1); // do rotation around axis (x:0;y:1;z:0)
  //  glRotatef(10,1,1,0);      // do another rotation for better view (accumulates to first rot.)
//  glScalef(sin(Angle*pi/90),sin(Angle*pi/90),sin(Angle*pi/90)); // simulate bumping
    glEnable(GL_DEPTH_TEST); // enable depth testing
//     glBitmap(32,32,1,1,0,0,0);
//     glBitmap(32,32,1,1,0,0,bmp.ScanLine[0]);
  glpushMatrix();
    glTranslatef(1,1,1);
   wall();

 glPopMatrix();

   cube();

  m_msg := '';
  SwapBuffers(Canvas.Handle); // copy back buffer to front
  DeactivateRenderingContext; // release control of context
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Application.Terminate;
  if Key = 'd' then m_z := m_z - 0.5;
  if Key = 'a' then m_z := m_z + 0.5;
  if Key = 'w' then m_x := m_x - 0.5;
  if Key = 's' then m_x := m_x + 0.5;
  if Key = 'q' then m_y := m_y - 0.5;
  if Key = 'e' then m_y := m_y + 0.5;
  if Key = 'z' then m_e := m_e - 0.1;
  if Key = 'c' then m_e := m_e + 0.1;

  if Key = 'r' then  begin m_rx:= m_rx + 0.5; m_msg := 'x' end;
  if Key = 't' then  begin m_ry:= m_ry + 0.5; m_msg := 'y' end;
  if Key = 'y' then  begin m_rz:= m_rz + 0.5; m_msg := 'z' end;
  Refresh;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin // handle form resizing (viewport must be adjusted)
  wglMakeCurrent(Canvas.handle,RC); // another way to make context drawable
  glViewport(0,0,Width,Height); // specify a viewport (has not necessarily to be the entire window)
  glMatrixMode(GL_PROJECTION); // activate projection matrix
  glLoadIdentity;              // set initial state
  gluPerspective(40,Width/Height,1,100); // specify perspective params (see OpenGL.hlp)
  wglMakeCurrent(0,0); // another way to release control of context
  Refresh;             // cause redraw
end;

procedure TMainForm.wall();
begin
 { glBegin(GL_TRIANGLE_FAN); // draw a tetrahedron
    glColor3f(1,1,1);       // color of the upper vertex
    glVertex3f(0,-1,0);      // coordinates of the upper vertex (= center of the fan)
    glColor3f(1,0,0);       // color left-front vertex
    glVertex3f(-1,0,1);     // coordinates of the left-front vertex
    glColor3f(0,1,0);       // right-front
    glVertex3f(1,0,1);      // right-front
    glColor3f(0,0,1);       // middle-back
    glVertex3f(0,0,-1);     // middle-back
    glColor3f(1,0,0);       // left-front again (close fan)
    glVertex3f(-1,0,1);     // left-front
  glEnd;                    // finish triangle fan
 glBegin(GL_TRIANGLE_FAN); // draw a tetrahedron
    glColor3f(1,1,1);       // color of the upper vertex
    glVertex3f(0,1,0);      // coordinates of the upper vertex (= center of the fan)
    glColor3f(1,0,0);       // color left-front vertex
    glVertex3f(1,0,-1);     // coordinates of the left-front vertex
    glColor3f(0,1,0);       // right-front
    glVertex3f(-1,0,-1);    // right-front
    glColor3f(0,0,1);       // middle-back
    glVertex3f(0,0,1);      // middle-back
    glColor3f(1,0,0);       // left-front again (close fan)
    glVertex3f(1,0,-1);     // left-front
  glEnd;}

{  glBegin(GL_TRIANGLE_FAN); // draw a tetrahedron
    glColor3f(1,1,1);       // color of the upper vertex
    glVertex3f(0,0,0);      // coordinates of the upper vertex (= center of the fan)
    glColor3f(1,0,0);       // color left-front vertex
    glVertex3f(0,1,0);      // coordinates of the left-front vertex
    glColor3f(0,1,0);       // right-front
    glVertex3f(1,1,0);      // right-front
    glColor3f(0,0,1);       // middle-back
    glVertex3f(1,0,0);      // middle-back
    glColor3f(1,0,0);       // left-front again (close fan)
    glVertex3f(0,0,0);      // left-front
  glEnd;
  }
  glBegin(GL_TRIANGLE_FAN); // draw a tetrahedron
    glColor3f(1,0,1);       // color of the upper vertex
    glVertex3f(0,0,1);      // coordinates of the upper vertex (= center of the fan)
    glColor3f(1,0,0);       // color left-front vertex
    glVertex3f(0,0,-1);      // coordinates of the left-front vertex
    glColor3f(0,1,0);       // right-front
    glVertex3f(1,1,-1);      // right-front
    glColor3f(0,0,1);       // middle-back
    glVertex3f(1,1,1);      // middle-back
  glEnd;
end;

procedure TMainForm.cube();
begin
  glBegin(GL_QUADS);                   // ����������
glNormal3f( 0.0, 0.0, 1.0); // ����ָ��۲���
{

�Ȼ�������Ķ��档����������һ��λ��ע��Y����ʼ��Ϊһ��λ����ʾ����ı�����Z��ƽ�С��Ȼ����϶��㣬����һ��λ������Ļ����һ��λ��Ȼ�����϶��㣬����һ��λ������Ļ����һ��λ��Ȼ���ǿ����۲��ߵ����º����¶��㡣������Ļ����һ��λ��

}
   glColor3f(0.0, 1.0, 0.0);            // ��ɫ��Ϊ��ɫ
   glVertex3f(1.0, 1.0, -1.0);          // �ı��ε����϶��� (����)
   glVertex3f(-1.0, 1.0, -1.0);         // �ı��ε����϶��� (����)
   glColor3f(0.0, 1.0, 1.0);
   glVertex3f(-1.0, 1.0, 1.0);          // �ı��ε����¶��� (����)
   glVertex3f(1.0, 1.0, 1.0);           // �ı��ε����¶��� (����)

{

����Ļ����Ͷ���ʮ�����ơ�ֻ��Y�������ˣ�1��������Ǵ����������������������Ļ�������ע�⵽���Ͻ���۲����������������Ȼ���۲�������Ķ��㡣Ȼ�������϶�����������Ļ��������º����¶��㡣

�������Ĳ��ں����ƶ���εĴ���(˳ʱ�������ʱ��)�Ļ���������ֱ�ӿ�������Ĵ��룬��Y�����1�ĳ� -1��Ҳ�ܹ���������һ��������������ӳ������������ʱ�����Ի��ƴ���ᵼ��ʮ�ֹ���Ľ����

}

   glColor3f(1.0, 0.5, 0.0);            // ��ɫ�ĳɳ�ɫ
   glVertex3f(1.0, -1.0, 1.0);          // �ı��ε����϶���(����)
   glVertex3f(-1.0, -1.0, 1.0);         // �ı��ε����϶���(����)
   glColor3f(1.0, 0.0, 1.0);
   glVertex3f(-1.0, -1.0, -1.0);        // �ı��ε����¶���(����)
   glVertex3f(1.0, -1.0, -1.0);         // �ı��ε����¶���(����)
{
���Ż��������ǰ�档����Z����Ϊһ��λ��ǰ�����������ǡ�
}

   glColor3f(1.0, 1.0, 0.0);            // ��ɫ�ĳɺ�ɫ
   glVertex3f(1.0, 1.0, 1.0);           // �ı��ε����϶���(ǰ��)
   glVertex3f(-1.0, 1.0, 1.0);          // �ı��ε����϶���(ǰ��)

   glColor3f(0.0, 0.5, 0.5);
   glVertex3f(-1.0, -1.0, 1.0);         // �ı��ε����¶���(ǰ��)
   glVertex3f(1.0, -1.0, 1.0);          // �ı��ε����¶���(ǰ��)
{
���������Ļ��Ʒ�����ǰ�����ơ�ֻ��λ����Ļ�����档ע��Z�������ڱ��� -1 ���䡣
}
   glColor3f(1.0, 0.5, 0.0);            // ��ɫ�ĳɻ�ɫ
   glVertex3f(1.0, -1.0, -1.0);         // �ı��ε����϶���(����)
   glVertex3f(-1.0, -1.0, -1.0);        // �ı��ε����϶���(����)
   glColor3f(0.5, 1.0, 0.5);
   glVertex3f(-1.0, 1.0, -1.0);         // �ı��ε����¶���(����)
   glVertex3f(1.0, 1.0, -1.0);          // �ı��ε����¶���(����)
{
��ʣ�����������ˡ�����ע�⵽����һ�����걣�ֲ��䡣��һ�λ�����X���ꡣ��Ϊ�����ڻ�����档
}

   glColor3f(0.5, 0.5, 1.0);            // ��ɫ�ĳ���ɫ
   glVertex3f(-1.0, 1.0, 1.0);          // �ı��ε����϶���(����)
   glVertex3f(-1.0, 1.0, -1.0);         // �ı��ε����϶���(����)
   glColor3f(0.5, 1.0, 0.5);
   glVertex3f(-1.0, -1.0, -1.0);        // �ı��ε����¶���(����)
   glVertex3f(-1.0, -1.0, 1.0);         // �ı��ε����¶���(����)

{
����������һ�����ˡ�X���걣��Ϊһ��λ����ʱ����ơ���Ը��Ļ�����������治��Ҳ���ԣ���������һ������:)
������Ҫ������Ȥ���Ըı����������ж����ɫ��ֵ������������������ɫ�����ῴ��һ���ǳ�Ư���Ĳ�ɫ�����壬������ɫ�����ĸ����������ʡ�
}
   glColor3f(0.8, 0.6, 1.0);            // ��ɫ�ĳ�������ɫ
   glVertex3f(1.0, 1.0, -1.0);          // �ı��ε����϶���(����)
   glVertex3f(1.0, 1.0, 1.0);           // �ı��ε����϶���(����)
   glColor3f(0.8, 0.0, 1.0);            // ��ɫ�ĳ�������ɫ
   glVertex3f(1.0, -1.0, 1.0);          // �ı��ε����¶���(����)
   glVertex3f(1.0, -1.0, -1.0);         // �ı��ε����¶���(����)
   glEnd();
end;
procedure TMainForm.Timer1Timer(Sender: TObject);
begin // do some animation
  Angle := angle + 0.08;
  if Angle >= 360 then Angle:=0;
  Repaint;
end;

procedure TMainForm.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin // avoid clearing the background (causes flickering and speed penalty)
    Message.Result:=1;
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if m_mt = 'up' then
  begin
     m_po.X := x;
     m_po.y := y;
  end;
  m_mt := 'down';
end;

procedure TMainForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
m_mt := 'up';
m_po.X := x;
m_po.y := y;
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if m_mt = 'down' then
   begin
      m_pn.X := x;
      m_pn.y := y;
    if (m_pn.x <> m_po.x) or (m_pn.y <> m_po.y) then
     begin
    m_rx := m_rx +  (m_pn.X - m_po.X)/100;


    m_rz := m_rz - cos(m_rx)*(m_pn.y - m_po.y)/100;
    m_ry := m_ry - sin(m_rx)*(m_pn.y - m_po.y)/100;
    {
    if ( abs(round(15*m_rx) mod 360 )> 315) or
       ( abs(round(15*m_rx) mod 360 ) < 45 )then
      m_rz := m_rx + (m_pn.y - m_po.y)/100;

    if  (abs(round(15*m_rx) mod 360 )> 45 ) and
        (abs(round(15*m_rx) mod 360 )<  135 )then
      m_ry := m_ry - (m_pn.y - m_po.y)/100;

     if (abs(round(15*m_rx) mod 360 )> 135 )and
        (abs(round(15*m_rx) mod 360 )< 225 )then
      m_rz := m_rz + (m_pn.y - m_po.y)/100;

    if  (abs(round(15*m_rx) mod 360 )> 225 )and
        (abs(round(15*m_rx) mod 360 )<  315 )then
      m_ry := m_ry - (m_pn.y - m_po.y)/100;
     }



     m_po.X := m_pn.X;
     m_po.y := m_pn.y;
    end;
    caption := currtostr(15*m_rx)+':'+ currtostr(m_ry*15);
    repaint;
   end;
end;

end.

