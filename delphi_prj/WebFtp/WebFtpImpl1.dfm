object WebFtp: TWebFtp
  Left = 246
  Top = 178
  Width = 426
  Height = 354
  AxBorderStyle = afbNone
  Caption = 'WebFtp'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 385
    Height = 113
    Caption = 'Login'
    TabOrder = 0
    object Button1: TButton
      Left = 262
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Connect'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Ed_host: TEdit
      Left = 64
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '218.30.100.113'
    end
    object Ed_user: TEdit
      Left = 64
      Top = 48
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'ufjfs1'
    end
    object Ed_password: TEdit
      Left = 64
      Top = 80
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
      Text = 'cubezone.com.cn'
    end
    object Button4: TButton
      Left = 264
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Disconnect'
      TabOrder = 4
      OnClick = Button4Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 128
    Width = 385
    Height = 177
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 65
      Height = 13
      Caption = #21407#25991#20214#21517
    end
    object Label2: TLabel
      Left = 8
      Top = 100
      Width = 81
      Height = 13
      Caption = #30446#26631#25991#20214#21517
    end
    object Label3: TLabel
      Left = 8
      Top = 60
      Width = 65
      Height = 13
      Caption = #30446#26631#36335#24452
    end
    object Ed_sourcefilename: TEdit
      Left = 88
      Top = 24
      Width = 281
      Height = 21
      TabOrder = 0
      Text = 'C:\test.jpeg'
    end
    object Ed_remotefilename: TEdit
      Left = 88
      Top = 100
      Width = 281
      Height = 21
      TabOrder = 1
      Text = 'test.jpeg'
    end
    object Ed_remotedir: TEdit
      Left = 88
      Top = 60
      Width = 281
      Height = 21
      TabOrder = 2
      Text = 'htdocs'
    end
    object Button2: TButton
      Left = 64
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Put'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 216
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Get'
      TabOrder = 4
      OnClick = Button3Click
    end
  end
  object NMFTP1: TNMFTP
    Port = 21
    ReportLevel = 0
    OnError = NMFTP1Error
    OnAuthenticationFailed = NMFTP1AuthenticationFailed
    Vendor = 2411
    ParseList = False
    ProxyPort = 0
    Passive = False
    FirewallType = FTUser
    FWAuthenticate = False
    Left = 600
  end
end
