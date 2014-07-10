unit mine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

  const mine_x :integer = 29;
  const mine_y :integer = 15;
  const CELL_H : integer = 16;
  const CELL_W : integer = 16;
type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure mineit(m,n:integer);
    function getminenum(m,n:integer):Integer;
    function getaroundmine(m,n:integer):Integer;
    function getaroundunknow(m,n:integer):Integer;
    procedure markaround(m,n:integer);
    procedure clickaround(m,n:integer);

  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  m_hd : HWnd;
  m_dc : HDC;
  m_run : integer;
  m_change: integer;
  m_mineary : array[0..29,0..15] of integer;
  // -1 :unknow
  // 0 : mine
  // 1..7 : mines round it;
  //  9 : already mine round;
  m_rect :Trect;  
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var t,m,n :integer;

begin
    m_hd:= findwindow('É¨À×','É¨À×');
    m_run := 1;
    if m_hd < 1 then
    begin
	application.MessageBox('ÏÈÔËÐÐÉ¨À×³ÌÐò£¡'+#13#10+#13#10+'launch mine first!','info');
	exit;
    end;

    GetWindowRect(m_hd,m_rect);
    m_dc := getwindowdc(m_hd);

    for m :=0 to 29 do
      for n := 0 to 15 do
       m_mineary[m,n] := -1;
       
    // while m_run=1 do
    for t := 0 to 30 do
     begin
       m_change :=0;
      for m :=0 to 29 do
        for n := 0 to 15 do
        begin
            mineit(m,n);
            application.ProcessMessages;
        end;      
  {    if  m_change = 0 then
       if(application.MessageBox('need help!','info',MB_RETRYCANCEL) <> IDRETRY ) then
       break;
   }
      end;

end;

procedure TForm1.mineit(m,n:integer);
var aroundmines   ,unknowmines:integer;
begin
    if  m_mineary[m,n] = -1 then
    begin
        getminenum(m,n);
    end;

    if (m_mineary[m,n] > 7) or(m_mineary[m,n] < 1)  then
        exit ;
        
    aroundmines:= 0;
    unknowmines:= 0;

    aroundmines := aroundmines +getaroundmine(m+1,n+1);
    aroundmines := aroundmines +getaroundmine(m+1,n);
    aroundmines := aroundmines +getaroundmine(m+1,n-1);
    aroundmines := aroundmines +getaroundmine(m,n+1);
    aroundmines := aroundmines +getaroundmine(m,n-1);
    aroundmines := aroundmines +getaroundmine(m-1,n+1);
    aroundmines := aroundmines +getaroundmine(m-1,n);
    aroundmines := aroundmines +getaroundmine(m-1,n-1);
    
    unknowmines := unknowmines+ getaroundunknow(m+1,n+1);
    unknowmines := unknowmines+ getaroundunknow(m+1,n);
    unknowmines := unknowmines+ getaroundunknow(m+1,n-1);
    unknowmines := unknowmines+ getaroundunknow(m,n+1);
    unknowmines := unknowmines+ getaroundunknow(m,n-1);
    unknowmines := unknowmines+ getaroundunknow(m-1,n+1);
    unknowmines := unknowmines+ getaroundunknow(m-1,n);
    unknowmines := unknowmines+ getaroundunknow(m-1,n-1);
            
    if unknowmines <> 0 then
    begin
        if   aroundmines + unknowmines = m_mineary[m,n] then
        begin
             markaround(m+1,n-1);
             markaround(m+1,n);
             markaround(m+1,n+1);
             markaround(m,n-1);
             markaround(m,n+1);
             markaround(m-1,n-1);
             markaround(m-1,n);
             markaround(m-1,n+1);
             m_mineary[m,n] := 9;
             m_change := 1;
        end;

        if   aroundmines = m_mineary[m,n] then
        begin
             clickaround(m+1,n-1);
             clickaround(m+1,n);
             clickaround(m+1,n+1);
             clickaround(m,n-1);
             clickaround(m,n+1);
             clickaround(m-1,n-1);
             clickaround(m-1,n);
             clickaround(m-1,n+1);
             m_mineary[m,n] := 9;
             m_change := 1;
        end;
    end;
end;

function TForm1.getaroundunknow(m,n:integer):integer;
var ret :integer;
begin
   ret:=0;
   if (m >=0) and (m <= mine_x) and
       (n >=0) and (n<= mine_y) and
       (m_mineary[m,n] = -1) then
          ret := 1;
  result := ret;
end;

function TForm1.getaroundmine(m,n:integer):integer;
var ret :integer;
begin
   ret:=0;
   if (m >=0) and (m <= mine_x) and
       (n >=0) and (n<= mine_y) and
       (m_mineary[m,n] = 0) then
          ret := 1;
  result := ret;
end;

function TForm1.getminenum(m,n:integer):integer;
var x , y : integer;
    color :integer;
    l_p1 :tpoint;
    l,r:integer;
    l_unclick :integer;
begin
   x := m_rect.Left+ 14 + m * CELL_W;
   y := m_rect.Top + 103 + 8 + n * CELL_H;
  //  setcursorpos(x,y);
   l_p1.X := x;l_p1.y := y;
    windows.ScreenToClient(m_hd,l_P1);
    l := l_p1.x + 0 + 3;
    r := l + CELL_W-6;
    y := l_p1.y + 45 + 9;

   l_unclick := 0;
//    for y := l_p1.y + 40  to l_p1.y+40+ 8  do
   for x := l to r do
   begin

       color := GetPixel(m_dc,x,y);
       if color = $FFFFFF then
          l_unclick := 1;

 //     form1.Canvas.Pixels[x,y]:=color;
       if  color = $FF0000 then //blue
       begin
          m_mineary[m,n]:= 1;
       end;
       if  (color = $008000) or (color = $008200) then //green
       begin
          m_mineary[m,n]:= 2;
       end;
       if  color = $0000FF then //orange
       begin
          m_mineary[m,n]:= 3;
       end;
       if  (color = $800000) or (color = $840000) then //dark blue
       begin
          m_mineary[m,n]:= 4;
       end;
       if  (color = $000080) or (color = $000084)then //blue
       begin
          m_mineary[m,n]:= 5;
       end;
       if  (color = $808000) or (color = $848400) then //blue
       begin
          m_mineary[m,n]:= 6;
       end;
       if  color = $000000 then //blue
       begin
          m_mineary[m,n]:= 0;
       end;
   end;
   if (l_unclick = 0) and (m_mineary[m,n]= -1) 
      then   m_mineary[m,n] := 9;

   result:=1;
end;

procedure TForm1.clickaround(m,n:integer);
var x , y : integer;
begin
     if (m >=0) and (m <= mine_x) and
       (n >=0) and (n<= mine_y) then
      if m_mineary[m,n] = -1 then
       begin

   x := m_rect.Left+ 14 +8 + m * CELL_W;
   y := m_rect.Top + 103 +8 + n * CELL_H;
   setcursorpos(x,y);
   mouse_event( MOUSEEVENTF_LEFTDOWN+MOUSEEVENTF_MOVE,0,0,0,0);
   mouse_event( MOUSEEVENTF_LEFTUP,0,0,0,0);
   getminenum(m,n);
   end;
end;

procedure TForm1.markaround(m,n:integer);
var x , y : integer;
begin
     if (m >=0) and (m <= mine_x) and
       (n >=0) and (n<= mine_y) then
    begin
      getminenum(m,n);
     if m_mineary[m,n] = -1 then
       begin
     x := m_rect.Left+ 14 + 8+ m * CELL_W;
    y := m_rect.Top + 103 + 8+ n * CELL_H;
   setcursorpos(x,y);
   mouse_event( MOUSEEVENTF_RIGHTDOWN+MOUSEEVENTF_MOVE,0,0,0,0);
    mouse_event( MOUSEEVENTF_RIGHTUP,0,0,0,0);
          m_mineary[m,n] :=0;
       end;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   m_run := 0;
end;

end.
