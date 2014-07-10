object WebCam: TWebCam
  Left = 233
  Top = 158
  Width = 498
  Height = 451
  AxBorderStyle = afbNone
  Caption = 'WebCam'
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = ActiveFormCreate
  OnDestroy = ActiveFormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 344
    Width = 39
    Height = 13
    Caption = 'Camera:'
  end
  object Button1: TButton
    Left = 328
    Top = 344
    Width = 57
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 392
    Top = 344
    Width = 65
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 56
    Top = 384
    Width = 57
    Height = 25
    Caption = 'Save JPG'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 176
    Top = 384
    Width = 59
    Height = 25
    Caption = 'Save AVI'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 256
    Top = 384
    Width = 57
    Height = 25
    Caption = 'Stop'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Panel1: TPanel
    Left = 32
    Top = 16
    Width = 425
    Height = 305
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = clBtnText
    TabOrder = 5
  end
  object ComboBox1: TComboBox
    Left = 72
    Top = 344
    Width = 241
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = 'ComboBox1'
  end
end
