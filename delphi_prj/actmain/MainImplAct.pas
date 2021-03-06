unit MainImplAct;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, MainAct_TLB, StdVcl, xmldom, XMLIntf, msxmldom, XMLDoc,
  ImgList,IniFiles,Clipbrd, Menus, StdCtrls,Contnrs,Math, Uobj,ExtCtrls,
  ComCtrls, Grids, ValEdit, ToolWin,Wininet;

type
  TMain = class(TActiveForm, IMain,IPersistPropertyBag)
    MainMenu1: TMainMenu;
    ToolBar1: TToolBar;
    ToolButtonLink: TToolButton;
    ToolButtonComm: TToolButton;
    PopupMenu1: TPopupMenu;
    aaa1: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Porject: TMenuItem;
    Delete1: TMenuItem;
    Save1: TMenuItem;
    Load: TMenuItem;
    ToolButtonArrow: TToolButton;
    ToolButtonOpen: TToolButton;
    ToolButtonSave: TToolButton;
    ToolButton3: TToolButton;
    Component: TMenuItem;
    Line: TMenuItem;
    Rec: TMenuItem;
    Elip: TMenuItem;
    tt: TMenuItem;
    ToolButtonTable: TToolButton;
    StatusBar1: TStatusBar;
    bringtofront1: TMenuItem;
    BringToTop1: TMenuItem;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Saveas: TMenuItem;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ComboBox1: TComboBox;
    Panel5: TPanel;
    Label2: TLabel;
    Button1: TButton;
    New: TMenuItem;
    ListBox2: TListBox;
    Splitter3: TSplitter;
    Image1: TImage;
    Panel7: TPanel;
    ToolButtonIF: TToolButton;
    ToolButtonline: TToolButton;
    ToolButtonEClip: TToolButton;
    ToolButtonRoundRect: TToolButton;
    ToolButtonImage: TToolButton;
    ToolButton7: TToolButton;
    ccc1: TMenuItem;
    ddd1: TMenuItem;
    eee1: TMenuItem;
    PopupMenuObj: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Eclip1: TMenuItem;
    Rect1: TMenuItem;
    RoundRect1: TMenuItem;
    Red: TMenuItem;
    Blue: TMenuItem;
    Yellow: TMenuItem;
    N1: TMenuItem;
    SendtoBack1: TMenuItem;
    N2: TMenuItem;
    ImageList1: TImageList;
    XMLDoc: TXMLDocument;
    ColorDialog1: TColorDialog;
    N3: TMenuItem;
    ToolButtonText: TToolButton;
    ScrollBox1: TScrollBox;
    EditInput: TEdit;
    PaintBox1: TPaintBox;
    Image: TImage;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    N4: TMenuItem;
    copysqltoclip1: TMenuItem;
    copyhtmltoclip1: TMenuItem;
    Tb_zoomin: TToolButton;
    tb_zoomout: TToolButton;
    Center1: TMenuItem;
    Bottom1: TMenuItem;
    ToolButton5: TToolButton;
    Panel8: TPanel;
    Btn_path: TButton;
    N5: TMenuItem;
    AlignLeft1: TMenuItem;
    AlignRight1: TMenuItem;
    AlighTop1: TMenuItem;
    AlignBottom1: TMenuItem;
    N6: TMenuItem;
    SameWidth1: TMenuItem;
    SameHeight1: TMenuItem;
    CopytoClipBord1: TMenuItem;
    PastefromClip1: TMenuItem;
    N7: TMenuItem;
    N_shadow: TMenuItem;
    Pn_Table: TPanel;
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    ValueListEditor1: TValueListEditor;
    Panel9: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    TabSheet4: TTabSheet;
    Memo3: TMemo;
    TabSheet6: TTabSheet;
    Memo_partition: TMemo;
    TabSheet_sql: TTabSheet;
    Memo1: TMemo;
    TabSheet5: TTabSheet;
    Memo_import: TMemo;
    TabSheet7: TTabSheet;
    Memo2: TMemo;
    Btn_imp: TButton;
    Btn_commit: TButton;
    Button2: TButton;
    Panel6: TPanel;
    Splitter2: TSplitter;
    VLE: TValueListEditor;
    TV: TTreeView;
    ToolButton6: TToolButton;
    procedure DrawMouseDown(Sender: TObject; Button: TXMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawMousemove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawMouseup(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure delete1Click(Sender: TObject);
    procedure SaveToClick(Sender: TObject);
    procedure SaveToFile( FileHandle: TXMLDocument);
    procedure LoadFromFile( FileHandle: TXMLDocument);
    procedure LoadClick(Sender: TObject);
    procedure bringtofront1Click(Sender: TObject);
    procedure ReDraw();
    procedure copyobjs();
    procedure pasteobjs();
    procedure BringToTop1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure Sync();
    procedure VLEKeyPress(Sender: TObject; var Key: Char);
    procedure SaveasClick(Sender: TObject);
    procedure NewClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ScrollBar_VChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditInputClick(Sender: TObject);
    procedure EditInputExit(Sender: TObject);
    procedure Rect1Click(Sender: TObject);
    procedure Eclip1Click(Sender: TObject);
    procedure RoundRect1Click(Sender: TObject);
    procedure RedClick(Sender: TObject);
    procedure BlueClick(Sender: TObject);
    procedure YellowClick(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure SendtoBack1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TXMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure EditInputKeyPress(Sender: TObject; var Key: Char);
    
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure PaintBox1DblClick(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure ScrollBox1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ScrollBox1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure copysqltoclip1Click(Sender: TObject);
    procedure copyhtmltoclip1Click(Sender: TObject);
    procedure SelectDelete(obj:Tobj);
    procedure SelectAdd(obj: TObj);
    procedure SelectAlignLeft;
    procedure SelectAlignRight;
    procedure SelectAlignTop;
    procedure SelectAlignBottom;
    procedure SelectSameWidth;
    procedure SelectSameHeight;
    procedure Tb_zoominClick(Sender: TObject);
    procedure tb_zoomoutClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Center1Click(Sender: TObject);
    procedure Bottom1Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure TVDblClick(Sender: TObject);
    procedure Btn_pathClick(Sender: TObject);
    procedure AlignLeft1Click(Sender: TObject);
    procedure AlignRight1Click(Sender: TObject);
    procedure AlighTop1Click(Sender: TObject);
    procedure AlignBottom1Click(Sender: TObject);
    procedure SameWidth1Click(Sender: TObject);
    procedure SameHeight1Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CopytoClipBord1Click(Sender: TObject);
    procedure PastefromClip1Click(Sender: TObject);
    procedure N_shadowClick(Sender: TObject);
    procedure Btn_commitClick(Sender: TObject);
    procedure Btn_impClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);


  private
   { Private declarations }
    m_list: TClassList;
    m_copylist: TClassList;
    m_selectlist: TClassList;
    m_lists: TClasslIst;
    l_list : TClassList;
    m_liblist :TClassList;
    m_tmpList: TClassList;
    m_showdot :boolean;
    R1 ,R2 :TRect;
    l_batselect:TRect;
    m_modify:boolean;
    l_batchselect : integer;
//    m_canvas :ptobj;
    { Private declarations }
    FEvents: IMainEvents;
    procedure ActivateEvent(Sender: TObject);
    procedure ClickEvent(Sender: TObject);
    procedure CreateEvent(Sender: TObject);
    procedure DblClickEvent(Sender: TObject);
    procedure DeactivateEvent(Sender: TObject);
    procedure DestroyEvent(Sender: TObject);
    procedure KeyPressEvent(Sender: TObject; var Key: Char);
    procedure PaintEvent(Sender: TObject);
  protected
     m_num : integer;
      m_zoom : integer;
      m_seq :integer;
      l_metafile : Tmetafile;
      m_filename :string;
       m_obj : ttable;
    { Public declarations }
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
    function Get_filename: WideString; safecall;
    procedure Set_filename(const Value: WideString); safecall;
    procedure tttt; safecall;

function IPersistPropertyBag.Load = PersistPropertyBagLoad;
function IPersistPropertyBag.Save = PersistPropertyBagSave;
function IPersistPropertyBag.InitNew = PersistPropertyBagInitNew;
function IPersistPropertyBag.GetClassID = PersistPropertyBagGetClassID;
function PersistPropertyBagLoad(const pPropBag: IPropertyBag;
      const pErrorLog: IErrorLog): HResult; stdcall;
function PersistPropertyBagSave(const pPropBag: IPropertyBag; fClearDirty: BOOL;
      fSaveAllProperties: BOOL): HResult; stdcall;
function PersistPropertyBagGetClassID(out classID: TCLSID): HResult; stdcall;
function PersistPropertyBagInitNew: HResult; stdcall;

function DownloadFile( const url:string; const destinationFileName:string):boolean;
    function Get_host: WideString; safecall;
    procedure Set_host(const Value: WideString); safecall;
  public
    { Public declarations }
    file_input : WideString ;
    procedure Initialize; override;
  end;

implementation

uses ComObj, ComServ;

{$R *.DFM}

{ TMain }

function TMain.PersistPropertyBagLoad (const pPropBag:
IPropertyBag; const pErrorLog:IErrorLog):HResult; stdcall;
var v: OleVariant;
    l_host:WideString;
begin
   if pPropBag.Read( 'host', v, pErrorLog) = S_OK then
   begin
        l_host := Widestring(v);
   end
   else
   begin
       l_host := 'http://127.0.0.1:7070/';
   end;
   if pPropBag.Read( 'filename', v, pErrorLog) = S_OK then
   begin
        file_input := Widestring(v);
        if file_input <> '' then
        begin
            if (downloadfile(l_host+file_input,'c:\a.xml'))  then
            begin
                xmldoc.LoadFromFile('c:\a.xml');
                LoadFromFile(xmldoc);
                m_filename := '';
                sync();
                redraw();
           end;
        end;
   end
   else
   begin
       file_input := 'no result';
   end;
   Result := S_OK;
end;

function TMain.PersistPropertyBagSave(const pPropBag:
IPropertyBag; fClearDirty: BOOL; fSaveAllProperties: BOOL): HResult; stdcall;
begin
   Result := S_OK;
end;

function TMain.PersistPropertyBagGetClassID(out classID: TCLSID): HResult;
begin
   Result := S_OK;
end;

function TMain.PersistPropertyBagInitNew: HResult;
begin
   Result := S_OK;
end;

procedure TMain.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  { Define property pages here.  Property pages are defined by calling
    DefinePropertyPage with the class id of the page.  For example,
      DefinePropertyPage(Class_MainPage); }
end;

procedure TMain.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IMainEvents;
  inherited EventSinkChanged(EventSink);
end;

procedure TMain.Initialize;
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

function TMain.Get_Active: WordBool;
begin
  Result := Active;
end;

function TMain.Get_AlignDisabled: WordBool;
begin
  Result := AlignDisabled;
end;

function TMain.Get_AutoScroll: WordBool;
begin
  Result := AutoScroll;
end;

function TMain.Get_AutoSize: WordBool;
begin
  Result := AutoSize;
end;

function TMain.Get_AxBorderStyle: TxActiveFormBorderStyle;
begin
  Result := Ord(AxBorderStyle);
end;

function TMain.Get_Caption: WideString;
begin
  Result := WideString(Caption);
end;

function TMain.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(Color);
end;

function TMain.Get_Cursor: Smallint;
begin
  Result := Smallint(Cursor);
end;

function TMain.Get_DoubleBuffered: WordBool;
begin
  Result := DoubleBuffered;
end;

function TMain.Get_DropTarget: WordBool;
begin
  Result := DropTarget;
end;

function TMain.Get_Enabled: WordBool;
begin
  Result := Enabled;
end;

function TMain.Get_Font: IFontDisp;
begin
  GetOleFont(Font, Result);
end;

function TMain.Get_HelpFile: WideString;
begin
  Result := WideString(HelpFile);
end;

function TMain.Get_HelpKeyword: WideString;
begin
  Result := WideString(HelpKeyword);
end;

function TMain.Get_HelpType: TxHelpType;
begin
  Result := Ord(HelpType);
end;

function TMain.Get_KeyPreview: WordBool;
begin
  Result := KeyPreview;
end;

function TMain.Get_PixelsPerInch: Integer;
begin
  Result := PixelsPerInch;
end;

function TMain.Get_PrintScale: TxPrintScale;
begin
  Result := Ord(PrintScale);
end;

function TMain.Get_Scaled: WordBool;
begin
  Result := Scaled;
end;

function TMain.Get_Visible: WordBool;
begin
  Result := Visible;
end;

function TMain.Get_VisibleDockClientCount: Integer;
begin
  Result := VisibleDockClientCount;
end;

procedure TMain._Set_Font(var Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TMain.ActivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnActivate;
end;

procedure TMain.ClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnClick;
end;

procedure TMain.CreateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnCreate;
end;

procedure TMain.DblClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDblClick;
end;

procedure TMain.DeactivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDeactivate;
end;

procedure TMain.DestroyEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDestroy;
end;

procedure TMain.KeyPressEvent(Sender: TObject; var Key: Char);
var
  TempKey: Smallint;
begin
  TempKey := Smallint(Key);
  if FEvents <> nil then FEvents.OnKeyPress(TempKey);
  Key := Char(TempKey);
end;

procedure TMain.PaintEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnPaint;
end;

procedure TMain.Set_AutoScroll(Value: WordBool);
begin
  AutoScroll := Value;
end;

procedure TMain.Set_AutoSize(Value: WordBool);
begin
  AutoSize := Value;
end;

procedure TMain.Set_AxBorderStyle(Value: TxActiveFormBorderStyle);
begin
  AxBorderStyle := TActiveFormBorderStyle(Value);
end;

procedure TMain.Set_Caption(const Value: WideString);
begin
  Caption := TCaption(Value);
end;

procedure TMain.Set_Color(Value: OLE_COLOR);
begin
  Color := TColor(Value);
end;

procedure TMain.Set_Cursor(Value: Smallint);
begin
  Cursor := TCursor(Value);
end;

procedure TMain.Set_DoubleBuffered(Value: WordBool);
begin
  DoubleBuffered := Value;
end;

procedure TMain.Set_DropTarget(Value: WordBool);
begin
  DropTarget := Value;
end;

procedure TMain.Set_Enabled(Value: WordBool);
begin
  Enabled := Value;
end;

procedure TMain.Set_Font(const Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TMain.Set_HelpFile(const Value: WideString);
begin
  HelpFile := String(Value);
end;

procedure TMain.Set_HelpKeyword(const Value: WideString);
begin
  HelpKeyword := String(Value);
end;

procedure TMain.Set_HelpType(Value: TxHelpType);
begin
  HelpType := THelpType(Value);
end;

procedure TMain.Set_KeyPreview(Value: WordBool);
begin
  KeyPreview := Value;
end;

procedure TMain.Set_PixelsPerInch(Value: Integer);
begin
  PixelsPerInch := Value;
end;

procedure TMain.Set_PrintScale(Value: TxPrintScale);
begin
  PrintScale := TPrintScale(Value);
end;

procedure TMain.Set_Scaled(Value: WordBool);
begin
  Scaled := Value;
end;

procedure TMain.Set_Visible(Value: WordBool);
begin
  Visible := Value;
end;

procedure TMain.DrawMouseDown(Sender: TObject; Button: TXMouseButton;
      Shift: TShiftState; X, Y: Integer);
var
    b,C :integer;
    t : Tobj;
    l_tv: TTreeNode;
begin

   t := nil;
 //  l_tv := nil;
// main.KeyPreview := true;
   Set_KeyPreview(true);
//------- Tform( main.Parent.Parent).KeyPreview := true;
//-------   main.KeyPreview := true;
   editinput.Visible := false;
  if button = mbRight then
  begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  (t.ptin(x,y)) then
       begin
        t.m_selected := 1;
        sync;
        redraw;
        popupmenuobj.Popup(mouse.CursorPos.X ,mouse.CursorPos.y);
       end
   end;
   exit;
 end;
 c:= 0;
 //x := round((x+5) div 10) * 10;
 //y := round((y+5) div 10) * 10;
 if ToolButtonarrow.Down then
 begin
  l_batchselect := 1;
  l_batselect.Left := x;
  l_batselect.Top := y;
   editinput.Tag := -1;

   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  (t.ptin(x,y)) then
       begin
          t.m_osx := t.m_sx ; t.m_osy := t.m_sy;
          t.m_ox := t.m_x ; t.m_oy := t.m_y;
          t.m_oselected := t.m_selected;
          l_batchselect := 0;
          if ([ssShift,ssLeft] = Shift ) then
          begin
             if  (t.m_selected = 1 )
              then
              begin
                 SelectDelete(t);//==========================
                 t.m_selected := 0;
                 t.m_mousedown := 0;
                 t.setstat(x,y);
                 break;
              end
              else
              begin
                SelectAdd(t);//==================== 
                t.m_selected := 2;
                t.m_mousedown := 1;
                t.setstat(x,y);
              end;
             C:=1;
             break;
          end
          else// no shift
          begin
            if  t.m_selected = 1 then
            begin
              t.m_selected := 2;
              t.m_mousedown := 1;
              t.setstat(x,y);
              editinput.Tag := b; //record the obj id.
//              memo1.Tag := b;
              C:=1;
            end;
            break;
          end;
          break;
       end
   end; // for


   if ([ssShift,ssLeft] = Shift) or (C = 1)then  //多选 被选择
   begin
        for B := (m_List.Count - 1) downto 0 do
        begin
            t := TObj(m_List.Items[B]);
            if t.m_selected = 1 then
            begin
                t.m_selected := 2;
                t.m_mousedown := 1;
                t.setstat(x,y);
            end
        end
   end
   else
   begin //全不选择
        for B := (m_List.Count - 1) downto 0 do
        begin
                t := TObj(m_List.Items[B]);
                if t.ptin(x,y) then
                begin
                    SelectAdd(t); //==========================
                    t.m_selected := 2;
                    t.m_mousedown := 1;
                    t.setstat(x,y);
                    break;
                end
                else
                begin
                    SelectDelete(t); //==========================
                    t.m_selected := 0;
                    t.m_mousedown := 0;
                    t.setstat(x,y);
                end;
        end;
        for B := B -1 downto 0 do
        begin
            t := TObj(m_List.Items[B]);
            SelectDelete(t);  //==========================
            t.m_selected := 0;
            t.m_mousedown := 0;
            t.setstat(x,y);
        end;

   end;
 end;

  if (ToolButtonLink.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
   // m_canvas := ptobj(Image.Canvas);
    t := Tlink.Create(Image.Canvas,x-20,y-20,x,y);
    Tlink(t).SetDRect(
    Rect(0,0,0,0),
    Rect(0,0,0,0));
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
    l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName) then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if (ToolButtonLine.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
    Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    //m_canvas := ptobj(Image.Canvas);
    t := Tline.Create(Image.Canvas,x-20,y-20,x,y);
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
    l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if  (ToolButtonComm.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x-80,y-40,x,y);
    t.m_dstyle := 1;
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 1;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
    l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if  (ToolButtonTable.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TTable.Create(Image.Canvas,x-100,y-160,x,y);
    TTable(t).m_data.Add('add data');
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 1;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if  (ToolButtonEclip.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x-80,y-40,x,y);
    t.m_dstyle := 2;
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 1;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;


    if  (ToolButtonRoundRect.Down = true) then
   begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x-140,y-30,x,y);
    t.m_dstyle := 3;
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 1;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if  (ToolButtonImage.Down = true) then
    begin
    if opendialog.Execute then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x-32,y-32,x,y);
    t.m_dstyle := 4;
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 1;
    t.m_mousedown := 1;
    t.setstat(x,y);
    t.m_image := opendialog.FileName ;
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
    l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;


    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;//end openfile
    end;

    if  (ToolButtonText.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x-80,y-40,x,y);
    t.m_dstyle := 5;
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 1;
    t.m_mousedown := 1;
    t.m_desc := '* input';
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if  (ToolButtonIF.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TIF.Create(Image.Canvas,x-100,y-30,x,y);
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 1;
    t.m_mousedown := 1;
    t.setstat(x+20,y+20);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;
    if t <> nil then
      SelectAdd(t);
    Sync;
    redraw;
end;

procedure TMain.DrawMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  i,b : integer;
  l_obj : Tobj;
  rp :integer;
  rec : Trect;
  flag,n: integer;
  o,o1 : Tobj;
begin
    rp := 0;
 //   x := round((x + 5) div 10) * 10;
 //   y := round((y + 5) div 10) * 10;
   l_batselect.Bottom := Y;
   l_batselect.Right := X;
   if self.l_batchselect = 1 then
   begin
      rp := 1;
      for B := 0 to (m_List.Count - 1) do
      begin
         l_obj := Tobj(m_List.Items[B]);
         if not l_obj.IsLink  then
         begin
           if IntersectRect(rec,l_batselect,Rect(l_obj.m_sx,l_obj.m_sy,l_obj.m_x,l_obj.m_y))
           then
           begin
             SelectAdd(l_obj);
             l_obj.m_selected := 1;
             l_obj.m_mousedown := 1;
              editinput.Visible := false;
//              memo1.Visible := false;
           end
           else
           begin
             SelectDelete(l_obj); 
             l_obj.m_selected := 0;
             l_obj.m_mousedown := 0;
           end
         end
      end;
   end;

   for B := 0 to (m_List.Count - 1) do
   begin
      l_obj := Tobj(m_List.Items[B]);
      if l_obj.m_selected = 1 then
      begin
         l_obj.setstat(x,y);
      end;

      if l_obj.m_selected = 2 then   //resize
      begin
          l_obj.ResizeXY(x,y);
          if  l_obj.m_resizenode = 0 then
          l_obj.m_sourcename := ''
          else
          l_obj.m_targetname := '';

          for i := m_List.Count - 1 downto 0 do
          begin
                if (l_obj <> Tobj(m_List.Items[i]))
                then
                begin
                    if (l_obj.IsLink and not Tobj(m_List.Items[i]).IsLink)
                     and Tobj(m_List.Items[i]).Ptin(x,y) then
                    begin
                      l_obj.ResizeXY( round((Tobj(m_List.Items[i]).m_sx + Tobj(m_List.Items[i]).m_x)/2) ,
                      round((Tobj(m_List.Items[i]).m_sy + Tobj(m_List.Items[i]).m_y)/2) );

                       if (l_obj.m_resizenode = 0) then
                          l_obj.m_sourcename := Tobj(m_List.Items[i]).m_name
                       else
                           l_obj.m_targetname := Tobj(m_List.Items[i]).m_name;

                       //avoid the start and end pointer point the same target.
                       if  l_obj.m_sourcename = l_obj.m_targetname then
                            l_obj.ResizeXY(x,y);
                        break;
                     end;

                    if (not l_obj.IsLink and Tobj(m_List.Items[i]).IsLink)
                    then
                    begin

                      if l_obj.m_name = Tobj(m_List.Items[i]).m_sourcename then
                      begin
                      Tobj(m_List.Items[i]).m_resizenode := 0;
                      Tobj(m_List.Items[i]).ResizeXY( round((l_obj.m_sx + l_obj.m_x)/2),
                      round((l_obj.m_sy + l_obj.m_y)/2) );
                      end;

                      if l_obj.m_name = Tobj(m_List.Items[i]).m_targetname then
                      begin
                      Tobj(m_List.Items[i]).m_resizenode := 1;
                      Tobj(m_List.Items[i]).ResizeXY( round((l_obj.m_sx + l_obj.m_x)/2) ,
                      round((l_obj.m_sy + l_obj.m_y)/2) );
                      end;
                     end;
                end;
          end;
          rp := 1;
      end;

      if l_obj.m_selected = 3 then  //move
      begin
          if( l_obj.IsLink ) and ((l_obj.m_tx <> X) or (l_obj.m_ty <> Y)) then
          begin
             l_obj.m_sourcename := '';
             l_obj.m_targetname := '';
          end;
          l_obj.MoveXY(x,y);
          //l_obj.m_targetname := '';
          if (not l_obj.IsLink) then
            begin
             for i := 0 to  (m_List.Count - 1) do
             begin
               if (Tobj(m_List.Items[i]).m_targetname = l_obj.m_name)
                 and (Tobj(m_List.Items[i]).IsLink) then
             begin
                  Tobj(m_List.Items[i]).m_resizenode := 1;
                  Tobj(m_List.Items[i]).ResizeXY(round((l_obj.m_sx + l_obj.m_x)/2),
                   round((l_obj.m_sy+l_obj.m_y)/2));
             end;

             if (Tobj(m_List.Items[i]).m_sourcename = l_obj.m_name)
                 and (Tobj(m_List.Items[i]).IsLink()) then
             begin
                  Tobj(m_List.Items[i]).m_resizenode := 0;
                  Tobj(m_List.Items[i]).ResizeXY(round((l_obj.m_sx + l_obj.m_x)/2),
                   round((l_obj.m_sy+l_obj.m_y)/2));
             end;
            end;
          end;
        rp:=1;
      end;
    end; // for

    o := nil ; o1 := nil;
    for b := 0 to (m_List.Count - 1) do //
    begin
        if TObj(m_List.Items[b]).IsLink then
        begin
           flag := 0;
            for n := 0 to (m_List.Count - 1) do
            begin
              if TObj(m_List.Items[n]).m_name = TObj(m_List.Items[b]).m_sourcename then
              begin
                o := TObj(m_List.Items[n]);
                flag:= flag + 1;
              end;
              if TObj(m_List.Items[n]).m_name = TObj(m_List.Items[b]).m_targetname then
              begin
                 o1 := TObj(m_List.Items[n]);
                 flag:= flag + 2;
              end;
            end;
            // 根据线连接的对象大小，重新计算线的起点和终点
            if ( flag = 0 ) then
            Tlink(m_List.Items[b]).SetDRect(
            Rect(0,0,0,0),
            Rect(0,0,0,0))
            else  if ( flag = 1) then
            Tlink(m_List.Items[b]).SetDRect(
            Rect(o.m_sx,o.m_sy,o.m_x,o.m_y),
            Rect(0,0,0,0))
            else  if ( flag = 2) then
             begin
              caption := Tobj(m_List.Items[b]).ClassName;
             Tlink(m_List.Items[b]).SetDRect(
              Rect(0,0,0,0),
              Rect(o1.m_sx,o1.m_sy,o1.m_x,o1.m_y)
              )
             end
            else
            Tlink(m_List.Items[b]).SetDRect(
            Rect(o.m_sx - 5 ,o.m_sy - 5,o.m_x + 5,o.m_y + 5),
           Rect(o1.m_sx - 5,o1.m_sy - 5,o1.m_x+ 5,o1.m_y+ 5));

          TObj(m_List.Items[b]).Draw;
        end;
     //
    end;
    if rp = 1 then
      redraw();
end;

procedure TMain.DrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   b :integer;
   l_obj :Tobj;
   l_si :tsize;
begin

   ToolButtonArrow.Down := true;
   l_batchselect := 0;
   screen.cursor :=  0;
  for B := 0 to (m_List.  Count - 1) do
    begin
      l_obj := Tobj(m_List.Items[B]);
      if l_obj.m_selected = 2 then
        l_obj.m_selected := 1
      else if l_obj.m_selected = 3 then
      begin

          if (l_obj.m_osx = l_obj.m_sx) and (l_obj.m_osy = l_obj.m_sy) and
          (l_obj.m_ox = l_obj.m_x) and  (l_obj.m_oy = l_obj.m_y)
          and (l_obj.m_oselected = 1)
          then
          begin
//----            Tform( main.Parent.Parent).KeyPreview := false;
                  Set_KeyPreview(false);
//----            main.KeyPreview  := false;

            editinput.Visible := true;
//            memo1.Visible := not memo1.Visible;
            editinput.Left := l_obj.m_sx -5 + scrollbox1.Left;
            if l_obj.ClassName = 'TTable' then
            editinput.Top := l_obj.m_sy + scrollbox1.Top
            else
            editinput.Top := round((l_obj.m_sy+l_obj.m_y)/2)+ scrollbox1.Top;
            gettextextentpointW(l_obj.m_canvas.Handle,pwidechar(l_obj.m_desc),length(string(l_obj.m_desc)),l_si);
//            edit1.Width := max(20 + length(l_obj.m_desc)*6,l_obj.m_x- l_obj.m_sx+10);
            editinput.Width := max(l_obj.m_x - l_obj.m_sx+40,l_si.cx);
            editinput.Text := l_obj.m_desc;
            editinput.SetFocus;
            editinput.SelectAll;
            SelectDelete(l_obj);
            l_obj.m_selected := 0;
          end
          else
           l_obj.m_selected := 1
      end;
      l_obj.m_mousedown := 0;
    end;
    if pn_table.Visible then editinput.Hide;
   redraw();

end;

procedure TMain.FormCreate(Sender: TObject);
begin
    m_zoom := 100;
    m_list := TClassList.Create;
    m_copylist := TClassList.Create;
    m_selectlist := TClassList.Create;
    m_lists := TClassList.Create;
    m_lists.Add(TClass(m_list));
    m_liblist := TClassList.Create;
    r1.Left:=0; r1.Right:=1024*2;
    r1.Top:=0; r1.Bottom:=768*2;
    Image.Width:=1024*2;
    Image.Height:=768*2;
    R2:= R1;
    m_seq := 0;
    m_showdot := true;
    image.Canvas.Brush.Color:=clwhite;
    image.Canvas.pen.Width := 1;
    m_modify := false;
   l_metafile := Tmetafile.create;
   paintbox1.Width := 1024*2;
   paintbox1.Height := 768*2;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
var i : integer;
begin
    if m_modify then
    begin
       i :=  application.MessageBox('保存当前的文件？', '提示', MB_YESNOCANCEL);
     if i = id_Yes then
      SaveToClick(self);
     if i = id_cancel then
     begin
       Action := caNone;
       exit;
     end;
    end;
    for i := 0 to m_lists.Count -1 do
    begin
       TClassList(m_lists.Items[i]).Free;
    end;
    m_lists.Free;
    m_copylist.Free;
    m_selectlist.Free;
    m_liblist.Free;
end;

procedure TMain.FormPaint(Sender: TObject);
begin
//   redraw();
end;

procedure TMain.delete1Click(Sender: TObject);
var
   b:integer;
   n: integer;
begin
   n := (m_List.Count - 1);
   for B := 0 to n do
        if (TObj(m_List.Items[B]).m_selected =1) then
         begin
            m_List.Delete(b);
            break;
         end;
    screen.Cursor := 0;
    Sync;
    redraw();
end;

procedure TMain.SaveToClick(Sender: TObject);
var
   l_r :TIniFile;
begin
 if m_filename <> '' then
 begin
        l_r:=TIniFile.Create(m_filename);
        Screen.Cursor := crHourGlass;
        SaveToFile(xmldoc);
        xmldoc.SaveToFile(m_filename);
        m_modify  := false;
        l_r.Destroy;
        Screen.Cursor := crarrow;
        exit;
 end
 else if SaveDialog.Execute then
 begin
        l_r:=TIniFile.Create(SaveDialog.FileName);
        Screen.Cursor := crHourGlass;
        SaveToFile(xmldoc);
        xmldoc.SaveToFile(SaveDialog.FileName);
        m_modify  := false;
        m_filename := SaveDialog.FileName;
        l_r.Destroy;
         Screen.Cursor := crarrow;
  end;
end;

procedure TMain.SaveToFile( FileHandle: TXmldocument);
var
    n,i : integer;
    l_node :ixmlnode;
begin
    filehandle.LoadFromStream(Tstringstream.Create('<?xml version="1.0" standalone="yes"?><content></content>'));
    filehandle.Active := true;

    for n := 0 to m_lists.count -1 do
    begin
    l_list := Tclasslist(m_lists.items[n]);
    l_node := filehandle.DocumentElement.AddChild('map');
    for i := 0 to l_list.Count-1  do
          Tobj(l_list.Items[i]).SavetoFile(i,l_node);
    end;
end;

procedure TMain.LoadFromFile( FileHandle: TXMLDocument);
var
  i :integer;
  o :tobj;
  cls :string;
  vnode,l_mapnode : IXMLNODE;
  l_tv : ttreenode;
  n : integer;
  l_mapnum : integer;
begin
    tv.Items.Clear;
    tv.Items.AddChild(nil,'Map');
    m_lists.Clear;

    l_mapnum := FileHandle.DocumentElement.ChildNodes.Count;
    for n := 0 to l_mapnum -1 do
    begin
       l_mapnode := FileHandle.DocumentElement.ChildNodes[n];
       m_num := l_mapnode.ChildNodes.Count;
       m_list  := TClassList.Create;
      l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = 'Map' then
      begin
        tv.Items.AddChild(l_tv,inttostr(n)).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;


    for i := 0 to m_num - 1 do
    begin
//        cls := FileHandle.ReadString(inttostr(i),'classname','');
        vnode := l_mapnode.ChildNodes[i];
        cls := vnode.childNodes['classname'].text;
          o := nil;
          if cls = 'TLink' then
          o := Tlink.Create(image.canvas,0,0,0,0)
          else if (cls = 'TComm')  then
           o := TComm.Create(Image.canvas,0,0,0,0)
          else if (cls = 'TEcllipse')  then
          begin
           o := TComm.Create(Image.canvas,0,0,0,0);
           o.m_dstyle:=2;
          end
          else if (cls = 'TLine')  then
           o := Tline.Create(Image.canvas,0,0,0,0)
          else if  (cls = 'TTable') then
          o := TTable.Create(Image.canvas,0,0,0,0)
          else if   (cls = 'TIF') then
          o := TIF.Create(Image.canvas,0,0,0,0)
          else if (cls = 'TRoundrect')  then
          begin
           o := TComm.Create(Image.canvas,0,0,0,0);
           o.m_dstyle:=3;
          end;

        //  o.m_name := FileHandle.ReadString(inttostr(i),'m_name','');
          o.m_name := vnode.ChildNodes['m_name'].Text;
          m_seq := max(m_seq,strtoint(o.m_name));
          o.LoadfromFile(i,vnode);
    l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = cls then
      begin
        tv.Items.AddChild(l_tv,o.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> cls)  then
    begin
      l_tv := tv.Items.Add(nil,cls);
      tv.Items.AddChild(l_tv,o.m_name).ImageIndex := 4;
    end;
          m_list.Add(Tclass(o));
          o.m_list := m_list;
    end;
    m_lists.Add(TClass(m_list));
    end;
    DrawMouseMove(self,[],0,0);
end;

procedure TMain.LoadClick(Sender: TObject);
var
   fh:TIniFile;
begin
 Opendialog.Filter := 'XML files |*.XML|All File|*.*';
 if OpenDialog.Execute then
 begin
        m_list.Clear;
        fh:=TIniFile.Create(OpenDialog.FileName);
        fh.Free;
        xmldoc.LoadFromFile(OpenDialog.FileName);
        LoadFromFile(xmldoc);
        m_filename := OpenDialog.FileName;
  end;
  sync();
  redraw();
  m_modify := false;
end;

procedure TMain.Redraw();
var
   b,n,maxx,maxy :integer;
   l_metacanvas : Tmetafilecanvas;
begin

   l_metacanvas := TMetafileCanvas.Create(l_metafile, 0);
   l_metafile.Width := 1000;
   l_metafile.Height := 1000;
    l_metacanvas.Brush.Color := clwhite;
    l_metacanvas.FillRect(rect(0,0,10000,10000));

   if m_showdot and (m_zoom > 70) then
   begin
     l_metacanvas.Pen.Color := clblack;
    for b := 0 to round(image.Width/20) do
    begin
      for n :=0 to  round(image.height/20) do
      begin
         l_metacanvas.MoveTo(b*20,n*20);
         l_metacanvas.LineTo(b*20+1,n*20);
      end;
    end;
   end;
   maxx := 400;
   maxy:= 400;

   //先画对象


    for b := 0 to (m_List.Count - 1) do
    begin
       TObj(m_List.Items[b]).m_canvas := l_metacanvas;
    end;

    for b := 0 to (m_List.Count - 1) do
    begin
           maxx :=  max(TObj(m_List.Items[b]).m_x+100,maxx);
           maxy := max(TObj(m_List.Items[b]).m_y+100,maxy);
           if not TObj(m_List.Items[b]).IsLink then
           TObj(m_List.Items[b]).Draw;
    end; // for

   //后画线
    for b := 0 to (m_List.Count - 1) do
    begin
           maxx :=  max(TObj(m_List.Items[b]).m_x+100,maxx);
           maxy := max(TObj(m_List.Items[b]).m_y+100,maxy);
        if TObj(m_List.Items[b]).IsLink then
        begin
        TObj(m_List.Items[b]).Draw;
        end;
    end; // for

    if l_batchselect = 1 then
    begin
      l_metacanvas.Brush.Color := clBlack;
      l_metacanvas.FrameRect(l_batselect);
      l_metacanvas.Brush.Color := clwhite;
    end;
{
   if m_zoom > 100 then
   begin
   paintbox1.Width := max(round(maxx * m_zoom /100),scrollbox1.Width);
   paintbox1.Height := max(round(maxy * m_zoom /100 ),scrollbox1.Height);
   end
   else
   begin
   paintbox1.Width := max(maxx ,scrollbox1.Width);
   paintbox1.Height := max(maxy  ,scrollbox1.Height);
   end;
}
   l_metacanvas.Free;
   
   image.canvas.StretchDraw(
    rect(
    round(0*m_zoom/100),
    round(0*m_zoom/100),
    round(l_metafile.Width *m_zoom/100),
    round(l_metafile.Height *m_zoom/100))
    ,l_metafile);

   paintbox1.canvas.CopyRect(paintbox1.ClientRect,image.canvas,paintbox1.ClientRect);
   image1.canvas.StretchDraw(image1.ClientRect,l_metafile);
   
    for b := 0 to (m_List.Count - 1) do
    begin
       TObj(m_List.Items[b]).m_canvas := image.Canvas;
    end;
end;

{
procedure TMain.Redraw_o();
var
   b,n,flag,maxx,maxy :integer;
   o,o1 :tobj;
begin
    image.Canvas.Brush.Color := clwhite;
    image.Canvas.FillRect(R2);

   if m_showdot then
   begin
     image.Canvas.Pen.Color := clblack;
    for b := 0 to round(image.Width/10) do
    begin
      for n :=0 to  round(image.height/10) do
      begin
         image.Canvas.MoveTo(b*10,n*10);
         image.Canvas.LineTo(b*10+1,n*10);
      end;
    end;
   end;
   maxx := 400;
   maxy:= 400;
   o := nil ; o1 := nil;
   //先画对象
    for b := 0 to (m_List.Count - 1) do
    begin
           maxx :=  max(TObj(m_List.Items[b]).m_x+100,maxx);
           maxy := max(TObj(m_List.Items[b]).m_y+100,maxy);
           if not TObj(m_List.Items[b]).IsLink then
           TObj(m_List.Items[b]).Draw;
    end; // for

   //后画线
    for b := 0 to (m_List.Count - 1) do
    begin
           maxx :=  max(TObj(m_List.Items[b]).m_x+100,maxx);
           maxy := max(TObj(m_List.Items[b]).m_y+100,maxy);
        if TObj(m_List.Items[b]).IsLink then
        begin
        TObj(m_List.Items[b]).Draw;
        end;
    end; // for

    if l_batchselect = 1 then
    begin
      image.Canvas.Brush.Color := clBlack;
      image.Canvas.FrameRect(l_batselect);
      image.Canvas.Brush.Color := clwhite;
    end;

   paintbox1.Width := max(maxx,scrollbox1.Width);
   paintbox1.Height := max(maxy,scrollbox1.Height);
//   paintbox1.canvas.CopyRect(paintbox1.ClientRect,image.canvas,paintbox1.ClientRect);

   paintbox1.canvas.StretchDraw(
    rect(
    round(image2.ClientRect.Left *m_zoom/100),
    round(image2.ClientRect.Top *m_zoom/100),
    round(image2.ClientRect.Right *m_zoom/100),
    round(image2.ClientRect.Bottom *m_zoom/100))
    ,image2.Picture.Graphic);

end;

}
procedure TMain.bringtofront1Click(Sender: TObject);
var t:tobj;
    b :integer;
begin
    if m_list.Count > 1 then
     begin
           for b := (m_List.Count - 1) downto 1 do
                if (TObj(m_List.Items[b]).m_selected = 1) then
            begin
                 t := TObj(m_List.Items[b-1]);
                  m_List.Items[b-1] :=  m_List.Items[b];
                   m_List.Items[b] := Tclass(t);
            end;
     end;
    redraw();
end;

procedure TMain.BringToTop1Click(Sender: TObject);
var t:tobj;
    b :integer;
begin
     if m_list.Count > 1 then
     begin
            for b := 0 to (m_List.Count - 2) do
                if (TObj(m_List.Items[b]).m_selected = 1) then
                begin
                 t := TObj(m_List.Items[b+1]);
                  m_List.Items[b+1] :=  m_List.Items[b];
                   m_List.Items[b] := Tclass(t);
                end;
     end;
    redraw();
end;

procedure TMain.FormDblClick(Sender: TObject);
begin
   sync;
end;

procedure TMain.VLEKeyPress(Sender: TObject; var Key: Char);
var
  b: Integer;
begin
  if (Key = #13) then
  begin

  for b := 0 to (m_List.Count -1 ) do
  begin
  if Tobj(m_List.Items[b]).m_selected = 1 then
  begin
      TObj(m_List.Items[b]).m_name:= VLE.Values['m_name'];
      TObj(m_List.Items[b]).m_sourcename := VLE.Values['m_sourcename'];
      TObj(m_List.Items[b]).m_targetname := VLE.Values['m_targetname'];
      TObj(m_List.Items[b]).m_x := strtoint(VLE.Values['m_x']);
      TObj(m_List.Items[b]).m_y := strtoint(VLE.Values['m_y']);
      TObj(m_List.Items[b]).m_sx := strtoint(VLE.Values['m_sx']);
      TObj(m_List.Items[b]).m_sy := strtoint(VLE.Values['m_sy']);
      TObj(m_List.Items[b]).m_desc := (VLE.Values['m_desc']);
      TObj(m_List.Items[b]).m_code := (VLE.Values['m_code']);
  end;
  end;
  sync;
  ReDraw;
  end;
end;

procedure TMain.Sync();
var
  b :integer;
  l_tv :ttreenode;
begin
   VLE.Strings.Clear;
   for b := 0 to (m_List.Count - 1) do
    begin
    if (TObj(m_List.Items[b]).m_selected > 0) then
    begin
      VLE.Strings.Clear;
      VLE.InsertRow('m_name',TObj(m_List.Items[b]).m_name,true);
      VLE.InsertRow('m_sourcename',TObj(m_List.Items[b]).m_sourcename,true);
      VLE.InsertRow('m_targetname',TObj(m_List.Items[b]).m_targetname,true);
      VLE.InsertRow('ClassName',TObj(m_List.Items[b]).ClassName,true);
      VLE.InsertRow('m_x',inttostr(TObj(m_List.Items[b]).m_x),true);
      VLE.InsertRow('m_y',inttostr(TObj(m_List.Items[b]).m_y),true);
      VLE.InsertRow('m_sx',inttostr(TObj(m_List.Items[b]).m_sx),true);
      VLE.InsertRow('m_sy',inttostr(TObj(m_List.Items[b]).m_sy),true);
      VLE.InsertRow('m_desc',TObj(m_List.Items[b]).m_desc,true);
      VLE.InsertRow('m_code',TObj(m_List.Items[b]).m_code,true);

      if tv.Focused then
      begin
        l_tv := tv.Items.GetFirstNode;
        while l_tv <> nil do
        begin
         if l_tv.Text = TObj(m_List.Items[b]).m_name then
            l_tv.Selected := true;
            l_tv := l_tv.GetNext;
        end;
      end;
      break;
     end;
    end;

    ListBox2.clear;
    if m_liblist.Count > 0 then
    begin
    m_tmplist := TClassList(m_liblist.Items[ComboBox1.ItemIndex]);

    for b:= 0 to m_tmplist.count-1 do
    begin
        ListBox2.AddItem(Tobj(m_tmplist.Items[b]).m_desc,Tobject(m_tmplist.Items[b]));
    end;
    end;
    caption:= 'FLY [' + m_filename + ']';
    m_modify := true;
end;

procedure TMain.SaveasClick(Sender: TObject);
//var
   //l_r :TiniFile;
//   lxmldoc :Txmldocument;
begin
 SaveDialog.Filter := 'XML files |*.XML|All File|*.*';
 if SaveDialog.Execute then
 begin
    // l_r:=TIniFile.Create(SaveDialog.FileName);
 //    lxmldoc := Txmldocument.Create(SaveDialog.FileName);
     SaveToFile(xmldoc);
     xmldoc.SaveToFile(SaveDialog.FileName);
     //l_r.Destroy;
     m_filename := SaveDialog.FileName;
  end;
end;

procedure TMain.NewClick(Sender: TObject);
begin
    m_list.Clear;
    m_seq := 0;
    m_filename := '';
    sync;
    redraw;
end;

procedure TMain.ComboBox1Change(Sender: TObject);
begin
   Sync;
   redraw;
end;

procedure TMain.ListBox2Click(Sender: TObject);
begin
   redraw;
end;

procedure TMain.ScrollBar_VChange(Sender: TObject);
begin;
end;

procedure TMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var l_obj : tobj;
    b :integer;
    l_tag : integer;
begin
 //---- if form1.PageControl1.ActivePageIndex <> 1 then exit;
   l_tag := 0;
   if (key = ord('D')) and  (Shift = [ssCtrl]) then
   begin
      l_tag := 1;
      m_showdot := not m_showdot;
   end;
   if (key = ord('W')) and  (Shift = [ssCtrl]) then
   begin

   end;
  if (key = ord('V')) and  (Shift = [ssCtrl]) then
  begin
        PastefromClip1Click(sender);
  end;

  if (key = ord('C')) and  (Shift = [ssCtrl]) then
  begin
     CopytoClipBord1Click(sender);
 //    copysqltoclip1Click(self);
  end;

  if (key = ord('A')) and  (Shift = [ssCtrl]) then
   begin
    l_tag := 1;
   for B := 0 to (m_List.Count - 1) do
    begin
      l_obj := Tobj(m_List.Items[B]);
      if (not l_obj.IsLink) then
      begin
      SelectAdd(l_obj);
      l_obj.m_selected := 1;
      end;
   end;
   end;
   
  if editinput.Visible then
    editinput.SetFocus;
  if l_tag <> 0 then
  begin
  Sync;
  redraw;
  end;
end;

procedure TMain.EditInputClick(Sender: TObject);
begin
//---    Tform( main.Parent.Parent).KeyPreview := false;
        Set_KeyPreview(false);
//---    main.KeyPreview := false;
end;

procedure TMain.EditInputExit(Sender: TObject);
begin
    editinput.Visible := false;
end;

procedure TMain.Rect1Click(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_dstyle := 1;
       end
   end;
    sync;
   redraw;
end;

procedure TMain.Eclip1Click(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_dstyle := 2;
       end
   end;
    sync;
   redraw;
end;

procedure TMain.RoundRect1Click(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_dstyle := 3;
       end
   end;
    sync;
   redraw;
end;

procedure TMain.RedClick(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_fillcolor := $99bbff;
       end
   end;
    sync;
   redraw;

end;

procedure TMain.BlueClick(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_fillcolor := $ffeedd;
       end
   end;
    sync;
   redraw;
end;

procedure TMain.YellowClick(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_fillcolor := $88ffff;
       end
   end;
    sync;
   redraw;
end;

procedure TMain.MenuItem4Click(Sender: TObject);
var
    b :integer;
begin
     if m_list.Count > 1 then
     begin
            for b := 0 to (m_List.Count - 1) do
                if (TObj(m_List.Items[b]).m_selected = 1) then
                begin
                  m_list.Move(b,m_list.Count-1);
                  break;

                end;
     end;
    redraw();

end;

procedure TMain.SendtoBack1Click(Sender: TObject);
var
    b :integer;
begin
    if m_list.Count > 1 then
     begin
           for b := (m_List.Count - 1) downto 1 do
                if (TObj(m_List.Items[b]).m_selected = 1) then
            begin
                  m_list.Move(b,0);
                  break;
            end;
     end;
    redraw();
end;

procedure TMain.N3Click(Sender: TObject);
var b,l_flag:integer;
    t : tobj;
begin
   l_flag := 0;
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
       if (l_flag = 0)  then
       begin
       ColorDialog1.Color := t.m_fillcolor;
       if  ColorDialog1.Execute then
       begin
         t.m_fillcolor := ColorDialog1.Color;
         l_flag := 1;
       end;
       end
       else
          t.m_fillcolor := ColorDialog1.Color;
       end;
   end;
    sync;
   redraw;
end;

procedure TMain.Image2MouseDown(Sender: TObject; Button: TXMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
       DrawMouseDown(Sender,button,shift,x,y);
end;

procedure TMain.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
        drawMouseMove(Sender,shift,x,y);
end;

procedure TMain.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
         drawMouseUp(Sender,button,shift,x,y);
end;

procedure TMain.TVChange(Sender: TObject; Node: TTreeNode);
var b :integer;
begin
     if (node.Parent <> nil) and (node.Parent.Text = 'Map') then exit;
       for b := (m_List.Count-1 ) downto 0 do
            if (TObj(m_List.Items[b]).m_name = node.Text) then
                TObj(m_List.Items[b]).m_selected := 1
            else
                TObj(m_List.Items[b]).m_selected := 0;
//       sync;
       redraw;
end;

procedure TMain.EditInputKeyPress(Sender: TObject; var Key: Char);
var l_obj : tobj;
    l_si :tsize;
begin
    l_obj := Tobj(m_List.Items[editinput.Tag]);
    if (key = chr(13)) then
    begin
//---        Tform( main.Parent.Parent).KeyPreview := true;
        Set_KeyPreview(true);
//---        main.KeyPreview := true;
        l_obj.m_desc := editinput.Text;
        editinput.Visible := false;
     end;
    gettextextentpointW(canvas.Handle,pwidechar(editinput.text),length(editinput.text),l_si);
    editinput.Width := max(l_obj.m_x - l_obj.m_sx+10,l_si.cx);
    redraw;
end;

{procedure TMain.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if not scrollbox1.Focused then
      scrollbox1.SetFocus;
   DrawMouseDown(Sender,button,shift,
   round(x*100/m_zoom),
   round(y*100/m_zoom));
end;
}
procedure TMain.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
      drawMouseMove(Sender,shift, round(x*100/m_zoom),round(y*100/m_zoom));
end;

procedure TMain.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    drawMouseUp(Sender,button,shift,
       round(x*100/m_zoom),
       round(y*100/m_zoom));
end;

procedure TMain.PaintBox1Paint(Sender: TObject);
begin
      redraw;
end;

procedure TMain.ScrollBox1Resize(Sender: TObject);
begin
 {    paintbox1.SetBounds(10,10,
     max(scrollbox1.Width, paintbox1.Width),
     max(scrollbox1.Height, paintbox1.Height)) ;
}
end;

procedure TMain.ToolButton1Click(Sender: TObject);
var
   b:integer;
   n: integer;
begin
   n := (m_List.Count - 1);
   for B := 0 to n do
        if (TObj(m_List.Items[B]).m_selected =1) then
         begin
            m_List.Delete(b);
            break;
         end;
    screen.Cursor := 0;
    Sync;
    redraw();
end;

procedure TMain.ToolButton4Click(Sender: TObject);
begin
    m_list.clear;
    m_copylist.Clear;
    m_selectlist.Clear;
    m_lists.Free;
    m_lists := TClassList.Create;
    m_seq := 0;
    m_filename := '';
    tv.Items.Clear;
    ToolButton5Click(sender);
    sync;
    redraw;
end;

procedure TMain.PaintBox1DblClick(Sender: TObject);
var
  l_p : Tpoint;
  b :integer;
  t : tobj;
  i : integer;
begin
   l_p := paintbox1.ScreenToClient(Mouse.CursorPos);
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  (t.ptin(l_p.x,l_p.y)) then
       begin
        t.m_selected := 1;
        sync;
        redraw;
        if t.ClassName = 'TTable' then
        begin
          ValueListEditor1.Strings.Clear;
           for i := 0 to TTable(t).m_data.Count - 1 do
                ValueListEditor1.Values[inttostr(i)] :=TTable(t).m_data[i];
           memo3.Text :=  StringReplace(TTable(t).m_index,#$A,#13#10,[rfReplaceAll]);
           edit1.Text := TTable(t).m_desc;
           m_obj := Ttable(t);
           memo_partition.Text := TTable(t).m_partition;
           editinput.Hide;
           pn_table.Show;
        end;
       end
   end;
end;

procedure TMain.PaintBox1Click(Sender: TObject);
var
  l_p : Tpoint;
begin
  l_p := paintbox1.ScreenToClient(Mouse.CursorPos);
  btn_path.Caption := file_input;
//   drawMouseDown(Sender,mbLeft,[],l_p.x,l_p.y);
end;

procedure TMain.ScrollBox1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
if shift = [ssCtrl] then
  Tb_zoomout.Click
else
     scrollbox1.VertScrollBar.Position :=
  max(scrollbox1.VertScrollBar.Position + 50,0);
end;

procedure TMain.ScrollBox1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
if shift = [ssCtrl] then
  Tb_zoomin.Click
else
 scrollbox1.VertScrollBar.Position :=
   min(scrollbox1.VertScrollBar.Position - 50,scrollbox1.VertScrollBar.Range);
end;

procedure TMain.copysqltoclip1Click(Sender: TObject);
var b :integer;
 l_sql :string;
 t : tobj;
begin
  for B := (m_List.Count - 1) downto 0 do
   begin
        t := TObj(m_List.Items[B]);
       if t.m_selected <> 0 then
       begin

       if t.ClassName = 'TTable' then
        l_sql := l_sql + TTABLE(t).GenSQL;
       end;
    end;
    clipboard.AsText := l_sql;
end;

procedure TMain.copyhtmltoclip1Click(Sender: TObject);
var b :integer;
 l_sql :string;
 t : tobj;
begin
  l_sql := '<style>table{ border:1px solid black;    border-collapse:collapse;    width:100%}';
  l_sql := l_sql + #13#10;
  l_sql := l_sql + 'td{    border:1px solid black;     padding-left:4px;    empty-cells:show;}</style>';
  for B := (m_List.Count - 1) downto 0 do
   begin
        t := TObj(m_List.Items[B]);
       if t.m_selected <> 0 then
       begin

       if t.ClassName = 'TTable' then
        l_sql := l_sql + TTABLE(t).GenhtmL;
       end;
    end;
    clipboard.AsText := l_sql;

end;

procedure TMain.Tb_zoominClick(Sender: TObject);
begin
   if m_zoom < 1000 then
   begin
    m_zoom := round(m_zoom * 1.1);
    paintbox1.Width :=   round(paintbox1.Width * 1.1);
    paintbox1.Height :=   round(paintbox1.Height * 1.1);
   redraw
    end;
end;

procedure TMain.tb_zoomoutClick(Sender: TObject);
begin
   if m_zoom > 20 then
   begin
    m_zoom := round(m_zoom /1.1);
    paintbox1.Width :=   round(paintbox1.Width / 1.1);
    paintbox1.Height :=   round(paintbox1.Height / 1.1);
     redraw
    end;

end;

procedure TMain.FormDestroy(Sender: TObject);
begin
   l_metafile.Free;
end;

procedure TMain.Center1Click(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_textalign := 'center';
       end
   end;
    sync;
   redraw;
end;

procedure TMain.Bottom1Click(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_textalign := 'bottom';
       end
   end;
    sync;
   redraw;
end;


procedure TMain.ToolButton5Click(Sender: TObject);
var
  l_tv : TTreenode;
begin
    m_list  := TClassList.Create;
    m_lists.Add(Tclass(m_List));
    l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = 'Map' then
      begin
        tv.Items.AddChild(l_tv,inttostr(m_lists.Count-1)).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if l_Tv = nil then
    begin
        l_tv := tv.Items.AddChild(nil,'Map');
        tv.Items.AddChild(l_Tv,inttostr(m_lists.Count-1)).ImageIndex := 4;
    end ;
    sync;
    redraw;
end;

procedure TMain.TVDblClick(Sender: TObject);
var
  l_p : Tpoint;
  AnItem: TTreeNode;
begin
    l_p := tv.ScreenToClient(mouse.CursorPos);
    AnItem := TV.GetNodeAt(l_p.X,l_p.Y);
    if ( AnItem <> nil) and
        (AnItem.Parent.Text = 'Map') then
    begin
    m_list := TClassList(m_lists.Items[strtoint(AnItem.Text)]);
    sync;
    redraw;
    end;
end;

procedure TMain.copyobjs();
var  b: integer;
     l_obj :Tobj;
begin
    m_copylist.Clear;
    for b := 0 to m_list.Count -1 do
    begin
        l_obj:=tobj(m_list.Items[b]);
        if l_obj.m_selected <> 0 then
        begin
           m_copylist.Add(TClass(l_obj));
        end;
    end;
end;

procedure TMain.pasteobjs();
var  b,c: integer;
     l_obj,o :Tobj;
     cls : string;
begin
    for b := 0 to m_copylist.Count -1 do
    begin
        l_obj:=tobj(m_copylist.Items[b]);
         cls := l_obj.ClassName;
         o := nil;
          if cls = 'TLink' then
          o := Tlink.Create(image.canvas,0,0,0,0)
          else if (cls = 'TComm')  then
           o := TComm.Create(Image.canvas,0,0,0,0)
          else if (cls = 'TEcllipse')  then
          begin
           o := TComm.Create(Image.canvas,0,0,0,0);
           o.m_dstyle:=2;
          end
          else if (cls = 'TLine')  then
           o := Tline.Create(Image.canvas,0,0,0,0)
          else if  (cls = 'TTable') then
          o := TTable.Create(Image.canvas,0,0,0,0)
          else if   (cls = 'TIF') then
          o := TIF.Create(Image.canvas,0,0,0,0)
          else if (cls = 'TRoundrect')  then
          begin
           o := TComm.Create(Image.canvas,0,0,0,0);
           o.m_dstyle:=3;
          end;
//          o.m_seq := inttostr(strtoint(l_obj.m_seq) +  m_copylist.Count);
          o.m_name       := inttostr(m_seq + strtoint(l_obj.m_name)+ m_copylist.Count);
          if l_obj.m_sourcename <> '' then
          o.m_sourcename := inttostr(m_seq + strtoint(l_obj.m_sourcename)+ m_copylist.Count);
          if l_obj.m_targetname <> '' then
          o.m_targetname := inttostr(m_seq + strtoint(l_obj.m_targetname)+ m_copylist.Count);
          O.m_dstyle := l_obj.m_dstyle;
          O.m_canvas := l_obj.m_canvas;
          O.m_sx := l_obj.m_sx +20;
          O.m_sy := l_obj.m_sY +20;
          O.m_y  :=  l_obj.m_Y +20;
          O.m_x  :=  l_obj.m_X +20;
          O.m_osx := l_obj.m_Osx +20;
          O.m_osy := l_obj.m_OSY +20;
          O.m_ox := l_obj.m_OX +20;
          O.m_oy := l_obj.m_OY +20;
          O.m_desc := l_obj.m_desc;
          O.m_textalign := l_obj.m_textalign;
          O.m_image := l_obj.m_image;
          O.m_color := l_obj.m_color;
          O.m_fillcolor := l_obj.m_fillcolor;
          o.m_mousedown := 0;
          if o.IsLink then
          o.m_selected := 0
          else
          o.m_selected := 1;
          o.m_drect := l_obj.m_drect;
          o.m_resizenode := l_obj.m_resizenode;
    //      o.m_list := l_obj.m_list;
          l_obj.m_mousedown := 0;
          l_obj.m_selected := 0;
          if o.ClassName = 'TTable' then
          begin
                for c := 0 to TTable(l_obj).m_data.Count - 1 do
                   TTable(o).m_data.Add(TTable(l_obj).m_data.Strings[c]);
              TTable(o).m_partition :=  TTable(l_obj).m_partition;
              TTable(o).m_index :=  TTable(l_obj).m_index;
          end;
          m_list.Add(TClass(O));
    end;
    m_seq := 2*m_seq +m_copylist.Count;
    sync;
    redraw;
end;

procedure TMain.Btn_pathClick(Sender: TObject);
begin
       renamefile('d:\\'+btn_path.Caption,'d:\\emf\\'+btn_path.Caption);
       clipboard.AsText := '[image]d:\emf\'+btn_path.Caption;
end;


procedure TMain.SelectDelete(obj: TObj);
begin
    m_SelectList.Remove(TClass(obj));
end;

procedure TMain.SelectAdd(obj: TObj);
var
     b:integer;
     l_obj : Tobj;
begin
   for b:=0 to m_SelectList.Count -1 do
   begin
      l_obj := Tobj(m_SelectList.Items[b]);
      if l_Obj.m_name = obj.m_name then
        exit;
   end;
     m_SelectList.Add(TClass(obj));
end;

procedure TMain.SelectAlignLeft();
var b:integer;
begin
   if m_SelectList.Count < 2 then exit;
   
   for b:=1 to m_SelectList.Count -1 do
   begin
      Tobj(m_SelectList.Items[b]).m_x := Tobj(m_SelectList.Items[0]).m_sx +
      abs(Tobj(m_SelectList.Items[b]).m_x - Tobj(m_SelectList.Items[b]).m_sx);
      Tobj(m_SelectList.Items[b]).m_sx := Tobj(m_SelectList.Items[0]).m_sx;
   end;
      sync;redraw;
end;

procedure TMain.SelectAlignRight();
var b:integer;
begin
   if m_SelectList.Count < 2 then exit;
   
   for b:=1 to m_SelectList.Count -1 do
   begin
      Tobj(m_SelectList.Items[b]).m_sx := Tobj(m_SelectList.Items[0]).m_x -
      abs(Tobj(m_SelectList.Items[b]).m_x - Tobj(m_SelectList.Items[b]).m_sx);
      Tobj(m_SelectList.Items[b]).m_x := Tobj(m_SelectList.Items[0]).m_x;
   end;
      sync;redraw;
end;

procedure TMain.SelectAligntop();
var b:integer;
begin
   if m_SelectList.Count < 2 then exit;
   
   for b:=1 to m_SelectList.Count -1 do
   begin
      Tobj(m_SelectList.Items[b]).m_y := Tobj(m_SelectList.Items[0]).m_sy +
      abs(Tobj(m_SelectList.Items[b]).m_y - Tobj(m_SelectList.Items[b]).m_sy);
      Tobj(m_SelectList.Items[b]).m_sy := Tobj(m_SelectList.Items[0]).m_sy;
   end;
   sync;redraw;
end;

procedure TMain.SelectAlignBottom();
var b:integer;
begin
   if m_SelectList.Count < 2 then exit;
   
   for b:=1 to m_SelectList.Count -1 do
   begin
      Tobj(m_SelectList.Items[b]).m_sy := Tobj(m_SelectList.Items[0]).m_y -
      abs(Tobj(m_SelectList.Items[b]).m_y - Tobj(m_SelectList.Items[b]).m_sy);
      Tobj(m_SelectList.Items[b]).m_y := Tobj(m_SelectList.Items[0]).m_y;
   end;
      sync;redraw;
end;

procedure TMain.SelectSameHeight();
var b:integer;
begin
   if m_SelectList.Count < 2 then exit;
   
   for b:=1 to m_SelectList.Count -1 do
   begin
      Tobj(m_SelectList.Items[b]).m_y := Tobj(m_SelectList.Items[b]).m_sy +
      abs(Tobj(m_SelectList.Items[0]).m_y - Tobj(m_SelectList.Items[0]).m_sy);
   end;
      sync;redraw;
end;

procedure TMain.SelectSameWidth();
var b:integer;
begin
   if m_SelectList.Count < 2 then exit;
   
   for b:=1 to m_SelectList.Count -1 do
   begin
      Tobj(m_SelectList.Items[b]).m_x := Tobj(m_SelectList.Items[b]).m_sx +
      abs(Tobj(m_SelectList.Items[0]).m_x - Tobj(m_SelectList.Items[0]).m_sx);
   end;
      sync;redraw;
end;

procedure TMain.AlignLeft1Click(Sender: TObject);
begin
   SelectAlignLeft;
end;

procedure TMain.AlignRight1Click(Sender: TObject);
begin
   SelectAlignRight;
end;

procedure TMain.AlighTop1Click(Sender: TObject);
begin
   SelectAlignTop;

end;

procedure TMain.AlignBottom1Click(Sender: TObject);
begin
    SelectAlignBottom;
end;

procedure TMain.SameWidth1Click(Sender: TObject);
begin
   SelectSameWidth;
end;

procedure TMain.SameHeight1Click(Sender: TObject);
begin
   SelectSameHeight;
end;

procedure TMain.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if not scrollbox1.Focused then
      scrollbox1.SetFocus;
   DrawMouseDown(Sender,TXMouseButton(button),shift,
   round(x*100/m_zoom),
   round(y*100/m_zoom));
end;

procedure TMain.CopytoClipBord1Click(Sender: TObject);
var b : integer;
  MyMetafile:TmetaFile;
  l_mcanvas : TMetafileCanvas;
  l_obj : tobj;
  l_tag :integer;
  l_rect : trect;
  l_oldcanvas : Tcanvas;
begin
   l_tag := 0;
   for B := 0 to (m_List.Count - 1) do
     begin
         l_obj := Tobj(m_list.Items[b]);
         if l_obj.m_selected <> 0 then
         begin
//           l_obj.m_selected := 0;
           if l_tag = 0 then
           begin
             l_rect := rect(l_obj.m_sx,l_obj.m_sy,l_obj.m_x+3,l_obj.m_y+3);
             l_tag := 1
           end
           else
           begin
             l_rect.Left := min ( l_rect.Left, l_obj.m_sx -3);
             l_rect.top  := min ( l_rect.top, l_obj.m_sy -3);
             l_rect.right := max ( l_rect.Right, l_obj.m_x +3 );
             l_rect.Bottom := max ( l_rect.Bottom, l_obj.m_y +3);
           end
        end
     end;

  MyMetafile := TMetafile.Create;
  mymetafile.Width := l_rect.Right - l_rect.Left;
  mymetafile.Height := l_rect.Bottom - l_rect.Top + 30;
   try
    l_mcanvas := TMetafileCanvas.Create(MyMetafile, 0);
    for B := 0 to (m_List.Count - 1) do
     begin
    l_obj := Tobj(m_list.Items[b]);
        if ((l_obj.m_selected <> 0 )
         or ( l_obj.islink and
          ptinrect(l_rect,point(l_Obj.m_x,l_obj.m_y)) and
          ptinrect(l_rect,point(l_Obj.m_sx,l_obj.m_sy))
          ))
        then
         begin
           l_oldcanvas := l_obj.m_canvas;

           l_mcanvas.Font := l_oldcanvas.font;
           l_mcanvas.Font.Charset := DEFAULT_CHARSET ;
           l_mcanvas.Font.Name := '宋体';
           l_mcanvas.Font.Size := 9;
           l_obj.m_canvas := l_mcanvas;
           l_obj.m_sx := l_obj.m_sx - l_rect.left;
           l_obj.m_x := l_obj.m_x - l_rect.left;
           l_obj.m_sy := l_obj.m_sy - l_rect.Top;
           l_obj.m_y := l_obj.m_y - l_rect.Top;
           l_obj.m_drect.Left := l_obj.m_drect.Left  - l_rect.left;
           l_obj.m_drect.Right := l_obj.m_drect.Right  - l_rect.left;
           l_obj.m_drect.Top := l_obj.m_drect.top  - l_rect.Top;
           l_obj.m_drect.Bottom := l_obj.m_drect.Bottom  - l_rect.Top;
           l_obj.m_selected := 0;
           l_obj.Draw;
           l_obj.m_selected := 1;
           l_obj.m_canvas := l_oldcanvas;
           l_obj.m_drect.Left := l_obj.m_drect.Left  + l_rect.left;
           l_obj.m_drect.Right := l_obj.m_drect.Right  + l_rect.left;
           l_obj.m_drect.Top := l_obj.m_drect.top  + l_rect.Top;
           l_obj.m_drect.Bottom := l_obj.m_drect.Bottom  + l_rect.Top;
           l_obj.m_sx := l_obj.m_sx + l_rect.left;
           l_obj.m_x := l_obj.m_x + l_rect.left;
           l_obj.m_sy := l_obj.m_sy + l_rect.Top;
           l_obj.m_y := l_obj.m_y + l_rect.Top;
         end
     end;
      if (l_rect.Right - l_rect.Left > 200) and
      (l_rect.Bottom - l_rect.Top > 300)
      then
      begin
         l_mcanvas.Brush.Color := clwhite;
         l_mcanvas.Textout(round((l_rect.Right - l_rect.Left)/2)- 35,
         l_rect.Bottom - l_rect.Top+10,'draft');
      end ;
    l_mcanvas.Free
     finally
    end;
    TimeSeparator :='-';
    DeleteFile('D:\\'+btn_path.Caption);
    btn_path.Caption :=  datetostr(date)+'-'+TimeToStr(time)+'.emf';
    mYmETAFILE.SaveToFile('d:\\'+btn_path.Caption);
    clipboard.Assign(mYmEtaFile);
    copyobjs;
end;

procedure TMain.PastefromClip1Click(Sender: TObject);
begin
   pasteobjs();
end;

procedure TMain.N_shadowClick(Sender: TObject);
var b:integer;
l_obj : tobj;
begin
   for B := 0 to (m_List.Count - 1) do
     begin
         l_obj := Tobj(m_list.Items[b]);
          if l_obj.m_selected <> 0 then
          begin
              if  l_obj.m_shadow = 1 then
                 l_obj.m_shadow := 0
              else
                 l_obj.m_shadow := 1
          end
     end;
   Sync;
   redraw;
end;

procedure TMain.Btn_impClick(Sender: TObject);
var i,b : integer;
  l_pos,l_tag : integer;
  l_str :string;
  l_ostr,l_name,l_cname,l_type :string;
begin
    screen.Cursor := crHourGlass;
    b:=0;
    l_tag := 0;
    ValueListEditor1.Strings.Text:='';
    for i := 0 to Memo_import.Lines.Count -1 do
    begin
    l_pos := pos('CREATE TABLE',uppercase(Memo_import.Lines[i]));
    if l_pos > 0 then
    begin
     edit1.Text := copy(Memo_import.Lines[i],14,200);
    end;
    if (pos(',',Memo_import.Lines[i]) > 0) or (l_tag = 1) then
    begin

      l_str := trim(Memo_import.Lines[i]);
      l_str := StringReplace(l_str,'  ',' ',[rfReplaceAll]);
      l_str := StringReplace(l_str,'  ',' ',[rfReplaceAll]);
      l_str := StringReplace(l_str,'  ',' ',[rfReplaceAll]);
      l_str := StringReplace(l_str,'  ',' ',[rfReplaceAll]);
      l_str := StringReplace(l_str,'  ',' ',[rfReplaceAll]);                        
      l_tag := 1;
      if pos(',',Memo_import.Lines[i]) = 0 then
      begin
      l_pos := pos('--',l_str);
      if l_pos > 0 then
      l_str := copy(l_str,1,l_pos-1) + ','+ copy(l_str,l_pos,200)
      else
      l_str := l_str + ',';
      l_tag  := 0;
      end;
      l_pos := pos(' ',l_str);
      l_name  := copy(l_str,0,l_pos -1);
      l_str := copy(l_str,l_pos+1,200);
      if (pos('(',l_str) > 0) and (pos('(',l_str) < pos(',',l_str)) then
      begin
        l_pos :=  pos(',',l_str);
        l_pos := l_pos + pos(',',copy(l_str,l_pos+1,200));
      end
      else
        l_pos := pos(',',l_str);
      l_type := copy(l_str,0,l_pos -1);
      l_str := copy(l_str,l_pos+1,200);
      l_pos := pos('--',l_str);
      if l_pos = 0 then
       l_cname := l_name
      else
       l_cname := copy(l_str,l_pos+2,200);
      l_ostr := l_cname + '^'+l_type + '^'+l_name +'^';
      ValueListEditor1.Values[inttostr(b)]:=l_ostr;
      b:=b+1;
    end
    else
     l_tag := 0;
    end;
    screen.Cursor := 0;
   Sync;
   redraw;
end;

procedure TMain.Btn_commitClick(Sender: TObject);
var i :integer;
begin
    m_obj.m_data.Clear;
    for i := 0 to ValueListEditor1.Strings.Count - 1 do
    m_obj.m_data.Add(ValueListEditor1.Values[inttostr(i)]);
    m_obj.m_desc := edit1.Text;
    m_obj.m_index := memo3.Text;
    m_obj.m_partition := memo_partition.Text;
    pn_table.Hide;
    Sync;
   redraw;
end;

procedure TMain.PageControl1Change(Sender: TObject);
var i :integer;
   l_str,l_cname,l_type,l_name,l_desc :string;
   l_pos : integer;
   l_sql :string;
begin
    memo1.Lines.Clear;    
    if TabSheet_sql.TabIndex = pagecontrol1.ActivePageIndex then
    begin
     l_pos := pos('--',edit1.Text);
     if l_pos > 0 then
      l_str := copy(edit1.Text,0,l_pos-1)
     else
     l_str := edit1.Text;

     l_sql := 'drop table '+ l_str +';'+ #13#10;
     l_sql := l_sql +  'create table '+edit1.Text + #13#10;
     l_sql := l_sql +'('+ #13#10;
    for i := 0 to  ValueListEditor1.Strings.Count -1 do
    begin
     l_str := copy(ValueListEditor1.Values[inttostr(i)],0,200);
     l_pos := pos('^',l_str);
     l_cname := copy(l_str,1,l_pos-1);
     l_str := copy(l_str,l_pos+1,200);
     l_pos := pos('^',l_str);
     l_type := copy(l_str,1,l_pos-1);
     l_str := copy(l_str,l_pos+1,200);
     l_pos := pos('^',l_str);
     l_name := copy(l_str,1,l_pos-1);
     l_str := copy(l_str,l_pos+1,200);
     l_pos := pos('^',l_str);
     l_desc := copy(l_str,1,l_pos-1);
     l_str := copy(l_str,l_pos+1,200);

     if i =  ValueListEditor1.Strings.Count -1 then
          l_sql := l_sql +l_name + ' ' + l_type + ' --' + l_cname+ #13#10
      else
          l_sql := l_sql +l_name + ' ' + l_type + ', --' + l_cname+ #13#10;
    end;
    l_sql := l_sql + ')'+#13#10;
    l_sql := l_sql + memo_partition.text +';' +#13#10;
    l_sql := l_sql + memo3.text+#13#10;
    memo1.Text := l_sql;
    end;

      Sync;
   redraw;
end;

procedure TMain.Button2Click(Sender: TObject);
begin
    pn_table.Hide;
end;

function TMain.Get_filename: WideString;
begin
    result := file_input;
end;

procedure TMain.Set_filename(const Value: WideString);
begin
    file_input := value;
end;

procedure TMain.tttt;
begin

end;
function Tmain.DownloadFile(
const url:string;
const destinationFileName:string):boolean;
var
        hInet:HINTERNET;
        hFile:HINTERNET;
        localFile:file;
        buffer:array[1..10240] of byte;
        bytesRead:DWORD;
begin
        result := False;
        hInet := InternetOpen(PChar(application.title),
                INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
        hFile := InternetOpenURL(hInet, PChar(url), nil, 0, 0, 0);

        if Assigned(hFile) then
        begin
                AssignFile(localFile, destinationFileName);
                Rewrite(localFile, 1);

                repeat
                InternetReadFile(hFile, @buffer, SizeOf(buffer), bytesRead);
                BlockWrite(localFile, buffer, bytesRead);
                until bytesRead = 0;
                CloseFile(localFile);
                result := true;
                InternetCloseHandle(hFile);
        end;
        InternetCloseHandle(hInet);
end;

function TMain.Get_host: WideString;
begin

end;

procedure TMain.Set_host(const Value: WideString);
begin

end;

initialization
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TMain,
    Class_Main,
    1,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmApartment);
end.
