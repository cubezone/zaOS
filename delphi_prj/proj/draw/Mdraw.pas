unit Mdraw;

interface

uses
  MEvent,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, Contnrs,ExtCtrls, StdCtrls, Buttons, CheckLst,
  MPlayer,mmsystem, ActnList, MCBtn,jpeg;

type
TWavHeader = record //����һ��Wav�ļ�ͷ��ʽ  
rId : longint;  
rLen : longint;  
wId : longint;  
fId : longint;  
fLen : longint;  
wFormatTag : word;  
nChannels : word;  
nSamplesPerSec : longint;  
nAvgBytesPerSec : longint;  
nBlockAlign : word;  
wBitsPerSample : word;  
dId : longint;  
wSampleLength : longint;  
end;

  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    OpenDlg: TOpenDialog;
    ActionList1: TActionList;
    ActSave: TAction;
    ActLoad: TAction;
    ActRemoveUnchecked: TAction;
    ActCopyToOneNote: TAction;
    ActNew: TAction;
    ActCloseMonitor: TAction;
    Timer2: TTimer;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Panel1: TPanel;
    PaintBox2: TPaintBox;
    Splitter1: TSplitter;
    PaintBox1: TPaintBox;
    Panel4: TPanel;
    TabControlx: TTabControl;
    Panel5: TPanel;
    MCBtnAddTabX: TMCBtn;
    Panel2: TPanel;
    Panel6: TPanel;
    CLBAction: TCheckListBox;
    Panel11: TPanel;
    MCBtnRemove: TMCBtn;
    Panel3: TPanel;
    TabControly: TTabControl;
    Panel9: TPanel;
    MCBtnAddTabY: TMCBtn;
    Panel7: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ColorBox1: TColorBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    MCBtn3: TMCBtn;
    MCBtn5: TMCBtn;
    MCBtn6: TMCBtn;
    MCBtn7: TMCBtn;
    MCBtn8: TMCBtn;
    MCBtn15: TMCBtn;
    TabSheet2: TTabSheet;
    Panel8: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ProgressBar1: TProgressBar;
    Mp3player: TMediaPlayer;
    TrackBar1: TTrackBar;
    MCBtnMP3: TMCBtn;
    MCBtnPre: TMCBtn;
    MCBtnPause: TMCBtn;
    MCBtnPlay: TMCBtn;
    MCBtnNext: TMCBtn;
    CheckBoxrandom: TCheckBox;
    Panel13: TPanel;
    CLBSong: TCheckListBox;
    TabSheet3: TTabSheet;
    Splitter2: TSplitter;
    Panel12: TPanel;
    Label5: TLabel;
    MCBtn9: TMCBtn;
    MCBtn10: TMCBtn;
    MCBtn11: TMCBtn;
    MCBtn12: TMCBtn;
    MCBtn13: TMCBtn;
    MCBtnZoomIn: TMCBtn;
    MCBtnZoomOut: TMCBtn;
    Panel14: TPanel;
    ListBox1: TListBox;
    Panel15: TPanel;
    Image1: TImage;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Panel10: TPanel;
    MCBtn1: TMCBtn;
    TabSheet7: TTabSheet;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    MCBtnSendMsg: TMCBtn;
    Memo1: TMemo;
    Memo2: TMemo;
    ComboBox3: TComboBox;
    Edit4: TEdit;
    MCBtnSendAT: TMCBtn;
    MCBtnConnect: TMCBtn;
    TabSheet8: TTabSheet;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    MCBtn14: TMCBtn;
    EdCom: TEdit;
    Label18: TLabel;
    MediaPlayer1: TMediaPlayer;
    MCBtnRecStart: TMCBtn;
    MCBtnRecStop: TMCBtn;
    ColorBox2: TColorBox;
    Label19: TLabel;
    Label20: TLabel;
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
    procedure MCBtnAddTabXClick(Sender: TObject);
    procedure MCBtnAddTabYClick(Sender: TObject);
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
    procedure CLBSongDblClick(Sender: TObject);
    procedure MCBtnConnectClick(Sender: TObject);
    procedure MCBtn13Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure MCBtn15Click(Sender: TObject);
    procedure PaintBox1DblClick(Sender: TObject);
    procedure TabControlxChange(Sender: TObject);
    procedure TabControlyChange(Sender: TObject);
    procedure MCBtnZoomInClick(Sender: TObject);
    procedure MCBtnZoomOutClick(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MCBtnSendMsgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure MCBtnSendATClick(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure MCBtn14Click(Sender: TObject);
     procedure CreateWav(channels : word; resolution : word; rate : longint; fn : string);
    procedure MCBtnRecStartClick(Sender: TObject);
    procedure MCBtnRecStopClick(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);//�Զ���дһ��Wav�ļ�ͷ����

  private
    { Private declarations }
    function SEncodeMobNO(SmobNO: string): string;
    function BIsArea(SmobNO: string): string;
    function PduHead(SmobNO: string; IsSmc: boolean): string;
    function EncodeEnglish(Input: string): string;
    function EncodeChinese(Input: WideString): string;
    function isEnglish(sms: string): boolean;
    function MadeMsg(sms: string): string;
    function MadeSMS(SMC, NoHand, DesMob, SMS: string): string;
    function MadeSmsHead(Smc, NoHand, DesMobNo: string): string;
    procedure OpenComm;
    function SetMS(Handle: THandle; AtCommand: string): string;
    function ReadCom: string;
    function GetSMSLen(SMC, DesMob, SMS: string): integer;
    function readFlag: string;
  public
    { Public declarations }
    procedure mdraw();
  end;
var
  Form1: TForm1;
  i_down,o_x,o_y:integer;
  i_color :TColor;
  l_draw :TDraw;
  l_frames :TMFrames;
  l_frame :TMFrame;
  hcomm: Thandle;
  flag: boolean;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.paintbox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if (paintbox1.Tag = 1) then
   begin
        paintbox1.Canvas.LineTo(x,y);
        l_draw.m_list.Add(TClass(TEvent.Create(EID_PEN_LINETO,x,y,-1,-1)));
   end;
end;

procedure TForm1.paintbox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   paintbox1.Tag := 1;
   paintbox1.Canvas.MoveTo(x,y);
   paintbox1.Canvas.Pen.Style  := psSolid;
   l_draw := TDraw.Create(0);
   paintbox1.Canvas.Pen.Width := strtoint(combobox1.Text);
   l_draw.m_list.Add(TClass(TEvent.Create(EID_PEN_SIZE,x,y,paintbox1.Canvas.Pen.Width,-1)));
   paintbox1.Canvas.Pen.Color :=  colorbox1.Colors[colorbox1.ItemIndex];
   l_draw.m_list.Add(TClass(TEvent.Create(EID_PEN_COLOR,x,y,-1,colorbox1.ItemIndex)));
   l_draw.m_list.Add(TClass(TEvent.Create(EID_PEN_MOVE,x,y,-1,-1)));
end;

procedure TForm1.paintbox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   l_s :string;
begin
    paintbox1.Tag := 0;
    if (l_draw = nil ) then exit;
    if (l_draw.m_List.Count > 5 ) then
    begin
     l_draw.m_check := 1;
     l_s := '�ʻ�'+ inttostr(CLBAction.Count + 1) ;
     CLBAction.Items.InsertObject(0,l_s,l_draw.m_List);
     l_frames.getframe_xy(tabcontrolx.TabIndex,tabcontroly.TabIndex)
          .m_list.Insert(0,TClass(l_draw));
     CLBAction.Checked[0] := true;
    end
    else
    begin
     l_Draw.Free;
     l_draw := nil;
    end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
      l_frame.m_grid := combobox2.ItemIndex;
      Form1.mdraw();
end;

procedure TForm1.mdraw();
var
        i,m:integer;
        l_lst:TClassList;
        l_evt:TEvent;
        l_hig:integer;
begin
     paintbox2.Canvas.Brush.Style := bsSolid;
     paintbox2.Canvas.Brush.Color := Colorbox2.Selected;
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
var i: integer;
begin
   for i := 0 to clbaction.Count -1 do
   begin
     if clbaction.Checked[i] then
     begin
        TDraw(l_frames.getframe_xy(tabcontrolx.TabIndex,tabcontroly.TabIndex)
          .m_list.Items[i]).m_check := 1;
     end
     else
         TDraw(l_frames.getframe_xy(tabcontrolx.TabIndex,tabcontroly.TabIndex)
          .m_list.Items[i]).m_check := 0;
   end;
    Form1.mdraw();
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  InputString: string;
begin
  InputString :=InputBox('����', 'ҳ����',DateToStr(Date));
  if    inputstring <> '' then
  begin
  TabControlx.TabIndex := TabControlx.Tabs.Add(inputstring);
  TabControly.Tabs.Clear;
  TabControly.Tabs.Add('1');
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
        if checkboxrandom.Checked then
        BEGIN
        Randomize;
        OpenDlg.Tag := random(OpenDlg.Files.Count);
        END;
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

procedure TForm1.ActSaveExecute(Sender: TObject);
var
    l_file :TFileStream;
     l_savedlg:TSavedialog;
begin
    l_savedlg :=  TSavedialog.Create(self);
    l_savedlg.Filter :=  'NFS files (*.nfs)|*.nfs|All files (*.*)|*.*';
    if l_savedlg.Execute then
    begin
     ActRemoveUncheckedExecute(self);
     l_file:=TFileStream.Create(l_savedlg.FileName, fmCreate);
     l_file.Write('NFS_A230',8);
     l_frames.SavetoFile(l_file);
     l_file.Free;
    end;
    l_savedlg.Free;
end;

procedure TForm1.ActLoadExecute(Sender: TObject);
var
    i,m,len:integer;
    l_file :TFileStream;
    l_opendlg:TOpendialog;
begin
    l_opendlg :=  TOpendialog.Create(self);
    l_opendlg.Filter :=  'NFS files (*.nfs)|*.nfs|All files (*.*)|*.*';
    l_opendlg.Options:= OpenDlg.Options + [ofFileMustExist];
    clbAction.Clear;
    if l_opendlg.Execute then
    begin
    l_file:=TFileStream.Create(l_opendlg.FileName, fmOpenRead);
    CLBAction.Clear;
    l_file.Read(len,4);l_file.Read(len,4);
    CLBAction.Hide;
    tabcontrolx.Tabs.clear;
    tabcontroly.Tabs.clear;
    l_frames.LoadFromFile(l_file);
    if l_frames.m_list.Count > 0 then
    begin
        l_frame := TMFrame(l_frames.getframe_xy(0,0));
        l_frame.assignlayout(clbAction);
        colorbox1.ItemIndex := l_frame.m_pencolorindex;
        colorbox2.ItemIndex := l_frame.m_bgcolorindex;
        combobox2.ItemIndex  := l_frame.m_grid;
        combobox1.ItemIndex := l_frame.m_penthick;
        for i := 0 to l_frames.m_list.Count -1 do
        begin
           if (TMFrame(l_frames.m_list[i]).m_x > tabcontrolx.Tabs.Count-1) then
           begin
              len := TMFrame(l_frames.m_list[i]).m_x - tabcontrolx.Tabs.Count ;
               for m := len downto 0  do
               tabcontrolx.Tabs.Add(TMFrame(l_frames.m_list[m]).m_caption);
           end;
           if TMFrame(l_frames.m_list[i]).m_x = 0 then
                tabcontroly.Tabs.Add(inttostr(tabcontroly.Tabs.Count+1));
        end
    end;
    CLBAction.Show;
    l_file.Free;
    mdraw;
    end;
    l_opendlg.free;
end;

procedure TForm1.ActRemoveUncheckedExecute(Sender: TObject);
var i,m,n : integer;
begin
    n := CLBAction.Items.Count -1 ;
    for  i := 0 to  n do
    begin
        for m := 0 to CLBAction.Items.Count -1 do
        if not CLBAction.Checked[m] then
        begin
         CLBAction.Items.Delete(m);
          l_frames.getframe_xy(tabcontrolx.TabIndex,tabcontroly.TabIndex)
          .m_list.Delete(m);
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
        if  CLBAction.Checked[i] then
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
    end;
    application.Restore;
end;

procedure TForm1.Button4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
        setcapture(handle); // ���ò���������� 
end;

procedure TForm1.Button4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
ReleaseCapture; // ��ֹ�����������
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
        if l_frames <> nil then
              l_frames.Free;
        tabcontrolx.Tabs.Clear;
        tabcontroly.Tabs.Clear;
        l_frames := TMFrames.Create('test.nfs');
        MCBtnAddTabXClick(self);
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
var
        i: integer;
begin
  Timer1.Enabled := false;
  clbsong.Clear;
  mp3player.Close;
 OpenDlg.Filter :=  'Mp3 files (*.mp3)|*.mp3|Asf files (*.asf)|*.asf|wmv files (*.wmv)|*.wmv|All files (*.*)|*.*';
 OpenDlg.Options:= OpenDlg.Options + [ofAllowMultiSelect, ofFileMustExist];
 if OpenDlg.Execute then
 begin
    mp3player.FileName := OpenDlg.Files[0];
    OpenDlg.Tag := 0;
    Sleep(200);
    clbsong.Visible := false;
    for i := 0 to OpenDlg.Files.Count -1 do
    begin
        clbsong.Items.Insert(i,OpenDlg.Files[i]);
        clbsong.Checked[i] := true;
    end;
    MCBtnPlayClick(self);
    Timer1.Enabled := true;
    clbsong.Visible := true;
    end
end;

procedure TForm1.MCBtnAddTabXClick(Sender: TObject);
var
  InputString: string;
begin
  InputString :=DateToStr(Date);
  if InputQuery('����', 'ҳ����',Inputstring) then
  begin
  TabControlx.TabIndex := TabControlx.Tabs.Add(inputstring);
  TabControly.Tabs.Clear;
  TabControly.Tabs.Add('1');
  l_frame := TMFrame.Create(tabcontrolx.Tabs.Count-1,0,inputstring);
  l_frame.assignlayout(clbaction);
  l_frames.m_list.Insert(0,TClass(l_frame));
  end;
end;

procedure TForm1.MCBtnAddTabYClick(Sender: TObject);
begin
  tabcontroly.Tabs.Add(inttostr(TabControly.Tabs.Count+1));
  l_frame := TMFrame.Create(tabcontrolx.TabIndex,tabcontroly.Tabs.Count-1,tabcontrolx.Tabs[tabcontrolx.TabIndex]);
  l_frame.assignlayout(clbaction);
  l_frames.m_list.Insert(0,TClass(l_frame));
end;

procedure TForm1.MCBtnPreClick(Sender: TObject);
begin
   if checkboxrandom.Checked then
   begin
        Randomize;
        OpenDlg.Tag := random(OpenDlg.Files.Count);
   END;
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
        try

        if   (mp3player.Mode <> mpPaused) then
        begin
                FillID3TagInformation(mp3player.FileName,Label6,Label7,Label6,Label7,Label6,Label7);
                mp3player.Open;
        end;
        ProgressBar1.Max := mp3player.Length ;
        mp3player.play;
        Label4.Caption := inttostr(OpenDlg.Tag + 1) + '/' + inttostr(OpenDlg.Files.Count);
        clbsong.Selected[opendlg.Tag] := true;
        except
          MCBtnNextClick(self);
        end;
   end;
end;

procedure TForm1.MCBtnNextClick(Sender: TObject);
begin
   if checkboxrandom.Checked then
   begin
        Randomize;
        OpenDlg.Tag := random(OpenDlg.Files.Count);
   end;
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
     paintbox1.Canvas.Brush.Color := colorbox2.Colors[colorbox2.ItemIndex];
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
        panel15.Caption := 'Loading ...';
    end
    else
    begin
        l_opendlg.free;
        panel15.Caption := '';
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
   l_img1:Timage;
   l_timer:Integer;
begin
        l_img1 :=  image1;
        l_timer := 0;
        if timer2.Enabled  then
        begin
                timer2.Enabled := false;
                l_timer := 1;
        end;
        if (listbox1.Tag < listbox1.Count - 1) then
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
        if l_timer = 1 then timer2.Enabled := true;
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
//      MCBtn10Click(self);
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
      MCBtn10Click(self);
end;

procedure TForm1.CLBSongDblClick(Sender: TObject);
var i :integer;
begin
     for i := 0 to clbsong.count -1 do
     begin
      if (  clbsong.Selected[i] = true ) then
     begin
       OpenDlg.Tag := i;
       ProgressBar1.Position := 0;
     mp3player.Close;
     mp3player.FileName := OpenDlg.Files[OpenDlg.Tag];
     MCBtnPlayClick(self);
     end;
     end;
end;

procedure TForm1.MCBtnConnectClick(Sender: TObject);
begin
  edit4.Visible := false;
  flag := false;
  opencomm;
//  sleep(100);
  if (pos('OK', SetMS(hcomm, 'AT' + #13)) <> 0) then
  begin
        statusbar1.Panels[0].text :=  SetMS(hcomm, 'AT+GMM' + #13);
        statusbar1.Panels[1].text := '�Ѿ�������....'
  end
  else
        statusbar1.Panels[1].text := '��������....';
end;

procedure TForm1.MCBtn13Click(Sender: TObject);
begin
        image1.Parent := formfull;
        Formfull.show;
        formfull.Color := clblack;
        Screen.cursor  := crNone ;
end;

procedure TForm1.Image1DblClick(Sender: TObject);
begin
        if image1.Parent = formfull then
        begin
          image1.Parent := panel15;
          formfull.Hide;
          Screen.cursor  := crDefault;
        end;
end;

procedure TForm1.MCBtn15Click(Sender: TObject);
begin
        Formfull.Color := clwhite;
        Formfull.show;
        paintbox1.Parent  := formfull;
        paintbox2.Parent  := formfull;
        paintbox1.BringToFront;
        mdraw;
end;

procedure TForm1.PaintBox1DblClick(Sender: TObject);
begin
    paintbox1.Tag := 0;
    if paintbox1.Parent = formfull then
    begin
          paintbox1.Parent := panel1;
          paintbox2.Parent := panel1;
          paintbox1.BringToFront;
          formfull.Hide;
    end;
    sendmessage(panel1.handle,WM_LBUTTONUP,0,0);
end;

procedure TForm1.TabControlxChange(Sender: TObject);
var i,n,m :integer;
begin
        n := 1;
        tabcontroly.Tabs.Clear;
        l_frame:=l_frames.getframe_xy(tabcontrolx.TabIndex,0);
        l_frame.assignlayout(clbaction);
        colorbox1.ItemIndex := l_frame.m_pencolorindex;
        colorbox2.ItemIndex := l_frame.m_bgcolorindex;
        combobox2.ItemIndex  := l_frame.m_grid;
        combobox1.ItemIndex := l_frame.m_penthick;
        for i := 0 to l_frames.m_list.Count - 1 do
         if (TMFrame(l_frames.m_list[i]).m_x = tabcontrolx.TabIndex) then
         begin
          if (TMFrame(l_frames.m_list[i]).m_y > tabcontroly.Tabs.Count -1 )then
            begin
             for m := 0 to  TMFrame(l_frames.m_list[i]).m_y - tabcontroly.Tabs.Count do
             begin
             tabcontroly.Tabs.Add(inttostr(n));
             inc(n);
             end;
            end;
         end;
        mdraw();
end;

procedure TForm1.TabControlyChange(Sender: TObject);
begin
        l_frame:=l_frames.getframe_xy(tabcontrolx.TabIndex,tabcontroly.TabIndex);
        l_frame.assignlayout(clbaction);
        colorbox1.ItemIndex := l_frame.m_pencolorindex;
        colorbox2.ItemIndex := l_frame.m_bgcolorindex;
        combobox2.ItemIndex  := l_frame.m_grid;
        combobox1.ItemIndex := l_frame.m_penthick;
        mdraw();
end;

procedure TForm1.MCBtnZoomInClick(Sender: TObject);
begin
        image1.Align := alNone;
        image1.Left := image1.Left - image1.Width div 4;
        image1.Top := image1.top - image1.Height div 4;
        image1.Width := image1.Width*150 div 100;
        image1.Height := image1.Height*150 div 100;
end;

procedure TForm1.MCBtnZoomOutClick(Sender: TObject);
begin
        image1.Align := alNone;
        image1.Top := image1.Top + image1.Height * 100 div 300;
        image1.Left := image1.Left + image1.Width * 100 div 300;
        image1.Width := image1.Width*100 div 150;
        image1.Height := image1.Height*100 div 150;
        if (image1.Width < image1.Parent.Width )and
        (image1.Height < image1.Parent.Height )then
        begin
        image1.Left := (image1.Parent.Width - image1.Width) div 2;
        image1.Top := (image1.Parent.Height - image1.Height) div 2;
        end;

end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i : integer;
begin
  if i_down = 1 then
  begin
   i := x - o_x ;
   image1.Left := image1.Left + i ;
   i := y - o_y ;
   image1.Top := image1.Top + i ;
  end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   o_x := x;
   o_y := y;
   i_down := 1;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    i_down := 0;
end;


function TForm1.SEncodeMobNO(SmobNO: string): string;
var
  TempPchar: Pchar;
  i: integer;
  Str: string;
begin
  if (copy(smobno, 1, 1) = '+') then //�ж��Ƿ�������ұ���
    SmobNO := copy(smobno, 2, length(smobno) - 1); //ȥ���ֻ������е�'+'

  if ((length(SmobNO) mod 2) = 1) then
    SmobNO := SmobNO + 'F';

  TempPchar := Pchar(SmobNO); //���ַ��� Char���黯

  i := 0;
  Str := '';
  while i < length(TempPchar) do begin
    Str := Str + TempPchar[i + 1] + TempPchar[i];
    i := i + 2;
  end;
  result := Str;
end;

procedure TForm1.opencomm;
var cc: tcommconfig;
  CommNO: string;
begin
  CommNO := edcom.Text;
  hcomm := CreateFile(pchar(CommNO), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, 0, 0); //�Զ�д��ʽ��com1
  if (hcomm = invalid_handle_value) then
  begin
    messagebox(0, '��ͨ�Ŷ˿�ʧ��,������������ռ�ã����ȹر�!', '', mb_ok);
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
    exit;
  end;
end;

 

function TForm1.SetMS(Handle: THandle; AtCommand: string): string;
var
  lrc: longword;
begin
  WriteFile(Handle, pchar(AtCommand)^, length(AtCommand), lrc, nil);
  sleep(200);
  result := ReadCom;
end;


function TForm1.readcom: string;
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

{���ظ��ֻ���ŵ���λ�����־
   SmobNO:string �ֻ�����}

function TForm1.BIsArea(SmobNO: string): string;
var
  Area: array[boolean] of pchar;
  BFlag: boolean;
begin
  Area[true] := '91'; //�й��ұ���
  Area[false] := '81'; //�޹��ұ���
  BFlag := false;
  if (copy(smobno, 1, 1) = '+') then //�ж��Ƿ�������ұ���
    BFlag := true;
  result := string(Area[Bflag]);
end;

procedure TForm1.MCBtnSendMsgClick(Sender: TObject);
var s: string;
  NoHand: string;
  i : integer ;
begin
   i := 1;
  s := 'AT+CMGF=0' + #13 + 'AT+CMGS=' + inttostr(GETSMSLEN(EDIT2.Text, EDIT1.Text, EDIT3.Text)) + #13;
  s := SetMS(hcomm, s);
  Memo1.Lines.Add(s);

  if (isEnglish(EDIT3.Text)) then
    NoHand := '0'
  else
    NoHand := '8';

  if flag then
    NoHand := '1' + NoHand
  else
    NoHand := '0' + NoHand;
  while true do begin
    i := i +1;
    if i = 100 then
        exit;
    Application.ProcessMessages;
    if (pos('>', s) <> 0) then begin
      Memo1.Lines.Add(SetMS(hcomm, MadeSMS(EDIT2.Text, NoHand, EDIT1.Text, EDIT3.Text) + #26));
      Memo1.Lines.Add(readFlag);
      break;
    end;
  end;

end;

function TForm1.readFlag(): string;
var s: string;
begin
  s := '';
  while true do begin
    Application.ProcessMessages;
    s := readcom;
    if (pos('OK', s) <> 0) then begin
      s := 'SMS Send success';
      break;
    end else if (pos('ERROR', s) <> 0) then begin
      s := 'SMS Send Fault';
      break;
    end;
  end;
  result := s;
end;

//����Ŀ�����

function TForm1.PduHead(SmobNO: string; IsSmc: boolean): string;
var
  SMob: string;
  IsArea: string;
  i: integer;
begin
  smob := SEncodeMobNO(Smobno); //�������
  IsArea := BIsArea(smobno); //ȡ�ù��ʸ�ʽ��־

  i := length(smob);
  if not isSmc then begin
    if ((copy(smob, length(smob) - 1, 1) = 'f') or (copy(smob, length(smob) - 1, 1) = 'F')) then //����������һλΪ'f',�򳤶�-1
      i := i - 1;
  end else
    i := length(IsArea + Smob) div 2;
  result := format('%2.2x', [i]) + IsArea + smob;
end;


 //����תucs����

function TForm1.EncodeChinese(Input: WideString): string;
var //'��' -->  '857E'
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Input) do
    Result := Result + Format('%4.4x', [ord(Input[i])]);
end;

 //Ӣ��תpdu����

function TForm1.EncodeEnglish(Input: string): string;
var
  i, j, len: Integer;
  cur: Integer;
  t: string;
begin
  Result := '';
  len := Length(Input);
  i := 1;
  j := 0; //j ������λ����
  while i <= len do begin
    if i < len then
      cur := (ord(Input[i]) shr j) or ((ord(Input[i + 1]) shl (7 - j)) and $FF) //���ݱ任
    else
      cur := (ord(Input[i]) shr j) and $7F;
    FmtStr(t, '%2.2x', [cur]);
    Result := Result + t;
    inc(i);
    j := (j + 1) mod 7; //��λ�����ﵽ7λ���ر���
    if j = 0 then inc(i);
  end;
end;

function TForm1.isEnglish(sms: string): boolean;
var i: integer;
begin
  result := true;
  for i := 0 to length(sms) do begin
    if ord(sms[i]) > $80 then result := false;
  end;
end;

function TForm1.MadeMsg(sms: string): string;
begin
  result := '';
  if (sms = '') then exit;
  if (isEnglish(sms)) then begin
    if length(sms) <= 160 then
      result := EncodeEnglish(sms)
  end else begin
    if length(sms) <= 70 then
      result := self.EncodeChinese(sms);
  end;
end;

function TForm1.MadeSmsHead(Smc, NoHand, DesMobNo: string): string;
var SmcHead, desMob: string;
  flagRep: string;

begin
  flagRep := '11'; //����Ϊ11  ��Ҫ״̬����31
  SmcHead := '00';
  if Smc <> '' then begin
    SmcHead := PduHead(Smc, true);
  end;
  desMob := PduHead(DesMobNo, false);
  result := smcHead + flagRep + '00' + desMob + '00' + NoHand + 'A7'
end;

function TForm1.GetSMSLen(SMC, DesMob, SMS: string): integer;
begin
  if self.isEnglish(sms) then
    result := 5 + (length(PduHead(DesMob, false) + format('%2.2x', [length(MadeMsg(SMS)) * 8 div 14]) + MadeMsg(SMS))) div 2
  else
    result := 5 + (length(PduHead(DesMob, false) + format('%2.2x', [length(MadeMsg(SMS)) div 2]) + MadeMsg(SMS))) div 2
end;

function TForm1.MadeSMS(SMC, NoHand, DesMob, SMS: string): string;
begin
  if self.isEnglish(sms) then
    result := MadeSmsHead(SMC, NoHand, DesMob) + format('%2.2x', [length(MadeMsg(SMS)) * 8 div 14]) + MadeMsg(SMS)
  else
    result := MadeSmsHead(SMC, NoHand, DesMob) + format('%2.2x', [length(MadeMsg(SMS)) div 2]) + MadeMsg(SMS)
end;


procedure TForm1.CheckBox1Click(Sender: TObject);
begin
    flag := CheckBox1.Checked;
end;

procedure TForm1.MCBtnSendATClick(Sender: TObject);
var
  s: string;
begin
   s := 'AT' + Combobox3.Text + #13;
   if   Edit4.Visible then
   s := 'AT' + Combobox3.Text + ' '+ edit4.Text + #13;
   s := SetMS(hcomm, s);
   Memo2.Clear;
   Memo2.Lines.Add(s);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  CloseHandle(hcomm); //�ر�com1���
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  MyWaveOutCaps: TWaveOutCaps;
  Volume: DWord;
//style : Cardinal ;
begin
//  style := GetWindowLong (ProgressBar1.Handle, GWL_EXSTYLE) ;
//  style := style AND NOT WS_EX_STATICEDGE ;
//С  SetWindowLong (ProgressBar1.Handle, GWL_EXSTYLE, style) ;
 if WaveOutGetDevCaps(
    WAVE_MAPPER,
    @MyWaveOutCaps,
    sizeof(MyWaveOutCaps))=MMSYSERR_NOERROR then
  begin
    WaveOutGetVolume(WAVE_MAPPER, @Volume);
  end;
  Volume:= Volume and $0000ffff;
  trackbar1.Position :=  Volume div 3200;
  l_frames := TMFrames.Create(DateToStr(Date)+'.nfs');
  l_frame := TMFrame.Create(0,0,'1');
  l_frame.assignlayout(clbaction);
  l_frames.m_list.Insert(0,TClass(l_frame));
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
         if combobox3.Text = '+CDV' then
          Edit4.Visible := true
        else
          Edit4.Visible := false;
end;

procedure TForm1.MCBtn14Click(Sender: TObject);
begin
      image1.Align := alclient;
end;
procedure TForm1.CreateWav( channels : word; { 1(����)����2(������) } 
resolution : word; { 8����16,����8λ��16λ���� } 
rate : longint; { ����Ƶ��,��11025,22050, 44100} 
fn : string { ��Ӧ���ļ����� } ); 
var 
wf : file of TWavHeader; 
wh : TWavHeader; 
begin 
wh.rId := $46464952;  
wh.rLen := 36;  
wh.wId := $45564157;  
wh.fId := $20746d66;  
wh.fLen := 16;  
wh.wFormatTag := 1;  
wh.nChannels := channels;  
wh.nSamplesPerSec := rate;  
wh.nAvgBytesPerSec := channels*rate*(resolution div 8); 
wh.nBlockAlign := channels*(resolution div 8); 
wh.wBitsPerSample := resolution; 
wh.dId := $61746164;  
wh.wSampleLength := 0;  

assignfile(wf,fn); {�򿪶�Ӧ�ļ� }  
rewrite(wf); {�ƶ�ָ�뵽�ļ�ͷ}  
write(wf,wh); {д���ļ�ͷ }  
closefile(wf); {�ر��ļ� }  
end;

procedure TForm1.MCBtnRecStartClick(Sender: TObject);
var
  l_opendlg:TOpendialog;
begin
    l_opendlg :=  TOpendialog.Create(self);
try
    l_opendlg.Filter :=  'wav files (*.wav)|*.wav|All files (*.*)|*.*';
    if l_opendlg.Execute then
    begin
//�ڳ���ǰĿ¼�´���һ��Wav�ļ�Temp.wav
CreateWav(1, 8, 11025, l_opendlg.FileName);
MediaPlayer1.DeviceType := dtAutoSelect; 
MediaPlayer1.FileName := l_opendlg.filename;
MediaPlayer1.Open; 
MediaPlayer1.StartRecording;
MCBtnRecStart.Enabled:=false;
MCBtnRecStop.Enabled:=true;
end;
l_Opendlg.Free;
except 
MCBtnRecStart.Enabled:=True;
MCBtnRecStop.Enabled:=false;
l_Opendlg.Free;
Application.MessageBox('ý���豸��ʼ��ʧ�ܣ�','����',MB_ICONERROR+MB_OK); 
end;
end;

procedure TForm1.MCBtnRecStopClick(Sender: TObject);
begin
try
MediaPlayer1.Stop;
MediaPlayer1.Save;
MediaPlayer1.Close;
Application.MessageBox('����¼�����!','��Ϣ',MB_ICONINFORMATION+MB_OK);
MCBtnRecStart.Enabled:=True;
MCBtnRecStop.Enabled:=false;
except
Application.MessageBox('���������ļ�����!','����',MB_ICONERROR+MB_OK);
MCBtnRecStart.Enabled:=True;
MCBtnRecStop.Enabled:=false;
end;
end;

procedure TForm1.ColorBox2Change(Sender: TObject);
begin
    l_frame.m_bgcolorindex := colorbox2.ItemIndex;
    mdraw();
end;

procedure TForm1.ColorBox1Change(Sender: TObject);
begin
    l_frame.m_pencolorindex := colorbox1.ItemIndex;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
    l_frame.m_penthick := combobox1.ItemIndex;
end;

end.
