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
  glBegin(GL_QUADS);                   // 绘制正方形
glNormal3f( 0.0, 0.0, 1.0); // 法线指向观察者
{

先画立方体的顶面。从中心上移一单位，注意Y坐标始终为一单位，表示这个四边形与Z轴平行。先画右上顶点，向右一单位，再屏幕向里一单位。然后左上顶点，向左一单位，再屏幕向里一单位。然后是靠近观察者的左下和右下顶点。就是屏幕往外一单位。

}
   glColor3f(0.0, 1.0, 0.0);            // 颜色改为蓝色
   glVertex3f(1.0, 1.0, -1.0);          // 四边形的右上顶点 (顶面)
   glVertex3f(-1.0, 1.0, -1.0);         // 四边形的左上顶点 (顶面)
   glColor3f(0.0, 1.0, 1.0);
   glVertex3f(-1.0, 1.0, 1.0);          // 四边形的左下顶点 (顶面)
   glVertex3f(1.0, 1.0, 1.0);           // 四边形的右下顶点 (顶面)

{

底面的画法和顶面十分类似。只是Y坐标变成了－1。如果我们从立方体的下面来看立方体的话，您会注意到右上角离观察者最近，因此我们先画离观察者最近的顶点。然后是左上顶点最后才是屏幕里面的左下和右下顶点。

如果您真的不在乎绘制多边形的次序(顺时针或者逆时针)的话，您可以直接拷贝顶面的代码，将Y坐标从1改成 -1，也能够工作。但一旦您进入象纹理映射这样的领域时，忽略绘制次序会导致十分怪异的结果。

}

   glColor3f(1.0, 0.5, 0.0);            // 颜色改成橙色
   glVertex3f(1.0, -1.0, 1.0);          // 四边形的右上顶点(底面)
   glVertex3f(-1.0, -1.0, 1.0);         // 四边形的左上顶点(底面)
   glColor3f(1.0, 0.0, 1.0);
   glVertex3f(-1.0, -1.0, -1.0);        // 四边形的左下顶点(底面)
   glVertex3f(1.0, -1.0, -1.0);         // 四边形的右下顶点(底面)
{
接着画立方体的前面。保持Z坐标为一单位，前面正对着我们。
}

   glColor3f(1.0, 1.0, 0.0);            // 颜色改成红色
   glVertex3f(1.0, 1.0, 1.0);           // 四边形的右上顶点(前面)
   glVertex3f(-1.0, 1.0, 1.0);          // 四边形的左上顶点(前面)

   glColor3f(0.0, 0.5, 0.5);
   glVertex3f(-1.0, -1.0, 1.0);         // 四边形的左下顶点(前面)
   glVertex3f(1.0, -1.0, 1.0);          // 四边形的右下顶点(前面)
{
立方体后面的绘制方法与前面类似。只是位于屏幕的里面。注意Z坐标现在保持 -1 不变。
}
   glColor3f(1.0, 0.5, 0.0);            // 颜色改成黄色
   glVertex3f(1.0, -1.0, -1.0);         // 四边形的右上顶点(后面)
   glVertex3f(-1.0, -1.0, -1.0);        // 四边形的左上顶点(后面)
   glColor3f(0.5, 1.0, 0.5);
   glVertex3f(-1.0, 1.0, -1.0);         // 四边形的左下顶点(后面)
   glVertex3f(1.0, 1.0, -1.0);          // 四边形的右下顶点(后面)
{
还剩两个面就完成了。您会注意到总有一个坐标保持不变。这一次换成了X坐标。因为我们在画左侧面。
}

   glColor3f(0.5, 0.5, 1.0);            // 颜色改成蓝色
   glVertex3f(-1.0, 1.0, 1.0);          // 四边形的右上顶点(左面)
   glVertex3f(-1.0, 1.0, -1.0);         // 四边形的左上顶点(左面)
   glColor3f(0.5, 1.0, 0.5);
   glVertex3f(-1.0, -1.0, -1.0);        // 四边形的左下顶点(左面)
   glVertex3f(-1.0, -1.0, 1.0);         // 四边形的右下顶点(左面)

{
立方体的最后一个面了。X坐标保持为一单位。逆时针绘制。您愿意的话，留着这个面不画也可以，这样就是一个盒子:)
或者您要是有兴趣可以改变立方体所有顶点的色彩值，象金字塔那样混合颜色。您会看见一个非常漂亮的彩色立方体，各种颜色在它的各个表面流淌。
}
   glColor3f(0.8, 0.6, 1.0);            // 颜色改成紫罗兰色
   glVertex3f(1.0, 1.0, -1.0);          // 四边形的右上顶点(右面)
   glVertex3f(1.0, 1.0, 1.0);           // 四边形的左上顶点(右面)
   glColor3f(0.8, 0.0, 1.0);            // 颜色改成紫罗兰色
   glVertex3f(1.0, -1.0, 1.0);          // 四边形的左下顶点(右面)
   glVertex3f(1.0, -1.0, -1.0);         // 四边形的右下顶点(右面)
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

