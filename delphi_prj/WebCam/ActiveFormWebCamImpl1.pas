unit ActiveFormWebCamImpl1;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, ActiveFormWebCamProj1_TLB, StdVcl, ExtCtrls, StdCtrls,
  Mask,Jpeg;

type
  TWebCam = class(TActiveForm, IActiveFormWebCam)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ActiveFormDestroy(Sender: TObject);
    procedure ActiveFormCreate(Sender: TObject);
  private
      hWndC : THandle;
    { Private declarations }
    FEvents: IActiveFormWebCamEvents;
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
  public
    { Public declarations }
    procedure Initialize; override;
  end;

const WM_CAP_START = WM_USER;
const WM_CAP_STOP = WM_CAP_START + 68;
const WM_CAP_DRIVER_CONNECT = WM_CAP_START + 10;
const WM_CAP_DRIVER_DISCONNECT = WM_CAP_START + 11;
const WM_CAP_SAVEDIB = WM_CAP_START + 25;
const WM_CAP_GRAB_FRAME = WM_CAP_START + 60;
const WM_CAP_SEQUENCE = WM_CAP_START + 62;
const WM_CAP_FILE_SET_CAPTURE_FILEA = WM_CAP_START + 20;
const WM_CAP_SEQUENCE_NOFILE = WM_CAP_START+ 63 ;
const WM_CAP_SET_OVERLAY = WM_CAP_START+ 51 ;
const WM_CAP_SET_PREVIEW = WM_CAP_START+ 50 ;
const WM_CAP_SET_CALLBACK_VIDEOSTREAM = WM_CAP_START +6;
const WM_CAP_SET_CALLBACK_ERROR = WM_CAP_START +2;
const WM_CAP_SET_CALLBACK_STATUSA= WM_CAP_START +3;
const WM_CAP_SET_CALLBACK_FRAME= WM_CAP_START +5;
const WM_CAP_SET_SCALE=WM_CAP_START+ 53  ;
const WM_CAP_SET_PREVIEWRATE=WM_CAP_START+ 52   ;

function capCreateCaptureWindowA(
          lpszWindowName : PCHAR;
          dwStyle : longint;
          x : integer;
          y : integer;
          nWidth : integer;
          nHeight : integer;
          ParentWin : HWND;
          nId : integer): HWND; STDCALL EXTERNAL 'AVICAP32.DLL';
function  capGetDriverDescriptionA(
            wDriverIndex :longint;
            lpszName  : PCHAR;
            cbName : integer;
            lpszVer : PCHAR;
            cbVer :integer;
             test :integer): HWND; STDCALL EXTERNAL 'AVICAP32.DLL';

implementation

uses ComObj, ComServ;

{$R *.DFM}

{ TActiveFormWebCam }

procedure TWebCam.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  { Define property pages here.  Property pages are defined by calling
    DefinePropertyPage with the class id of the page.  For example,
      DefinePropertyPage(Class_ActiveFormWebCamPage); }
end;

procedure TWebCam.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IActiveFormWebCamEvents;
  inherited EventSinkChanged(EventSink);
end;

procedure TWebCam.Initialize;
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

function TWebCam.Get_Active: WordBool;
begin
  Result := Active;
end;

function TWebCam.Get_AlignDisabled: WordBool;
begin
  Result := AlignDisabled;
end;

function TWebCam.Get_AutoScroll: WordBool;
begin
  Result := AutoScroll;
end;

function TWebCam.Get_AutoSize: WordBool;
begin
  Result := AutoSize;
end;

function TWebCam.Get_AxBorderStyle: TxActiveFormBorderStyle;
begin
  Result := Ord(AxBorderStyle);
end;

function TWebCam.Get_Caption: WideString;
begin
  Result := WideString(Caption);
end;

function TWebCam.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(Color);
end;

function TWebCam.Get_Cursor: Smallint;
begin
  Result := Smallint(Cursor);
end;

function TWebCam.Get_DoubleBuffered: WordBool;
begin
  Result := DoubleBuffered;
end;

function TWebCam.Get_DropTarget: WordBool;
begin
  Result := DropTarget;
end;

function TWebCam.Get_Enabled: WordBool;
begin
  Result := Enabled;
end;

function TWebCam.Get_Font: IFontDisp;
begin
  GetOleFont(Font, Result);
end;

function TWebCam.Get_HelpFile: WideString;
begin
  Result := WideString(HelpFile);
end;

function TWebCam.Get_HelpKeyword: WideString;
begin
  Result := WideString(HelpKeyword);
end;

function TWebCam.Get_HelpType: TxHelpType;
begin
  Result := Ord(HelpType);
end;

function TWebCam.Get_KeyPreview: WordBool;
begin
  Result := KeyPreview;
end;

function TWebCam.Get_PixelsPerInch: Integer;
begin
  Result := PixelsPerInch;
end;

function TWebCam.Get_PrintScale: TxPrintScale;
begin
  Result := Ord(PrintScale);
end;

function TWebCam.Get_Scaled: WordBool;
begin
  Result := Scaled;
end;

function TWebCam.Get_Visible: WordBool;
begin
  Result := Visible;
end;

function TWebCam.Get_VisibleDockClientCount: Integer;
begin
  Result := VisibleDockClientCount;
end;

procedure TWebCam._Set_Font(var Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TWebCam.ActivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnActivate;
end;

procedure TWebCam.ClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnClick;
end;

procedure TWebCam.CreateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnCreate;
end;

procedure TWebCam.DblClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDblClick;
end;

procedure TWebCam.DeactivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDeactivate;
end;

procedure TWebCam.DestroyEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDestroy;
end;

procedure TWebCam.KeyPressEvent(Sender: TObject; var Key: Char);
var
  TempKey: Smallint;
begin
  TempKey := Smallint(Key);
  if FEvents <> nil then FEvents.OnKeyPress(TempKey);
  Key := Char(TempKey);
end;

procedure TWebCam.PaintEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnPaint;
end;

procedure TWebCam.Set_AutoScroll(Value: WordBool);
begin
  AutoScroll := Value;
end;

procedure TWebCam.Set_AutoSize(Value: WordBool);
begin
  AutoSize := Value;
end;

procedure TWebCam.Set_AxBorderStyle(
  Value: TxActiveFormBorderStyle);
begin
  AxBorderStyle := TActiveFormBorderStyle(Value);
end;

procedure TWebCam.Set_Caption(const Value: WideString);
begin
  Caption := TCaption(Value);
end;

procedure TWebCam.Set_Color(Value: OLE_COLOR);
begin
  Color := TColor(Value);
end;

procedure TWebCam.Set_Cursor(Value: Smallint);
begin
  Cursor := TCursor(Value);
end;

procedure TWebCam.Set_DoubleBuffered(Value: WordBool);
begin
  DoubleBuffered := Value;
end;

procedure TWebCam.Set_DropTarget(Value: WordBool);
begin
  DropTarget := Value;
end;

procedure TWebCam.Set_Enabled(Value: WordBool);
begin
  Enabled := Value;
end;

procedure TWebCam.Set_Font(const Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TWebCam.Set_HelpFile(const Value: WideString);
begin
  HelpFile := String(Value);
end;

procedure TWebCam.Set_HelpKeyword(const Value: WideString);
begin
  HelpKeyword := String(Value);
end;

procedure TWebCam.Set_HelpType(Value: TxHelpType);
begin
  HelpType := THelpType(Value);
end;

procedure TWebCam.Set_KeyPreview(Value: WordBool);
begin
  KeyPreview := Value;
end;

procedure TWebCam.Set_PixelsPerInch(Value: Integer);
begin
  PixelsPerInch := Value;
end;

procedure TWebCam.Set_PrintScale(Value: TxPrintScale);
begin
  PrintScale := TPrintScale(Value);
end;

procedure TWebCam.Set_Scaled(Value: WordBool);
begin
  Scaled := Value;
end;

procedure TWebCam.Set_Visible(Value: WordBool);
begin
  Visible := Value;
end;

procedure TWebCam.Button1Click(Sender: TObject);
var test:integer;
begin
  Button2.Click();
  test := 0;
  hWndC := 0;
  hWndC := capCreateCaptureWindowA('My Own Capture Window',WS_CHILD or WS_VISIBLE ,Panel1.Left,Panel1.Top,Panel1.Width,Panel1.Height,Handle,0);
  //hWndC := capCreateCaptureWindowA('My Own Capture Window',WS_CHILD or WS_VISIBLE ,Panel1.Left,Panel1.Top,Panel1.Width,Panel1.Height,Handle,0);
  if hWndC <> 0 then
  begin
    SendMessage(hWndC, WM_CAP_SET_CALLBACK_VIDEOSTREAM, 0, test);
    SendMessage(hWndC, WM_CAP_SET_CALLBACK_ERROR, 0, test);
    SendMessage(hWndC, WM_CAP_SET_CALLBACK_STATUSA, 0, test);
//    Application.MessageBox(pchar(inttostr(ComBoBox1.ItemIndex)),'');
    SendMessage(hWndC, WM_CAP_DRIVER_CONNECT, ComBoBox1.ItemIndex, test);
    SendMessage(hWndC, WM_CAP_SET_SCALE, 1, 0);
    SendMessage(hWndC, WM_CAP_SET_PREVIEWRATE, 66, 0);
    SendMessage(hWndC, WM_CAP_SET_OVERLAY, 1, 0);
    SendMessage(hWndC, WM_CAP_SET_PREVIEW, 1, 0);
  end
  else
    Application.MessageBox('camera init error','info');

end;

procedure TWebCam.Button2Click(Sender: TObject);
begin
  if hWndC <> 0 then
  begin
    SendMessage(hWndC, WM_CAP_DRIVER_DISCONNECT, 0, 0);
    DestroyWindow(hWndC);
    hWndC := 0;
  end;
end;

procedure TWebCam.Button3Click(Sender: TObject);
var jpeg: TJPEGImage;
  bmp: TBitmap;
begin
  if hWndC <> 0 then
  begin
    SendMessage(hWndC,WM_CAP_SAVEDIB,0,longint(pchar('c:\\test.bmp')));
    jpeg:= TJPEGImage.Create;
    bmp:= TBitmap.Create;
    try
      bmp.LoadFromFile('c:\\test.bmp' );
      jpeg.Assign( bmp );
      jpeg.compress;
      jpeg.SaveTofile('c:\\test.jpeg' );
    except
    end;
    bmp.Free;
    jpeg.Free;
    DeleteFile('c:\\test.bmp' );
  end;
end;

procedure TWebCam.Button4Click(Sender: TObject);
begin
  if hWndC <> 0 then
  begin
    SendMessage(hWndC,WM_CAP_FILE_SET_CAPTURE_FILEA,0, Longint(pchar('c:\\test.avi')));
    SendMessage(hWndC, WM_CAP_SEQUENCE, 0, 0);
  end;
end;

procedure TWebCam.Button5Click(Sender: TObject);
begin
  if hWndC <> 0 then
  begin
    SendMessage(hWndC, WM_CAP_STOP, 0, 0);
  end;
end;

procedure TWebCam.ActiveFormDestroy(Sender: TObject);
begin
  if hWndC <> 0 then
  begin
    SendMessage(hWndC, WM_CAP_DRIVER_DISCONNECT, 0, 0);
    DestroyWindow(hWndC);
  end;
end;

procedure TWebCam.ActiveFormCreate(Sender: TObject);
var i : integer;
    drv_name, drv_desc: array[0..40] of Char;
    flag :integer;
begin
   flag := 0;
   for i:= 0 to 9 do
   begin
    if (capGetDriverDescriptionA(i,@drv_name,40,@drv_desc,40,0)> 0) then
     begin
        ComboBox1.Items.Add(drv_name);
        flag := 1;
     end;
   end;
   if (flag = 1) then
    ComboBox1.ItemIndex := 0;
end;

initialization
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TWebCam,
    Class_WebCam,
    1,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmApartment);
end.
