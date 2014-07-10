object Form1: TForm1
  Left = 404
  Top = 244
  BorderStyle = bsSingle
  Caption = 'Cube Robot V1.0'
  ClientHeight = 131
  ClientWidth = 269
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
    Left = 24
    Top = 104
    Width = 201
    Height = 13
    Caption = 'CubeZone.Com.cn   CopyRight 1997-2007'
  end
  object Label2: TLabel
    Left = 16
    Top = 16
    Width = 233
    Height = 13
    AutoSize = False
    Caption = #20808#22312#25195#38647#31243#24207#20013#28857#20987#20986#26080#38647#21306#65292
  end
  object Label3: TLabel
    Left = 16
    Top = 32
    Width = 233
    Height = 13
    AutoSize = False
    Caption = #28982#21518#28857#20987'Mine Robot '#25353#38062#12290
  end
  object Button1: TButton
    Left = 32
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Mine Robot'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 152
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Suspend'
    TabOrder = 1
    OnClick = Button2Click
  end
end
