unit f_bluemedia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,mmsystem, ExtCtrls,Clipbrd,ShellAPI, Menus;

CONST WM_NID = WM_USER +100;
type
  TForm3 = class(TForm)
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    BTN_CONNECT: TButton;
    EdCom: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Memo8: TMemo;
    Image1: TImage;
    Button1: TButton;
    Splitter1: TSplitter;
    ed_page: TEdit;
    Ed_per: TEdit;
    BTN_PRE: TButton;
    BTN_PLAY: TButton;
    BTN_NEXT: TButton;
    BTN_STOP: TButton;
    BTN_SPACE: TButton;
    Label1: TLabel;
    Label2: TLabel;
    BTN_HIBER: TButton;
    BTN_DARK: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure BTN_CONNECTClick(Sender: TObject);
    function OpenComm : boolean;
    function ReadCom: string;
    procedure BTN_NEXTClick(Sender: TObject);
    procedure BTN_STOPClick(Sender: TObject);
    procedure BTN_PREClick(Sender: TObject);
    procedure BTN_PLAYClick(Sender: TObject);
    procedure BTN_SPACEClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BTN_HIBERClick(Sender: TObject);
    procedure BTN_DARKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WMNID(var msg:TMessage);message WM_NID;
    procedure WMSysCommand(var Msg: TWMSysCommand) ;message WM_SYSCOMMAND;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const VK_MEDIA_NEXT_TRACK = $B0 ;// 'Windows 2000/XP: Next Track key
Const VK_MEDIA_PREV_TRACK = $B1 ;//'Windows 2000/XP: Previous Track key
Const VK_MEDIA_STOP = $B2 ;//'Windows 2000/XP: Stop Media key
Const VK_MEDIA_PLAY_PAUSE = $B3 ;//'Windows 2000/XP: Play/Pause Media key
Const VK_VOLUME_MUTE = $AD;
Const VK_VOLUME_DOWN = $AE;
Const VK_VOLUME_UP   = $AF;

var
  Form3: TForm3;
  g_serial_listen:boolean;
  g_stop: integer;
  g_utf8: string;
  g_cmd :string;
  hcomm :HWND;
  NotifyIcon :TNotifyIconData;
implementation

{$R *.dfm}

procedure TForm3.BTN_CONNECTClick(Sender: TObject);
var s,r:string;
   lrc:longword;
   l_ret:string;
   l_wnd : Thandle;
   ls_caption : array[0..255] of Char;
   l_pos :integer;
   Volume :Dword;
   l_curpos : Tpoint;
   n: integer;
   p1,p2,P3:integer;
begin
  g_cmd :='r' ;
  if not opencomm  then exit;
  memo8.Lines.Add(DateToStr(Date)+' '+ TimeToStr(Time)+':���ӳɹ�.');
  BTN_CONNECT.Enabled := false;
  g_serial_listen := true;
  while true do
  begin
    Application.ProcessMessages;
    if  not g_serial_listen then exit;

    sleep(100);
    r :=  ReadCom;
    if ( r = '') then continue;

    if (r = #8) then
    begin
      g_cmd :='r'; s:='r';
    end
    else
    begin
      s := g_cmd + r;
    end;
  l_ret := #13#10+ s+' unknown command. p for help.'+#13#10#13#10+'C:\>';
  if (g_cmd ='rm') then
  l_ret := #13#10+ s+' unknown command. p for help.'+#13#10#13#10+'C:\ý�岥��\>';
  if (g_cmd ='rk') then
  l_ret := #13#10+ s+' unknown command. p for help.'+#13#10#13#10+'C:\�������\>';
  if (g_cmd ='rs') then
  l_ret := #13#10+ s+' unknown command. p for help.'+#13#10#13#10+'C:\ϵͳ\>';
  if (g_cmd ='rv') then
  l_ret := #13#10+ s+' unknown command. p for help.'+#13#10#13#10+'C:\PPT\>';

  if (s ='r') then
  begin
      l_ret := #13#10+#13#10+'C:\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������ʾ');
  end else
  if (s ='rp')or (s='r^')  then
  begin
      l_ret := #13#10+'help: '+#13#10;
      l_ret := l_ret + 'p: this help.'+#13#10;
      l_ret := l_ret + 'm: ý�岥��.'+#13#10;
      l_ret := l_ret + 'k: �������ģʽ.'+#13#10;
      l_ret := l_ret + 's: ϵͳ.'+#13#10;
      l_ret := l_ret + 'v: ���PPT.'+#13#10+#13#10;
      l_ret := l_ret +'C:\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������ʾ');
  end else
  if (s='rm') then
  begin
      l_ret := #13#10+#13#10+'C:\ý�岥��\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������ʾ');
      g_cmd := 'rm';
  end else
  if (s='rv') then
  begin
      l_ret :=  #13#10+#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������ʾ');
      g_cmd := 'rv';
  end else
  if (s='rk') then
  begin
      l_ret :=  #13#10+#13#10+'C:\�������\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������ʾ');
      g_cmd  := 'rk';
  end else
  if (s='rs') then
  begin
      l_ret :=  #13#10+#13#10+'C:\SYSTEM\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������ʾ');
      g_cmd := 'rs';
  end else
  if (s='rsp')then
  begin
      l_ret := #13#10+'help: '+#13#10;
      l_ret := l_ret + 'p: this help.'+#13#10;
      l_ret := l_ret + 's: shutdown PC.'+#13#10#13#10;
      l_ret := l_ret +'C:\SYSTEM\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������ʾ');
  end else
  if (s='rkp')then
  begin
      l_ret := #13#10+'help: '+#13#10;
      l_ret := l_ret + 'p: this help.'+#13#10;
      l_ret := l_ret + 'click: mouse left click.'+#13#10;
      l_ret := l_ret + 'cancel: mouse right click.'+#13#10;
      l_ret := l_ret + 'traceroll: mouse move.'+#13#10;
      l_ret := l_ret + '#: escape. '+#13#10;
      l_ret := l_ret + 'space: space.'+#13#10#13#10;
      l_ret := l_ret +'C:\�������\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������ʾ');
  end else
  if (s='rk^')then
  begin
        mouse_event( MOUSEEVENTF_LEFTDOWN,0,0,0,0);
        mouse_event( MOUSEEVENTF_LEFTUP,0,0,0,0);
      l_ret := #13#10+'��������'+#13#10+#13#10;
      l_ret := l_ret +'C:\�������\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':��������');
  end else
 if (s='rk'+#$1B)then
  begin
      mouse_event( MOUSEEVENTF_RIGHTDOWN,0,0,0,0);
      mouse_event( MOUSEEVENTF_RIGHTUP,0,0,0,0);
      l_ret := #13#10+'������Ҽ�'+#13#10+#13#10;
      l_ret := l_ret +'C:\�������\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������Ҽ�');
  end else
  if (length(s)=5) and (copy(s,1,3) ='rk$')then
  begin

       GetCursorPos(l_curpos);
       l_curpos.X := l_curpos.X +
         9 * (strtoint(copy(s,4,1))-5)*
              (strtoint(copy(s,4,1))-5)*
              (strtoint(copy(s,4,1))-5);
       l_curpos.Y := l_curpos.Y +
          9 * (strtoint(copy(s,5,1))-5)*
               (strtoint(copy(s,5,1))-5)*
                (strtoint(copy(s,5,1))-5);
       setcursorpos(l_curpos.X,l_curpos.Y);
      l_ret := #13#10+'����ƶ�:'+r+#13#10+#13#10;
      l_ret := l_ret +'C:\�������\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':���̰���:'+r);
  end else
  if (copy(s,1,2)='rk') and (r <> '')then
  begin
      if (( r>='0') and (r <= '9')) then
      begin
        keybd_event(ord(r[1]),0,0,0);
        keybd_event(ord(r[1]),0,KEYEVENTF_KEYUP,0);
      end;
      if (( r>='a') and (r<='z')) then
      begin
       keybd_event(ord(r[1])-32,0,0,0);
       keybd_event(ord(r[1])-32,0,KEYEVENTF_KEYUP,0);
      end;
      if  (( r>='A') and (r<='Z')) then
      begin
       keybd_event(VK_LSHIFT,0,0,0);
       keybd_event(ord(r[1]),0,0,0);
       keybd_event(ord(r[1]),0,KEYEVENTF_KEYUP,0);
       keybd_event(VK_LSHIFT,0,KEYEVENTF_KEYUP,0);
      end;
      if  ( r=' ')then
      begin
       keybd_event(VK_SPACE,0,0,0);
       keybd_event(VK_SPACE,0,KEYEVENTF_KEYUP,0);
      end;
      if  ( r=#$D)then
      begin
       keybd_event(VK_RETURN,0,0,0);
       keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0);
      end;
      if  ( r=#127)then
      begin
       keybd_event(VK_BACK,0,0,0);
       keybd_event(VK_BACK,0,KEYEVENTF_KEYUP,0);
      end;
      if  ( r='?')then
      begin
       keybd_event(VK_LSHIFT,0,0,0);
       keybd_event(VK_ADD,0,0,0);
       keybd_event(VK_ADD,0,KEYEVENTF_KEYUP,0);
       keybd_event(VK_LSHIFT,0,KEYEVENTF_KEYUP,0);
      end;
      if  ( r='!')then
      begin
       keybd_event(VK_LSHIFT,0,0,0);
       keybd_event(byte('1'),0,0,0);
       keybd_event(byte('1'),0,KEYEVENTF_KEYUP,0);
       keybd_event(VK_LSHIFT,0,KEYEVENTF_KEYUP,0);
      end;
       if  ( r='#')then
      begin
       keybd_event(VK_ESCAPE,0,0,0);
       keybd_event(VK_ESCAPE,0,KEYEVENTF_KEYUP,0);
      end;

      l_ret := #13#10+'���̰���:'+(r)[1]+#13#10+#13#10;
      l_ret := l_ret +'C:\�������\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':���̰���:'+r[1]);
  end else
  if (s='rss') then
  begin
      l_ret := #13#10+'����.'+#13#10#13#10;
      l_ret := l_ret +'ϵͳ���ڽ�������״̬.....'+#13#10#13#10;
      l_ret := l_ret + 'C:\SYSTEM\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':����');
  end else
  if (s='rmp')then
  begin
      l_ret := #13#10+'����: '+#13#10;
      l_ret := l_ret + 'p: ��ʾ�˰���.'+#13#10;
      l_ret := l_ret + 'b: �ر���ʾ��.'+#13#10;
      l_ret := l_ret + 'cancel: ǰһ��Ŀ.'+#13#10;
      l_ret := l_ret + 'traceroll click: ��һ��Ŀ.'+#13#10;
      l_ret := l_ret + 'traceroll right: ���.'+#13#10;
      l_ret := l_ret + 'traceroll left: ����.'+#13#10;
      l_ret := l_ret + 'traceroll up: �������� .'+#13#10;
      l_ret := l_ret + 'traceroll down: ��������.'+#13#10;
      l_ret := l_ret + 'j: ����/��ͣ.'+#13#10;
      l_ret := l_ret + 'm: ֹͣ.'+#13#10+#13#10;
      l_ret := l_ret +'C:\ý�岥��\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������ʾ');
  end else
  if (s ='rm^')then
  begin
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':��һ��Ŀ');
      BTN_NEXT.Click();
      sleep(500);
      l_wnd := Findwindow('TTPlayer_PlayerWnd', nil);
      GetWindowText(l_wnd,ls_caption,255);
      l_pos := ansipos('ǧǧ����',ls_caption);
      g_utf8 := trim(copy(ls_caption,l_pos +11,255))
      +copy(ls_caption,1,l_pos-3);
      l_ret := #13#10+'��һ��Ŀ:'+
      g_utf8 + #13#10#13#10 +'C:\ý�岥��\>';
  end else
  if (s='rm'+#$1B) then
  begin
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':ǰһ��Ŀ');
      BTN_PRE.Click();
      sleep(500);
      l_wnd := Findwindow('TTPlayer_PlayerWnd', nil);
      GetWindowText(l_wnd,ls_caption,255);
      l_pos := ansipos('ǧǧ����',ls_caption);
      g_utf8 := trim(copy(ls_caption,l_pos +11,255))
      +copy(ls_caption,1,l_pos-3);
      l_ret := #13#10+'ǰһ��Ŀ:'+
      g_utf8+#13#10#13#10 +'C:\ý�岥��\>';
  end else
  if (s ='rmb') then
  begin
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':�ر���ʾ��');
      BTN_DARK.Click;
      l_ret := #13#10+'�ر���ʾ��.'+
       #13#10#13#10 +'C:\ý�岥��\>';
  end else
  if (s ='rm'+#$D) then
  begin
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':ȫ��');
      keybd_event($0D,0,0,0);
      keybd_event($0D,0,KEYEVENTF_KEYUP,0);
      l_wnd := Findwindow('TTPlayer_PlayerWnd', nil);
      GetWindowText(l_wnd,ls_caption,255);
      l_pos := ansipos('ǧǧ����',ls_caption);
      g_utf8 := trim(copy(ls_caption,l_pos +11,255))
      +copy(ls_caption,1,l_pos-3);
      l_ret := #13#10+'ȫ��:'+
      g_utf8 + #13#10#13#10 +'C:\ý�岥��\>';
  end else
  if (s='rmd') then
  begin
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':��ȡʱ��');
      l_wnd := Findwindow('TTPlayer_PlayerWnd', nil);
      GetWindowText(l_wnd,ls_caption,255);
      l_pos := ansipos('ǧǧ����',ls_caption);
      g_utf8 := trim(copy(ls_caption,l_pos +11,255))
      +copy(ls_caption,1,l_pos-3);
      l_ret := #13#10+'��ǰʱ��:'+
      DateToStr(Date)+' ' + TimeToStr(Time)+#13#10#13#10 +'C:\ý�岥��\>';
  end else
  if (s='rmr') then
  begin
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':ˢ����Ŀ');
      l_wnd := Findwindow('TTPlayer_PlayerWnd', nil);
      GetWindowText(l_wnd,ls_caption,255);
      l_pos := ansipos('ǧǧ����',ls_caption);
      g_utf8 := trim(copy(ls_caption,l_pos +11,255))
      +copy(ls_caption,1,l_pos-3);
      l_ret := #13#10+'��ǰ��Ŀ:'+
      g_utf8+#13#10#13#10 +'C:\ý�岥��\>';
  end else
  if (s='rmm') then
  begin
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':ֹͣ');
      BTN_STOP.Click();
      l_ret := #13#10+'ֹͣ'+#13#10#13#10+'C:\ý�岥��\>';
  end else
  if (length(s)=5) and (copy(s,1,3) ='rm$') and ((StrToInt(copy(s,5,1))-5) <> 0)then
  begin
      if (StrToInt(copy(s,5,1))-5) < 0 then
      begin
        for n:=1 to   ( (StrToInt(copy(s,5,1))-5))*( (StrToInt(copy(s,5,1))-5)) do
        begin
        keybd_event(VK_VOLUME_UP,0,0,0);
        keybd_event(VK_VOLUME_UP,0,KEYEVENTF_KEYUP,0);
        end;
        l_ret := #13#10+'��������'+#13#10#13#10+'C:\ý�岥��\>';
     end
      else
      begin
        for n:=1 to ( (StrToInt(copy(s,5,1))-5))*( (StrToInt(copy(s,5,1))-5)) do
        begin
        keybd_event(VK_VOLUME_DOWN,0,0,0);
        keybd_event(VK_VOLUME_DOWN,0,KEYEVENTF_KEYUP,0);
        end;
        l_ret := #13#10+'��������'+#13#10#13#10+'C:\ý�岥��\>';
      end;

  end else
  if (length(s)=5) and (copy(s,1,3) ='rm$') and ((StrToInt(copy(s,4,1))-5) <> 0)then
  begin
      l_wnd := Findwindow('TTPlayer_PlayerWnd', nil);
      windows.SetFocus(l_wnd);
      if (StrToInt(copy(s,4,1))-5) < 0 then
      begin
        for n:=1 to   ( (StrToInt(copy(s,4,1))-5))*( (StrToInt(copy(s,4,1))-5)) do
        begin
        keybd_event(VK_LEFT,0,0,0);
        keybd_event(VK_LEFT,0,KEYEVENTF_KEYUP,0);
        end;
        l_ret := #13#10+'����'+#13#10#13#10+'C:\ý�岥��\>';
     end
      else
      begin
        for n:=1 to ( (StrToInt(copy(s,4,1))-5))*( (StrToInt(copy(s,4,1))-5)) do
        begin
        keybd_event(VK_RIGHT,0,0,0);
        keybd_event(VK_RIGHT,0,KEYEVENTF_KEYUP,0);
        end;
        l_ret := #13#10+'���'+#13#10#13#10+'C:\ý�岥��\>';
      end;

  end else
  if (s='rmj') then
  begin
      memo8.Lines.Insert(0,DateToStr(Date)+' '+TimeToStr(Time)+':����');
      keybd_event(VK_MEDIA_PLAY_PAUSE,0,0,0);
      keybd_event(VK_MEDIA_PLAY_PAUSE,0,KEYEVENTF_KEYUP,0);
      l_ret := #13#10+'����/��ͣ'+#13#10#13#10+'C:\ý�岥��\>';
  end else
  if (s='rm ') then
  begin
      memo8.Lines.Insert(0,DateToStr(Date)+' '+TimeToStr(Time)+':�ո�');
      keybd_event(VK_SPACE,0,0,0);
      keybd_event(VK_SPACE,0,KEYEVENTF_KEYUP,0);
      l_ret := #13#10+'�ո�'+#13#10#13#10+'C:\ý�岥��\>';
  end else
  if (s='rvp')then
  begin
      l_ret := #13#10+'help: '+#13#10;
      l_ret := l_ret + 'v: view full screen ppt.'+#13#10;
      l_ret := l_ret + 't: escape full screen mode.'+#13#10;
      l_ret := l_ret + 'k: next page.'+#13#10;
      l_ret := l_ret + 'h: prev page.'+#13#10+#13#10;
      l_ret := l_ret +'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':������ʾ');
  end else
  if (s='rvh')or (s='rv'+#$1B) then
  begin
      l_ret := #13#10+'ǰһҳ'+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':ǰһҳ');
      keybd_event(VK_PRIOR ,0,0,0);
      keybd_event(VK_PRIOR ,0,KEYEVENTF_KEYUP,0);
  end else
  if (length(s)=5) and (copy(s,1,3) ='rv$') and ((StrToInt(copy(s,5,1))-5) <> 0)then
  begin
    if ((StrToInt(copy(s,5,1))-5) < 0) then
    begin
      l_ret := #13#10+'����'+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':����');
      keybd_event(VK_UP,0,0,0);
      keybd_event(VK_UP,0,KEYEVENTF_KEYUP,0);
    end;
    if ((StrToInt(copy(s,5,1))-5) > 0) then
    begin
      l_ret := #13#10+'����'+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':����');
      keybd_event(VK_DOWN,0,0,0);
      keybd_event(VK_DOWN,0,KEYEVENTF_KEYUP,0);
    end;
  end else
  if (copy(s,1,4) ='rv$A') then
  begin
       l_ret := #13#10+s+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':'+s);
      p1 :=  pos('%1',s);
      p2 :=  pos('%2',s);
      p3 :=  pos('%3',s);
       setcursorpos(
       round(StrToInt(copy(s,p1+2,p2-p1-2))*2.5),
       round( StrToInt(copy(s,p2+2,P3-P2-2))*2.5)
       );

      mouse_event( MOUSEEVENTF_LEFTDOWN,0,0,0,0);
  end else
  if (copy(s,1,4) ='rv$B') then
  begin
         l_ret := #13#10+s+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':'+s);
     p1 :=  pos('%1',s);
     p2 :=  pos('%2',s);
     p3 :=  pos('%3',s);
     mouse_event( MOUSEEVENTF_LEFTDOWN,0,0,0,0);
     setcursorpos(
       round(StrToInt(copy(s,p1+2,p2-p1-2))*2.5),
       round( StrToInt(copy(s,p2+2,P3-P2-2))*2.5)
       );
     //mouse_event( MOUSEEVENTF_ABSOLUTE + MOUSEEVENTF_MOVE + MOUSEEVENTF_LEFTDOWN,

    // StrToInt(copy(s,p1+2,p2-p1-2))*4,
    // StrToInt(copy(s,p2+2,P3-P2-2))*4,0,0);

  end else
  if (copy(s,1,4) ='rv$C') then
  begin
        l_ret := #13#10+s+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':'+s);
       mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
       keybd_event(ord('E'),0,0,0);
       keybd_event(ord('E'),0,KEYEVENTF_KEYUP,0);
  end else
  if (s='rvj') then
  begin
      l_ret := #13#10+'����'+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':����');
      keybd_event(VK_EXECUTE,0,0,0);
      keybd_event(VK_EXECUTE,0,KEYEVENTF_KEYUP,0);
  end else  if (s='rvk') or (s='rv^')  then
  begin
      l_ret := #13#10+'��һҳ'+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':��һҳ');
      keybd_event(VK_NEXT,0,0,0);
      keybd_event(VK_NEXT,0,KEYEVENTF_KEYUP,0);
  end else
  if (s='rvw') then
  begin
      l_ret := #13#10+'����'+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':����');
      keybd_event(byte('W'),0,0,0);
      keybd_event(byte('W'),0,KEYEVENTF_KEYUP,0);
  end else
  if (s='rvb') then
  begin
      l_ret := #13#10+'����'+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':����');
      keybd_event(byte('B'),0,0,0);
      keybd_event(byte('B'),0,KEYEVENTF_KEYUP,0);
  end else
  if (s='rvv') then
  begin
      l_ret := #13#10+'ȫ�����ppt'+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':����õ�Ƭ');
      keybd_event(VK_LSHIFT,0,0,0);
      keybd_event(VK_F5,0,0,0);
      keybd_event(VK_F5,0,KEYEVENTF_KEYUP,0);
      keybd_event(VK_LSHIFT,0,KEYEVENTF_KEYUP,0);

      mouse_event( MOUSEEVENTF_RIGHTDOWN,0,0,0,0);
       keybd_event(ord('O'),0,0,0);
       keybd_event(ord('O'),0,KEYEVENTF_KEYUP,0);
       keybd_event(ord('H'),0,0,0);
       keybd_event(ord('H'),0,KEYEVENTF_KEYUP,0);
      mouse_event( MOUSEEVENTF_RIGHTUP,0,0,0,0);
      
  end else
  if (s='rvt') then
  begin
      l_ret := #13#10+'�˳�ȫ��'+#13#10#13#10+'C:\PPT\>';
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':�˳�');
      keybd_event(VK_ESCAPE,0,0,0);
      keybd_event(VK_ESCAPE,0,KEYEVENTF_KEYUP,0);
  end else
  begin
      memo8.Lines.Insert(0,DateToStr(Date)+' '+ TimeToStr(Time)+':δ֪������'+s);
  end;

  if (r <>'') then
   WriteFile(hcomm,pchar(' '+l_ret)^,length(' '+l_ret), lrc, nil);
   if (s = 'rss') then
   begin
      winexec(pchar('Rundll32.exe PowrProf.dll SetSuspendState'),SW_HIDE);
      closehandle(hcomm);
      hcomm := 0;
   end
  end

end;

function TForm3.opencomm;
var cc: tcommconfig;
  CommNO: string;
  msg :string;
begin
  CommNO := edcom.Text;
  hcomm := CreateFile(pchar('\\.\'+CommNO), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, 0, 0); //�Զ�д��ʽ��com1
  if (hcomm = invalid_handle_value) then
  begin
    msg := '��ͨ�Ŷ˿�'+ CommNo + 'ʧ��, ������������ռ�ã����ȹر�!';
    messagebox(0, pchar(msg), '', mb_ok);
    result := false;
    exit;
  end;

  getcommstate(hcomm, cc.dcb);
  cc.dcb.BaudRate := cbr_9600;
  cc.dcb.ByteSize := 8;
  cc.dcb.Parity := noparity;
  cc.dcb.StopBits := onestopbit;

  if not setcommstate(hcomm, cc.dcb) then
  begin
    messagebox(0, 'ͨѶ�˿����ô��󣡣�', '', mb_ok);
    closehandle(hcomm);
    result := false;
    exit;
  end;
  result := true;
end;

function TForm3.readcom: string;
var temp: string;
  inbuff: array[0..10240] of char;
  nbytesread, dwerror: longword;
  cs: tcomstat;
begin
  clearcommerror(hcomm, dwerror, @cs);
  if cs.cbInQue > sizeof(inbuff) then
  begin
    purgecomm(hcomm, purge_rxclear);
    exit;
  end;
  readfile(hcomm, inbuff, cs.cbInQue, nbytesread, nil);
  temp := copy(inbuff, 1, cs.cbInQue);
  result := temp;
end;

procedure TForm3.BTN_NEXTClick(Sender: TObject);
begin
    g_stop := 1;
    keybd_event(VK_MEDIA_NEXT_TRACK,0,0,0);
    keybd_event(VK_MEDIA_NEXT_TRACK,0,KEYEVENTF_KEYUP,0);
end;

procedure TForm3.BTN_STOPClick(Sender: TObject);
begin
    g_stop := 1;
    keybd_event(VK_MEDIA_STOP,0,0,0);
    keybd_event(VK_MEDIA_STOP,0,KEYEVENTF_KEYUP,0);
end;

procedure TForm3.BTN_PREClick(Sender: TObject);
begin
    g_stop := 1;
    keybd_event(VK_MEDIA_PREV_TRACK,0,0,0);
    keybd_event(VK_MEDIA_PREV_TRACK,0,KEYEVENTF_KEYUP,0);
end;

procedure TForm3.BTN_PLAYClick(Sender: TObject);
begin
    keybd_event(VK_MEDIA_PLAY_PAUSE,0,0,0);
    keybd_event(VK_MEDIA_PLAY_PAUSE,0,KEYEVENTF_KEYUP,0);
end;

procedure TForm3.BTN_SPACEClick(Sender: TObject);
begin
    keybd_event(VK_SPACE,0,0,0);
    keybd_event(VK_SPACE,0,KEYEVENTF_KEYUP,0);
end;

procedure TForm3.Button1Click(Sender: TObject);
var winHWND, hCur:integer;
     winDC:integer;
     rect:TRect;
     //AFormat : Word;
     //AData,APalette : THandle;
     pt:TPoint;
     fBitmap:TBitmap;
     timer11:Integer;
     R :trect;
     n : integer;
     l_per :string;
begin
     form3.Hide;
     l_per := ed_per.Text;
     for n := 10 to strtoint(ed_page.Text) + 10 do
     begin
     sleep(1000);
     timer11:=GetTickCount;

     hCur := GetCursor(); // �� �� �� �� �� ��
     GetCursorPos(pt); // �� ¼ �� �� λ ��
    winHWND := GetDesktopWindow();
   //winHWND := Findwindow('PP11FrameClass', nil);
     winDC := GetDC(winHWND);
     GetWindowRect(winHWND, rect);

     fBitmap := TBitmap.create;
     fBitmap.width := rect.right-rect.left;
     fBitmap.height := rect.bottom-rect.top;

     BitBlt(fBitmap.canvas.handle, 0, 0, fBitmap.width, fBitmap.height, winDC, 0, 0, SRCCOPY);
     DrawIcon(fBitmap.canvas.handle, pt.x, pt.y, hCur); // �� �� ��

     fBitmap.SaveToFile('c:\\ppt\\'+inttostr(n)+'.bmp');
     winexec(pchar('c:\\ppt\\pngmate -resize '+l_per+'% '+ 'c:\\ppt\\'+inttostr(n)+'.bmp'),SW_HIDE);
//     ShellExecute(handle, 'open','c:\\ppt\\pngmate','-resize '+l_per+'% '+inttostr(n)+'.bmp',nil, SW_SHOWNORMAL);

     r.Left := 0;
     r.top := 0;
     r.Bottom := round(rect.Bottom*strtoint(l_per)/100);
     r.Right := round(rect.Right*strtoint(l_per)/100);

     fbitmap.Canvas.StretchDraw( r,fbitmap);

     fbitmap.Width := r.Right;
     fbitmap.Height := r.Bottom;

     Image1.Picture.Bitmap:= fBitmap;
     ReleaseDC(winHWND, winDC);
     fBitmap.Free;
      keybd_event(VK_NEXT,0,0,0);
      keybd_event(VK_NEXT,0,KEYEVENTF_KEYUP,0);
      end;
//     Caption:=inttostr( GetTickCount-timer11);
     form3.Show;
end;

procedure TForm3.BTN_HIBERClick(Sender: TObject);
begin
      winexec(pchar('Rundll32.exe PowrProf.dll SetSuspendState'),SW_HIDE);
      closehandle(hcomm);
      hcomm := 0;
end;

       
procedure TForm3.BTN_DARKClick(Sender: TObject);
begin
  SendMessage(form3.Handle, WM_SYSCOMMAND, SC_MONITORPOWER, 2);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
with NotifyIcon do
begin
cbSize:=SizeOf(TNotifyIconData);
Wnd:=Handle;
uID:=1;
uFlags:=NIF_ICON or NIF_MESSAGE or NIF_TIP;
uCallBackMessage:=WM_NID;
hIcon:=Application.Icon.Handle;
szTip:='ý�����';
end;
Shell_NotifyIcon(NIM_ADD,@NotifyIcon);
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
    g_serial_listen := false;
    BTN_CONNECT.Enabled := true;
    Shell_NotifyIcon(NIM_DELETE,@NotifyIcon);
end;

procedure TForm3.WMNID(var msg:TMessage);
var
   t: tpoint;
begin
   getcursorpos(t);
case msg.LParam of
WM_LBUTTONUp: Form3.Visible:=not Form3.Visible;
WM_RBUTTONUP: popupmenu1.Popup(t.X,t.Y);
End;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action :=caNone;
    form3.Hide;
end;

procedure TForm3.N1Click(Sender: TObject);
begin
    form3.Destroy;
    application.Terminate;
end;

procedure TForm3.N2Click(Sender: TObject);
begin
     form3.Show;
end;

procedure TForm3.WMSysCommand;
begin
   if (Msg.CmdType = SC_MINIMIZE)then
     form3.Hide
   else
    DefaultHandler(Msg) ;
end;

end
.