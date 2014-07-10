object FormDraw: TFormDraw
  Left = 271
  Top = 221
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'FormDraw'
  ClientHeight = 469
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnMouseMove = FormMouseMove
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 392
    Top = 432
    Width = 75
    Height = 25
    Caption = 'commit'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 504
    Height = 417
    ActivePage = TabSheet1
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabIndex = 0
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Properties'
      object ValueListEditor1: TValueListEditor
        Left = 0
        Top = 41
        Width = 496
        Height = 346
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #23435#20307
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goThumbTracking]
        ParentFont = False
        TabOrder = 0
        ColWidths = (
          48
          442)
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 496
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel1'
        TabOrder = 1
        object Label1: TLabel
          Left = 48
          Top = 16
          Width = 48
          Height = 15
          Caption = 'Table '
        end
        object Edit1: TEdit
          Left = 128
          Top = 8
          Width = 249
          Height = 23
          TabOrder = 0
          Text = 'Edit1'
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Index'
      ImageIndex = 3
      object Memo3: TMemo
        Left = 0
        Top = 0
        Width = 496
        Height = 387
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Partiton'
      ImageIndex = 5
      object Memo_partition: TMemo
        Left = 0
        Top = 0
        Width = 496
        Height = 387
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object TabSheet_sql: TTabSheet
      Caption = 'Sql'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 496
        Height = 387
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Import'
      ImageIndex = 4
      object Memo_import: TMemo
        Left = 0
        Top = 0
        Width = 496
        Height = 387
        Align = alClient
        Lines.Strings = (
          '')
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Remark'
      ImageIndex = 2
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 496
        Height = 387
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object Button4: TButton
    Left = 16
    Top = 432
    Width = 75
    Height = 25
    Caption = 'Import'
    TabOrder = 2
    OnClick = Button4Click
  end
end
