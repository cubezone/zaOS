object Form3: TForm3
  Left = 320
  Top = 144
  Width = 820
  Height = 584
  Caption = #23186#20307#25511#21046'V2.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 802
    Height = 100
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object BTN_CONNECT: TButton
      Left = 118
      Top = 9
      Width = 100
      Height = 32
      Caption = #36830#25509
      TabOrder = 0
      OnClick = BTN_CONNECTClick
    end
    object EdCom: TEdit
      Left = 14
      Top = 10
      Width = 86
      Height = 24
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 1
      Text = 'COM4'
    end
    object BTN_PRE: TButton
      Left = 10
      Top = 59
      Width = 90
      Height = 31
      Caption = #21069#19968#26354#30446
      TabOrder = 2
      OnClick = BTN_PREClick
    end
    object BTN_PLAY: TButton
      Left = 107
      Top = 59
      Width = 101
      Height = 31
      Caption = #25773#25918'/'#26242#20572
      TabOrder = 3
      OnClick = BTN_PLAYClick
    end
    object BTN_NEXT: TButton
      Left = 213
      Top = 59
      Width = 93
      Height = 31
      Caption = #19979#19968#26354#30446
      TabOrder = 4
      OnClick = BTN_NEXTClick
    end
    object BTN_STOP: TButton
      Left = 311
      Top = 59
      Width = 94
      Height = 31
      Caption = #20572#27490
      TabOrder = 5
      OnClick = BTN_STOPClick
    end
    object BTN_SPACE: TButton
      Left = 459
      Top = 59
      Width = 92
      Height = 31
      Caption = #31354#26684
      TabOrder = 6
      OnClick = BTN_SPACEClick
    end
    object BTN_HIBER: TButton
      Left = 561
      Top = 59
      Width = 51
      Height = 31
      Caption = #20241#30496
      TabOrder = 7
      OnClick = BTN_HIBERClick
    end
    object BTN_DARK: TButton
      Left = 620
      Top = 59
      Width = 51
      Height = 31
      Caption = #40657#23631
      TabOrder = 8
      OnClick = BTN_DARKClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 492
    Width = 802
    Height = 47
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 128
      Top = 15
      Width = 90
      Height = 16
      AutoSize = False
      Caption = #32553#25918#30334#20998#27604
    end
    object Label2: TLabel
      Left = 10
      Top = 15
      Width = 60
      Height = 16
      AutoSize = False
      Caption = #39029#25968
    end
    object Button1: TButton
      Left = 358
      Top = 7
      Width = 92
      Height = 31
      Caption = #25130#21462'PPT'
      TabOrder = 0
      OnClick = Button1Click
    end
    object ed_page: TEdit
      Left = 53
      Top = 10
      Width = 41
      Height = 24
      TabOrder = 1
      Text = '1'
    end
    object Ed_per: TEdit
      Left = 224
      Top = 10
      Width = 90
      Height = 24
      TabOrder = 2
      Text = '60'
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 100
    Width = 802
    Height = 392
    Align = alClient
    TabOrder = 2
    object Image1: TImage
      Left = 1
      Top = 197
      Width = 800
      Height = 194
      Align = alBottom
      Center = True
    end
    object Splitter1: TSplitter
      Left = 1
      Top = 181
      Width = 800
      Height = 16
      Cursor = crVSplit
      Align = alBottom
    end
    object Memo8: TMemo
      Left = 1
      Top = 1
      Width = 800
      Height = 180
      Align = alClient
      BevelOuter = bvNone
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 424
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 352
    Top = 8
    object N2: TMenuItem
      Caption = #26174#31034
      OnClick = N2Click
    end
    object N1: TMenuItem
      Caption = #20851#38381
      OnClick = N1Click
    end
  end
end
