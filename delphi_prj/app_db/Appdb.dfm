object Form1: TForm1
  Left = 198
  Top = 113
  Width = 699
  Height = 642
  Caption = 'db core'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 73
    Width = 691
    Height = 542
    ActivePage = TabSheet1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object Splitter2: TSplitter
        Left = 0
        Top = 353
        Width = 683
        Height = 12
        Cursor = crVSplit
        Align = alBottom
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 41
        Width = 683
        Height = 312
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Memo1: TMemo
        Left = 0
        Top = 365
        Width = 683
        Height = 149
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Fixedsys'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 683
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 2
        object Edit011: TEdit
          Left = 32
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit012: TEdit
          Left = 192
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
        end
        object Edit013: TEdit
          Left = 368
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
        object Button01: TButton
          Left = 605
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Query'
          TabOrder = 3
          OnClick = Button01Click
        end
        object CheckBox10: TCheckBox
          Left = 528
          Top = 16
          Width = 49
          Height = 17
          Caption = 'Timer'
          TabOrder = 4
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 0
        Top = 305
        Width = 683
        Height = 12
        Cursor = crVSplit
        Align = alBottom
      end
      object Memo2: TMemo
        Left = 0
        Top = 317
        Width = 683
        Height = 197
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Fixedsys'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 41
        Width = 683
        Height = 264
        Align = alClient
        DataSource = DataSource2
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 683
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 2
        object Edit021: TEdit
          Left = 32
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit022: TEdit
          Left = 192
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
        end
        object Edit023: TEdit
          Left = 368
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
        object Button02: TButton
          Left = 605
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Query'
          TabOrder = 3
          OnClick = Button02Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      object Splitter3: TSplitter
        Left = 0
        Top = 446
        Width = 683
        Height = 12
        Cursor = crVSplit
        Align = alBottom
      end
      object DBGrid3: TDBGrid
        Left = 0
        Top = 41
        Width = 683
        Height = 405
        Align = alClient
        DataSource = DataSource3
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Memo3: TMemo
        Left = 0
        Top = 458
        Width = 683
        Height = 56
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Fixedsys'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 683
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 2
        object Edit031: TEdit
          Left = 32
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit032: TEdit
          Left = 192
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
        end
        object Edit033: TEdit
          Left = 368
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
        object Button03: TButton
          Left = 605
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Query'
          TabOrder = 3
          OnClick = Button03Click
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'TabSheet4'
      ImageIndex = 3
      object Splitter8: TSplitter
        Left = 0
        Top = 446
        Width = 683
        Height = 12
        Cursor = crVSplit
        Align = alBottom
      end
      object DBGrid4: TDBGrid
        Left = 0
        Top = 41
        Width = 683
        Height = 405
        Align = alClient
        DataSource = DataSource4
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Memo4: TMemo
        Left = 0
        Top = 458
        Width = 683
        Height = 56
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Fixedsys'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 683
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 2
        object Edit041: TEdit
          Left = 32
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit042: TEdit
          Left = 192
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
        end
        object Edit043: TEdit
          Left = 368
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
        object Button04: TButton
          Left = 605
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Query'
          TabOrder = 3
          OnClick = Button04Click
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'TabSheet5'
      ImageIndex = 4
      object Splitter4: TSplitter
        Left = 0
        Top = 446
        Width = 683
        Height = 12
        Cursor = crVSplit
        Align = alBottom
      end
      object DBGrid5: TDBGrid
        Left = 0
        Top = 41
        Width = 683
        Height = 405
        Align = alClient
        DataSource = DataSource5
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Memo5: TMemo
        Left = 0
        Top = 458
        Width = 683
        Height = 56
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Fixedsys'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 683
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 2
        object Edit051: TEdit
          Left = 32
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit052: TEdit
          Left = 192
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
        end
        object Edit053: TEdit
          Left = 368
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
        object Button05: TButton
          Left = 605
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Query'
          TabOrder = 3
          OnClick = Button05Click
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'TabSheet6'
      ImageIndex = 5
      object Splitter5: TSplitter
        Left = 0
        Top = 446
        Width = 683
        Height = 12
        Cursor = crVSplit
        Align = alBottom
      end
      object DBGrid6: TDBGrid
        Left = 0
        Top = 41
        Width = 683
        Height = 405
        Align = alClient
        DataSource = DataSource6
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Memo6: TMemo
        Left = 0
        Top = 458
        Width = 683
        Height = 56
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Fixedsys'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 683
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 2
        object Edit061: TEdit
          Left = 32
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit062: TEdit
          Left = 192
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
        end
        object Edit063: TEdit
          Left = 368
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
        object Button06: TButton
          Left = 605
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Query'
          TabOrder = 3
          OnClick = Button06Click
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'TabSheet7'
      ImageIndex = 6
      object Splitter7: TSplitter
        Left = 0
        Top = 446
        Width = 683
        Height = 12
        Cursor = crVSplit
        Align = alBottom
      end
      object Panel9: TPanel
        Left = 0
        Top = 0
        Width = 683
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 0
        object Edit071: TEdit
          Left = 32
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit072: TEdit
          Left = 192
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
        end
        object Edit073: TEdit
          Left = 368
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
        object Button07: TButton
          Left = 605
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Query'
          TabOrder = 3
          OnClick = Button07Click
        end
      end
      object DBGrid7: TDBGrid
        Left = 0
        Top = 41
        Width = 683
        Height = 405
        Align = alClient
        DataSource = DataSource7
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Memo7: TMemo
        Left = 0
        Top = 458
        Width = 683
        Height = 56
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Fixedsys'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 2
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'TabSheet8'
      ImageIndex = 7
      object Splitter6: TSplitter
        Left = 0
        Top = 446
        Width = 683
        Height = 12
        Cursor = crVSplit
        Align = alBottom
      end
      object DBGrid8: TDBGrid
        Left = 0
        Top = 41
        Width = 683
        Height = 405
        Align = alClient
        DataSource = DataSource8
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Memo8: TMemo
        Left = 0
        Top = 458
        Width = 683
        Height = 56
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Fixedsys'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 683
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 2
        object Edit081: TEdit
          Left = 32
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit082: TEdit
          Left = 192
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
        end
        object Edit083: TEdit
          Left = 368
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
        object Button08: TButton
          Left = 605
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Query'
          TabOrder = 3
          OnClick = Button08Click
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'TabSheet9'
      ImageIndex = 8
      object Splitter0: TSplitter
        Left = 0
        Top = 446
        Width = 683
        Height = 12
        Cursor = crVSplit
        Align = alBottom
      end
      object DBGrid9: TDBGrid
        Left = 0
        Top = 41
        Width = 683
        Height = 405
        Align = alClient
        DataSource = DataSource9
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Memo9: TMemo
        Left = 0
        Top = 458
        Width = 683
        Height = 56
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Fixedsys'
        Font.Style = []
        Lines.Strings = (
          '')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Panel11: TPanel
        Left = 0
        Top = 0
        Width = 683
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 2
        object Edit091: TEdit
          Left = 32
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit092: TEdit
          Left = 192
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
        end
        object Edit093: TEdit
          Left = 368
          Top = 12
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
        object Button09: TButton
          Left = 605
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Query'
          TabOrder = 3
          OnClick = Button09Click
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 691
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
    object Query: TButton
      Left = 606
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Query'
      TabOrder = 0
      OnClick = QueryClick
    end
    object Edit001: TEdit
      Left = 32
      Top = 12
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'Edit001'
    end
    object Edit002: TEdit
      Left = 192
      Top = 12
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'Edit1'
    end
    object Edit003: TEdit
      Left = 368
      Top = 12
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'Edit1'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 691
    Height = 32
    Align = alTop
    TabOrder = 2
    object CheckBox1: TCheckBox
      Left = 24
      Top = 8
      Width = 33
      Height = 17
      Caption = 'C'
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 88
      Top = 7
      Width = 33
      Height = 17
      Caption = 'C'
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 152
      Top = 7
      Width = 33
      Height = 17
      Caption = 'C'
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 216
      Top = 7
      Width = 33
      Height = 17
      Caption = 'C'
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 280
      Top = 7
      Width = 33
      Height = 17
      Caption = 'C'
      TabOrder = 4
    end
    object CheckBox6: TCheckBox
      Left = 344
      Top = 7
      Width = 33
      Height = 17
      Caption = 'C'
      TabOrder = 5
    end
    object CheckBox7: TCheckBox
      Left = 416
      Top = 7
      Width = 33
      Height = 17
      Caption = 'C'
      TabOrder = 6
    end
    object CheckBox8: TCheckBox
      Left = 480
      Top = 7
      Width = 33
      Height = 17
      Caption = 'C'
      TabOrder = 7
    end
    object CheckBox9: TCheckBox
      Left = 544
      Top = 7
      Width = 33
      Height = 17
      Caption = 'C'
      TabOrder = 8
    end
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 568
    Top = 8
  end
  object Query1: TQuery
    Active = True
    DatabaseName = 'app_db'
    SQL.Strings = (
      'select  '#39'a'#39' from dual')
    Left = 528
    Top = 8
  end
  object Database1: TDatabase
    AliasName = 'gz_bill'
    Connected = True
    DatabaseName = 'app_db'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=oldcdr'
      'PASSWORD=oldcdr123')
    SessionName = 'Default'
    BeforeConnect = Database1BeforeConnect
    Left = 496
    Top = 8
  end
  object Query2: TQuery
    Active = True
    DatabaseName = 'app_db'
    SQL.Strings = (
      'select  '#39'a'#39' from dual')
    Left = 528
    Top = 8
  end
  object DataSource2: TDataSource
    DataSet = Query2
    Left = 568
    Top = 8
  end
  object Query3: TQuery
    Active = True
    DatabaseName = 'app_db'
    SQL.Strings = (
      'select  '#39'a'#39' from dual')
    Left = 528
    Top = 8
  end
  object DataSource3: TDataSource
    DataSet = Query3
    Left = 568
    Top = 8
  end
  object Query4: TQuery
    Active = True
    DatabaseName = 'app_db'
    SQL.Strings = (
      'select  '#39'a'#39' from dual')
    Left = 528
    Top = 8
  end
  object DataSource4: TDataSource
    DataSet = Query4
    Left = 568
    Top = 8
  end
  object Query5: TQuery
    Active = True
    DatabaseName = 'app_db'
    SQL.Strings = (
      'select  '#39'a'#39' from dual')
    Left = 528
    Top = 8
  end
  object DataSource5: TDataSource
    DataSet = Query5
    Left = 568
    Top = 8
  end
  object Query6: TQuery
    Active = True
    DatabaseName = 'app_db'
    SQL.Strings = (
      'select  '#39'a'#39' from dual')
    Left = 528
    Top = 8
  end
  object DataSource6: TDataSource
    DataSet = Query6
    Left = 568
    Top = 8
  end
  object Query7: TQuery
    Active = True
    DatabaseName = 'app_db'
    SQL.Strings = (
      'select  '#39'a'#39' from dual')
    Left = 528
    Top = 8
  end
  object DataSource7: TDataSource
    DataSet = Query7
    Left = 568
    Top = 8
  end
  object Query8: TQuery
    Active = True
    DatabaseName = 'app_db'
    SQL.Strings = (
      'select  '#39'a'#39' from dual')
    Left = 528
    Top = 8
  end
  object DataSource8: TDataSource
    DataSet = Query8
    Left = 568
    Top = 8
  end
  object Query9: TQuery
    Active = True
    DatabaseName = 'app_db'
    SQL.Strings = (
      'select  '#39'a'#39' from dual')
    Left = 536
    Top = 8
  end
  object DataSource9: TDataSource
    DataSet = Query9
    Left = 576
    Top = 8
  end
  object ActionList1: TActionList
    Left = 616
    Top = 48
    object Action_Exec: TAction
      Caption = 'Action'
    end
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 560
    Top = 16
  end
end
