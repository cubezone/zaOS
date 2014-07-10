unit WebFtpImpl1;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, WebFtpProj1_TLB, StdVcl, Psock, NMFtp, StdCtrls;

type
  TWebFtp = class(TActiveForm, IWebFtp)
    NMFTP1: TNMFTP;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Ed_host: TEdit;
    Ed_user: TEdit;
    Ed_password: TEdit;
    GroupBox2: TGroupBox;
    Ed_sourcefilename: TEdit;
    Ed_remotefilename: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Ed_remotedir: TEdit;
    Label3: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure NMFTP1AuthenticationFailed(var Handled: Boolean);
    procedure NMFTP1Error(Sender: TComponent; Errno: Word; Errmsg: String);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    FEvents: IWebFtpEvents;
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
var
Ftp :TNMFtp;
implementation

uses ComObj, ComServ;

{$R *.DFM}

{ TWebFtp }

procedure TWebFtp.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  { Define property pages here.  Property pages are defined by calling
    DefinePropertyPage with the class id of the page.  For example,
      DefinePropertyPage(Class_WebFtpPage); }
end;

procedure TWebFtp.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IWebFtpEvents;
  inherited EventSinkChanged(EventSink);
end;

procedure TWebFtp.Initialize;
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

function TWebFtp.Get_Active: WordBool;
begin
  Result := Active;
end;

function TWebFtp.Get_AlignDisabled: WordBool;
begin
  Result := AlignDisabled;
end;

function TWebFtp.Get_AutoScroll: WordBool;
begin
  Result := AutoScroll;
end;

function TWebFtp.Get_AutoSize: WordBool;
begin
  Result := AutoSize;
end;

function TWebFtp.Get_AxBorderStyle: TxActiveFormBorderStyle;
begin
  Result := Ord(AxBorderStyle);
end;

function TWebFtp.Get_Caption: WideString;
begin
  Result := WideString(Caption);
end;

function TWebFtp.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(Color);
end;

function TWebFtp.Get_Cursor: Smallint;
begin
  Result := Smallint(Cursor);
end;

function TWebFtp.Get_DoubleBuffered: WordBool;
begin
  Result := DoubleBuffered;
end;

function TWebFtp.Get_DropTarget: WordBool;
begin
  Result := DropTarget;
end;

function TWebFtp.Get_Enabled: WordBool;
begin
  Result := Enabled;
end;

function TWebFtp.Get_Font: IFontDisp;
begin
  GetOleFont(Font, Result);
end;

function TWebFtp.Get_HelpFile: WideString;
begin
  Result := WideString(HelpFile);
end;

function TWebFtp.Get_HelpKeyword: WideString;
begin
  Result := WideString(HelpKeyword);
end;

function TWebFtp.Get_HelpType: TxHelpType;
begin
  Result := Ord(HelpType);
end;

function TWebFtp.Get_KeyPreview: WordBool;
begin
  Result := KeyPreview;
end;

function TWebFtp.Get_PixelsPerInch: Integer;
begin
  Result := PixelsPerInch;
end;

function TWebFtp.Get_PrintScale: TxPrintScale;
begin
  Result := Ord(PrintScale);
end;

function TWebFtp.Get_Scaled: WordBool;
begin
  Result := Scaled;
end;

function TWebFtp.Get_Visible: WordBool;
begin
  Result := Visible;
end;

function TWebFtp.Get_VisibleDockClientCount: Integer;
begin
  Result := VisibleDockClientCount;
end;

procedure TWebFtp._Set_Font(var Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TWebFtp.ActivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnActivate;
end;

procedure TWebFtp.ClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnClick;
end;

procedure TWebFtp.CreateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnCreate;
end;

procedure TWebFtp.DblClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDblClick;
end;

procedure TWebFtp.DeactivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDeactivate;
end;

procedure TWebFtp.DestroyEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDestroy;
end;

procedure TWebFtp.KeyPressEvent(Sender: TObject; var Key: Char);
var
  TempKey: Smallint;
begin
  TempKey := Smallint(Key);
  if FEvents <> nil then FEvents.OnKeyPress(TempKey);
  Key := Char(TempKey);
end;

procedure TWebFtp.PaintEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnPaint;
end;

procedure TWebFtp.Set_AutoScroll(Value: WordBool);
begin
  AutoScroll := Value;
end;

procedure TWebFtp.Set_AutoSize(Value: WordBool);
begin
  AutoSize := Value;
end;

procedure TWebFtp.Set_AxBorderStyle(Value: TxActiveFormBorderStyle);
begin
  AxBorderStyle := TActiveFormBorderStyle(Value);
end;

procedure TWebFtp.Set_Caption(const Value: WideString);
begin
  Caption := TCaption(Value);
end;

procedure TWebFtp.Set_Color(Value: OLE_COLOR);
begin
  Color := TColor(Value);
end;

procedure TWebFtp.Set_Cursor(Value: Smallint);
begin
  Cursor := TCursor(Value);
end;

procedure TWebFtp.Set_DoubleBuffered(Value: WordBool);
begin
  DoubleBuffered := Value;
end;

procedure TWebFtp.Set_DropTarget(Value: WordBool);
begin
  DropTarget := Value;
end;

procedure TWebFtp.Set_Enabled(Value: WordBool);
begin
  Enabled := Value;
end;

procedure TWebFtp.Set_Font(const Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TWebFtp.Set_HelpFile(const Value: WideString);
begin
  HelpFile := String(Value);
end;

procedure TWebFtp.Set_HelpKeyword(const Value: WideString);
begin
  HelpKeyword := String(Value);
end;

procedure TWebFtp.Set_HelpType(Value: TxHelpType);
begin
  HelpType := THelpType(Value);
end;

procedure TWebFtp.Set_KeyPreview(Value: WordBool);
begin
  KeyPreview := Value;
end;

procedure TWebFtp.Set_PixelsPerInch(Value: Integer);
begin
  PixelsPerInch := Value;
end;

procedure TWebFtp.Set_PrintScale(Value: TxPrintScale);
begin
  PrintScale := TPrintScale(Value);
end;

procedure TWebFtp.Set_Scaled(Value: WordBool);
begin
  Scaled := Value;
end;

procedure TWebFtp.Set_Visible(Value: WordBool);
begin
  Visible := Value;
end;

procedure TWebFtp.Button1Click(Sender: TObject);
begin
    FTP := TNMFtp.Create(self);
    ftp.Host := ed_host.Text;
    ftp.UserID := ed_user.Text;
    ftp.Password := ed_password.Text;
    try
    button1.Enabled  := false;
    ftp.Connect;
    ftp.Mode(MODE_BYTE);
    except
       Application.MessageBox('connect err','Info');
    end;
    button1.Enabled  := true ;
end;

procedure TWebFtp.NMFTP1AuthenticationFailed(var Handled: Boolean);
begin
    Application.MessageBox('connect err','Info');
end;

procedure TWebFtp.NMFTP1Error(Sender: TComponent; Errno: Word;
  Errmsg: String);
begin
    Application.MessageBox('connect err','Info');
end;

procedure TWebFtp.Button2Click(Sender: TObject);
begin
    ftp.ChangeDir(ed_remotedir.Text);
    ftp.Upload(ed_sourcefilename.Text,ed_remotefilename.Text);
end;

procedure TWebFtp.Button3Click(Sender: TObject);
begin
    ftp.ChangeDir(ed_remotedir.Text);
    ftp.Download(ed_remotefilename.Text,ed_sourcefilename.Text);
end;

procedure TWebFtp.Button4Click(Sender: TObject);
begin
   ftp.Disconnect;
end;

initialization
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TWebFtp,
    Class_WebFtp,
    1,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmApartment);
end.
