object Form1: TForm1
  Left = 231
  Top = 132
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 343
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 296
    Width = 54
    Height = 13
    Caption = 'Device No:'
  end
  object Button1: TButton
    Left = 136
    Top = 296
    Width = 41
    Height = 25
    Caption = 'Init'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 184
    Top = 296
    Width = 57
    Height = 25
    Caption = 'Disconnet'
    TabOrder = 1
  end
  object Button3: TButton
    Left = 248
    Top = 296
    Width = 65
    Height = 25
    Caption = 'Save bmp'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 320
    Top = 296
    Width = 57
    Height = 25
    Caption = 'Save Avi'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 376
    Top = 296
    Width = 41
    Height = 25
    Caption = 'Stop'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Panel1: TPanel
    Left = 24
    Top = 16
    Width = 393
    Height = 265
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = clBtnText
    TabOrder = 5
  end
  object MaskEdit1: TMaskEdit
    Left = 80
    Top = 296
    Width = 32
    Height = 21
    EditMask = '0;1;_'
    MaxLength = 1
    TabOrder = 6
    Text = '1'
  end
end
