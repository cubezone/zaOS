unit HandBlogImpl;
{$WARN SYMBOL_PLATFORM OFF}
{
//2005-08-10 created.
//2005-10-20 support对象的resize.move
//2005-11-20 support对象的batch select
//2005-12-20 support filet save & load.
//2006-03-20 draw pic with dual buffer technolgy。
//2006-04-20 support键盘Ctrl C
//2006-06-20 modify 输出为xml格式文件。
//2006-07-20 add emf 文件格式的保存。
//2006-08-20 enhance drawing obj's color , shadow, text align etc.
//2006-10-20 add batch Ctrl +C copy & Ctrl +V paste object.
//2006-10-23 add align top,bottom,left,right, same width,height.
//2006-11-13 add play moive funtion,asf,mov
}
interface

uses


   MEvent,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ActiveX, AxCtrls, HandBlogProj_TLB,  Menus, ComCtrls, ToolWin, Contnrs,ExtCtrls,
  StdCtrls, Buttons, CheckLst, ComServ,
  MPlayer,mmsystem, ActnList, MCBtn,jpeg, Grids, xmldom, XMLIntf, msxmldom,
  XMLDoc, OleCtnrs,ComObj, Clipbrd ,Math,ShellAPI, Spin, ImgList,
  ValEdit, StdVcl;

type
TWavHeader = record //定义一个Wav文件头格式
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

Tarea = class (Tobject)
public
     m_top : integer;
     m_buttom : integer;
     m_bookid : string;
     m_type : string;
     m_font : string;
     m_time : string;
     m_seq : string;
     m_hide : bool;
end;

Tpic = class (Tobject)
public
     m_pic : tpicture;
     m_filename : string ;
end;

THandBlog = class(TActiveForm, IHandBlog)
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
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Panel10: TPanel;
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
    Panel16: TPanel;
    StringGrid1: TStringGrid;
    Panel17: TPanel;
    MCBtn1: TMCBtn;
    Button1: TButton;
    TabSheet6: TTabSheet;
    Button2: TButton;
    TabSheet9: TTabSheet;
    RichEdit1: TRichEdit;
    OpenDialog1: TOpenDialog;
    XMLDoc: TXMLDocument;
    Button4: TButton;
    Panel19: TPanel;
    SG: TStringGrid;
    Splitter4: TSplitter;
    Panel_head: TPanel;
    Edit5: TEdit;
    Btn_filter: TButton;
    aa: TPanel;
    Memo3: TMemo;
    CB_AllBook: TCheckBox;
    CB_BookContent: TCheckBox;
    Splitter6: TSplitter;
    Panel21: TPanel;
    Panel23: TPanel;
    Btn_edit: TButton;
    RadioButton1: TRadioButton;
    RB_edit: TRadioButton;
    Btn_refresh: TButton;
    FontDialog1: TFontDialog;
    PageControl2: TPageControl;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    Button9: TButton;
    Panel18: TPanel;
    Button7: TButton;
    Panel24: TPanel;
    LB_Collect: TListBox;
    Panel25: TPanel;
    Btn_lib: TButton;
    Btn_font: TButton;
    Button5: TButton;
    Panel20: TPanel;
    TabSheet13: TTabSheet;
    Memo4: TMemo;
    Button6: TButton;
    SE_Line: TSpinEdit;
    PageControl3: TPageControl;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    TV_Books: TTreeView;
    PageControl4: TPageControl;
    TabSheet16: TTabSheet;
    OleN: TOleContainer;
    ListBox3: TListBox;
    Panel26: TPanel;
    Button3: TButton;
    Splitter3: TSplitter;
    TabSheet17: TTabSheet;
    Img_doc_pic: TImage;
    Button8: TButton;
    PM_Book: TPopupMenu;
    Ndelete: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Button10: TButton;
    ImageList1: TImageList;
    Lv_obj: TListView;
    ScrollBox1: TScrollBox;
    PaintBox4: TPaintBox;
    TabSheet18: TTabSheet;
    ListBox2: TListBox;
    Memo6: TMemo;
    Work1: TMenuItem;
    rip1: TMenuItem;
    Info1: TMenuItem;
    Poject1: TMenuItem;
    CB_Line: TCheckBox;
    Button14: TButton;
    TabSheet19: TTabSheet;
    Image1: TImage;
    PaintBox3: TPaintBox;
    Image2: TImage;
    Memo_his: TMemo;
    Panel27: TPanel;
    Splitter5: TSplitter;
    Button_Locate: TButton;
    Button12: TButton;
    TabSheet20: TTabSheet;
    Button13: TButton;
    Panel22: TPanel;
    Splitter7: TSplitter;
    Memo5: TMemo;
    Memo7: TMemo;
    Panel28: TPanel;
    Button15: TButton;
    Button11: TButton;
    Button16: TButton;
    Button19: TButton;
    procedure paintbox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure paintbox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure paintbox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox2Change(Sender: TObject);
    procedure CLBActionClickCheck(Sender: TObject);
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
    procedure ComboBox1Change(Sender: TObject);
    procedure PaintBox2DblClick(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure PaintBox3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Btn_filterClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Btn_libClick(Sender: TObject);
    procedure SGMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Btn_editClick(Sender: TObject);
    procedure Btn_refreshClick(Sender: TObject);
    procedure Memo3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Btn_fontClick(Sender: TObject);
    procedure RB_editClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure Edit5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NdeleteClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure TV_BooksChange(Sender: TObject; Node: TTreeNode);
    procedure TV_BooksEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure TV_BooksEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure Lv_objDblClick(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure ScrollBox1Resize(Sender: TObject);
//    procedure Button13Click(Sender: TObject);
    procedure PaintBox4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Memo6Exit(Sender: TObject);
    procedure Button_recalClick(Sender: TObject);
    procedure Memo6KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ScrollBox1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ScrollBox1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Work1Click(Sender: TObject);
    procedure rip1Click(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure Poject1Click(Sender: TObject);
    procedure CB_LineClick(Sender: TObject);
    procedure PaintBox4DblClick(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure PaintBox3Paint(Sender: TObject);
    procedure PaintBox4Paint(Sender: TObject);
    procedure TV_BooksDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TV_BooksDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PaintBox4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TabSheet15Resize(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TabSheet19Show(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button_LocateClick(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);

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
    procedure doc_recal();
    procedure mdraw();
    procedure doc_filter();
    procedure doc_repaint();

    procedure ActiveFormCreate(Sender: TObject);
  private
    { Private declarations }
    FEvents: IHandBlogEvents;
    procedure ActivateEvent(Sender: TObject);
    procedure ClickEvent(Sender: TObject);
    procedure CreateEvent(Sender: TObject);
    procedure DblClickEvent(Sender: TObject);
    procedure DeactivateEvent(Sender: TObject);
    procedure DestroyEvent(Sender: TObject);
    procedure KeyPressEvent(Sender: TObject; var Key: Char);
    procedure PaintEvent(Sender: TObject);
  protected
    { Protected declarations }
    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    function Get_Active: WordBool; safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_AutoScroll: WordBool; safecall;
    function Get_AutoSize: WordBool; safecall;
    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    function Get_Caption: WideString; safecall;
    function Get_Color: OLE_COLOR; safecall;
    function Get_Cursor: Smallint; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    function Get_DropTarget: WordBool; safecall;
    function Get_Enabled: WordBool; safecall;
    function Get_Font: IFontDisp; safecall;
    function Get_HelpFile: WideString; safecall;
    function Get_HelpKeyword: WideString; safecall;
    function Get_HelpType: TxHelpType; safecall;
    function Get_KeyPreview: WordBool; safecall;
    function Get_PixelsPerInch: Integer; safecall;
    function Get_PrintScale: TxPrintScale; safecall;
    function Get_Scaled: WordBool; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    procedure AboutBox; safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    procedure Set_Cursor(Value: Smallint); safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    procedure Set_HelpKeyword(const Value: WideString); safecall;
    procedure Set_HelpType(Value: TxHelpType); safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_host: WideString; safecall;
    procedure Set_host(const Value: WideString); safecall;
    procedure change(const name: WideString); safecall;
    procedure cc(cc: Integer; ee: PWideChar); safecall;
  public
    { Public declarations }
    procedure Initialize; override;
  end;
var
  Form1: THandBlog;
  i_down,o_x,o_y:integer;
  m_x,m_y : integer;
  i_color :TColor;
  l_draw :TDraw;
  l_frames :TMFrames;
  l_frame :TMFrame;
  hcomm: Thandle;
  flag: boolean;
  mouse:Tmouse;
  l_pagenum: integer;
   m_bookid :string;
   l_mousey : integer;
   m_list :Tlist;
   m_p :Tpoint;
   l_margin :integer;
//  l_my:mysql;
  m_pic_width , m_pic_height :integer;
  m_pic_list :Tlist;
implementation

//uses Unit2, FramDraw, OOB;
uses Unit2;//FramDraw, OOB;
{$R *.dfm}

procedure THandBlog.paintbox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if (paintbox1.Tag = 1) and (panel1.Tag = 0) then
   begin
        paintbox1.Canvas.LineTo(x,y);
        l_draw.m_list.Add(TClass(TEvent.Create(EID_PEN_LINETO,x,y,-1,-1)));
   end
   else
   begin
         panel1.Tag := 0;
         paintbox1.Tag := 0;
   end;
end;

procedure THandBlog.paintbox1MouseDown(Sender: TObject; Button: TMouseButton;
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

procedure THandBlog.paintbox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   l_s :string;
begin
    paintbox1.Tag := 0;
    if (l_draw = nil ) then exit;
    if (l_draw.m_List.Count > 5 ) then
    begin
     l_draw.m_check := 1;
     l_s := '笔画'+ inttostr(CLBAction.Count + 1) ;
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

procedure THandBlog.ComboBox2Change(Sender: TObject);
begin
      l_frame.m_grid := combobox2.ItemIndex;
      mdraw();
end;

procedure THandBlog.mdraw();
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
     if paintbox1.Parent = formfull then
     begin
        paintbox1.Canvas.Pen.Width := 1;
        paintbox1.Canvas.Pen.Color := clgray;
        paintbox1.Canvas.Rectangle
        (paintbox1.Width - 20,
         paintbox1.Height - 20,
         paintbox1.Width - 2,
         paintbox1.Height - 2
         );
         paintbox1.Canvas.MoveTo(paintbox1.Width -20,paintbox1.Height - 20);
         paintbox1.Canvas.LineTo(paintbox1.Width - 2,paintbox1.Height - 2);
         paintbox1.Canvas.MoveTo(paintbox1.Width - 2,paintbox1.Height - 20);
         paintbox1.Canvas.LineTo(paintbox1.Width - 20,paintbox1.Height - 2);
     end
end;
procedure THandBlog.CLBActionClickCheck(Sender: TObject);
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
   mdraw();
end;

procedure THandBlog.Timer1Timer(Sender: TObject);

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
    begin
        ProgressBar1.Position :=  mp3player.Position ;
    end;
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

procedure THandBlog.ProgressBar1MouseDown(Sender: TObject;
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

procedure THandBlog.ButtonPauseClick(Sender: TObject);
begin
    if (mp3player.Mode = mpPlaying) then
        mp3player.Pause;
end;

procedure THandBlog.TrackBar1Change(Sender: TObject);
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

procedure THandBlog.ActSaveExecute(Sender: TObject);
var
     l_file :TFileStream;
     l_savedlg:TSavedialog;
begin
    l_savedlg :=  TSavedialog.Create(self);
    l_savedlg.Filter :=  'NFS files (*.nfs)|*.nfs|All files (*.*)|*.*';
    l_savedlg.FileName := 'NFS_' + DateToStr(Date);
    if l_savedlg.Execute then
    begin
     ActRemoveUncheckedExecute(self);
     l_file:=TFileStream.Create(l_savedlg.FileName+'.nfs', fmCreate);
     l_file.Write('NFS_A230',8);
     l_frames.SavetoFile(l_file);
     l_file.Free;
    end;
    l_savedlg.Free;
end;

procedure THandBlog.ActLoadExecute(Sender: TObject);
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
    l_pagenum:= tabcontrolx.Tabs.Count;
    CLBAction.Show;
    l_file.Free;
    mdraw;
    end;
    l_opendlg.free;
end;

procedure THandBlog.ActRemoveUncheckedExecute(Sender: TObject);
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

procedure THandBlog.ActCopyToOneNoteExecute(Sender: TObject);
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

procedure THandBlog.Button4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
        setcapture(handle); // 设置捕获鼠标输入
end;

procedure THandBlog.Button4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
ReleaseCapture; // 终止捕获鼠标输入
end;

procedure THandBlog.PaintBox1Paint(Sender: TObject);
begin
        mdraw;
end;

procedure THandBlog.ActNewExecute(Sender: TObject);
begin
        CLBAction.Clear;
        mdraw();
        l_pagenum:=0;
        paintbox1.BringToFront;
        if l_frames <> nil then
              l_frames.Free;
        tabcontrolx.Tabs.Clear;
        tabcontroly.Tabs.Clear;
        l_frames := TMFrames.Create(datetostr(date)+'.nfs');
        MCBtnAddTabXClick(self);
end;

procedure THandBlog.ActCloseMonitorExecute(Sender: TObject);
begin
         SendMessage(form1.Handle, WM_SYSCOMMAND, SC_MONITORPOWER, 2);
end;

procedure THandBlog.MCBtn1Click(Sender: TObject);
begin
        mcbtn1.Caption := '111';
end;

procedure THandBlog.MCBtnMP3Click(Sender: TObject);
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

procedure THandBlog.MCBtnAddTabXClick(Sender: TObject);
var
  InputString: string;
begin
  InputString :=DateToStr(date) + '_' + inttostr(l_pagenum);
  l_pagenum := l_pagenum + 1;
  if InputQuery('输入', '页名称',Inputstring) then
  begin
  TabControlx.TabIndex := TabControlx.Tabs.Add(inputstring);
  TabControly.Tabs.Clear;
  TabControly.Tabs.Add('1');
  l_frame := TMFrame.Create(tabcontrolx.Tabs.Count-1,0,inputstring);
  l_frame.m_pencolorindex := colorbox1.ItemIndex;
  l_frame.m_bgcolorindex := colorbox2.ItemIndex;
  l_frame.m_grid := combobox2.ItemIndex ;
  l_frame.m_penthick := combobox1.ItemIndex ;
  l_frame.assignlayout(clbaction);
  l_frames.m_list.Insert(0,TClass(l_frame));
  end;
end;

procedure THandBlog.MCBtnAddTabYClick(Sender: TObject);
begin
  tabcontroly.Tabs.Add(inttostr(TabControly.Tabs.Count+1));
  l_frame := TMFrame.Create(tabcontrolx.TabIndex,tabcontroly.Tabs.Count-1,tabcontrolx.Tabs[tabcontrolx.TabIndex]);
  l_frame.m_pencolorindex := colorbox1.ItemIndex;
  l_frame.m_bgcolorindex := colorbox2.ItemIndex;
  l_frame.m_grid := combobox2.ItemIndex ;
  l_frame.m_penthick := combobox1.ItemIndex ;
  l_frame.assignlayout(clbaction);
  l_frames.m_list.Insert(0,TClass(l_frame));
end;

procedure THandBlog.MCBtnPreClick(Sender: TObject);
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

procedure THandBlog.MCBtnPauseClick(Sender: TObject);
begin
    if (mp3player.Mode = mpPlaying) then
        mp3player.Pause;
end;

procedure THandBlog.MCBtnPlayClick(Sender: TObject);
var hd: hwnd;
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
             hd := findwindowEx(0,0,'MCIQTZ_Window',pchar(mp3player.filename));
        if hd <> 0 then
        begin
         setwindowpos(hd,HWND_TOP,1000,1000,50,50,SWP_NOSIZE);
         windows.setparent(hd,panel22.handle);
         hd := GetWindow(hd,GW_CHILD );
         windows.setparent(hd,panel22.handle);
         setwindowpos(hd,HWND_TOP,50,100,50,50,SWP_NOSIZE);

        end;


        except
          MCBtnNextClick(self);
        end;
   end;
end;

procedure THandBlog.MCBtnNextClick(Sender: TObject);
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

procedure THandBlog.MCBtn8Click(Sender: TObject);
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

procedure THandBlog.MCBtn9Click(Sender: TObject);
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
//        panel15.Caption := 'Loading ...';
    end
    else
    begin
        l_opendlg.free;
//        panel15.Caption := '';
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
procedure THandBlog.MCBtn11Click(Sender: TObject);
begin
        if (listbox1.Count > 0) and (listbox1.Tag > 1) then
        begin
            listbox1.Tag := listbox1.Tag -1;
            listbox1.Selected[listbox1.Tag]:= true;
            image1.Picture.LoadFromFile(listbox1.Items[listbox1.Tag]);
        end;
end;

procedure THandBlog.MCBtn10Click(Sender: TObject);
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
    // paintbox1.Canvas.CopyRect(paintbox1.ClientRect,l_img1.Canvas,paintbox1.ClientRect)
end;

procedure THandBlog.MCBtn12Click(Sender: TObject);
begin
        timer2.Enabled := not timer2.Enabled;
        if  timer2.Enabled then
        MCBtn12.Caption := '>>'
        else
        MCBtn12.Caption := '||';
end;

procedure THandBlog.Timer2Timer(Sender: TObject);
begin
         MCBtn10Click(self);
end;

procedure THandBlog.ListBox1Click(Sender: TObject);
var
   i: integer;
begin
     for i := 0 to  listbox1.count -1 do
     begin
      if (  listbox1.Selected[i] = true ) then
     begin
     listbox1.Tag := i;
//     image1.BringToFront;
//    image1.Visible := true;
//     paintbox3.Repaint;

      paintbox3.Canvas.StretchDraw(rect(m_x,m_y,
      m_pic_width +m_x,m_pic_height+m_y)
    ,image1.Picture.Graphic);
     image1.Picture.LoadFromFile(listbox1.Items[listbox1.Tag]);
     m_pic_width := image1.Picture.Width;
     m_pic_height := image1.Picture.Height;

     if m_pic_width > m_pic_height then
     begin
     m_pic_width := paintbox3.Width;
     m_pic_height := m_pic_width* paintbox3.Height div paintbox3.Width;
//     m_x := 0 ; m_y := 0;
     end;

     if m_pic_width > m_pic_height then
     begin
     m_pic_height := paintbox3.Height;
     m_pic_width := m_pic_height*paintbox3.Width div paintbox3.Height;
//     m_x := 0 ; m_y := 0;
     end;


     end;
     end;
end;

procedure THandBlog.Image1Click(Sender: TObject);
begin
//      MCBtn10Click(self);
end;

procedure THandBlog.Image2Click(Sender: TObject);
begin
      MCBtn10Click(self);
end;

procedure THandBlog.CLBSongDblClick(Sender: TObject);
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

procedure THandBlog.MCBtnConnectClick(Sender: TObject);
begin
  edit4.Visible := false;
  flag := false;
  opencomm;
//  sleep(100);
{  if (pos('OK', SetMS(hcomm, 'AT' + #13)) <> 0) then
  begin
        statusbar1.Panels[0].text :=  SetMS(hcomm, 'AT+GMM' + #13);
        statusbar1.Panels[1].text := '已经连接上....'
  end
  else
        statusbar1.Panels[1].text := '不能连接....';
}
end;

procedure THandBlog.MCBtn13Click(Sender: TObject);
begin
        image1.Parent := formfull;
        Formfull.show;
        formfull.Color := clblack;
        Screen.cursor  := crNone ;
end;

procedure THandBlog.Image1DblClick(Sender: TObject);
begin
        if image1.Parent = formfull then
        begin
          image1.Parent := panel15;
          formfull.Hide;
          Screen.cursor  := crDefault;
        end;
end;

procedure THandBlog.MCBtn15Click(Sender: TObject);
begin
        Formfull.Color := clwhite;
        Formfull.show;
        paintbox1.Tag := 0;
        paintbox2.Parent  := formfull;
        paintbox1.Parent  := formfull;
        paintbox1.BringToFront;
        mdraw;
end;

procedure THandBlog.PaintBox1DblClick(Sender: TObject);
begin
    if (paintbox1.Parent = formfull) and
    ptinrect(rect(paintbox1.Width -20,
         paintbox1.Height - 20,
         paintbox1.Width -2,
         paintbox1.Height - 2
         ),mouse.CursorPos)
    then
    begin
          formfull.Hide;
          paintbox2.Parent := panel1;
          paintbox1.Parent := panel1;
          paintbox1.BringToFront;
          panel1.tag := 1;
    end;

end;

procedure THandBlog.TabControlxChange(Sender: TObject);
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

procedure THandBlog.TabControlyChange(Sender: TObject);
begin
        l_frame:=l_frames.getframe_xy(tabcontrolx.TabIndex,tabcontroly.TabIndex);
        l_frame.assignlayout(clbaction);
        colorbox1.ItemIndex := l_frame.m_pencolorindex;
        colorbox2.ItemIndex := l_frame.m_bgcolorindex;
        combobox2.ItemIndex  := l_frame.m_grid;
        combobox1.ItemIndex := l_frame.m_penthick;
        mdraw();
end;

procedure THandBlog.MCBtnZoomInClick(Sender: TObject);
begin
{        image1.Align := alNone;
        image1.Left := image1.Left - image1.Width div 4;
        image1.Top := image1.top - image1.Height div 4;
        image1.Width := image1.Width*150 div 100;
        image1.Height := image1.Height*150 div 100;
}
      m_pic_width := m_pic_width*150 div 100;
      m_pic_height := m_pic_height*150 div 100;
      if m_pic_width < paintbox3.Width then
         m_x := (paintbox3.Width - m_pic_width) div 2;
      if m_pic_height < paintbox3.Height then
         m_y := (paintbox3.height - m_pic_height) div 2;

   if m_x > 0 then
     paintbox3.Canvas.Rectangle(0,0,m_x,paintbox3.Width);
   if m_y > 0 then
     paintbox3.Canvas.Rectangle(0,0,paintbox3.Width,m_y);
   if m_pic_width + m_x < paintbox3.Width then
     paintbox3.Canvas.Rectangle(m_pic_width + m_x,0,paintbox3.Width,paintbox3.Height);
   if m_pic_height + m_y < paintbox3.Height then
     paintbox3.Canvas.Rectangle(0,m_pic_height + m_y,paintbox3.Width,paintbox3.Height);

//   panel15.;
      paintbox3.Canvas.StretchDraw(rect(m_x,m_y,
      m_pic_width +m_x,m_pic_height+m_y)
    ,image1.Picture.Graphic);


end;

procedure THandBlog.MCBtnZoomOutClick(Sender: TObject);
begin
{        image1.Align := alNone;
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
}
      m_pic_width := m_pic_width*100 div 150;
      m_pic_height := m_pic_height*100 div 150;
      if m_pic_width < paintbox3.Width then
         m_x := (paintbox3.Width - m_pic_width) div 2;
      if m_pic_height < paintbox3.Height then
         m_y := (paintbox3.height - m_pic_height) div 2;

   if m_x > 0 then
     paintbox3.Canvas.Rectangle(0,0,m_x,paintbox3.Width);
   if m_y > 0 then
     paintbox3.Canvas.Rectangle(0,0,paintbox3.Width,m_y);
   if m_pic_width + m_x < paintbox3.Width then
     paintbox3.Canvas.Rectangle(m_pic_width + m_x,0,paintbox3.Width,paintbox3.Height);
   if m_pic_height + m_y < paintbox3.Height then
     paintbox3.Canvas.Rectangle(0,m_pic_height + m_y,paintbox3.Width,paintbox3.Height);

//   panel15.;
      paintbox3.Canvas.StretchDraw(rect(m_x,m_y,
      m_pic_width +m_x,m_pic_height+m_y)
    ,image1.Picture.Graphic);

end;

procedure THandBlog.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
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

procedure THandBlog.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   o_x := x;
   o_y := y;
   i_down := 1;
end;

procedure THandBlog.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    i_down := 0;
end;


function THandBlog.SEncodeMobNO(SmobNO: string): string;
var
  TempPchar: Pchar;
  i: integer;
  Str: string;
begin
  if (copy(smobno, 1, 1) = '+') then //判断是否包含国家编码
    SmobNO := copy(smobno, 2, length(smobno) - 1); //去掉手机号码中的'+'

  if ((length(SmobNO) mod 2) = 1) then
    SmobNO := SmobNO + 'F';

  TempPchar := Pchar(SmobNO); //将字符串 Char数组化

  i := 0;
  Str := '';
  while i < length(TempPchar) do begin
    Str := Str + TempPchar[i + 1] + TempPchar[i];
    i := i + 2;
  end;
  result := Str;
end;

procedure THandBlog.opencomm;
var cc: tcommconfig;
  CommNO: string;
begin
  CommNO := edcom.Text;
  hcomm := CreateFile(pchar(CommNO), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, 0, 0); //以读写方式打开com1
  if (hcomm = invalid_handle_value) then
  begin
    messagebox(0, '打开通信端口失败,如有其他程序占用，请先关闭!', '', mb_ok);
    exit;  
  end;

  getcommstate(hcomm, cc.dcb);
  cc.dcb.BaudRate := cbr_9600;
  cc.dcb.ByteSize := 8;
  cc.dcb.Parity := noparity;
  cc.dcb.StopBits := onestopbit;

  if not setcommstate(hcomm, cc.dcb) then
  begin
    messagebox(0, '通讯端口设置错误！！', '', mb_ok);
    closehandle(hcomm);
    exit;
  end;
end;

 

function THandBlog.SetMS(Handle: THandle; AtCommand: string): string;
var
  lrc: longword;
begin
  WriteFile(Handle, pchar(AtCommand)^, length(AtCommand), lrc, nil);
  sleep(200);
  result := ReadCom;
end;


function THandBlog.readcom: string;
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

{返回该手机编号的区位编码标志
   SmobNO:string 手机号码}

function THandBlog.BIsArea(SmobNO: string): string;
var
  Area: array[boolean] of pchar;
  BFlag: boolean;
begin
  Area[true] := '91'; //有国家编码
  Area[false] := '81'; //无国家编码
  BFlag := false;
  if (copy(smobno, 1, 1) = '+') then //判断是否包含国家编码
    BFlag := true;
  result := string(Area[Bflag]);
end;

procedure THandBlog.MCBtnSendMsgClick(Sender: TObject);
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

function THandBlog.readFlag(): string;
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

//处理目标号码

function THandBlog.PduHead(SmobNO: string; IsSmc: boolean): string;
var
  SMob: string;
  IsArea: string;
  i: integer;
begin
  smob := SEncodeMobNO(Smobno); //号码编码
  IsArea := BIsArea(smobno); //取得国际格式标志

  i := length(smob);
  if not isSmc then begin
    if ((copy(smob, length(smob) - 1, 1) = 'f') or (copy(smob, length(smob) - 1, 1) = 'F')) then //若号码的最后一位为'f',则长度-1
      i := i - 1;
  end else
    i := length(IsArea + Smob) div 2;
  result := format('%2.2x', [i]) + IsArea + smob;
end;


 //中文转ucs编码

function THandBlog.EncodeChinese(Input: WideString): string;
var //'蕾' -->  '857E'
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Input) do
    Result := Result + Format('%4.4x', [ord(Input[i])]);
end;

 //英文转pdu编码

function THandBlog.EncodeEnglish(Input: string): string;
var
  i, j, len: Integer;
  cur: Integer;
  t: string;
begin
  Result := '';
  len := Length(Input);
  i := 1;
  j := 0; //j 用于移位计数
  while i <= len do begin
    if i < len then
      cur := (ord(Input[i]) shr j) or ((ord(Input[i + 1]) shl (7 - j)) and $FF) //数据变换
    else
      cur := (ord(Input[i]) shr j) and $7F;
    FmtStr(t, '%2.2x', [cur]);
    Result := Result + t;
    inc(i);
    j := (j + 1) mod 7; //移位计数达到7位的特别处理
    if j = 0 then inc(i);
  end;
end;

function THandBlog.isEnglish(sms: string): boolean;
var i: integer;
begin
  result := true;
  for i := 0 to length(sms) do begin
    if ord(sms[i]) > $80 then result := false;
  end;
end;

function THandBlog.MadeMsg(sms: string): string;
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

function THandBlog.MadeSmsHead(Smc, NoHand, DesMobNo: string): string;
var SmcHead, desMob: string;
  flagRep: string;

begin
  flagRep := '11'; //不需为11  需要状态报告31
  SmcHead := '00';
  if Smc <> '' then begin
    SmcHead := PduHead(Smc, true);
  end;
  desMob := PduHead(DesMobNo, false);
  result := smcHead + flagRep + '00' + desMob + '00' + NoHand + 'A7'
end;

function THandBlog.GetSMSLen(SMC, DesMob, SMS: string): integer;
begin
  if self.isEnglish(sms) then
    result := 5 + (length(PduHead(DesMob, false) + format('%2.2x', [length(MadeMsg(SMS)) * 8 div 14]) + MadeMsg(SMS))) div 2
  else
    result := 5 + (length(PduHead(DesMob, false) + format('%2.2x', [length(MadeMsg(SMS)) div 2]) + MadeMsg(SMS))) div 2
end;

function THandBlog.MadeSMS(SMC, NoHand, DesMob, SMS: string): string;
begin
  if self.isEnglish(sms) then
    result := MadeSmsHead(SMC, NoHand, DesMob) + format('%2.2x', [length(MadeMsg(SMS)) * 8 div 14]) + MadeMsg(SMS)
  else
    result := MadeSmsHead(SMC, NoHand, DesMob) + format('%2.2x', [length(MadeMsg(SMS)) div 2]) + MadeMsg(SMS)
end;


procedure THandBlog.CheckBox1Click(Sender: TObject);
begin
    flag := CheckBox1.Checked;
end;

procedure THandBlog.MCBtnSendATClick(Sender: TObject);
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

procedure THandBlog.FormDestroy(Sender: TObject);
begin
  CloseHandle(hcomm); //关闭com1句柄
 //      l_my.disconnect;
 //    l_my.Free;

  Tpic(m_pic_List.Items[0]).m_pic.free;
  Tpic(m_pic_List.Items[1]).m_pic.free;
  Tpic(m_pic_List.Items[2]).m_pic.free;
  Tpic(m_pic_List.Items[3]).m_pic.free;
  Tpic(m_pic_List.Items[4]).m_pic.free;
  Tpic(m_pic_List.Items[5]).m_pic.free;
  Tpic(m_pic_List.Items[6]).m_pic.free;
  Tpic(m_pic_List.Items[7]).m_pic.free;
  Tpic(m_pic_List.Items[8]).m_pic.free;
  Tpic(m_pic_List.Items[9]).m_pic.free;
  m_pic_list.Free;
end;

procedure THandBlog.FormCreate(Sender: TObject);
var
  MyWaveOutCaps: TWaveOutCaps;
  Volume: DWord;
//style : Cardinal ;
begin
//  style := GetWindowLong (ProgressBar1.Handle, GWL_EXSTYLE) ;
//  style := style AND NOT WS_EX_STATICEDGE ;
//小  SetWindowLong (ProgressBar1.Handle, GWL_EXSTYLE, style) ;

  m_x := 0;
  m_y := 0;
//AnimateWindow(Handle,1000,AW_CENTER);
   l_pagenum := 0;
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
  l_frame.m_pencolorindex := colorbox1.ItemIndex;
  l_frame.m_bgcolorindex := colorbox2.ItemIndex;
  l_frame.m_grid := combobox2.ItemIndex ;
  l_frame.m_penthick := combobox1.ItemIndex ;
  l_frame.assignlayout(clbaction);
  TabControlx.Tabs.Strings[0] := DateToStr(Date)+ '_' + inttostr(l_pagenum);
  l_pagenum := l_pagenum + 1;
  l_frames.m_list.Insert(0,TClass(l_frame));
  l_margin := 105;
  paintbox4.height := 800;

  //paintbox4.Width := max(200,scrollbox1.Width-40);
  //memo6.Width := max(200,scrollbox1.Width -40-l_margin);
  memo6.Left := l_margin;
  //--l_my := Tpmysql.Create;
  //--l_my.connect('root','root123','test');
  m_pic_list := Tlist.Create;
  m_pic_List.Add(tpic.Create);
  m_pic_List.Add(tpic.Create);
  m_pic_List.Add(tpic.Create);
  m_pic_List.Add(tpic.Create);
  m_pic_List.Add(tpic.Create);
  m_pic_List.Add(tpic.Create);
  m_pic_List.Add(tpic.Create);
  m_pic_List.Add(tpic.Create);
  m_pic_List.Add(tpic.Create);
  m_pic_List.Add(tpic.Create);
  Tpic(m_Pic_list.Items[0]).m_pic := tpicture.create;
  Tpic(m_Pic_list.Items[1]).m_pic := tpicture.create;
  Tpic(m_Pic_list.Items[2]).m_pic := tpicture.create;
  Tpic(m_Pic_list.Items[3]).m_pic := tpicture.create;
  Tpic(m_Pic_list.Items[4]).m_pic := tpicture.create;
  Tpic(m_Pic_list.Items[5]).m_pic := tpicture.create;
  Tpic(m_Pic_list.Items[6]).m_pic := tpicture.create;
  Tpic(m_Pic_list.Items[7]).m_pic := tpicture.create;
  Tpic(m_Pic_list.Items[8]).m_pic := tpicture.create;
  Tpic(m_Pic_list.Items[9]).m_pic := tpicture.create;
  paintbox4.Width :=  max(600,scrollbox1.Width-40);
  memo6.Width := max(600-l_margin,scrollbox1.Width -40 -l_margin);

//  Main.Show;
//  Main.Parent := tabsheet19;;

end;

procedure THandBlog.ComboBox3Change(Sender: TObject);
begin
         if combobox3.Text = '+CDV' then
          Edit4.Visible := true
        else
          Edit4.Visible := false;
end;

procedure THandBlog.MCBtn14Click(Sender: TObject);
begin
      image1.Align := alclient;
end;
procedure THandBlog.CreateWav( channels : word; { 1(单声)或者2(立体声) } 
resolution : word; { 8或者16,代表8位或16位声音 } 
rate : longint; { 声音频率,如11025,22050, 44100} 
fn : string { 对应的文件名称 } ); 
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

assignfile(wf,fn); {打开对应文件 }  
rewrite(wf); {移动指针到文件头}
write(wf,wh); {写进文件头 }  
closefile(wf); {关闭文件 }  
end;

procedure THandBlog.MCBtnRecStartClick(Sender: TObject);
var
  l_opendlg:TOpendialog;
begin
    l_opendlg :=  TOpendialog.Create(self);
try
    l_opendlg.Filter :=  'wav files (*.wav)|*.wav|All files (*.*)|*.*';
    if l_opendlg.Execute then
    begin
//在程序当前目录下创建一个Wav文件Temp.wav
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
Application.MessageBox('媒体设备初始化失败！','错误',MB_ICONERROR+MB_OK);
end;
end;

procedure THandBlog.MCBtnRecStopClick(Sender: TObject);
begin
try
MediaPlayer1.Stop;
MediaPlayer1.Save;
MediaPlayer1.Close;
Application.MessageBox('声音录制完毕!','信息',MB_ICONINFORMATION+MB_OK);
MCBtnRecStart.Enabled:=True;
MCBtnRecStop.Enabled:=false;
except
Application.MessageBox('保存声音文件出错!','错误',MB_ICONERROR+MB_OK);
MCBtnRecStart.Enabled:=True;
MCBtnRecStop.Enabled:=false;
end;
end;

procedure THandBlog.ColorBox2Change(Sender: TObject);
begin
    l_frame.m_bgcolorindex := colorbox2.ItemIndex;
    mdraw();
end;

procedure THandBlog.ColorBox1Change(Sender: TObject);
begin
    l_frame.m_pencolorindex := colorbox1.ItemIndex;
end;

procedure THandBlog.ComboBox1Change(Sender: TObject);
begin
    l_frame.m_penthick := combobox1.ItemIndex;
end;

procedure THandBlog.PaintBox2DblClick(Sender: TObject);
begin
    paintbox1.Tag := 0;
end;

procedure THandBlog.Panel1DblClick(Sender: TObject);
begin
    paintbox1.Tag := 0;
end;


procedure THandBlog.Button1Click(Sender: TObject);
var
   r,n :integer;
   bullet,reback,money,last,rate :double ;
    F: TextFile;
  S,t: string;
begin
   bullet:= 0;
   money := 100000;
   last := 0;
   reback := 0;
   stringgrid1.RowCount := 1;
   stringgrid1.ColCount := 10;
   Randomize;
   
   AssignFile(F, 'C:\a.txt');
    Reset(F);
   n := 0;
   while ( not Eof(F)) do
   begin
        Readln(F, S);
        stringgrid1.RowCount := stringgrid1.RowCount  +1;
        inc(n);
           t := copy(S,4,7);
          stringgrid1.Cells[0,n] := t;
        stringgrid1.Cells[1,n] := inttostr(n);
        t := copy(S,26,5);
        stringgrid1.Cells[2,n] := t;
        t := copy(S,12,6);
        stringgrid1.Cells[5,n] := t;
   end;
   CloseFile(F);
   
 {
   for n := 1 to 200 do
   begin
        stringgrid1.Cells[1,n] := inttostr(n);
        stringgrid1.Cells[0,n] := inttostr(n);
        stringgrid1.Cells[2,n] := floattostr((Random(10))/1000);
        if Random(2) = 1 then
        stringgrid1.Cells[2,n] := floattostr(-(Random(10))/1000);
   end;
 }
   try
   for n :=stringgrid1.RowCount -1 downto 1  do
   begin
         stringgrid1.Cells[7,n] := '0';
    //    stringgrid1.Cells[5,n] := floattostr(rate * (1+StrToFloat(stringgrid1.Cells[2,n])));
        stringgrid1.Cells[3,n] := floattostr(bullet);
        stringgrid1.Cells[4,n] := floattostr(money);
        if n = 154 then
         caption := floattostr(reback);
        if ((tag > 2) and (reback > 0.02))then
        begin
           money := money + bullet*0.9*0.995 * StrToFloat(stringgrid1.Cells[5,n]);
           stringgrid1.Cells[4,n] := floattostr(money);
           stringgrid1.Cells[7,n]:= floattostr(bullet*0.9*0.005 * StrToFloat(stringgrid1.Cells[5,n]));
           bullet := bullet * 0.1;
           stringgrid1.Cells[3,n] := floattostr(bullet);
           tag := 0;
           reback := 0;
            last := 0;
         end;
        if (tag < -2) and (reback < -0.15)  then
        begin
            bullet := bullet + money*0.9*0.99 /StrToFloat(stringgrid1.Cells[5,n]);
            stringgrid1.Cells[7,n]:= floattostr(money*0.9*0.01 );
            stringgrid1.Cells[3,n] := floattostr(bullet);
            money := money * 0.1;
            stringgrid1.Cells[4,n] := floattostr(money);

            tag := 0;
            reback := 0;
            last := 0;
        end;
        r := 0;
        if (StrToFloat(stringgrid1.Cells[2,n]) > 0) and (last > 0) then
        begin
           tag := tag + 1;
           reback := reback + last;
           r := 1;
        end;
        if (StrToFloat(stringgrid1.Cells[2,n]) < 0) and (last < 0) then
        begin
           tag := tag - 1;
           reback := reback + last;
           r := 1
        end;
        if r = 0 then
        begin
          reback := 0;
          tag := 0;
        end;
        last := StrToFloat(stringgrid1.Cells[2,n]);
        bullet := StrToFloat(stringgrid1.Cells[3,n]);
        money :=  StrToFloat(stringgrid1.Cells[4,n]);
        rate := StrToFloat(stringgrid1.Cells[5,n]);
        stringgrid1.Cells[6,n] := floattostr( bullet * rate + money );
   end;

   money :=0;
    for n :=stringgrid1.RowCount -1 downto 1  do
   begin
      money := money + strtofloat(stringgrid1.Cells[7,n]);
   end;
   stringgrid1.Cells[7,0]:= floattostr(money);
   finally
   end;
end;
procedure THandBlog.Button2Click(Sender: TObject);
var
   headnode :IXMLNode;
   fromnode :IXMLNode;
   namenode :IXMLNode;
   vnode :IXMLNode;
   name : string;
begin
 headnode := XMLDoc.DocumentElement.ChildNodes['head'];
 fromnode := headnode.ChildNodes['from'];
 namenode := fromnode.ChildNodes['name'];
 name := namenode.Text;
 namenode.Attributes['id'] := '';
 vnode := fromnode.AddChild('country');
 vnode.Text := '<china></china>';
 caption := name;
 xmldoc.SaveToFile();
end;

procedure THandBlog.Button3Click(Sender: TObject);
var
  l_opendlg : TOpendialog;
begin
     l_opendlg :=  TOpendialog.Create(self);
     if l_opendlg.Execute then
    begin
        olen.CreateObjectFromFile(l_opendlg.filename,false);
     end;
  l_opendlg.Free;
end;

procedure THandBlog.Button5Click(Sender: TObject);
var
  MSWord: Variant;
  l_opendlg : TOpendialog;
begin
  l_opendlg :=  TOpendialog.Create(self);
     if l_opendlg.Execute then
    begin
  MSWord := CreateOleObject('Word.Application');
  msword.Visible := false;
  msword.Documents.Open(l_opendlg.FileName,False,False);
  msword.Selection.WholeStory;
  msword.Selection.copy;
  richedit1.Clear;
  richedit1.PasteFromClipboard;
  msword.Documents.close(false);
  msword.quit(false);
  msword := null;
  end;
  l_opendlg.Free;
end;

procedure THandBlog.Button6Click(Sender: TObject);
begin
  if   ([fsBold] = richedit1.SelAttributes.Style)   then
  begin
//  application.MessageBox(pchar(richedit1.Lines[strtoint(edit5.text)]),'black')
application.MessageBox(pchar(    richedit1.SelText),'black')
  end
  else

//  CurrentLine:=richedit1.Perform(em_LineFromChar,$FFFF,0);
//  Application.MessageBox(PChar('当前行号是' + IntToStr(CurrentLine)),'消息',mb_iconinformation);

//application.MessageBox(pchar(    richedit1.SelText),'');
//richedit1.Perform(EM_UNDO,0,0);

end;

procedure THandBlog.PaintBox3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   o_x := x;
   o_y := y;
   i_down := 1;
end;

procedure THandBlog.PaintBox3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i : integer;
begin
  if i_down = 1 then
  begin
   i := x - o_x ;
   m_x := m_x + i ;
   i := y - o_y ;
   m_y := m_y + i ;

   paintbox3.Canvas.Brush.Color := clblack;
   if m_x > 0 then
     paintbox3.Canvas.Rectangle(0,0,m_x,paintbox3.Width);
   if m_y > 0 then
     paintbox3.Canvas.Rectangle(0,0,paintbox3.Width,m_y);
   if m_pic_width + m_x < paintbox3.Width then
     paintbox3.Canvas.Rectangle(m_pic_width + m_x,0,paintbox3.Width,paintbox3.Height);
   if m_pic_height + m_y < paintbox3.Height then
     paintbox3.Canvas.Rectangle(0,m_pic_height + m_y,paintbox3.Width,paintbox3.Height);

//   panel15.;
      paintbox3.Canvas.StretchDraw(rect(m_x,m_y,
      m_pic_width +m_x,m_pic_height+m_y)
    ,image1.Picture.Graphic);
     o_y := y ; o_x := x;
  end;

end;

procedure THandBlog.PaintBox3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 i_down := 0;
end;

procedure THandBlog.Button4Click(Sender: TObject);
var  l_mt  :Tmetafile;

begin
    l_mt := tmetafile.Create;
    if  clipboard.HasFormat(CF_BITMAP) then
    begin
    l_mt.LoadFromClipboardFormat(CF_BITMAP,0,0);
//    paintbox4.Canvas.Draw(0,0,l_mt);
    end;
    clipboard.FormatCount;    
    l_mt.Destroy;
end;

procedure THandBlog.Button7Click(Sender: TObject);
var 
    i: integer;

    l_doc_id : string;
    l_ls,sql,l_tmp ,l_tp: string;
    l_len:integer;
begin
  {
    i:= 0;
   if richedit1.Lines.Count = 1 then exit;

    l_my.query('select max(doc_id) from tab_doc');
     l_my.fetch_row;
     l_doc_id := l_my.fetch_field(0);
     l_my.fetch_row;

     if l_doc_id = '' then l_doc_id := '0';
     l_doc_id := inttostr(strtoint(l_doc_id)+1);
     sql := 'insert into tab_doc  select '''+ l_doc_id + ''','''+inttostr(i) +''',concat(curdate(),char(32),curtime()),concat(curdate(),char(32),curtime()),''0''' ;
     l_my.query(sql);
//    l_pos := 0;
     l_tmp := richedit1.Text;
     l_len := pos(#13#10,l_tmp);
     while  l_len > 0 do
     begin
         l_ls := copy(l_tmp,0,l_len-1);

         l_tmp := copy( l_tmp,l_len+2,length(l_tmp));
         l_len := pos(#13#10,l_tmp);
         button7.caption := '导入 ' +inttostr(i);
         l_tp := StringReplace(l_ls,'''','''''',[rfReplaceAll]);
         sql := 'insert into tab_doc_content  select '''+l_doc_id+''','''+inttostr(i) +''',''0'',''' + l_tp;
         if   ([fsBold] = richedit1.SelAttributes.Style)   then
                sql := sql +''',concat(curdate(),char(32),curtime()), '''','+inttostr(i)+',''T5'''
         else
                sql := sql +''',concat(curdate(),char(32),curtime()), '''','+inttostr(i)+',''T5''';
         inc(i);
        l_my.query(sql);
     end;
    btn_lib.Click;
  }
end;

procedure THandBlog.Btn_filterClick(Sender: TObject);
begin
    doc_filter;
end;


procedure THandBlog.doc_filter;
var
    i,b,m : integer;
    l_f : pchar;

    l_area :Tarea;
    bookid : string;
begin
{    b:=0;

    screen.Cursor := crHourGlass;
    if TV_books.Items.GetFirstNode = nil then exit;
    sg.RowCount := 2;
    memo4.Text := '';
    if cb_allbook.Checked then
    bookid := '%'
    else
    bookid := m_bookid;

    if edit5.Text <> '' then
      l_my.query('select * from tab_doc_content where doc_id like '''+ bookid  +''' and content like ''%'+edit5.Text +'%'' order by ord')
    else
      l_my.query('select * from tab_doc_content where doc_id  = '''+ bookid  +''' order by ord');

    while l_my.fetch_row <> 0 do
    begin

            if b >= listbox2.Count then
            l_area := Tarea.Create
            else
            l_area := Tarea(listbox2.Items.Objects[b]);

            l_f :=  l_my.fetch_field(3);
            l_area.m_top := 0;
            l_area.m_buttom  :=10 ;
            l_area.m_bookid :=  l_my.fetch_field(0);
            l_area.m_seq :=  l_my.fetch_field(1);
            l_area.m_type := l_my.fetch_field(2);
            l_area.m_time := l_my.fetch_field(4);
            l_area.m_font := l_my.fetch_field(7);
            if b >= listbox2.Count then
              listbox2.AddItem(l_f,l_area)
            else
              listbox2.Items.Strings[b] := l_f;
           inc(b);
    end;
    m := listbox2.Count - 1;

    for i := m downto b do
    begin
     Tarea(listbox2.Items.Objects[i]).Free;
     listbox2.Items.Delete(listbox2.Count-1);
    end;

    paintbox4.Height := 800;
    listbox2.Tag := 0;
    doc_recal();
    scrollbox1.VertScrollBar.Position := 0;
    screen.Cursor := 0;
  if listbox2.Count > 0 then
  begin
      listbox2.Tag := 0;
      memo6.Text := listbox2.Items.Strings[0];
      memo6.Top := 0;
      memo6.Tag := 0;
      memo6.Height := tarea(listbox2.Items.Objects[0]).m_buttom;
//    paintbox4.OnMouseDown(self,mbLeft,[],3,3);
  end;
      }
end;

procedure THandBlog.Button9Click(Sender: TObject);
var
  MSWord: Variant;
  l_opendlg : TSaveDialog;
  F1: TextFile;
   i : integer;
   l_str :string;
  l_tab : integer;
begin
  l_opendlg :=  TSaveDialog.Create(self);
  if l_opendlg.Execute then
  begin

   AssignFile(F1, 'temp.vbs');
    Rewrite(F1);
      Writeln(F1,'Const wdColorBlack = 0');
      Writeln(F1,'Const wdColorRed = 255');
    Writeln(F1,'Const wdColorBlue = 16711680');
      Writeln(F1,'Const wdColorYellow = 65535');


   Writeln(F1,'Set Word = CreateObject("Word.Application")');
   Writeln(F1,'word.Visible=true');

  if listbox2.Count > 0 then
  begin
   if copy(listbox2.Items.Strings[0],0,5) = '[dot]' then //dot tmplate
   l_str := 'Word.Documents.Add("' + copy(listbox2.Items.Strings[0],6,200)+'")'
  else
   l_str := 'Word.Documents.Add';
  end;
  Writeln(F1,l_str);
  Writeln(F1,'Word.Selection.WholeStory');
  l_tab := 0;
  for i :=0 to listbox2.Count -1 do
  begin
   Writeln(F1,'Word.Selection.MoveDown 5, 1000');
 if tarea(listbox2.Items.Objects[i]).m_font <> 'T4' then
     l_tab := 0
 else
     l_tab := l_tab + 1;

   Writeln(F1,'Word.Selection.Font.Color = wdColorBlack');
   if  tarea(listbox2.Items.Objects[i]).m_type = '2' then
         Writeln(F1,'Word.Selection.Font.Color = wdColorRed');
   if  tarea(listbox2.Items.Objects[i]).m_type = '3' then
         Writeln(F1,'Word.Selection.Font.Color = wdColorBlue');

   if copy(listbox2.Items.Strings[i],0,7) = '[image]' then //image
   begin

   l_str := 'word.Selection.InlineShapes.AddPicture "'+ copy(listbox2.Items.Strings[i],8,200) + '"';
//    Selection.InlineShapes.AddOLEObject ClassType:="Word.Document.8", FileName _
//        :="C:\Documents and Settings\sysdaemon.LINKONE\My Documents\te.doc", _
//        LinkToFile:=False, DisplayAsIcon:=True, IconFileName:= _
//        "C:\WINDOWS\Installer\{90110804-6000-11D3-8CFE-0150048383C9}\wordicon.exe" _
//        , IconIndex:=1, IconLabel:= _
//        "C:\Documents and Settings\sysdaemon.LINKONE\My Documents\te.doc"
   l_str := l_str + #13#10 + 'word.Selection.ParagraphFormat.Alignment =  1'
   end
   else if copy(listbox2.Items.Strings[i],0,5) = '[doc]' then //doc
   begin
     l_str := 'word.Selection.InlineShapes.AddOLEObject "Word.Document.8","'+ copy(listbox2.Items.Strings[i],6,200) + '",False,True,';
     l_str := l_str + '"C:\WINDOWS\Installer\{90110804-6000-11D3-8CFE-0150048383C9}\wordicon.exe",1,"'+ ExtractFileName(copy(listbox2.Items.Strings[i],6,200))+'"'
   end
   else if copy(listbox2.Items.Strings[i],0,5) = '[vba]' then //vba
   begin
     l_str := copy(listbox2.Items.Strings[i],6,200);
   end
   else if (copy(listbox2.Items.Strings[i],0,1) = '[') and (copy(listbox2.Items.Strings[i],5,1) = ']')
     then
     l_str := 'word.Selection.InlineShapes.AddOLEObject "Package","'+ copy(listbox2.Items.Strings[i],6,200) + '"'
   else  if tarea(listbox2.Items.Objects[i]).m_font = 'T4' then
     l_str := 'Word.Selection = "'+ stringreplace(StringReplace(listbox2.Items.Strings[i],'"','""',[rfReplaceAll]),#13#10,'" & vbCrlf & "',[rfReplaceAll])+ '"'
   else
     l_str := 'Word.Selection.typetext "'+ stringreplace(StringReplace(listbox2.Items.Strings[i],'"','""',[rfReplaceAll]),#13#10,'" & vbCrlf & "',[rfReplaceAll])+ '"';

   if (copy(listbox2.Items.Strings[i],0,5) = '[dot]') then l_str := '';
   
   Writeln(F1,l_str);

  l_str := '';
  if tarea(listbox2.Items.Objects[i]).m_font = 'T1' then
   l_str := 'Word.Selection.Style = Word.ActiveDocument.Styles("标题 1")';
  if tarea(listbox2.Items.Objects[i]).m_font = 'T2' then
   l_str := 'Word.Selection.Style = Word.ActiveDocument.Styles("标题 2")';
  if tarea(listbox2.Items.Objects[i]).m_font = 'T3' then
   l_str := 'Word.Selection.Style = Word.ActiveDocument.Styles("标题 3")';
  if tarea(listbox2.Items.Objects[i]).m_font = 'T4' then
  begin
   //l_str := 'Word.Selection.Style = Word.ActiveDocument.Styles("标题 4")';
   l_str := 'Word.Selection.ConvertToTable 100, 100, 0, 0';
   l_str := l_str + #13#10 + 'Word.selection.Tables(1).Style = "网格型"';
   if l_tab = 1 then
   begin
   l_str := l_str + #13#10 + 'Word.selection.Range.Shading.BackgroundPatternColor = 13421772';
   l_str := l_str + #13#10 + 'Word.selection.Range.Font.Bold = 9999998';
   end;
   l_str := l_str + #13#10 + 'Word.Selection.MoveDown 5, 1 ';
  end;
   
    Writeln(F1,l_str);
  if l_tab < 1 then  
  begin
    Writeln(F1,'Word.Selection.TypeParagraph');
    Writeln(F1,'word.Selection.ParagraphFormat.Alignment =  0');
  end;
  end; //end for
     if FileExists(l_opendlg.FileName) then deletefile(l_opendlg.FileName);
   l_str :='Word.ActiveDocument.SaveAs ("'+ l_opendlg.FileName+ '")';
   Writeln(F1,l_str);
   Writeln(F1,'Word.Quit (False)');
   Writeln(F1,'Set Word = Nothing');
   closefile(F1);
   ShellExecute(Application.Handle,'Open','temp.vbs',PChar(''),nil,SW_SHOWNORMAL);
   sleep(1000);
   ShellExecute(Application.Handle,'Open',pchar(l_opendlg.FileName),PChar(''),nil,SW_SHOWNORMAL);
  end;
  l_opendlg.Free;

end;

procedure THandBlog.Btn_libClick(Sender: TObject);
var

    l_f : pchar;
    sql : string;
    CurItem,l_item: TTreeNode;
    i : integer;
begin
{     for i := 0 to m_pic_list.Count -1 do
     begin
        tpic(m_pic_list.Items[i]).m_filename := '';
     end;
     tv_books.Items.Clear;
     sql := 'select * from tab_doc order by updatetime desc ' ;
     l_my.query(sql);
      while l_my.fetch_row <> 0 do
     begin
           l_f :=  l_my.fetch_field(0)  ;
          curitem := tv_books.Items.GetFirstNode;
           while curitem <> nil do
           begin
              if  curitem.Text = l_my.fetch_field(4)  then
              begin
                curitem := tv_books.Items.AddChild(curitem,l_my.fetch_field(1));
                curitem.ImageIndex := 3;
                curitem.SelectedIndex := 3;
                l_item := tv_books.Items.AddChild(curitem,l_f);
                l_item.ImageIndex := 4;
                l_item.SelectedIndex := 4;
              l_item := tv_books.Items.AddChild(curitem,'Create:' +l_my.fetch_field(2));
              l_item.ImageIndex := 4;
              l_item.SelectedIndex := 4;
              l_item := tv_books.Items.AddChild(curitem,'Modify:' +l_my.fetch_field(3));
              l_item.ImageIndex := 4;
              l_item.SelectedIndex := 4;
                break;
              end;
              curitem := curitem.getNextSibling;
           end;

           if curitem = nil then
           begin
              curitem := tv_books.Items.Insert(nil,l_my.fetch_field(4));
              curitem := tv_books.Items.AddChild(curitem,l_my.fetch_field(1));
              curitem.ImageIndex := 3;
              curitem.SelectedIndex := 3;
              l_item := tv_books.Items.AddChild(curitem,l_f);
              l_item.ImageIndex := 4;
              l_item.SelectedIndex := 4;
              l_item := tv_books.Items.AddChild(curitem,'Create:' +l_my.fetch_field(2));
              l_item.ImageIndex := 4;
              l_item.SelectedIndex := 4;
              l_item := tv_books.Items.AddChild(curitem,'Modify:' +l_my.fetch_field(3));
              l_item.ImageIndex := 4;
              l_item.SelectedIndex := 4;
           end;
     end;

    screen.Cursor := 0;
}
end;

procedure THandBlog.SGMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Column, Row: Longint;
  i , m : integer;
begin                                         memo3.text := '';
  sg.MouseToCell(X, Y, Column, Row);
//  sg.Cells[Column, Row] := 'Col ' + IntToStr(Column) +
//    ',Row ' + IntToStr(Row);
  if (column < 0 )or (row < 0) then exit;
  sg.Tag := row ;
  if rb_edit.Checked then
  m := 0
  else
  m := se_line.Value;
  //row := row - m;
  for i := max(0,row -m ) to min(row + m,sg.RowCount-1)  do
  begin
      memo3.Text  := memo3.text + sg.Cells[column,i] + #13#10;
  end;

  memo3.SelStart := pos(sg.Cells[column,row],memo3.Text);
  memo3.SelLength := length(sg.Cells[column,row]);
  memo3.SetFocus;
end;

procedure THandBlog.Btn_editClick(Sender: TObject);
var 
    b :integer;

    sql : string;
begin    b:=0;
{
    sql := 'insert into  tab_doc_content_his select * from tab_doc_content  where  doc_id = ''';
    sql := sql + sg.Cells[1,sg.tag]  +''' and content_seq = ''' +sg.Cells[2,sg.tag] +'''';
    l_my.query(sql);
    sql := 'update  tab_doc_content set content = ''' + memo3.Text ;
    sql := sql + ''' , update_time = concat(curdate(),char(32),curtime()) where doc_id = ''';
    sql := sql + sg.Cells[1,sg.tag]  +''' and content_seq = ''' +sg.Cells[2,sg.tag] +'''';
//    l_my.fetch_row;
    l_my.query(sql);
//    l_my.fetch_row;

      btn_edit.Caption := '保存';
    sg.Cells[4,sg.tag] := memo3.Text;
}
end;

procedure THandBlog.Btn_refreshClick(Sender: TObject);
begin
        doc_filter;
end;

procedure THandBlog.Memo3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   btn_edit.Caption := '保存 *';
end;

procedure THandBlog.Btn_fontClick(Sender: TObject);
begin
   fontdialog1.Font := memo3.Font;
  if  fontdialog1.Execute then
  begin
     memo3.Font := fontdialog1.Font;
     sg.Font := memo3.Font;
     LB_Collect.Font := sg.Font;
     memo4.Font := sg.Font;
     tv_books.Font := sg.Font;
  end
end;

procedure THandBlog.RB_editClick(Sender: TObject);
begin
    btn_edit.Enabled := true;
    doc_filter ;
    memo3.Text := sg.Cells[49,1];
    memo3.ReadOnly := false;
end;

procedure THandBlog.RadioButton1Click(Sender: TObject);
begin
    btn_edit.Enabled := false;
    memo3.ReadOnly := true;
end;

procedure THandBlog.Button8Click(Sender: TObject);
var 
    l_dlg : TopenDialog;
    l_item : TListItem;
    l_objid,sql: string;
    l_str :string;
begin
 {
    l_dlg := TopenDialog.Create(self);
    if l_dlg.Execute then
    begin
       listbox3.Items.Add(l_dlg.FileName);
       l_item := Lv_obj.Items.Add;
       l_item.Caption :=l_dlg.FileName;

     sql := 'select max(obj_id) from tab_doc_obj';
      l_my.query(sql);
      l_my.fetch_row;
       l_objid := l_my.fetch_field(0);
      l_my.fetch_row;
     if l_objid = '' then l_objid := '0';
     l_objid := Format('%10d',[strtoint(l_objid)+1]);
     l_item.SubItems.Add(l_objid);

     sql := ' insert into tab_doc_obj_relation select ''';
     sql := sql + m_bookid + ''',''';
     sql := sql + l_objid + ''',''';
     sql := sql + '''';
      l_my.query(sql);
     sql := 'insert into  tab_doc_obj select ''';
     sql := sql + l_objid + ''',''' ;
     l_str := StringReplace(l_dlg.FileName,'\','\\\',[rfReplaceAll]);
     sql := sql + l_str + ''',''' ;
     sql := sql  + ''',''' ;
     sql := sql  + ''',''' ;
     sql := sql  + ''',''' ;
     sql := sql  + '''' ;
      l_my.query(sql);

       l_item.ImageIndex := 1;
    end;
    l_dlg.Free;
 }
end;

procedure THandBlog.ListBox3Click(Sender: TObject);
begin
        if pos('.JPG',uppercase(listbox3.Items[listbox3.ItemIndex])) > 0 then
        begin
          img_doc_pic.Picture.LoadFromFile(listbox3.Items[listbox3.ItemIndex]);
        end;
end;

procedure THandBlog.ListBox3DblClick(Sender: TObject);
begin
    ShellExecute(Application.Handle,'Open',pchar(listbox3.Items[listbox3.ItemIndex]),PChar(''),nil,SW_SHOWNORMAL);
end;

procedure THandBlog.Edit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key = vk_return then doc_filter
end;

procedure THandBlog.NdeleteClick(Sender: TObject);
var 
    i,b : integer;
    l_f : pchar;
    InputString,sql : string;
begin
{ b:=0;
   InputString:= InputBox('Input Box', 'Prompt', 'Default string');
   if inputstring <> '' then
   begin
     sql := 'update  tab_doc set remark = ''' + inputstring + ''' where doc_id = '''+ m_bookid+'''';
    l_my.query(sql);
    doc_filter;
  end
}
end;

procedure THandBlog.Button10Click(Sender: TObject);
begin
    if  lv_obj.ItemIndex > 0 then
       Lv_obj.Items.Delete(lv_obj.ItemIndex);
end;

procedure THandBlog.TV_BooksChange(Sender: TObject; Node: TTreeNode);
var 
    sql : string;
    l_item : TListItem;
begin
 {  scrollbox1.VertScrollBar.Position := 0;
   paintbox4.Top := 0;
   if node.Parent = nil then exit;

    if node.HasChildren then
        begin
        m_bookid := node.getFirstChild.Text;
        doc_filter;
        lv_obj.Items.Clear;
     sql := 'select a.obj_id, a.obj_path from tab_doc_obj a, tab_doc_obj_relation b ';
     sql := sql + 'where a.obj_id = b.obj_id and ';
     sql := sql + 'b.doc_id = '''+ m_bookid +'''';
     l_my.query(sql);
     while l_my.fetch_row <> 0 do
     begin
        l_item := lv_obj.Items.Add;
        l_item.Caption := l_my.fetch_field(1);
        l_item.SubItems.Add( l_my.fetch_field(0));
        l_item.ImageIndex := 1;
     end;
   end;
  }
end;

procedure THandBlog.TV_BooksEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
var
    i,b : integer;
    l_f : pchar;
    sql : string;
begin    b:=0;
{

     sql := 'update  tab_doc set doc_name = ''' + S;
     sql := sql  + ''' where doc_id = '''+ node.getFirstChild.Text + '''';
    l_my.query(sql);
}
end;

procedure THandBlog.TV_BooksEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
     allowedit := false;
     if node.HasChildren then
        begin
          if not node.getFirstChild.HasChildren then
          allowedit := true;
     end;
end;

procedure THandBlog.Lv_objDblClick(Sender: TObject);
begin
    ShellExecute(Application.Handle,'Open',pchar(lv_obj.Items[lv_obj.ItemIndex].Caption),PChar(''),nil,SW_SHOWNORMAL);
end;

procedure THandBlog.Button19Click(Sender: TObject);
var
// ShowCaret(paintbox1.Parent.Handle);
  l_str :string;
  l_len,i,l_slen,l_y :integer;
  l_sub :string;
  l_rectbuttom,l_rectop:integer;
  l_re: Trect;
  l_h :hdc;
  fnMapModeOld:integer;
  iWidthMM,iHeightMM,iWidthPels,iHeightPels:integer;
  l_p : tpoint;
begin

  l_re := rect(0,0,400,400);

  iWidthMM := GetDeviceCaps(image2.Canvas.Handle, HORZSIZE);
  iHeightMM := GetDeviceCaps(image2.Canvas.Handle, VERTSIZE);
  iWidthPels := GetDeviceCaps(image2.Canvas.Handle, HORZRES);
  iHeightPels := GetDeviceCaps(image2.Canvas.Handle, VERTRES);

 l_re.left := round((l_re.left * iWidthMM * 100)/ iWidthPels);
 l_re.top := round((l_re.top * iHeightMM * 100)/iHeightPels);
 l_re.right := round((l_re.right * iWidthMM * 100)/iWidthPels);
 l_re.bottom := round((l_re.bottom * iHeightMM * 100)/iHeightPels);

  l_h := CreateEnhMetaFile(image2.Canvas.Handle,'c:\\a.emf',@l_re,pchar('aa'));
  fnMapModeOld := SetMapMode(l_h, MM_LOENGLISH);
 for i := 0 to 10 do
 begin
  textout( image2.Canvas.Handle,3,100+15*i,'11111111111111',10);
  l_p := point(3,100+15*i);
  DPtoLP(l_h,l_p,1);
  textout( l_h,l_p.X,l_p.Y,'11111111111111',10);
 end;

 SetMapMode(l_H, fnMapModeOld);

  CloseEnhMetaFile(l_h);

end;

procedure THandBlog.doc_repaint;

var
  l_str :string;
  l_len,i,m,l_slen,l_y :integer;
  l_sub :string;
  l_rectbuttom,l_rectop,l_selec:integer;
  l_p,l_p2 :tpoint;
  l_ico : Ticon;
  l_pic : Tpicture;
   p : integer;
begin
  l_p := paintbox4.ScreenToClient(Scrollbox1.ClientToScreen(point(0,0)));
  l_p2 := paintbox4.ScreenToClient(Scrollbox1.ClientToScreen(point(0,scrollbox1.Height)));
  l_ico := Ticon.create;
  paintbox4.Canvas.Brush.Color := $EEEEEE;
  paintbox4.Canvas.Rectangle(rect(-1,l_p.Y-1,l_margin+1,l_p2.y+1));
  paintbox4.Canvas.Brush.Color := clwhite;
  paintbox4.Canvas.Rectangle(rect(l_margin,l_p.Y-1,paintbox4.Width,l_p2.y+1));
  //  l_img := Timage.Create(self);
  for m := 0 to listbox2.Count -1 do
  begin
        if  Tarea(listbox2.Items.Objects[m]).m_hide then continue;

        if not ( (Tarea(listbox2.Items.Objects[m]).m_buttom < l_p.Y) or
        (Tarea(listbox2.Items.Objects[m]).m_top > l_p2.Y )) then
//        (Tarea(listbox2.Items.Objects[m]).m_top > 0) then
        begin
            if l_str = '' then l_str := ' ';
            if (Tarea(listbox2.Items.Objects[m]).m_font = 'T5')
            and (copy(listbox2.Items.Strings[m],1,1) <> '[') then
             l_str := '    ' + listbox2.Items.Strings[m]
            else
             l_str :=  listbox2.Items.Strings[m];

             l_slen := length(l_str);
             l_y := Tarea(listbox2.Items.Objects[m]).m_top;

          if cb_line.Checked then
          begin
           paintbox4.Canvas.Pen.Color := clblue;
           paintbox4.Canvas.MoveTo( l_margin+ 1,l_y-5);
           paintbox4.Canvas.LineTo(paintbox4.Width-1,l_y-5);
           paintbox4.Canvas.Pen.Color := clblack;
          end;

             if   copy(l_str,0,7) = '[image]' then
             begin
                try
                for  p := 0 to m_pic_list.Count -1 do
                begin
                  if copy(l_str,8,200) = tpic(m_pic_list.Items[p]).m_filename then
                  begin
                    l_pic := tpic(m_pic_list.Items[p]).m_pic;
                    break;
                  end;
                end;
                if p > m_pic_list.Count -1   then
                begin
                 Randomize;
                 p:= Random(9);
                 tpic(m_pic_list.Items[p]).m_Pic.LoadFromFile(trim(copy(l_str,8,200)));
                 tpic(m_pic_list.Items[p]).m_filename := trim(copy(l_str,8,200));
                 l_pic := tpic(m_pic_list.Items[p]).m_pic;
                end;
                if l_pic.Width > (paintbox4.Width - l_margin)*0.8 then
                begin
                paintbox4.Canvas.StretchDraw(rect(
                l_margin + round((paintbox4.Width - l_margin)*0.1),
                l_y + 30+ round(paintbox4.Canvas.Textheight(' ')*1.5),
                l_margin + round((paintbox4.Width - l_margin)*0.1) + round((paintbox4.Width - l_margin)*0.8),
                l_y + 30 + round(paintbox4.Canvas.Textheight(' ')*1.5) + round( l_pic.Height *((paintbox4.Width - l_margin) *0.8)/l_pic.Width)),
                l_pic.Graphic);
                end
                else
                 paintbox4.Canvas.Draw(l_margin + round((paintbox4.Width - l_margin)*0.2),l_y + 30+ round(paintbox4.Canvas.Textheight(' ')*1.5)
                 ,l_pic.Graphic);
                except
                ;
                end;
             end;


             if l_slen = 0 then
             begin
            paintbox4.Canvas.Brush.Color := $EEEEEE;
            paintbox4.Canvas.TextOut(3,l_y,inttostr(m));
            paintbox4.Canvas.Brush.Color := clwhite;
             continue;
             end;
             imagelist1.GetIcon( strtoint(Tarea(listbox2.Items.Objects[m]).m_type),l_ico);
             paintbox4.Canvas.Draw(40,l_y,l_Ico);

            //draw level rectangle
            paintbox4.Canvas.Pen.Style:= psDot;
            if Tarea(listbox2.Items.Objects[m]).m_font < 'T5' then
            begin
             if Tarea(listbox2.Items.Objects[min(m+1,listbox2.Count-1)]).m_hide then
             begin
             imagelist1.GetIcon(5,l_ico);
             paintbox4.Canvas.Draw(80,l_y,l_Ico)
             end
             else
             begin
             imagelist1.GetIcon(6,l_ico);
             paintbox4.Canvas.Draw(80,l_y,l_Ico);
             paintbox4.Canvas.MoveTo(87,Tarea(listbox2.Items.Objects[m]).m_top+12);
             paintbox4.Canvas.LineTo(87,Tarea(listbox2.Items.Objects[m]).m_buttom);
             end
            end
            else
            begin
               paintbox4.Canvas.MoveTo(87,Tarea(listbox2.Items.Objects[m]).m_top);
               paintbox4.Canvas.LineTo(87,Tarea(listbox2.Items.Objects[m]).m_buttom);
            end;
            paintbox4.Canvas.Pen.Style:= pssolid;

            paintbox4.Canvas.Brush.Color := $EEEEEE;
            paintbox4.Canvas.TextOut(3,l_y,inttostr(m));
            paintbox4.Canvas.TextOut(60,l_y,Tarea(listbox2.Items.Objects[m]).m_font);
            paintbox4.Canvas.Brush.Color := clwhite;

            while l_slen <> 0 do
             begin
               l_len := l_margin;
               for i := 0 to l_slen do
               begin
               l_len := l_len + paintbox4.Canvas.TextWidth(l_str[i]);
               if (l_len > paintbox4.Width ) or (l_str[i] = #10) then
                    break;
              end;// end for

            if l_y > paintbox4.Height then paintbox4.Height := l_y + 30;

       //判断换行时的中文。
            if ByteToCharIndex(l_str,i) = ByteToCharIndex(l_str,i+1)then
               i:= i + 1;
           if Tarea(listbox2.Items.Objects[m]).m_font <> 'T5' then //set font
           begin
               paintbox4.Canvas.Font.Style :=  [fsBold];
               paintbox4.Canvas.Brush.Color := $EEEEEE;
//               if (l_y - Tarea(listbox2.Items.Objects[m]).m_top) < 20 then
//               paintbox4.Canvas.Rectangle(l_margin +
//               strtoint(copy(Tarea(listbox2.Items.Objects[m]).m_font,2,1))*120-120 ,
//               l_y-13+strtoint(copy(Tarea(listbox2.Items.Objects[m]).m_font,2,1)) ,
//               paintbox4.Width,l_y-3);
               paintbox4.Canvas.Brush.Color := clwhite
          end;

             if tarea(listbox2.Items.Objects[m]).m_font <> 'T5' then
                begin
                 paintbox4.Canvas.Font.Color := clblack;
                 paintbox4.Canvas.Font.Size := 15 -
                 strtoint(copy(Tarea(listbox2.Items.Objects[m]).m_font,2,1));
                end
             else
                paintbox4.Canvas.Font.Size := 12;

           if  tarea(listbox2.Items.Objects[m]).m_type = '1' then
           begin
              paintbox4.Canvas.Font.Color := clblack;
           end;
           if  tarea(listbox2.Items.Objects[m]).m_type = '2' then
           begin
              paintbox4.Canvas.Font.Color := clred;
           end;
           if  tarea(listbox2.Items.Objects[m]).m_type = '3' then
           begin
              paintbox4.Canvas.Font.Color := clblue;
           end;


           memo6.Font.Color := paintbox4.Canvas.Font.Color;

           if memo6.Tag <> m  then
              paintbox4.Canvas.TextOut(l_margin+5,l_y,copy(l_str,0,i));

            paintbox4.Canvas.Font.Color := clblack;
            paintbox4.Canvas.Font.Style :=  []; //restore font

            l_y := l_y+ round(paintbox4.Canvas.Textheight(copy (l_str,0,i))*1.5);

            l_str := copy(l_str,i+1,l_slen);
            l_slen :=  length(l_str);
           end; //end while

//            paintbox4.Canvas.Brush.Color := $EEEEEE;
//            paintbox4.Canvas.TextOut(3,l_y-20,copy(Tarea(listbox2.Items.Objects[m]).m_time,12,5));
//            paintbox4.Canvas.Brush.Color := clwhite;

         end;  // end if
         paintbox4.Canvas.Font.Size := 12;
  end;//end for
  l_ico.free;
end;

procedure THandBlog.ScrollBox1Resize(Sender: TObject);
begin
    paintbox4.Width :=  max(600,scrollbox1.Width-40);
    memo6.Width := max(600-l_margin,scrollbox1.Width -40 -l_margin);
    doc_recal;
end;

{procedure THandBlog.Button13Click(Sender: TObject);
var
  l_str :string;
  l_len,i,l_slen,l_y :integer;
  l_sub :string;
  l_rectbuttom,l_rectop,l_selec:integer;
  l_area :Tarea;
  l_tmpstr :string;
begin
  l_str:= memo5.Text;
  l_slen := length(l_str);
  l_y := 0;
  l_rectop := 0;
  l_selec := 0;
  listbox2.Clear;
  paintbox4.Width := scrollbox1.Width-25;
  paintbox4.Canvas.Brush.Color := clwhite;
  paintbox4.Canvas.Rectangle(paintbox4.ClientRect);
  while l_slen <> 0 do
  begin
   l_len := 60;
   for i := 0 to l_slen do
   begin
     l_len := l_len + paintbox4.Canvas.TextWidth(l_str[i]);
     if (l_len > paintbox4.Width ) or (l_str[i] = #10) then
       break;
   end;
    if l_y > paintbox4.Height then
       paintbox4.Height := l_y + 30;
    if ByteToCharIndex(l_str,i) = ByteToCharIndex(l_str,i+1)then
     i:= i + 1;

    l_y := l_y+ round(paintbox4.Canvas.Textheight(copy (l_str,0,i))*1.5);
    l_tmpstr := l_tmpstr + copy (l_str,0,i);
    l_rectbuttom := l_y;

    if l_str[i] = #10 then
    begin
     l_area := Tarea.Create;
     l_area.m_top := l_rectop+10;
     l_area.m_buttom := l_rectbuttom;
     listbox2.AddItem(l_tmpstr,Tobject(l_area));
     l_tmpstr := '';

    l_selec := 0;
    l_rectop := l_y +10;
    end;

   l_str := copy(l_str,i+1,l_slen);
   l_slen :=   length(l_str);
  end;

  if listbox2.Count > 0 then
  begin
      memo6.Text := listbox2.Items.Strings[0];
      paintbox4.OnMouseDown(self,mbLeft,[],3,3);
  end;

end;
}
procedure THandBlog.PaintBox4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i : integer;
    l_p: tpoint;
    l_tag : string;
    sql : string;
    l_seq : string;
    l_ral : bool;
    m : integer;
    l_font : string;
    l_check:bool;
begin
{   l_ral := false;
   memo6.OnExit(self);
   screen.Cursor := crhourglass;
   for i := 0 to listbox2.count - 1 do
   begin
        if  (Y >  Tarea(listbox2.Items.Objects[i]).m_top) and
        (Y <  Tarea(listbox2.Items.Objects[i]).m_buttom ) then
        begin
                if Tarea(listbox2.Items.Objects[i]).m_font <> 'T5' then
                begin
                   memo6.Font.Style :=  [fsBold];
                   memo6.Font.Size := 15 -
                   strtoint(copy(Tarea(listbox2.Items.Objects[i]).m_font,2,1));
                end
                else
                begin
                   memo6.Font.Size := 12;
                   memo6.Font.Style :=  [];
                end;

                l_p := paintbox4.ClientToScreen(point(x,Tarea(listbox2.Items.Objects[i]).m_top));
                memo6.Top :=scrollbox1.ScreenToClient(l_p).Y -4 ;

           memo6.Tag := i;

                memo6.Hint := '修改时间 : ' + Tarea(listbox2.Items.Objects[memo6.Tag]).m_time + #13#10   ;
                memo6.Hint := memo6.hint + 'book     : ' + Tarea(listbox2.Items.Objects[memo6.Tag]).m_bookid + #13#10   ;
                memo6.Hint := memo6.hint + 'Seq      : ' + Tarea(listbox2.Items.Objects[memo6.Tag]).m_seq + #13#10   ;
                memo6.Hint := memo6.hint + 'Top      : ' + inttostr(Tarea(listbox2.Items.Objects[memo6.Tag]).m_top) + #13#10   ;
                memo6.Hint := memo6.hint + 'Buttom   : ' + inttostr(Tarea(listbox2.Items.Objects[memo6.Tag]).m_buttom)   ;

                if  abs(x - 50) < 10 then // color
                begin
                   l_tag := Tarea(listbox2.Items.Objects[i]).m_type;
                   l_tag := inttostr(strtoint(l_tag)+1);
                   if l_tag = '4' then l_tag := '0';
                   Tarea(listbox2.Items.Objects[i]).m_type := l_tag;
                   doc_Repaint;
                   sql := ' update  tab_doc_content set content_type = ''';
                   sql := sql + l_tag +''' where doc_id =''' + m_bookid + ''' and ';
                   sql := sql + 'content_seq = ''' +  Tarea(listbox2.Items.Objects[i]).m_seq + '''';
                   l_my.query(sql);

                end;

                l_tag := Tarea(listbox2.Items.Objects[i]).m_type;

                if l_tag  = '1' then
                        memo6.Font.Color := clblack;
                if l_tag  = '2' then
                        memo6.Font.Color := clred;
                if l_tag  = '3' then
                        memo6.Font.Color := clblue;

                memo6.Text :=  listbox2.Items.Strings[i];

                if copy(memo6.Text,0,7) = '[image]' then
                memo6.Height :=  round(paintbox4.Canvas.Textheight(' ')*1.5)+10
                else
                memo6.Height :=  Tarea(listbox2.Items.Objects[i]).m_buttom- Tarea(listbox2.Items.Objects[i]).m_top -10;

                     
                if  abs(x - 70) < 10 then  // font
                begin
                   l_tag := Tarea(listbox2.Items.Objects[i]).m_font;
                   if l_tag = 'T1' then
                      l_tag := 'T2'
                   else if l_tag = 'T2' then
                      l_tag := 'T3'
                   else if l_tag = 'T3' then
                      l_tag := 'T4'
                   else if l_tag = 'T4' then
                      l_tag := 'T5'
                   else if l_tag = 'T5' then
                      l_tag := 'T1';
                   Tarea(listbox2.Items.Objects[i]).m_font := l_tag;

                 if Tarea(listbox2.Items.Objects[i]).m_font <> 'T5' then
                 begin
                   memo6.Font.Style :=  [fsBold];
//                   memo6.Font.Size := 22- strtoint(copy(l_tag,2,1))*2;
                 end
                else
                   memo6.Font.Style :=  [];
                   doc_Repaint;

                   sql := ' update  tab_doc_content set font_type = ''';
                   sql := sql + l_tag +''' where doc_id =''' + m_bookid + ''' and ';
                   sql := sql + 'content_seq = ''' +  Tarea(listbox2.Items.Objects[i]).m_seq + '''';
                   l_my.query(sql);

                end;

              if  abs(x - 90) < 10 then  //hide
              begin
                 l_font := Tarea(listbox2.Items.Objects[i]).m_font;
                 for m := i + 1 to listbox2.count - 1 do
                 begin
                  if Tarea(listbox2.Items.Objects[m]).m_font > l_font then
                  begin
                     if m = i + 1 then
                     Tarea(listbox2.Items.Objects[m]).m_hide := not Tarea(listbox2.Items.Objects[m]).m_hide
                     else
                     Tarea(listbox2.Items.Objects[m]).m_hide :=  Tarea(listbox2.Items.Objects[i + 1]).m_hide;
                     l_ral := true;
                  end
                  else
                     break;
                end; // end for
              end;

              if  abs(x - 10) < 10 then // find pos
              begin
                 l_seq := Tarea(listbox2.Items.Objects[i]).m_seq;
                 sql := edit5.Text ;
                 edit5.Text := '';
                  l_check := false;
                 cb_allbook.Checked := false;
                 m_bookid := Tarea(listbox2.Items.Objects[i]).m_bookid;
                 doc_filter;
                 for m := 0 to listbox2.Count -1 do
                 begin
                   if l_seq  = Tarea(listbox2.Items.Objects[m]).m_seq then
                   begin
                      scrollbox1.VertScrollBar.Position := Tarea(listbox2.Items.Objects[m]).m_top ;
                     l_check := true;
                      break;
                   end;
                 end;
                  edit5.Text := sql;
                 if l_check then break;
              end
        end;
   end;  // end for
   if l_ral then
     doc_recal;
   screen.Cursor := crarrow;
}
end;

procedure THandBlog.Memo6Exit(Sender: TObject);
var
    l_f : pchar;
    sql : string;
begin
{    if listbox2.count < 1 then exit;
    if   listbox2.Items.Strings[memo6.Tag] <> memo6.Text then
    begin
    listbox2.Items.Strings[memo6.Tag] := memo6.Text;

    sql := 'insert into  tab_doc_content_his select * from tab_doc_content ';
    sql := sql + ' where  doc_id = '''+ m_bookid  +''' and content_seq = ''' ;
    sql := sql + tarea(listbox2.Items.Objects[memo6.Tag]).m_seq+'''';
    l_my.query(sql);
    sql := 'update  tab_doc_content set content = ''' +  StringReplace(memo6.Text ,'\','\\\',[rfReplaceAll]);
    sql := sql + ''' , update_time = concat(curdate(),char(32),curtime()) ,';
    sql := sql + 'content_type = '''+ tarea(listbox2.Items.Objects[memo6.Tag]).m_type +'''';
    sql := sql + 'where doc_id = '''+ m_bookid  +''' and content_seq = ''' ;
    sql := sql + tarea(listbox2.Items.Objects[memo6.Tag]).m_seq +'''';
    l_my.query(sql);
    sql := 'update  tab_doc a set updatetime = (select b.update_time from ';
    sql := sql + 'tab_doc_content b where a.doc_id = b.doc_id  and  b.content_seq = ''' ;
    sql := sql + tarea(listbox2.Items.Objects[memo6.Tag]).m_seq +''') ';
    sql := sql + 'where a.doc_id = ''' + m_bookid +'''';
    l_my.query(sql);
    doc_recal();
    end;
    }
end;

procedure THandBlog.doc_recal();
var
  l_str :string;
  l_len,i,m,l_slen,l_y :integer;
  l_sub :string;
  l_rectbuttom,l_rectop,l_selec:integer;
  l_area :Tarea;
  l_tmpstr :string;
  l_Pic : Tpicture;
begin
  l_y := 10;
  l_rectop := 10;
  l_rectbuttom:= 10;
  l_selec := 0;
  for m := 0 to listbox2.Count -1 do
  begin
{    if l_y > scrollbox1.VertScrollBar.Position  + 700 then
    begin
      tarea(listbox2.Items.Objects[m]).m_top := -1;
      continue;
    end;
}
    if tarea(listbox2.Items.Objects[m]).m_hide = true then
    begin
      tarea(listbox2.Items.Objects[m]).m_top := l_y ;
      tarea(listbox2.Items.Objects[m]).m_buttom := l_y ;
      continue;
    end;
    tarea(listbox2.Items.Objects[m]).m_top := l_y;
    l_y := l_y + 5;
   if copy(listbox2.Items.Strings[m],1,1) <> '[' then
   l_str := '    ' +listbox2.Items.Strings[m]
   else
   l_str :=  listbox2.Items.Strings[m];
   l_slen := length(l_str);
//   paintbox4.Canvas.Font.Size := 22- strtoint(copy(tarea(listbox2.Items.Objects[m]).m_font,2,1))*2;

    if  tarea(listbox2.Items.Objects[m]).m_font <> 'T5' then
        paintbox4.Canvas.Font.Size := 15 -
                   strtoint(copy(Tarea(listbox2.Items.Objects[m]).m_font,2,1))
    else
        paintbox4.Canvas.Font.Size := 12;

      //[image]
   if copy(l_str,0,7) = '[image]' then
   begin
      try
      l_pic := Tpicture.Create();
      l_pic.LoadFromFile(trim(copy(l_str,8,200)));
      //paintbox4.Canvas.Draw(l_margin,l_y,l_pic.Graphic);
//      l_y := l_y + l_pic.Graphic.Height +round(paintbox4.Canvas.Textheight(' ')*1.5); ;

       if l_pic.Width > (paintbox4.Width-l_margin)*0.8 then
        l_y := l_y +  round( l_pic.Height *(paintbox4.Width *0.8)/l_pic.Width)  +round(paintbox4.Canvas.Textheight(' ')*1.5)
       else
         l_y := l_y + 10 + round(paintbox4.Canvas.Textheight(' ')*1.5)+ l_pic.Height;
      if l_y > paintbox4.Height then
        paintbox4.Height := l_y + 30;
       l_rectbuttom := l_y;
      l_pic.Free;
      except
      l_y := l_y + 20+round(paintbox4.Canvas.Textheight(' ')*1.5);
      l_rectbuttom := l_y;
      end;
   end
  else
    begin // lese not image
    if l_slen = 0 then
  begin
   l_y := l_y +  round(paintbox4.Canvas.Textheight(' ')*1.5);
   l_rectbuttom := l_y;
  end
  else
  while l_slen <> 0 do
  begin
   l_len := l_margin;

   for i := 0 to l_slen do
   begin
     l_len := l_len + paintbox4.Canvas.TextWidth(l_str[i]);
     if (l_len > paintbox4.Width ) or (l_str[i] = #10)then
       break;
   end;

    if l_y > paintbox4.Height then
       paintbox4.Height := l_y + 30;
    if ByteToCharIndex(l_str,i) = ByteToCharIndex(l_str,i+1)then
     i:= i + 1;

    l_y := l_y+ round(paintbox4.Canvas.Textheight(copy (l_str,0,i))*1.5);

    l_tmpstr := l_tmpstr + copy (l_str,0,i);
    l_rectbuttom := l_y;

   l_str := copy(l_str,i+1,l_slen);
   l_slen :=   length(l_str);
  end; //end while
  end;//image

    if (i < l_slen) and  (l_str[i] = #10 )then
        l_y := l_y +  round(paintbox4.Canvas.Textheight(' ')*1.5);

     l_y := l_y + 5;
     tarea(listbox2.Items.Objects[m]).m_buttom := l_y;
     l_tmpstr := '';

     l_selec := 0;
   end; //end for
  doc_Repaint;
end;

procedure THandBlog.Button_recalClick(Sender: TObject);
begin
        doc_recal
end;

procedure THandBlog.Memo6KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    i :integer;
    l_f : pchar;
    sql,l_max : string;
   l_area : Tarea;
begin
//    if  (key = 86 ) then  //'v'
//     if (shift = [ssCtrl] ) then
{     if (memo6.Height < paintbox4.Canvas.Textheight(' ') * memo6.Lines.Count)then
      begin
        memo6.Height :=  paintbox4.Canvas.Textheight(' ') * memo6.Lines.Count;
     end;

    if  (key = ord(13)) then
    if  (shift = [ssAlt]) then
    begin
       memo6.OnExit(self);
       l_area := Tarea.Create;
        l_area.m_top :=  Tarea(listbox2.Items.Objects[memo6.Tag]).m_buttom ;
        l_area.m_type := '1';
        l_area.m_font := 'T5';
       listbox2.Items.InsertObject(memo6.Tag+1,'',l_area);
       memo6.Text := ' ';
       memo6.Height :=  round(paintbox4.Canvas.Textheight(' ')*1.5);


      sql := 'select convert(max(convert(content_seq,signed)),char) from tab_doc_content where doc_id =''';
      sql := sql + m_bookid +'''';
      l_my.query(sql);
      l_my.fetch_row;
      l_max := l_my.fetch_field(0);
      l_my.fetch_row;

       sql := 'update tab_doc_content  set ord = ord +1 where doc_id = '''+ m_bookid+'''';
       sql := sql + ' and ord >' + inttostr(memo6.tag) ;
      l_my.query(sql);
      l_area.m_seq := inttostr(strtoint(l_max)+1);
      sql := 'insert into tab_doc_content  select '''+ m_bookid+''','''+ l_area.m_seq+''',''0'',''';
      sql := sql +''',concat(curdate(),char(32),curtime()), '''','+inttostr(memo6.tag+1) +',''T5''';
      l_my.query(sql);
      memo6.Tag := memo6.Tag + 1;
      listbox2.Tag := memo6.Tag;
      memo6.Top :=
      scrollbox1.ScreenToClient(
      paintbox4.clienttoscreen(point(0,Tarea(listbox2.Items.Objects[memo6.Tag]).m_top))
      ).Y;

      doc_recal;
      doc_Repaint;

    end;
    }
end;

procedure THandBlog.ScrollBox1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  scrollbox1.VertScrollBar.Position :=
  max(scrollbox1.VertScrollBar.Position + 50,0);
end;

procedure THandBlog.ScrollBox1MouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
   scrollbox1.VertScrollBar.Position :=
   min(scrollbox1.VertScrollBar.Position - 50,scrollbox1.VertScrollBar.Range);

end;

procedure THandBlog.Work1Click(Sender: TObject);
var
    i,b : integer;
    l_f : pchar;
    sql : string;
begin    b:=0;
{     if application.MessageBox('Are you sure to update the book to Word ?','Information',MB_OKCANCEL) = ID_OK then
     begin
     sql := 'update  tab_doc set remark = ''Word'' where doc_id = '''+ m_bookid+'''';
    l_my.query(sql);
    l_my.disconnect;
    doc_filter;
    end;

 }
end;

procedure THandBlog.rip1Click(Sender: TObject);
var
    i,b : integer;
    l_f : pchar;
    sql : string;
begin    b:=0;
{     if application.MessageBox('Are you sure to update the book to Walk ?','Information',MB_OKCANCEL) = ID_OK then
     begin
     sql := 'update  tab_doc set remark = ''Walk'' where doc_id = '''+ m_bookid+'''';
    l_my.query(sql);
    doc_filter;
    end;                 }
end;

procedure THandBlog.Info1Click(Sender: TObject);
var
    b : integer;
    sql : string;
begin    b:=0;
{     if application.MessageBox('Are you sure to update the book to info?','Information',MB_OKCANCEL) = ID_OK then
     begin
     sql := 'update  tab_doc set remark = ''Info'' where doc_id = '''+ m_bookid+'''';
    l_my.query(sql);
    doc_filter;
    end;
 }
end;

procedure THandBlog.Poject1Click(Sender: TObject);
var
    b : integer;

    sql : string;
begin    b:=0;
 {    if application.MessageBox('Are you sure to update the book to Porject ?','Information',MB_OKCANCEL) = ID_OK then
     begin
     sql := 'update  tab_doc set remark = ''Project'' where doc_id = '''+ m_bookid+'''';
    l_my.query(sql);
    doc_filter;
    end;                        }
end;

procedure THandBlog.CB_LineClick(Sender: TObject);
begin
     doc_Repaint;
end;

procedure THandBlog.PaintBox4DblClick(Sender: TObject);
var
    l_tag : string;
    sql : string;
begin
 {      if memo6.Tag > listbox2.Count -1 then
       begin
       memo6.Tag := 0;
       exit;
       end;

      if copy(listbox2.Items.Strings[memo6.tag],0,7) = '[image]' then
        ShellExecute(Application.Handle,'Open',pchar(copy(listbox2.Items.Strings[memo6.tag],8,200)),PChar(''),nil,SW_SHOWMAXIMIZED	)
      else  if (copy(listbox2.Items.Strings[memo6.tag],0,1) =  '[')
        and (copy(listbox2.Items.Strings[memo6.tag],5,1) = ']') THEN
        begin
            ShellExecute(Application.Handle,'Open',pchar(copy(listbox2.Items.Strings[memo6.tag],6,200)),PChar(''),nil,SW_SHOWMAXIMIZED	);
           application.Minimize;
        end
      else //show his;
      begin
        memo_his.Clear;
     sql := 'select * from tab_doc_content_his ';
     sql := sql + 'where doc_id = ''' +
            tarea(listbox2.Items.Objects[memo6.tag]).m_bookid
             + ''' and content_seq = '''
             + tarea(listbox2.Items.Objects[memo6.tag]).m_seq
             +'''';
     sql := sql + 'order by update_time desc ' ;
     l_my.query(sql);
      while l_my.fetch_row <> 0 do
      begin
           memo_his.Lines.Add('['+l_my.fetch_field(4) + ']:' +l_my.fetch_field(3) );
      end;   
      end;        }
end;

procedure THandBlog.Button14Click(Sender: TObject);
var
  MSWord: Variant;
  l_opendlg : TSaveDialog;

   i : integer;
   l_str :string;

begin
  l_opendlg :=  TSaveDialog.Create(self);
  if l_opendlg.Execute then
  begin
  MSWord := CreateOleObject('Word.Application');
  msword.Visible := false;
 // msword.Documents.Open(FileName:=l_opendlg.FileName,ReadOnly:=False, AddToRecentFiles:=False);
    msword.Documents.add;
  msword.Selection.MoveDown (5, 1000) ;
//  msword.Selection.typetext ('统计结果');
  msword.Selection.typetext (inttostr(msword.selection.type));
  msword.Selection.ParagraphFormat.Alignment := 0;
//  msword.Selection.Style := msword.ActiveDocument.Styles.item('标题 1');
//  msword.Selection.style := msword.ActiveDocument.Styles.item('标题 1');
  msword.Selection.TypeParagraph;
  msword.Selection.MoveDown (5, 1000);
  for i :=0 to listbox2.Count -1 do
  begin
//  msword.Selection.TypeText (sg.Cells[4,i]);
  msword.Selection.TypeText (listbox2.Items.Strings[i]);
  msword.Selection.MoveDown (5, 1000);
  msword.Selection.TypeParagraph;
//  msword.Selection.typetext (inttostr(msword.selection.type));
  button14.Caption := 'Export ' +inttostr(i);
  end;
  msWord.ActiveDocument.SaveAs (l_opendlg.FileName);
  msword.Documents.close(false);
  msword.quit(false);
  msword := null;
  end;
  ShellExecute(Application.Handle,'Open',pchar(l_opendlg.FileName),PChar(''),nil,SW_SHOWNORMAL);
  l_opendlg.Free;

end;

procedure THandBlog.PaintBox3Paint(Sender: TObject);
begin
   if m_x > 0 then
     paintbox3.Canvas.Rectangle(0,0,m_x,paintbox3.Width);
   if m_y > 0 then
     paintbox3.Canvas.Rectangle(0,0,paintbox3.Width,m_y);
   if m_pic_width + m_x < paintbox3.Width then
     paintbox3.Canvas.Rectangle(m_pic_width + m_x,0,paintbox3.Width,paintbox3.Height);
   if m_pic_height + m_y < paintbox3.Height then
     paintbox3.Canvas.Rectangle(0,m_pic_height + m_y,paintbox3.Width,paintbox3.Height);

//   panel15.;
      paintbox3.Canvas.StretchDraw(rect(m_x,m_y,
      m_pic_width +m_x,m_pic_height+m_y)
    ,image1.Picture.Graphic);

end;

procedure THandBlog.PaintBox4Paint(Sender: TObject);
begin
        doc_repaint;
end;

procedure THandBlog.TV_BooksDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  AnItem: TTreeNode;
  AttachMode: TNodeAttachMode;
  HT: THitTests;
  sql : string;
begin
{  if Tv_books.Selected = nil then Exit;
  HT := Tv_books.GetHitTestInfoAt(X, Y);
  AnItem := Tv_books.GetNodeAt(X, Y);
  if (HT - [htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) then
  begin
    if (htOnItem in HT) or (htOnIcon in HT) then AttachMode := naAddChild
    else if htNowhere in HT then AttachMode := naAdd

    else if htOnIndent in HT then AttachMode := naInsert;
    Tv_books.Selected.MoveTo(AnItem, AttachMode);
    sql := 'update  tab_doc set remark = '''+ anitem.Text;
    sql := sql +''' where doc_id = '''+ m_bookid+'''';
    l_my.query(sql);
    doc_filter;
  end;                     }
end;

procedure THandBlog.TV_BooksDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  AnItem: TTreeNode;
begin
  AnItem := Tv_books.GetNodeAt(X, Y);
  if anitem.Parent = nil then
      accept := true
  else
      accept := false;
end;

procedure THandBlog.PaintBox4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if not memo6.Focused then
   scrollbox1.SetFocus;
end;

procedure THandBlog.TabSheet15Resize(Sender: TObject);
begin
   tabsheet15.Width := max(50,tabsheet15.Width);
end;

procedure THandBlog.ToolButton1Click(Sender: TObject);
begin
//   formdraw.Parent := tabsheet19;
//   formdraw.Show;
end;

procedure THandBlog.Button11Click(Sender: TObject);
begin
{   Main.Show;
   Main.Parent := tabsheet19;
}
end;

procedure THandBlog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{   main.FormKeyDown(sender,key,shift);
}
end;

procedure THandBlog.TabSheet19Show(Sender: TObject);
begin
{   Main.Show;
   Main.Parent := tabsheet19;
}
end;

procedure THandBlog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//        main.FormClose(sender,action);
end;

procedure THandBlog.Button_LocateClick(Sender: TObject);
var
  l_bookid : string;
  l_node : TTreenode;
begin
  l_bookid := Tarea(listbox2.Items.Objects[memo6.Tag]).m_bookid;
  l_node := tv_books.Selected;
  while l_node <> nil do
  begin
    if l_node.Text = l_bookid then
    begin
    tv_books.Select(l_node);
    exit
    end
    else
    l_node := l_node.GetNext;
  end;  
end;

procedure THandBlog.Button12Click(Sender: TObject);
begin
   if button12.Caption = '-' then
   begin
    panel_head.Height := 3 + button12.Height;
    memo_his.Height := 0;
    button12.Caption := '+';
   end
   else
   begin
    panel_head.Height := 55;
    memo_his.Height := 70;
    button12.Caption := '-';
   end;
  scrollbox1.SetFocus
end;

procedure THandBlog.Button13Click(Sender: TObject);
var
  Buf: array [0..511] of Byte;     //数据缓冲区
  ShowText, TmpStr: string;
  FileHandle: THandle;           
  ReadCount, i: Cardinal;
  pos :integer;
  iFileHandle :integer;
begin
  //打开磁盘
  FileHandle := CreateFile('\\.\C:', GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE,
    nil, OPEN_EXISTING, 0, 0);
  if FileHandle = INVALID_HANDLE_VALUE then
  begin
    MessageBox(GetDesktopWindow, '打开磁盘失败', 'ERROR', MB_OK);
    exit;
  end;
  //读出引导扇区数据
  pos := 0;
  if ReadFile(FileHandle, Buf, 512, ReadCount, nil) then
  begin
    SetLength(ShowText, Length(Buf) * 3 + Length(Buf) DIV 16 *2  );
    //将数据转为字串
    for i := Low(Buf) to High(Buf) do
    begin
      TmpStr := Format('%2.2x ', [Buf[i]]);
      CopyMemory(@ShowText[pos+1], @TmpStr[1], 3);
      pos  := pos + 3;
      if  ((i+1) mod 16) = 0 then
      begin
      TmpStr := #13#10;
      CopyMemory(@ShowText[pos+1], @TmpStr[1], 2);
      pos  := pos + 2;
      end;
    end;
  end;
//  MessageBox(GetDesktopWindow, PChar(ShowText), '引导扇区', MB_OK);
  memo5.Text := showtext;
  CloseHandle(FileHandle);
  iFileHandle := FileOpen('c:\a.bin', fmOpenwrite);
  FileSeek(iFileHandle,0,0);
  Filewrite(iFileHandle, Buf, 512);
  FileClose(iFileHandle);
end;

procedure THandBlog.Button15Click(Sender: TObject);
var  b,n:integer;
     l_sf :string;
    l_area :Tarea;
begin
 {    l_my.query(memo7.Text);
     listbox2.Clear;
     b:=0;

    while l_my.fetch_row <> 0 do
    begin
        l_sf := l_my.fetch_field(0);
        for n := 1 to l_my.m_field_num -1 do
        begin
              l_sf :=  l_sf +',' +l_my.fetch_field(n);
        end;
              //               + l_my.fetch_field(2) + l_my.fetch_field(3);
                l_area := Tarea.Create;
                l_area.m_top := 0;
                l_area.m_buttom  :=10 ;
                l_area.m_type := '1';
                l_area.m_font := 'T4';
                l_area.m_seq := '1';
                l_area.m_hide := false;
                listbox2.AddItem(l_sf,l_area);
                inc(b);
    end;
    memo6.Tag := 0;
    listbox2.Tag := 0;
    doc_recal;
     if listbox2.Count > 0 then
  begin
      listbox2.Tag := 0;
      memo6.Text := listbox2.Items.Strings[0];
      memo6.Top := 0;
      memo6.Tag := 0;
      memo6.Height := tarea(listbox2.Items.Objects[0]).m_buttom;
//    paintbox4.OnMouseDown(self,mbLeft,[],3,3);
  end;
        }
end;

procedure THandBlog.Button16Click(Sender: TObject);
var i :integer;
begin
 {   for i := 0 to memo7.Lines.Count - 1 do
    begin
     l_my.query( memo7.Lines[i]);

     button16.Caption := inttostr(i+1);
    end;
  }
end;

 procedure THandBlog.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  { Define property pages here.  Property pages are defined by calling
    DefinePropertyPage with the class id of the page.  For example,
      DefinePropertyPage(Class_HandBlogPage); }
end;

procedure THandBlog.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IHandBlogEvents;
  inherited EventSinkChanged(EventSink);
end;

procedure THandBlog.Initialize;
begin
  inherited Initialize;
  OnActivate := ActivateEvent;
  OnClick := ClickEvent;
  OnCreate := CreateEvent;
  OnDblClick := DblClickEvent;
  OnDeactivate := DeactivateEvent;
  OnDestroy := DestroyEvent;
  OnKeyPress := KeyPressEvent;
  OnPaint := PaintEvent;
end;

function THandBlog.Get_Active: WordBool;
begin
  Result := Active;
end;

function THandBlog.Get_AlignDisabled: WordBool;
begin
  Result := AlignDisabled;
end;

function THandBlog.Get_AutoScroll: WordBool;
begin
  Result := AutoScroll;
end;

function THandBlog.Get_AutoSize: WordBool;
begin
  Result := AutoSize;
end;

function THandBlog.Get_AxBorderStyle: TxActiveFormBorderStyle;
begin
  Result := Ord(AxBorderStyle);
end;

function THandBlog.Get_Caption: WideString;
begin
  Result := WideString(Caption);
end;

function THandBlog.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(Color);
end;

function THandBlog.Get_Cursor: Smallint;
begin
  Result := Smallint(Cursor);
end;

function THandBlog.Get_DoubleBuffered: WordBool;
begin
  Result := DoubleBuffered;
end;

function THandBlog.Get_DropTarget: WordBool;
begin
  Result := DropTarget;
end;

function THandBlog.Get_Enabled: WordBool;
begin
  Result := Enabled;
end;

function THandBlog.Get_Font: IFontDisp;
begin
  GetOleFont(Font, Result);
end;

function THandBlog.Get_HelpFile: WideString;
begin
  Result := WideString(HelpFile);
end;

function THandBlog.Get_HelpKeyword: WideString;
begin
  Result := WideString(HelpKeyword);
end;

function THandBlog.Get_HelpType: TxHelpType;
begin
  Result := Ord(HelpType);
end;

function THandBlog.Get_KeyPreview: WordBool;
begin
  Result := KeyPreview;
end;

function THandBlog.Get_PixelsPerInch: Integer;
begin
  Result := PixelsPerInch;
end;

function THandBlog.Get_PrintScale: TxPrintScale;
begin
  Result := Ord(PrintScale);
end;

function THandBlog.Get_Scaled: WordBool;
begin
  Result := Scaled;
end;

function THandBlog.Get_Visible: WordBool;
begin
  Result := Visible;
end;

function THandBlog.Get_VisibleDockClientCount: Integer;
begin
  Result := VisibleDockClientCount;
end;

procedure THandBlog._Set_Font(var Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure THandBlog.AboutBox;
begin
 // ShowHandBlogAbout;
end;

procedure THandBlog.ActivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnActivate;
end;

procedure THandBlog.ClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnClick;
end;

procedure THandBlog.CreateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnCreate;
end;

procedure THandBlog.DblClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDblClick;
end;

procedure THandBlog.DeactivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDeactivate;
end;

procedure THandBlog.DestroyEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDestroy;
end;

procedure THandBlog.KeyPressEvent(Sender: TObject; var Key: Char);
var
  TempKey: Smallint;
begin
  TempKey := Smallint(Key);
  if FEvents <> nil then FEvents.OnKeyPress(TempKey);
  Key := Char(TempKey);
end;

procedure THandBlog.PaintEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnPaint;
end;

procedure THandBlog.Set_AutoScroll(Value: WordBool);
begin
  AutoScroll := Value;
end;

procedure THandBlog.Set_AutoSize(Value: WordBool);
begin
  AutoSize := Value;
end;

procedure THandBlog.Set_AxBorderStyle(Value: TxActiveFormBorderStyle);
begin
  AxBorderStyle := TActiveFormBorderStyle(Value);
end;

procedure THandBlog.Set_Caption(const Value: WideString);
begin
  Caption := TCaption(Value);
end;

procedure THandBlog.Set_Color(Value: OLE_COLOR);
begin
  Color := TColor(Value);
end;

procedure THandBlog.Set_Cursor(Value: Smallint);
begin
  Cursor := TCursor(Value);
end;

procedure THandBlog.Set_DoubleBuffered(Value: WordBool);
begin
  DoubleBuffered := Value;
end;

procedure THandBlog.Set_DropTarget(Value: WordBool);
begin
  DropTarget := Value;
end;

procedure THandBlog.Set_Enabled(Value: WordBool);
begin
  Enabled := Value;
end;

procedure THandBlog.Set_Font(const Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure THandBlog.Set_HelpFile(const Value: WideString);
begin
  HelpFile := String(Value);
end;

procedure THandBlog.Set_HelpKeyword(const Value: WideString);
begin
  HelpKeyword := String(Value);
end;

procedure THandBlog.Set_HelpType(Value: TxHelpType);
begin
  HelpType := THelpType(Value);
end;

procedure THandBlog.Set_KeyPreview(Value: WordBool);
begin
  KeyPreview := Value;
end;

procedure THandBlog.Set_PixelsPerInch(Value: Integer);
begin
  PixelsPerInch := Value;
end;

procedure THandBlog.Set_PrintScale(Value: TxPrintScale);
begin
  PrintScale := TPrintScale(Value);
end;

procedure THandBlog.Set_Scaled(Value: WordBool);
begin
  Scaled := Value;
end;

procedure THandBlog.Set_Visible(Value: WordBool);
begin
  Visible := Value;
end;

procedure THandBlog.ActiveFormCreate(Sender: TObject);
begin

end;

function THandBlog.Get_host: WideString;
begin

end;

procedure THandBlog.Set_host(const Value: WideString);
begin

end;

procedure THandBlog.change(const name: WideString);
begin
  MCBtn8.Caption := name;
end;

procedure THandBlog.cc(cc: Integer; ee: PWideChar);
begin
   MCBtn8.Caption := 'aaaaaaaa';
   ee:= 'aaa';      
end;

initialization
    TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    THandBlog,
    Class_HandBlog,
    1,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmApartment);
end.
end.

