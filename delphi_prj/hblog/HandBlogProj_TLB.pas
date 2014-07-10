unit HandBlogProj_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.130  $
// File generated on 2007-5-31 10:04:48 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Program Files\Borland\Delphi6\Projects\hblog\HandBlogProj.tlb (1)
// LIBID: {A704F1BA-AF43-4C10-A437-4556F564A1B9}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\System32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}

interface

uses ActiveX, Classes, Graphics, OleCtrls, StdVCL, Variants, Windows;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  HandBlogProjMajorVersion = 1;
  HandBlogProjMinorVersion = 0;

  LIBID_HandBlogProj: TGUID = '{A704F1BA-AF43-4C10-A437-4556F564A1B9}';

  IID_IHandBlog: TGUID = '{4C45DAD4-50B7-46B7-BF24-A2CB96370D62}';
  DIID_IHandBlogEvents: TGUID = '{4C746089-5552-4C12-9094-BCEACD24AA66}';
  CLASS_HandBlog: TGUID = '{14CEF024-FB7E-4B99-9957-EAD234CDC1C7}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TxActiveFormBorderStyle
type
  TxActiveFormBorderStyle = TOleEnum;
const
  afbNone = $00000000;
  afbSingle = $00000001;
  afbSunken = $00000002;
  afbRaised = $00000003;

// Constants for enum TxPrintScale
type
  TxPrintScale = TOleEnum;
const
  poNone = $00000000;
  poProportional = $00000001;
  poPrintToFit = $00000002;

// Constants for enum TxMouseButton
type
  TxMouseButton = TOleEnum;
const
  mbLeft = $00000000;
  mbRight = $00000001;
  mbMiddle = $00000002;

// Constants for enum TxHelpType
type
  TxHelpType = TOleEnum;
const
  htKeyword = $00000000;
  htContext = $00000001;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IHandBlog = interface;
  IHandBlogDisp = dispinterface;
  IHandBlogEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  HandBlog = IHandBlog;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PPUserType1 = ^IFontDisp; {*}


// *********************************************************************//
// Interface: IHandBlog
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4C45DAD4-50B7-46B7-BF24-A2CB96370D62}
// *********************************************************************//
  IHandBlog = interface(IDispatch)
    ['{4C45DAD4-50B7-46B7-BF24-A2CB96370D62}']
    function  Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function  Get_AutoScroll: WordBool; safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    function  Get_AutoSize: WordBool; safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    function  Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    function  Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function  Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    function  Get_Font: IFontDisp; safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    function  Get_KeyPreview: WordBool; safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    function  Get_PixelsPerInch: Integer; safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    function  Get_PrintScale: TxPrintScale; safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    function  Get_Scaled: WordBool; safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    function  Get_Active: WordBool; safecall;
    function  Get_DropTarget: WordBool; safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    function  Get_HelpFile: WideString; safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    function  Get_DoubleBuffered: WordBool; safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    function  Get_AlignDisabled: WordBool; safecall;
    function  Get_VisibleDockClientCount: Integer; safecall;
    function  Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function  Get_Cursor: Smallint; safecall;
    procedure Set_Cursor(Value: Smallint); safecall;
    function  Get_HelpType: TxHelpType; safecall;
    procedure Set_HelpType(Value: TxHelpType); safecall;
    function  Get_HelpKeyword: WideString; safecall;
    procedure Set_HelpKeyword(const Value: WideString); safecall;
    function  Get_host: WideString; safecall;
    procedure Set_host(const Value: WideString); safecall;
    procedure change(const name: WideString); safecall;
    procedure cc(cc: Integer; ee: PWideChar); safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property AutoScroll: WordBool read Get_AutoScroll write Set_AutoScroll;
    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property AxBorderStyle: TxActiveFormBorderStyle read Get_AxBorderStyle write Set_AxBorderStyle;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property Font: IFontDisp read Get_Font write Set_Font;
    property KeyPreview: WordBool read Get_KeyPreview write Set_KeyPreview;
    property PixelsPerInch: Integer read Get_PixelsPerInch write Set_PixelsPerInch;
    property PrintScale: TxPrintScale read Get_PrintScale write Set_PrintScale;
    property Scaled: WordBool read Get_Scaled write Set_Scaled;
    property Active: WordBool read Get_Active;
    property DropTarget: WordBool read Get_DropTarget write Set_DropTarget;
    property HelpFile: WideString read Get_HelpFile write Set_HelpFile;
    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;
    property AlignDisabled: WordBool read Get_AlignDisabled;
    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Cursor: Smallint read Get_Cursor write Set_Cursor;
    property HelpType: TxHelpType read Get_HelpType write Set_HelpType;
    property HelpKeyword: WideString read Get_HelpKeyword write Set_HelpKeyword;
    property host: WideString read Get_host write Set_host;
  end;

// *********************************************************************//
// DispIntf:  IHandBlogDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4C45DAD4-50B7-46B7-BF24-A2CB96370D62}
// *********************************************************************//
  IHandBlogDisp = dispinterface
    ['{4C45DAD4-50B7-46B7-BF24-A2CB96370D62}']
    property Visible: WordBool dispid 1;
    property AutoScroll: WordBool dispid 2;
    property AutoSize: WordBool dispid 3;
    property AxBorderStyle: TxActiveFormBorderStyle dispid 4;
    property Caption: WideString dispid -518;
    property Color: OLE_COLOR dispid -501;
    property Font: IFontDisp dispid -512;
    property KeyPreview: WordBool dispid 5;
    property PixelsPerInch: Integer dispid 6;
    property PrintScale: TxPrintScale dispid 7;
    property Scaled: WordBool dispid 8;
    property Active: WordBool readonly dispid 9;
    property DropTarget: WordBool dispid 10;
    property HelpFile: WideString dispid 11;
    property DoubleBuffered: WordBool dispid 12;
    property AlignDisabled: WordBool readonly dispid 13;
    property VisibleDockClientCount: Integer readonly dispid 14;
    property Enabled: WordBool dispid -514;
    property Cursor: Smallint dispid 15;
    property HelpType: TxHelpType dispid 16;
    property HelpKeyword: WideString dispid 17;
    property host: WideString dispid 18;
    procedure change(const name: WideString); dispid 19;
    procedure cc(cc: Integer; ee: {??PWideChar}OleVariant); dispid 20;
  end;

// *********************************************************************//
// DispIntf:  IHandBlogEvents
// Flags:     (4096) Dispatchable
// GUID:      {4C746089-5552-4C12-9094-BCEACD24AA66}
// *********************************************************************//
  IHandBlogEvents = dispinterface
    ['{4C746089-5552-4C12-9094-BCEACD24AA66}']
    procedure OnActivate; dispid 1;
    procedure OnClick; dispid 2;
    procedure OnCreate; dispid 3;
    procedure OnDblClick; dispid 5;
    procedure OnDestroy; dispid 6;
    procedure OnDeactivate; dispid 7;
    procedure OnKeyPress(var Key: Smallint); dispid 11;
    procedure OnPaint; dispid 16;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : THandBlog
// Help String      : HandBlog Control
// Default Interface: IHandBlog
// Def. Intf. DISP? : No
// Event   Interface: IHandBlogEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  THandBlogOnKeyPress = procedure(Sender: TObject; var Key: Smallint) of object;

  THandBlog = class(TOleControl)
  private
    FOnActivate: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnCreate: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    FOnKeyPress: THandBlogOnKeyPress;
    FOnPaint: TNotifyEvent;
    FIntf: IHandBlog;
    function  GetControlInterface: IHandBlog;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure change(const name: WideString);
    procedure cc(cc: Integer; ee: PWideChar);
    property  ControlInterface: IHandBlog read GetControlInterface;
    property  DefaultInterface: IHandBlog read GetControlInterface;
    property Visible: WordBool index 1 read GetWordBoolProp write SetWordBoolProp;
    property Active: WordBool index 9 read GetWordBoolProp;
    property DropTarget: WordBool index 10 read GetWordBoolProp write SetWordBoolProp;
    property HelpFile: WideString index 11 read GetWideStringProp write SetWideStringProp;
    property DoubleBuffered: WordBool index 12 read GetWordBoolProp write SetWordBoolProp;
    property AlignDisabled: WordBool index 13 read GetWordBoolProp;
    property VisibleDockClientCount: Integer index 14 read GetIntegerProp;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp;
  published
    property  ParentColor;
    property  ParentFont;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property AutoScroll: WordBool index 2 read GetWordBoolProp write SetWordBoolProp stored False;
    property AutoSize: WordBool index 3 read GetWordBoolProp write SetWordBoolProp stored False;
    property AxBorderStyle: TOleEnum index 4 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Caption: WideString index -518 read GetWideStringProp write SetWideStringProp stored False;
    property Color: TColor index -501 read GetTColorProp write SetTColorProp stored False;
    property Font: TFont index -512 read GetTFontProp write _SetTFontProp stored False;
    property KeyPreview: WordBool index 5 read GetWordBoolProp write SetWordBoolProp stored False;
    property PixelsPerInch: Integer index 6 read GetIntegerProp write SetIntegerProp stored False;
    property PrintScale: TOleEnum index 7 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Scaled: WordBool index 8 read GetWordBoolProp write SetWordBoolProp stored False;
    property Cursor: Smallint index 15 read GetSmallintProp write SetSmallintProp stored False;
    property HelpType: TOleEnum index 16 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property HelpKeyword: WideString index 17 read GetWideStringProp write SetWideStringProp stored False;
    property host: WideString index 18 read GetWideStringProp write SetWideStringProp stored False;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnCreate: TNotifyEvent read FOnCreate write FOnCreate;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnKeyPress: THandBlogOnKeyPress read FOnKeyPress write FOnKeyPress;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'Servers';

implementation

uses ComObj;

procedure THandBlog.InitControlData;
const
  CEventDispIDs: array [0..7] of DWORD = (
    $00000001, $00000002, $00000003, $00000005, $00000006, $00000007,
    $0000000B, $00000010);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CControlData: TControlData2 = (
    ClassID: '{14CEF024-FB7E-4B99-9957-EAD234CDC1C7}';
    EventIID: '{4C746089-5552-4C12-9094-BCEACD24AA66}';
    EventCount: 8;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $0000001D;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnActivate) - Cardinal(Self);
end;

procedure THandBlog.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IHandBlog;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function THandBlog.GetControlInterface: IHandBlog;
begin
  CreateControl;
  Result := FIntf;
end;

procedure THandBlog.change(const name: WideString);
begin
  DefaultInterface.change(name);
end;

procedure THandBlog.cc(cc: Integer; ee: PWideChar);
begin
  DefaultInterface.cc(cc, ee);
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[THandBlog]);
end;

end.
