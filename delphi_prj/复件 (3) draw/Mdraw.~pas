unit Mdraw;

interface

uses
  MEvent,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, Contnrs,ExtCtrls, StdCtrls, Buttons, CheckLst,
  MPlayer,mmsystem, ActnList, MCBtn,jpeg;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    TabControl1: TTabControl;
    MainMenu1: TMainMenu;
    StatusBar1: TStatusBar;
    a1: TMenuItem;
    b1: TMenuItem;
    c1: TMenuItem;
    d1: TMenuItem;
    f1: TMenuItem;
    g1: TMenuItem;
    Panel4: TPanel;
    Panel5: TPanel;
    paintbox1: Tpaintbox;
    paintbox2: Tpaintbox;
    N1: TMenuItem;
    N2: TMenuItem;
    Panel2: TPanel;
    Panel6: TPanel;
    CLBAction: TCheckListBox;
    Timer1: TTimer;
    OpenDlg: TOpenDialog;
    CoolBar1: TCoolBar;
    PageScroller1: TPageScroller;
    PageScroller2: TPageScroller;
    Panel7: TPanel;
    Label1: TLabel;
    ColorBox1: TColorBox;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    ComboBox2: TComboBox;
    Panel8: TPanel;
    ProgressBar1: TProgressBar;
    Label4: TLabel;
    Mp3player: TMediaPlayer;
    Splitter1: TSplitter;
    Panel3: TPanel;
    TabControl2: TTabControl;
    Panel9: TPanel;
    PageScroller3: TPageScroller;
    Panel10: TPanel;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    Panel11: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    TrackBar1: TTrackBar;
    N14: TMenuItem;
    d2: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    ActionList1: TActionList;
    ActSave: TAction;
    ActLoad: TAction;
    ActRemoveUnchecked: TAction;
    ActCopyToOneNote: TAction;
    OneNote1: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    ActNew: TAction;
    ActCloseMonitor: TAction;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    MCBtn1: TMCBtn;
    MCBtnMP3: TMCBtn;
    MCBtnRemove: TMCBtn;
    MCBtn3: TMCBtn;
    MCBtn2: TMCBtn;
    MCBtn4: TMCBtn;
    MCBtn5: TMCBtn;
    MCBtn6: TMCBtn;
    MCBtn7: TMCBtn;
    MCBtnPre: TMCBtn;
    MCBtnPause: TMCBtn;
    MCBtnPlay: TMCBtn;
    MCBtnNext: TMCBtn;
    MCBtn8: TMCBtn;
    PageScroller4: TPageScroller;
    Panel12: TPanel;
    MCBtn9: TMCBtn;
    MCBtn10: TMCBtn;
    MCBtn11: TMCBtn;
    MCBtn12: TMCBtn;
    MCBtn13: TMCBtn;
    ListBox1: TListBox;
    Timer2: TTimer;
    Image1: TImage;
    Image2: TImage;
    Label5: TLabel;
    procedure paintbox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure paintbox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure paintbox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox2Change(Sender: TObject);
    procedure CLBActionClickCheck(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ProgressBar1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonPauseClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActLoadExecute(Sender: TObject);
    procedure ActRemoveUncheckedExecute(Sender: TObject);
    procedure ActCopyToOneNoteExecute(Sender: TObject);
    procedure Button4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure ActNewExecute(Sender: TObject);
    procedure ActCloseMonitorExecute(Sender: TObject);
    procedure MCBtn1Click(Sender: TObject);
    procedure MCBtnMP3Click(Sender: TObject);
    procedure MCBtn2Click(Sender: TObject);
    procedure MCBtn4Click(Sender: TObject);
    procedure MCBtnPreClick(Sender: TObject);
    procedure MCBtnPauseClick(Sender: TObject);
    procedure MCBtnPlayClick(Sender: TObject);
    procedure MCBtnNextClick(Sender: TObject);
    procedure MCBtn8Click(Sender: TObject);
    procedure MCBtn9Click(Sender: TObject);
    procedure MCBtn11Click(Sender: TObject);
    procedure MCBtn10Click(Sender: TObject);
    procedure MCBtn12Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure mdraw();
  end;
var
  Form1: TForm1;
  i_down,o_x,o_y:integer;
  i_color :TColor;
  l_list :TClassList;

implementation

{$R *.dfm}

procedure TForm1.paintbox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if (i_down = 1) then
   begin
        paintbox1.Canvas.LineTo(x,y);
        //paintbox1.Canvas.CopyRect(paintbox1.ClientRect,
        //paintbox2.Canvas,paintbox2.ClientRect);
        l_list.Add(TClass(TEvent.Create(EID_PEN_LINETO,x,y,-1,-1)));
   end;
end;

procedure TForm1.paintbox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   i_down := 1;
   paintbox1.Canvas.MoveTo(x,y);
   paintbox1.Canvas.Pen.Style  := psSolid;
   l_list := TClassList.Create();
   paintbox1.Canvas.Pen.Width := strtoint(combobox1.Text);
   l_list.Add(TClass(TEvent.Create(EID_PEN_SIZE,x,y,paintbox1.Canvas.Pen.Width,-1)));
   paintbox1.Canvas.Pen.Color :=  colorbox1.Colors[colorbox1.ItemIndex];
   l_list.Add(TClass(TEvent.Create(EID_PEN_COLOR,x,y,-1,colorbox1.ItemIndex)));
   l_list.Add(TClass(TEvent.Create(EID_PEN_MOVE,x,y,-1,-1)));
end;

procedure TForm1.paintbox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   l_s :string;
begin
    i_down := 0;
    if (l_list = nil) then exit;
    if (l_List.Count > 5 ) then
    begin
     l_s := '笔画 '+ inttostr(CLBAction.Count + 1) ;
     CLBAction.Items.InsertObject(0,l_s,l_List);
     CLBAction.Checked[0] := true;
    end
    else
    begin
     l_List.Free;
    end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);

begin
      Form1.mdraw();
end;

procedure TForm1.mdraw();
var
        i,m:integer;
        l_lst:TClassList;
        l_evt:TEvent;
        l_hig:integer;
begin

    paintbox2.Canvas.FillRect(paintbox2.ClientRect);
     l_hig:= strtoint(copy(ComboBox2.Text,1,1))*20;
     if l_hig <> 0 then
     begin
        for i := 1 to  (paintbox2.ClientRect.Right div l_hig) do
        begin
                paintbox2.Canvas.Moveto(0,i*l_hig);
                paintbox2.Canvas.Pen.Width := 1;
                paintbox2.Canvas.Pen.Color := clLtGray;
                paintbox2.Canvas.LineTo(paintbox2.ClientRect.Right,i*l_hig);
        end;
     end;
     for i := CLBAction.Items.Count - 1 downto  0 do
     begin
        if ( CLBAction.Checked [i]) then
        begin
            l_lst:=TClassList(CLBAction.Items.Objects[i]);
            for m  := 0 to l_lst.Count -1 do
            begin
                l_evt:= TEvent(l_lst.Items[m]);
                if l_evt.event_id = EID_PEN_LINETO then
                begin
                   paintbox2.Canvas.LineTo(l_evt.x,l_evt.y);
                end;
                if l_evt.event_id = EID_PEN_MOVE then
                begin
                   paintbox2.Canvas.Moveto(l_evt.x,l_evt.y);
                end;
                if l_evt.event_id = EID_PEN_SIZE then
                begin
                   paintbox2.Canvas.Pen.Width := l_evt.size;
                end;
                if l_evt.event_id = EID_PEN_COLOR then
                begin
                   paintbox2.Canvas.Pen.Color := colorbox1.Colors[l_evt.color];;
                end;

            end;
        end;
     end;
     paintbox1.Canvas.CopyRect(paintbox1.ClientRect,
     paintbox2.Canvas,paintbox2.ClientRect);
end;
procedure TForm1.CLBActionClickCheck(Sender: TObject);
begin
    Form1.mdraw();
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  InputString: string;
begin
  InputString :=InputBox('输入', '页名称',DateToStr(Date));
  if    inputstring <> '' then
  begin
  TabControl1.TabIndex := TabControl1.Tabs.Add(inputstring);
  TabControl2.Tabs.Clear;
  TabControl2.Tabs.Add('1');
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
    if timer1.tag = 1 then
    begin
       timer1.tag := 0;
       Label7.Visible := false;
       Label6.Visible := true;
    end
    else
    begin
       timer1.tag := 1;
       Label6.Visible := false;
       Label7.Visible := true;
    end;
    if (ProgressBar1.Max <> 0 )and (mp3player.Mode  = mpPlaying) then
        ProgressBar1.Position :=  mp3player.Position ;
    if (mp3player.Mode = mpStopped ) and
      (ProgressBar1.Position > 10000) then
    Begin
        MCBtnNextClick(self);
    end;
end;

procedure TForm1.ProgressBar1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if( mp3player.Mode = mpplaying ) then
   begin
   timer1.Enabled := false;
   ProgressBar1.Position :=   mp3player.Length * x div ProgressBar1.Width;
   mp3player.Position :=  ProgressBar1.Position;
   mp3player.play;
   timer1.Enabled := true;
   end;
end;

procedure TForm1.ButtonPauseClick(Sender: TObject);
begin
    if (mp3player.Mode = mpPlaying) then
        mp3player.Pause;
end;



procedure TForm1.TrackBar1Change(Sender: TObject);
var
  MyWaveOutCaps: TWaveOutCaps;
  Volume: LongWord;
begin
  Volume:= trackbar1.Position*3200;
  if WaveOutGetDevCaps(
    WAVE_MAPPER,
    @MyWaveOutCaps,
    sizeof(MyWaveOutCaps))=MMSYSERR_NOERROR then
      WaveOutSetVolume(WAVE_MAPPER, MakeLong(Volume, Volume));

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  MyWaveOutCaps: TWaveOutCaps;
  Volume: DWord;
//  style : Cardinal ;
begin
//  style := GetWindowLong (ProgressBar1.Handle, GWL_EXSTYLE) ;
//  style := style AND NOT WS_EX_STATICEDGE ;
//小  SetWindowLong (ProgressBar1.Handle, GWL_EXSTYLE, style) ;
 if WaveOutGetDevCaps(
    WAVE_MAPPER,
    @MyWaveOutCaps,
    sizeof(MyWaveOutCaps))=MMSYSERR_NOERROR then
  begin
    WaveOutGetVolume(WAVE_MAPPER, @Volume);
  end;
  Volume:= Volume and $0000ffff;
  trackbar1.Position :=  Volume div 3200;

end;

procedure TForm1.N12Click(Sender: TObject);
begin
        Application.MessageBox(#13 +#13 +
        '     Note For Sharp A230 框架版     '
        + #13
        + #13 +
        '          　设计: 朱兴宇             '
        + #13
        +#13+
        '          　  2005.8                 '
        +#13,       
        '关于');
end;

procedure TForm1.ActSaveExecute(Sender: TObject);
var
    i ,m:integer;
    l_evn: TEvent;
    l_clist :TClassList;
    l_file :TFileStream;
     l_savedlg:TSavedialog;
begin
    l_savedlg :=  TSavedialog.Create(self);
    l_savedlg.Filter :=  'NFS files (*.nfs)|*.nfs|All files (*.*)|*.*';
    if l_savedlg.Execute then
    begin
     ActRemoveUncheckedExecute(self);
    l_file:=TFileStream.Create(l_savedlg.FileName, fmCreate);
    i := CLBAction.Items.Count;
    l_file.Write('NFS_A230',8);
    l_file.Write(i,sizeof(integer));
    for i := CLBAction.Items.Count -1 downto  0 do
    begin
        l_clist:= TClassList( CLBAction.Items.Objects[i]);
        l_file.Write(l_clist.count,sizeof(integer));
        for m := 0 to  l_clist.count - 1 do
        begin
                l_evn := TEvent(l_clist.Items[m]);
                l_evn.SavetoFile(l_file);
        end;
    end;
    l_file.Free;
    end;
    l_savedlg.Free;
end;

procedure TForm1.ActLoadExecute(Sender: TObject);
var
    i ,m,len,len2:integer;
    l_evn: TEvent;
    l_clist :TClassList;
    l_file :TFileStream;
     l_opendlg:TOpendialog;
begin
    l_opendlg :=  TOpendialog.Create(self);
    l_opendlg.Filter :=  'NFS files (*.nfs)|*.nfs|All files (*.*)|*.*';
    l_opendlg.Options:= OpenDlg.Options + [ofFileMustExist];

    if l_opendlg.Execute then
    begin
    l_file:=TFileStream.Create(l_opendlg.FileName, fmOpenRead);
    CLBAction.Clear;
    l_file.Read(len,4);l_file.Read(len,4);
    l_file.Read(len,sizeof(integer));
    CLBAction.Hide;
    for i := 0 to len - 1 do
    begin
        l_CList := TCLassList.Create;
        l_file.Read(len2,sizeof(integer));
        for m := 0 to  len2 -1 do
        begin
                L_evn := TEvent.Create(0,0,0,0,0);
                l_evn.LoadFromFile(l_file);
                l_clist.Add(TClass(l_evn));
        end;
        CLBAction.Items.InsertObject(0,'笔画'+ inttostr(i+1),l_Clist);
        CLBAction.Checked[0] := true;
    end;
    CLBAction.Show;
    l_file.Free;
    mdraw;
    end;
    l_opendlg.free;
end;

procedure TForm1.ActRemoveUncheckedExecute(Sender: TObject);
var i,m : integer;
begin
    for  i := 0 to  CLBAction.Items.Count -1 do
    begin
        for m := 0 to CLBAction.Items.Count -1 -i  do
        if not CLBAction.Checked[i] then
        begin
         CLBAction.Items.Delete(i);
         break;
        end;
    end;
end;

procedure TForm1.ActCopyToOneNoteExecute(Sender: TObject);
var
  i,m: integer;
  l_evn : TEvent;
  l_clist : TClassList;
begin
   application.Minimize;
   sleep(200);
   setcursorpos(300,300);
   mouse_event( MOUSEEVENTF_LEFTDOWN,0,0,0,0);

 {  keybd_event(VK_F10,0,0,0);
   keybd_event(VK_F10,KEYEVENTF_KEYUP,0,0);
   sleep(100);
   keybd_event(byte('T'),0,0,0);
   keybd_event(byte('T'),KEYEVENTF_KEYUP,0,0);
   keybd_event(byte('W'),0,0,0);
   keybd_event(byte('W'),KEYEVENTF_KEYUP,0,0);
   keybd_event(byte('P'),0,0,0);
   keybd_event(byte('P'),KEYEVENTF_KEYUP,0,0);
   keybd_event(VK_DOWN,0,0,0);
   keybd_event(VK_DOWN,KEYEVENTF_KEYUP,0,0);
   keybd_event(VK_RETURN,0,0,0);
   keybd_event(VK_RETURN,KEYEVENTF_KEYUP,0,0);
 }
   for i := CLBAction.Items.Count -1 downto  0 do
    begin
        l_clist:= TClassList( CLBAction.Items.Objects[i]);
         l_evn := TEvent(l_clist.Items[0]);
        for m := 0  to  l_clist.count - 1 do
        begin
                l_evn := TEvent(l_clist.Items[m]);
                if l_evn.event_id = EID_PEN_MOVE then
                begin
                mouse_event( MOUSEEVENTF_LEFTUP,0,0,0,0);
                setcursorpos(l_evn.x,l_evn.y+100);
                 mouse_event( MOUSEEVENTF_LEFTDOWN+MOUSEEVENTF_MOVE,0,0,0,0);
                end;
                if l_evn.event_id = EID_PEN_LINETO then
                begin
                setcursorpos(l_evn.x,l_evn.y+100);
                mouse_event( MOUSEEVENTF_LEFTDOWN+MOUSEEVENTF_MOVE,0,0,0,0);
                 sleep(1);
                end;
        end;
        sleep(2);
        setcursorpos(l_evn.x,l_evn.y+100);
        mouse_event( MOUSEEVENTF_LEFTUP,0,0,0,0);
    end;
    application.Restore;
end;

procedure TForm1.Button4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
        setcapture(handle); // 设置捕获鼠标输入 
end;

procedure TForm1.Button4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
ReleaseCapture; // 终止捕获鼠标输入
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
        mdraw;
end;

procedure TForm1.ActNewExecute(Sender: TObject);
begin
        CLBAction.Clear;
        Form1.mdraw();
        paintbox1.BringToFront;
        clbaction.BringToFront;
end;

procedure TForm1.ActCloseMonitorExecute(Sender: TObject);
begin
         SendMessage(form1.Handle, WM_SYSCOMMAND, SC_MONITORPOWER, 2);
end;

procedure TForm1.MCBtn1Click(Sender: TObject);
begin
        mcbtn1.Caption := '111';
end;

procedure TForm1.MCBtnMP3Click(Sender: TObject);
begin
   Timer1.Enabled := false;
  mp3player.Close;
 OpenDlg.Filter :=  'Mp3 files (*.mp3)|*.mp3|Asf files (*.asf)|*.asf|wmv files (*.wmv)|*.wmv|All files (*.*)|*.*';
 OpenDlg.Options:= OpenDlg.Options + [ofAllowMultiSelect, ofFileMustExist];
 if OpenDlg.Execute then
 begin
    mp3player.FileName := OpenDlg.Files[0];
    OpenDlg.Tag := 0;
    Sleep(200);
    MCBtnPlayClick(self);
    Timer1.Enabled := true;
 end
end;

procedure TForm1.MCBtn2Click(Sender: TObject);
var
  InputString: string;
begin
  InputString :=InputBox('输入', '页名称',DateToStr(Date));
  if    inputstring <> '' then
  begin
  TabControl1.TabIndex := TabControl1.Tabs.Add(inputstring);
  TabControl2.Tabs.Clear;
  TabControl2.Tabs.Add('1');
  end;
end;

procedure TForm1.MCBtn4Click(Sender: TObject);
begin
  tabcontrol2.Tabs.Add(inttostr(TabControl2.Tabs.Count + 1));
end;

procedure TForm1.MCBtnPreClick(Sender: TObject);
begin
   if( OpenDlg.Tag >= 1 ) then
   begin
     ProgressBar1.Position := 0;
     OpenDlg.Tag := OpenDlg.Tag -1 ;
     mp3player.Close;
     mp3player.FileName := OpenDlg.Files[OpenDlg.Tag];
     MCBtnPlayClick(self);
   end;
end;

procedure TForm1.MCBtnPauseClick(Sender: TObject);
begin
    if (mp3player.Mode = mpPlaying) then
        mp3player.Pause;
end;

procedure TForm1.MCBtnPlayClick(Sender: TObject);
begin
    if (mp3player.Mode = mpNotReady) then exit;
    if (mp3player.Mode <> mpplaying) then
    begin
        if   (mp3player.Mode <> mpPaused) then
        begin
                FillID3TagInformation(mp3player.FileName,Label6,Label7,Label6,Label7,Label6,Label7);
                mp3player.Open;
        end;
        ProgressBar1.Max := mp3player.Length ;
        mp3player.play;
        Label4.Caption := inttostr(OpenDlg.Tag + 1) + '/' + inttostr(OpenDlg.Files.Count);

   end;
end;

procedure TForm1.MCBtnNextClick(Sender: TObject);
begin
  if( OpenDlg.Tag < OpenDlg.Files.Count -1 ) then
   begin
     OpenDlg.Tag := OpenDlg.Tag +1 ;
     ProgressBar1.Position := 0;
     mp3player.Close;
     mp3player.FileName := OpenDlg.Files[OpenDlg.Tag];
     MCBtnPlayClick(self);
   end
   else if OpenDlg.Files.Count>0 then
   begin
     OpenDlg.Tag := 0 ;
     mp3player.Close;
     ProgressBar1.Position := 0;
     mp3player.FileName := OpenDlg.Files[OpenDlg.Tag];
     MCBtnPlayClick(self);
   end;
end;

procedure TForm1.MCBtn8Click(Sender: TObject);
var
        i,m:integer;
        l_lst:TClassList;
        l_evt:TEvent;
        l_hig:integer;
begin
     paintbox1.Canvas.FillRect(paintbox1.ClientRect);
     l_hig:= strtoint(copy(ComboBox2.Text,1,1))*20;
     if l_hig <> 0 then
     begin
        for i := 1 to  (paintbox1.ClientRect.Right div l_hig) do
        begin
                paintbox1.Canvas.Moveto(0,i*l_hig);
                paintbox1.Canvas.Pen.Width := 1;
                paintbox1.Canvas.Pen.Color := clLtGray;
                paintbox1.Canvas.LineTo(paintbox1.ClientRect.Right,i*l_hig);
        end;
     end;
     for i := CLBAction.Items.Count - 1 downto  0 do
     begin
        if ( CLBAction.Checked [i]) then
        begin
            l_lst:=TClassList(CLBAction.Items.Objects[i]);
            for m  := 0 to l_lst.Count -1 do
            begin
                l_evt:= TEvent(l_lst.Items[m]);
                if l_evt.event_id = EID_PEN_LINETO then
                begin
                   paintbox1.Canvas.LineTo(l_evt.x,l_evt.y);
                end;
                if l_evt.event_id = EID_PEN_MOVE then
                begin
                   paintbox1.Canvas.Moveto(l_evt.x,l_evt.y);
                end;
                if l_evt.event_id = EID_PEN_SIZE then
                begin
                   paintbox1.Canvas.Pen.Width := l_evt.size;
                end;
                if l_evt.event_id = EID_PEN_COLOR then
                begin
                   paintbox1.Canvas.Pen.Color := colorbox1.Colors[l_evt.color];;
                end;
                sleep(3);
                application.ProcessMessages;
            end;

        end;
        sleep(100);
     end;
end;

procedure TForm1.MCBtn9Click(Sender: TObject);
var
   l_opendlg : TOpendialog;
   var Rec  : TSearchRec;
    Path : string;
begin
    l_opendlg :=  TOpendialog.Create(self);
    l_opendlg.Filter :=  'Jpg files (*.jpg)|*.jpg|Jpeg files (*.jpeg)|*.jpeg|All files (*.*)|*.*';
    l_opendlg.Options:= OpenDlg.Options + [ofFileMustExist];
    if l_opendlg.Execute then
    begin
        image1.Picture.LoadFromFile(l_opendlg.FileName);
        path :=  ExtractFilePath(l_opendlg.FileName);
        image1.BringToFront;
        l_opendlg.free;
    end
    else
    begin
        l_opendlg.free;
        exit;
    end;
    ListBox1.Clear;
    if FindFirst (Path + '*.jpeg',faAnyFile - faDirectory,Rec) = 0 then
    try
        repeat
        ListBox1.Items.Add(Path + Rec.Name);
        until FindNext(Rec) <> 0;
    finally
    FindClose(Rec);
     end;
    if FindFirst (Path + '*.jpg',faAnyFile - faDirectory,Rec) = 0 then
    try
        repeat
        ListBox1.Items.Add(Path + Rec.Name);
        until FindNext(Rec) <> 0;
    finally
    FindClose(Rec);
    end;
    label5.Caption := inttostr(listbox1.Tag+1)+'/'+inttostr(listbox1.Count);
    listbox1.BringToFront
end;
procedure TForm1.MCBtn11Click(Sender: TObject);
begin
        if (listbox1.Count > 0) and (listbox1.Tag > 1) then
        begin
            listbox1.Tag := listbox1.Tag -1;
            listbox1.Selected[listbox1.Tag]:= true;
            image1.Picture.LoadFromFile(listbox1.Items[listbox1.Tag]);
        end;
end;

procedure TForm1.MCBtn10Click(Sender: TObject);
var
    l_img1,l_img2:Timage;
begin
        if  image2.Tag = 1 then
        begin
          l_img1 :=  image2;
          l_img2 :=   image1;
          image2.Tag := 0;
          image2.Visible:= false;
        end
        else
        begin
           l_img1 :=  image1;
           l_img2 :=   image2;
           image2.Tag := 1;
           image1.Visible:= false;
        end;
        l_img2.BringToFront;
        l_img2.Visible:= true;
        if (listbox1.Tag + 1 < listbox1.Count - 1) then
        begin
            listbox1.Tag := listbox1.Tag +1;
            listbox1.Selected[listbox1.Tag]:= true;
            l_Img1.Picture.LoadFromFile(listbox1.Items[listbox1.Tag]);
        end
        else
        if  listbox1.Count > 0 then
        begin
            listbox1.Tag := 0 ;
            listbox1.Selected[listbox1.Tag]:= true;
            l_Img1.Picture.LoadFromFile(listbox1.Items[listbox1.Tag]);
        end;
        label5.Caption := inttostr(listbox1.Tag+1)+'/'+inttostr(listbox1.Count);
end;

procedure TForm1.MCBtn12Click(Sender: TObject);
begin
        timer2.Enabled := not timer2.Enabled;
        if  timer2.Enabled then
        MCBtn12.Caption := '>>'
        else
        MCBtn12.Caption := '||';

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
         MCBtn10Click(self);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var
   i: integer;
begin
     for i := 0 to  listbox1.count -1 do
     begin
      if (  listbox1.Selected[i] = true ) then
     begin
     listbox1.Tag := i;
     image1.BringToFront;
     image1.Visible := true;
     image1.Picture.LoadFromFile(listbox1.Items[listbox1.Tag]);
     end;
     end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
      MCBtn10Click(self);
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
      MCBtn10Click(self);
end;

end.
