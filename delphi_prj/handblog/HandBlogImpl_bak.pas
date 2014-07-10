unit HandBlogImpl_bak;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, HandBlogProj_TLB, StdVcl;

type
  THandBlog = class(TActiveForm, IHandBlog)
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
  public
    { Public declarations }
    procedure Initialize; override;
  end;

implementation

uses ComObj, ComServ, About1,Mdraw;

{$R *.DFM}

{ THandBlog }

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
  ShowHandBlogAbout;
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
