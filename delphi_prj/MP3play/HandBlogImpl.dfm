object HandBlog: THandBlog
  Left = 222
  Top = 46
  Width = 892
  Height = 656
  Caption = 'Ap 1.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label19: TLabel
    Left = 493
    Top = 9
    Width = 29
    Height = 13
    AutoSize = False
    Caption = #32447#23485
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 884
    Height = 622
    ActivePage = TabSheet2
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    MultiLine = True
    ParentFont = False
    TabIndex = 0
    TabOrder = 0
    TabPosition = tpBottom
    object TabSheet1: TTabSheet
      Caption = 'HandBlog'
      TabVisible = False
      object Label8: TLabel
        Left = 80
        Top = 75
        Width = 96
        Height = 16
        Caption = #35774#35745'  '#26417#20852#23431
      end
      object Label9: TLabel
        Left = 56
        Top = 40
        Width = 184
        Height = 16
        Caption = 'Note for Sharp A230 1.0'
      end
      object Label10: TLabel
        Left = 96
        Top = 104
        Width = 48
        Height = 16
        Caption = '2005.8'
      end
      object Panel1: TPanel
        Left = 0
        Top = 33
        Width = 876
        Height = 560
        Align = alClient
        AutoSize = True
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        OnDblClick = Panel1DblClick
        object PaintBox2: TPaintBox
          Left = 33
          Top = 33
          Width = 695
          Height = 527
          Align = alClient
          OnDblClick = PaintBox2DblClick
        end
        object Splitter1: TSplitter
          Left = 728
          Top = 33
          Width = 8
          Height = 527
          Cursor = crHSplit
          Align = alRight
          Beveled = True
          Color = clBtnFace
          ParentColor = False
        end
        object PaintBox1: TPaintBox
          Left = 33
          Top = 33
          Width = 695
          Height = 527
          Align = alClient
          OnDblClick = PaintBox1DblClick
          OnMouseDown = paintbox1MouseDown
          OnMouseMove = paintbox1MouseMove
          OnMouseUp = paintbox1MouseUp
          OnPaint = PaintBox1Paint
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 876
          Height = 33
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel4'
          TabOrder = 0
          object TabControlx: TTabControl
            Left = 52
            Top = 0
            Width = 824
            Height = 33
            Align = alClient
            TabOrder = 0
            Tabs.Strings = (
              '1')
            TabIndex = 0
            OnChange = TabControlxChange
          end
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 52
            Height = 33
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 1
            object MCBtnAddTabX: TMCBtn
              Left = 23
              Top = 8
              Width = 24
              Height = 18
              BevelOuter = bvNone
              Caption = '+'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              OnClick = MCBtnAddTabXClick
              CColorr = clBlue
            end
          end
        end
        object Panel2: TPanel
          Left = 736
          Top = 33
          Width = 140
          Height = 527
          Align = alRight
          BevelOuter = bvNone
          Caption = 'Panel2'
          TabOrder = 1
          object Panel6: TPanel
            Left = 0
            Top = 0
            Width = 140
            Height = 527
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object CLBAction: TCheckListBox
              Left = 0
              Top = 41
              Width = 140
              Height = 486
              OnClickCheck = CLBActionClickCheck
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              ItemHeight = 16
              TabOrder = 0
            end
            object Panel11: TPanel
              Left = 0
              Top = 0
              Width = 140
              Height = 41
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              object MCBtnRemove: TMCBtn
                Left = 16
                Top = 6
                Width = 113
                Height = 24
                BevelOuter = bvNone
                Caption = #21024#38500#26410#36873#30340#31508#30011
                TabOrder = 0
                OnClick = ActRemoveUncheckedExecute
                CColorr = clBlue
              end
            end
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 33
          Width = 33
          Height = 527
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 2
          object TabControly: TTabControl
            Left = 0
            Top = 25
            Width = 33
            Height = 502
            Align = alClient
            BiDiMode = bdLeftToRight
            MultiLine = True
            ParentBiDiMode = False
            TabOrder = 0
            TabPosition = tpLeft
            Tabs.Strings = (
              '1')
            TabIndex = 0
            OnChange = TabControlyChange
          end
          object Panel9: TPanel
            Left = 0
            Top = 0
            Width = 33
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object MCBtnAddTabY: TMCBtn
              Left = 6
              Top = 2
              Width = 22
              Height = 21
              BevelOuter = bvNone
              Caption = '+'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              OnClick = MCBtnAddTabYClick
              CColorr = clBlue
            end
          end
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 876
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 369
          Top = 10
          Width = 40
          Height = 13
          AutoSize = False
          Caption = #31508#39068#33394
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 597
          Top = 9
          Width = 29
          Height = 13
          AutoSize = False
          Caption = #24213#33394
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 722
          Top = 9
          Width = 29
          Height = 13
          AutoSize = False
          Caption = #32593#26684
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 517
          Top = 9
          Width = 29
          Height = 13
          AutoSize = False
          Caption = #32447#23485
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object ColorBox1: TColorBox
          Left = 429
          Top = 5
          Width = 84
          Height = 22
          Selected = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnChange = ColorBox1Change
        end
        object ComboBox1: TComboBox
          Left = 554
          Top = 5
          Width = 39
          Height = 20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          ItemHeight = 12
          ItemIndex = 1
          ParentFont = False
          TabOrder = 1
          Text = '2'
          OnChange = ComboBox1Change
          Items.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12'
            '13'
            '14'
            '15'
            '16'
            '17'
            '18'
            '19'
            '20')
        end
        object ComboBox2: TComboBox
          Left = 757
          Top = 5
          Width = 81
          Height = 20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          ItemHeight = 12
          ItemIndex = 3
          ParentFont = False
          TabOrder = 2
          Text = '3 '#32593#26684' 30'
          OnChange = ComboBox2Change
          Items.Strings = (
            '0 '#26080#32593#26684
            '1 '#32593#26684' 10'
            '2 '#32593#26684' 20'
            '3 '#32593#26684' 30'
            '4 '#32593#26684' 40'
            '5 '#32593#26684' 50'
            '6 '#32593#26684' 60'
            '7 '#32593#26684' 70'
            '8 '#32593#26684' 80'
            '9 '#32593#26684' 90')
        end
        object MCBtn3: TMCBtn
          Left = 270
          Top = 3
          Width = 91
          Height = 25
          BevelOuter = bvNone
          Caption = 'To OneNote'
          TabOrder = 3
          OnClick = ActCopyToOneNoteExecute
          CColorr = clBlue
        end
        object MCBtn5: TMCBtn
          Left = 5
          Top = 4
          Width = 36
          Height = 25
          BevelOuter = bvNone
          Caption = #26032#24314
          TabOrder = 4
          OnClick = ActNewExecute
          CColorr = clBlue
        end
        object MCBtn6: TMCBtn
          Left = 58
          Top = 4
          Width = 33
          Height = 25
          BevelOuter = bvNone
          Caption = #25171#24320
          TabOrder = 5
          OnClick = ActLoadExecute
          CColorr = clBlue
        end
        object MCBtn7: TMCBtn
          Left = 109
          Top = 4
          Width = 36
          Height = 25
          BevelOuter = bvNone
          Caption = #20445#23384
          TabOrder = 6
          OnClick = ActSaveExecute
          CColorr = clBlue
        end
        object MCBtn8: TMCBtn
          Left = 213
          Top = 3
          Width = 44
          Height = 25
          BevelOuter = bvNone
          Caption = 'Play22'
          TabOrder = 7
          OnClick = MCBtn8Click
        end
        object MCBtn15: TMCBtn
          Left = 158
          Top = 4
          Width = 36
          Height = 25
          BevelOuter = bvNone
          Caption = '[+]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          OnClick = MCBtn15Click
          CColorr = clBlue
        end
        object ColorBox2: TColorBox
          Left = 629
          Top = 3
          Width = 84
          Height = 22
          Selected = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 9
          OnChange = ColorBox2Change
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Word'
      Enabled = False
      ImageIndex = 8
      TabVisible = False
      object Splitter4: TSplitter
        Left = 145
        Top = 0
        Width = 5
        Height = 593
        Cursor = crHSplit
      end
      object Panel24: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 593
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel24'
        TabOrder = 0
        object Panel25: TPanel
          Left = 0
          Top = 0
          Width = 145
          Height = 65
          Align = alTop
          BevelOuter = bvNone
          Caption = ' '
          TabOrder = 0
          object Btn_lib: TButton
            Left = 8
            Top = 8
            Width = 57
            Height = 25
            Caption = 'Lib'
            TabOrder = 0
            OnClick = Btn_libClick
          end
          object Btn_font: TButton
            Left = 72
            Top = 8
            Width = 57
            Height = 25
            Caption = 'Font'
            TabOrder = 1
            OnClick = Btn_fontClick
          end
          object CB_Line: TCheckBox
            Left = 8
            Top = 40
            Width = 97
            Height = 17
            Caption = 'Line'
            TabOrder = 2
            OnClick = CB_LineClick
          end
          object Button_Locate: TButton
            Left = 72
            Top = 36
            Width = 57
            Height = 25
            Caption = 'Locate'
            TabOrder = 3
            OnClick = Button_LocateClick
          end
        end
        object PageControl3: TPageControl
          Left = 0
          Top = 65
          Width = 145
          Height = 528
          ActivePage = TabSheet15
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          Images = ImageList1
          ParentFont = False
          TabIndex = 0
          TabOrder = 1
          TabPosition = tpBottom
          object TabSheet15: TTabSheet
            Caption = 'Lib'
            ImageIndex = 1
            OnResize = TabSheet15Resize
            object TV_Books: TTreeView
              Left = 0
              Top = 0
              Width = 137
              Height = 499
              Align = alClient
              DragMode = dmAutomatic
              HideSelection = False
              Images = ImageList1
              Indent = 19
              PopupMenu = PM_Book
              TabOrder = 0
              OnChange = TV_BooksChange
              OnDragDrop = TV_BooksDragDrop
              OnDragOver = TV_BooksDragOver
              OnEdited = TV_BooksEdited
              OnEditing = TV_BooksEditing
            end
          end
          object TabSheet14: TTabSheet
            Caption = 'Pool'
            object LB_Collect: TListBox
              Left = 0
              Top = 0
              Width = 137
              Height = 499
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 17
              Font.Name = #23435#20307
              Font.Style = []
              ItemHeight = 17
              ParentFont = False
              PopupMenu = PM_Book
              TabOrder = 0
            end
          end
        end
      end
      object Panel27: TPanel
        Left = 150
        Top = 0
        Width = 726
        Height = 593
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel27'
        TabOrder = 1
        object Splitter5: TSplitter
          Left = 0
          Top = 523
          Width = 726
          Height = 5
          Cursor = crVSplit
          Align = alBottom
        end
        object PageControl2: TPageControl
          Left = 0
          Top = 0
          Width = 726
          Height = 523
          ActivePage = TabSheet11
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          MultiLine = True
          ParentFont = False
          TabIndex = 2
          TabOrder = 0
          object TabSheet13: TTabSheet
            Caption = 'View'
            ImageIndex = 3
            object Memo4: TMemo
              Left = 96
              Top = 464
              Width = 556
              Height = 339
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              ScrollBars = ssVertical
              TabOrder = 0
            end
            object ScrollBox1: TScrollBox
              Left = 0
              Top = 56
              Width = 718
              Height = 436
              VertScrollBar.Smooth = True
              VertScrollBar.Style = ssFlat
              VertScrollBar.Tracking = True
              Align = alClient
              DockSite = True
              Color = clAppWorkSpace
              ParentColor = False
              TabOrder = 1
              OnMouseWheelDown = ScrollBox1MouseWheelDown
              OnMouseWheelUp = ScrollBox1MouseWheelUp
              OnResize = ScrollBox1Resize
              object PaintBox4: TPaintBox
                Left = 0
                Top = 0
                Width = 528
                Height = 535
                ParentShowHint = False
                ShowHint = False
                OnDblClick = PaintBox4DblClick
                OnMouseDown = PaintBox4MouseDown
                OnMouseMove = PaintBox4MouseMove
                OnPaint = PaintBox4Paint
              end
              object Memo6: TMemo
                Left = 59
                Top = 0
                Width = 469
                Height = 25
                BevelInner = bvNone
                BevelOuter = bvNone
                BorderStyle = bsNone
                Color = clSkyBlue
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -16
                Font.Name = #23435#20307
                Font.Style = []
                Lines.Strings = (
                  '')
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnExit = Memo6Exit
                OnKeyUp = Memo6KeyUp
              end
            end
            object Panel_head: TPanel
              Left = 0
              Top = 0
              Width = 718
              Height = 56
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 2
              object Edit5: TEdit
                Left = 8
                Top = 16
                Width = 153
                Height = 24
                TabOrder = 0
                OnKeyDown = Edit5KeyDown
              end
              object Btn_filter: TButton
                Left = 165
                Top = 16
                Width = 28
                Height = 25
                Caption = 'F'
                TabOrder = 1
                OnClick = Btn_filterClick
              end
              object CB_AllBook: TCheckBox
                Left = 200
                Top = 16
                Width = 97
                Height = 17
                Caption = 'All Book'
                TabOrder = 2
              end
              object CB_BookContent: TCheckBox
                Left = 288
                Top = 16
                Width = 105
                Height = 17
                Caption = 'Context'
                TabOrder = 3
              end
              object Button9: TButton
                Left = 424
                Top = 16
                Width = 65
                Height = 25
                Caption = 'Exp(VB)'
                TabOrder = 4
                OnClick = Button9Click
              end
              object SE_Line: TSpinEdit
                Left = 376
                Top = 16
                Width = 41
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -14
                Font.Name = #23435#20307
                Font.Style = []
                MaxValue = 0
                MinValue = 0
                ParentFont = False
                TabOrder = 5
                Value = 15
              end
              object Button14: TButton
                Left = 496
                Top = 17
                Width = 76
                Height = 23
                Caption = 'Exp(OLE)'
                TabOrder = 6
                OnClick = Button14Click
              end
              object Button12: TButton
                Left = 584
                Top = 0
                Width = 41
                Height = 11
                Caption = '-'
                TabOrder = 7
                OnClick = Button12Click
              end
            end
          end
          object TabSheet10: TTabSheet
            Caption = 'Edit'
            object Panel19: TPanel
              Left = 0
              Top = 0
              Width = 718
              Height = 492
              Align = alClient
              BevelOuter = bvNone
              Caption = 'Panel19'
              TabOrder = 0
              object aa: TPanel
                Left = 0
                Top = 0
                Width = 718
                Height = 492
                Align = alClient
                BevelOuter = bvNone
                Caption = 'aa'
                TabOrder = 0
                object Splitter6: TSplitter
                  Left = 0
                  Top = 254
                  Width = 718
                  Height = 9
                  Cursor = crVSplit
                  Align = alBottom
                end
                object SG: TStringGrid
                  Left = 0
                  Top = 0
                  Width = 718
                  Height = 254
                  Align = alClient
                  ColCount = 10
                  DefaultColWidth = 40
                  RowCount = 2
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = #23435#20307
                  Font.Style = []
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
                  ParentFont = False
                  TabOrder = 0
                  OnMouseUp = SGMouseUp
                  ColWidths = (
                    40
                    35
                    32
                    28
                    499
                    40
                    40
                    40
                    40
                    40)
                end
                object Panel21: TPanel
                  Left = 0
                  Top = 263
                  Width = 718
                  Height = 229
                  Align = alBottom
                  BevelOuter = bvNone
                  Caption = 'Panel21'
                  TabOrder = 1
                  object Memo3: TMemo
                    Left = 0
                    Top = 41
                    Width = 718
                    Height = 188
                    Align = alClient
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -16
                    Font.Name = #23435#20307
                    Font.Style = []
                    Lines.Strings = (
                      '')
                    ParentFont = False
                    ScrollBars = ssVertical
                    TabOrder = 0
                    OnKeyDown = Memo3KeyDown
                  end
                  object Panel23: TPanel
                    Left = 0
                    Top = 0
                    Width = 718
                    Height = 41
                    Align = alTop
                    BevelOuter = bvNone
                    Caption = ' '
                    TabOrder = 1
                    object Btn_edit: TButton
                      Left = 264
                      Top = 8
                      Width = 75
                      Height = 25
                      Caption = #20445#23384
                      TabOrder = 0
                      OnClick = Btn_editClick
                    end
                    object RadioButton1: TRadioButton
                      Left = 112
                      Top = 16
                      Width = 65
                      Height = 17
                      Caption = #26597#30475
                      TabOrder = 1
                      OnClick = RadioButton1Click
                    end
                    object RB_edit: TRadioButton
                      Left = 184
                      Top = 16
                      Width = 49
                      Height = 17
                      Caption = #32534#36753
                      Checked = True
                      TabOrder = 2
                      TabStop = True
                      OnClick = RB_editClick
                    end
                    object Btn_refresh: TButton
                      Left = 360
                      Top = 8
                      Width = 75
                      Height = 25
                      Caption = #21047#26032
                      TabOrder = 3
                      OnClick = Btn_refreshClick
                    end
                  end
                end
              end
            end
          end
          object TabSheet11: TTabSheet
            Caption = 'Import'
            ImageIndex = 1
            object RichEdit1: TRichEdit
              Left = 0
              Top = 41
              Width = 718
              Height = 451
              Align = alClient
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = #23435#20307
              Font.Style = []
              Lines.Strings = (
                '')
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
            end
            object Panel18: TPanel
              Left = 0
              Top = 0
              Width = 718
              Height = 41
              Align = alTop
              BevelOuter = bvNone
              Caption = ' '
              TabOrder = 1
              object Button7: TButton
                Left = 168
                Top = 8
                Width = 89
                Height = 25
                Caption = 'Import'
                TabOrder = 0
                OnClick = Button7Click
              end
              object Button5: TButton
                Left = 24
                Top = 8
                Width = 105
                Height = 25
                Caption = #20174#25991#26723#33719#21462
                TabOrder = 1
                OnClick = Button5Click
              end
              object Button6: TButton
                Left = 446
                Top = 8
                Width = 75
                Height = 25
                Caption = 'Button6'
                TabOrder = 2
                OnClick = Button6Click
              end
            end
          end
          object TabSheet12: TTabSheet
            Caption = 'Objects'
            ImageIndex = 2
            object Splitter3: TSplitter
              Left = 0
              Top = 137
              Width = 718
              Height = 10
              Cursor = crVSplit
              Align = alTop
            end
            object Panel20: TPanel
              Left = 0
              Top = 0
              Width = 718
              Height = 137
              Align = alTop
              BevelOuter = bvNone
              Caption = ' '
              TabOrder = 0
              object ListBox3: TListBox
                Left = 137
                Top = 0
                Width = 581
                Height = 137
                Align = alClient
                ItemHeight = 16
                TabOrder = 0
                OnClick = ListBox3Click
                OnDblClick = ListBox3DblClick
              end
              object Panel26: TPanel
                Left = 0
                Top = 0
                Width = 137
                Height = 137
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 1
                object Button3: TButton
                  Left = 16
                  Top = 24
                  Width = 97
                  Height = 25
                  Caption = 'Open Word'
                  TabOrder = 0
                  OnClick = Button3Click
                end
                object Button8: TButton
                  Left = 16
                  Top = 64
                  Width = 97
                  Height = 25
                  Caption = 'Add'
                  TabOrder = 1
                  OnClick = Button8Click
                end
                object Button10: TButton
                  Left = 16
                  Top = 96
                  Width = 97
                  Height = 25
                  Caption = 'Remove'
                  TabOrder = 2
                  OnClick = Button10Click
                end
              end
              object Lv_obj: TListView
                Left = 137
                Top = 0
                Width = 581
                Height = 137
                Align = alClient
                Columns = <>
                LargeImages = ImageList1
                SmallImages = ImageList1
                TabOrder = 2
                ViewStyle = vsSmallIcon
                OnDblClick = Lv_objDblClick
              end
            end
            object PageControl4: TPageControl
              Left = 0
              Top = 147
              Width = 718
              Height = 345
              ActivePage = TabSheet17
              Align = alClient
              TabIndex = 1
              TabOrder = 1
              object TabSheet16: TTabSheet
                Caption = #25991#26723
                object OleN: TOleContainer
                  Left = 0
                  Top = 0
                  Width = 524
                  Height = 385
                  Align = alClient
                  Caption = 'OleN'
                  Color = clBtnFace
                  TabOrder = 0
                  Data = {
                    42444F430100000000BE0000D0CF11E0A1B11AE1000000000000000000000000
                    000000003E000300FEFF09000600000000000000000000000100000001000000
                    00000000001000000200000001000000FEFFFFFF0000000000000000FFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF12000000FEFFFFFF1300000005000000
                    060000000700000008000000090000000A0000000B0000000C0000000D000000
                    0E0000000F0000001000000011000000FEFFFFFF55000000FEFFFFFF15000000
                    160000001700000018000000190000001A0000001B0000001C0000001D000000
                    1E0000001F000000200000002100000022000000230000002400000025000000
                    260000002700000028000000290000002A0000002B0000002C0000002D000000
                    2E0000002F000000300000003100000032000000330000003400000035000000
                    360000003700000038000000390000003A0000003B0000003C0000003D000000
                    3E0000003F000000400000004100000042000000430000004400000045000000
                    460000004700000048000000490000004A0000004B0000004C000000FEFFFFFF
                    4E0000004F0000005000000051000000520000005300000054000000FEFFFFFF
                    FEFFFFFF5700000058000000590000005A0000005B0000005C0000005D000000
                    FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900
                    0000000000000000000000000000000000000000000000000000000000000000
                    00000000000000000000000016000500FFFFFFFFFFFFFFFF0400000006090200
                    00000000C0000000000000460000000000000000000000009045609C8AA2C701
                    03000000800200000000000001004F006C006500000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000A000201FFFFFFFFFFFFFFFFFFFFFFFF00000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    00000000140000000000000031005400610062006C0065000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000E0002000100000003000000FFFFFFFF00000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    040000008D1B000000000000010043006F006D0070004F0062006A0000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    00000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF00000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    010000006600000000000000FEFFFFFF02000000FEFFFFFF0400000005000000
                    06000000070000000800000009000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFF0100000200000000000000000000000000000000
                    4805150000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000100FEFF030A0000FFFFFFFF0609020000000000
                    C000000000000046140000004D6963726F736F667420576F726420CEC4B5B500
                    0A0000004D53576F7264446F630010000000576F72642E446F63756D656E742E
                    3800F439B2710000000000000000000000000000000000000000000000000000
                    000000000000000000000000FFFFFFFF030000000400000001000000FFFFFFFF
                    0200000000000000514B00003903000052010000010009000003A90000000300
                    1C00000000001400000026060F001E00FFFFFFFF040014000000576F72640E00
                    4D6963726F736F667420576F7264050000000B0200000000050000000C026100
                    E5081C000000FB021000070000000000BC02000000860102022253797374656D
                    0000610866FB00000A0026008A0100000000FFFFFFFF2CC71300040000002D01
                    00001C000000FB02DAFF0000000000009001000000000440001254696D657320
                    4E657720526F6D616E00D89FF177E19FF1772020F377610866FB040000002D01
                    0100040000002D010100050000000201010000001C000000FB02CEFF00000000
                    00009001000000000440001254696D6573204E657720526F6D616E00D89FF177
                    E19FF1772020F377610866FB140013000A00010069000F000300000003000000
                    000054000040F1FF020054000C040200636B876500001D0000000324031184C8
                    001264680101003124005744C8006084C800612403002000434A18004B480200
                    5F480104614A18006D4809046E48040873480904744804084202010001000200
                    42020C00EE0007689898200031002C00480031002C00500049004D0020003100
                    2C00680031002C0031002C004800750076007500640072007500620072006900
                    6B002C006100700070002000680065006100640069006E006700200031002C00
                    6100700070002000680065006100640069006E0067002000310031002C006100
                    700070002000680065006100640069006E0067002000310032002C0061007000
                    70002000680065006100640069006E00670020003100310031002C0061007000
                    70002000680065006100640069006E0067002000310033002C00700072006F00
                    70002C00480065006100640069006E0067002000310031002C00490049002B00
                    2C0049002C004800310031002C004800310032002C004800310033002C004800
                    310034002C004800310035002C004800310036002C004800310037002C004800
                    310038002C0048003100310031002C0048003100320031002C00480031003300
                    31002C0048003100340031002C0048003100350031002C004800310036003100
                    2C0048003100370031002C004800310039002C0048003100310032002C004800
                    3100320032002C0048003100330032002C0048003100340032002C0048003100
                    350032002C0048003100360032002C0048003100370032002C00480031003800
                    31000000370001000324000624010A26000B4601000F8400001184000013A4F0
                    0014A46400312401402600574400005C24015E84000060840000612400001B00
                    350881434A1E004B481C004F4A0200504A0400514A0200614A14000056020200
                    0100020056020C00F80007689898200032002C00500049004D0032002C004800
                    32002C00480065006100640069006E0067002000320020004800690064006400
                    65006E002C00480065006100640069006E006700200032002000430043004200
                    53002C00680065006100640069006E006700200032002C005400690074007200
                    650033002C004800440032002C007300650063007400200031002E0032002C00
                    4800320031002C007300650063007400200031002E00320031002C0048003200
                    32002C007300650063007400200031002E00320032002C004800320031003100
                    2C007300650063007400200031002E003200310031002C004800320033002C00
                    7300650063007400200031002E00320033002C0048003200310032002C007300
                    650063007400200031002E003200310032002C00680032002C002C7B004EE07A
                    200007689898200032002C0044004F002C0032006E00640020006C0065007600
                    65006C002C0032002C006C0032002C0044004F0020004E004F00540020005500
                    530045005F00680032002C00630068006E002C00430068006100700074006500
                    720020004E0075006D006200650072002F0041007000700065006E0064006900
                    780020004C00650074007400650072002C00490053004F0031002C0055004E00
                    440045005200520055004200520049004B00200031002D003200000037000200
                    0324000624010A26010B4601000F8400001184000013A4F00014A46400312401
                    402601574400005C24015E84000060840000612400001B00350881434A1C004B
                    4800004F4A0200504A0400514A0200614A140000540203000100020054020C00
                    F70007689898200033002C00680033002C00480033002C006C00650076006500
                    6C005F0033002C00500049004D00200033002C004C006500760065006C002000
                    3300200048006500610064002C00480065006100640069006E00670020003300
                    20002D0020006F006C0064002C00730065006300740031002E0032002E003300
                    2C00730065006300740031002E0032002E00330031002C007300650063007400
                    31002E0032002E00330032002C00730065006300740031002E0032002E003300
                    310031002C00730065006300740031002E0032002E00330033002C0073006500
                    6300740031002E0032002E003300310032002C0042006F006C00640020004800
                    6500610064002C00620068002C00700072006F00700033002C0033002C003300
                    680065006100640069006E0067002C00680065006100640069006E0067002000
                    33002C00480065006100640069006E0067002000330031002C0055006E006400
                    65007200720075006200720069006B0032002C0031002E0032002E0033002E00
                    2C004800330031002C004800330032002C0041007200690061006C0020003100
                    3200200046006500740074002C004C006500760065006C002000310020002D00
                    200031002C004C006500760065006C002000310020002D00200032002C004800
                    65006100640053006D0061006C006C000000370003000324000624010A26020B
                    4601000F8400001184000013A4F00014A46400312401402602574400005C2401
                    5E84000060840000612400001B00350881434A18004B4800004F4A0200504A04
                    00514A0200614A140000600204000100020060020C00FC000768989820003400
                    2C00500049004D00200034002C00480034002C00680034002C00620075006C00
                    6C00650074002C0062006C002C00620062002C0034002C003400680065006100
                    640069006E0067002C005400610062006C006500200061006E00640020004600
                    6900670075007200650073002C004C006500760065006C002000320020002D00
                    200061002C004C006500760065006C002000320020002D002000280061002900
                    2C00680065006100640069006E006700200034002C0073006500630074002000
                    31002E0032002E0033002E0034002C0052006500660020004800650061006400
                    69006E006700200031002C007200680031002C00730065006300740020003100
                    2E0032002E0033002E00340031002C0052006500660020004800650061006400
                    69006E0067002000310031002C0072006800310031002C007300650063007400
                    200031002E0032002E0033002E00340032002C00520065006600200048006500
                    6100640069006E0067002000310032002C0072006800310032002C0073006500
                    63007400200031002E0032002E0033002E003400310031002C00520065006600
                    2000480065006100640069006E00670020003100310031002C00720068003100
                    310031002C007300650063007400200031002E0032002E0033002E0034003300
                    2C00490034002C0072006800310033000000410004000324000624010A26030B
                    4601000DC60701E40601D002000F8400001184000013A4780014A46400312401
                    402603574400005C24015E840000608400006124000013003508814B4800004F
                    4A0200514A0200614A1400008E000500010002008E000C001800076898982000
                    35002C0064006100730068002C00640073002C00640064002C00480035002C00
                    500049004D00200035000000340005000324000A26040B4601000F8400001184
                    000013A4F00014A46400312401402604574400005C24015E8400006084000061
                    24001700350881434A18004B4800004F4A0200514A0200614A14000084000600
                    0100020084000C000D0007689898200036002C00500049004D00200036002C00
                    480036000000340006000324000A26050B4601000F8400001184000013A4F000
                    14A46400312401402605574400005C24015E8400006084000061240023003608
                    81434A18004B4800004F4A0200504A0500514A0200614A14006E480404744804
                    04007A000700010002007A000C000A0007689898200037002C00500049004D00
                    200037000000340007000324000A26060B4601000F8400001184000013A4F000
                    14A46400312401402606574400005C24015E840000608400006124002000434A
                    18004B4800004F4A0200504A0500514A0200614A14006E480404744804047800
                    08000100020078000C00090007689898200038002C00E86C0F614668534F0000
                    340008000324000A26070B4601000F8400001184000013A4F00014A464003124
                    01402607574400005C24015E840000608400006124002000434A12004B480000
                    4F4A0200504A0500514A0200614A14006E480404744804047000090001000200
                    70000C000A0007689898200039002C00500049004D0020003900000026000900
                    0324000A26080B46010012646801010013A4F00014A43C003124014026085C24
                    016124002300360881434A12004B4800004F4A0200504A0500514A0200614A14
                    006E48040474480404001C004140F2FFA1001C000C050600D89EA48BB56B3D84
                    575B534F000000000000000000000000300059000100F20030000C0005008765
                    6368D37E8467FE56000013000F002D4420014DC60A000000FF00008000000000
                    00004C001F40010002014C000C0002007598097700002D0010000324010DC608
                    00023910722001021264F000010026640601000147240050C608000000FF0601
                    0100612401000800434A1200614A12003A002040010012013A000C0002007598
                    1A8100001C0011000324000DC60800023910722001021264F000010047240061
                    24000800434A1200614A120014002940A200210114000C000200759801780000
                    0000000000009A0000000500000C00000000FFFFFFFF010000000420FFFF0100
                    2226A30000000000000000009A00000000000000000000000000010000000300
                    00007200000075000000930000009B0000009800000000000000000000000080
                    000000800A000000003000000000000000000000000098000000100000000000
                    00000080000000800A0000000030000000000000000000000000980000001100
                    0000000000000080000000809A00000000000000000000000080000000800000
                    0000000000000000000000000000000000000000000000000000020000007200
                    0000740000009300000095000000970000009A00000000040000340500000300
                    0000000400003405000004000000000400003205000005000000470000006200
                    00006F000000750000007C0000007E000000820000008D0000008F0000009A00
                    0000131DD4FF9580132114FF9580131A14FF95800F0000F074000000000006F0
                    20000000020C0000030000000400000002000000010000000200000002000000
                    030000001F0001F02C000000620007F0240000000606953793C923AF9752EAC1
                    64DF8C5C128FFF00E863000001000000320C00000000D00140001EF110000000
                    FFFF00000000FF0080808000F7000010010F0002F092000000200008F0080000
                    0002000000020800000F0003F07A0000000F0004F028000000010009F0100000
                    000000000000000000000000000000000002000AF00800000000080000050000
                    000F0004F042000000B2040AF00800000002080000000A000033000BF0120000
                    00044101000000BF0100001000FF0100000800000010F0040000000000000000
                    0011F00400000031000000000F0002F092000000100008F00800000001000000
                    010400000F0003F0300000000F0004F028000000010009F01000000000000000
                    00000000000000000000000002000AF00800000000040000050000000F0004F0
                    4200000012000AF00800000001040000000E000053000BF01E000000BF010000
                    1000CB0100000000FF01000008000403090000003F0301000100000011F00400
                    000001000000020000009A0000000208000000000000DDFFFFFF1C0200007E01
                    0000740000000000000000000100000004000000080000007500000076000000
                    8000000081000000820000008300000091000000920000009B00000007000700
                    0500070005000700050007000500070005000700000000000100000004000000
                    080000009B000000070007003A00070000000000010000000300000071000000
                    7500000076000000800000008300000091000000920000009B00000007000700
                    050007000500070005000700050007000200B9705D17108F6E6AFF0FFF0FFF0F
                    FF0FFF0FFF0FFF0FFF0FFF0F10000A273626E03FFA9501000200030004000500
                    0600070008000900000001000000171000000000000000000000000000000000
                    00000B1800000F84A40111845CFE15C6050001A401065E84A40160845CFE4F4A
                    0600514A06006F28000100D8F001000000171000000000000000000000000000
                    00000000000B1800000F84480311845CFE15C60500014803065E84480360845C
                    FE4F4A0600514A06006F280001006EF001000000179000000000000000000000
                    00000000000000000B1800000F84EC0411845CFE15C6050001EC04065E84EC04
                    60845CFE4F4A0600514A06006F2800010075F001000000179000000000000000
                    00000000000000000000000B1800000F84900611845CFE15C60500019006065E
                    84900660845CFE4F4A0600514A06006F280001006CF001000000179000000000
                    00000000000000000000000000000B1800000F84340811845CFE15C605000134
                    08065E84340860845CFE4F4A0600514A06006F280001006EF001000000179000
                    00000000000000000000000000000000000B1800000F84D80911845CFE15C605
                    0001D809065E84D80960845CFE4F4A0600514A06006F2800010075F001000000
                    17900000000000000000000000000000000000000B1800000F847C0B11845CFE
                    15C60500017C0B065E847C0B60845CFE4F4A0600514A06006F280001006CF001
                    00000017900000000000000000000000000000000000000B1800000F84200D11
                    845CFE15C6050001200D065E84200D60845CFE4F4A0600514A06006F28000100
                    6EF00100000017900000000000000000000000000000000000000B1800000F84
                    C40E11845CFE15C6050001C40E065E84C40E60845CFE4F4A0600514A06006F28
                    00010075F0010000000010010000000000000000000000000000000000031800
                    000F84B001118450FE15C6050001B001065E84B001608450FE6F280101000000
                    010000000010010300000000000000000000000000000000031801000F844002
                    1184C0FD15C60500014002065E8440026084C0FD6F2801030000002E00010001
                    0000000010010305000000000000000000000000000000221802000F84D00211
                    8430FD15C6050001D002065E84D002608430FD6F280147CA1C434A18004F4A00
                    00504A0000514A000073480904744804085F480104050000002E0001002E0002
                    000100000000100103050700000000000000000000000000002A1803000F84E4
                    061184A0FC15C6050001E406065E84E4066084A0FC332A0047CA24350801434A
                    18004F4A0000504A0000514A000073480000744800005F4800003DF800200007
                    0000002E0001002E0002002E0003000100000000100103050709000000000000
                    00000000000000031804000F84F003118410FC15C6050001F003065E84F00360
                    8410FC6F2801090000002E0001002E0002002E0003002E000400010000000010
                    01030507090B000000000000000000000000031805000F848004118480FB15C6
                    0500018004065E848004608480FB6F28010B0000002E0001002E0002002E0003
                    002E0004002E00050001000000001001030507090B0D00000000000000000000
                    00031806000F8410051184F0FA15C60500011005065E8410056084F0FA6F2801
                    0D0000002E0001002E0002002E0003002E0004002E0005002E00060001000000
                    001001030507090B0D0F00000000000000000000031807000F84A005118460FA
                    15C6050001A005065E84A005608460FA6F28010F0000002E0001002E0002002E
                    0003002E0004002E0005002E0006002E00070001000000001001030507090B0D
                    0F11000000000000000000031808000F8430061184D0F915C60500013006065E
                    8430066084D0F96F2801110000002E0001002E0002002E0003002E0004002E00
                    05002E0006002E0007002E000800030000000A27362600000000000000000000
                    0000B9705D170000000000000000000000000A27362600000000000000000000
                    0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF0200000000000000FFFF020000001200
                    0B00090403000904050009040100090403000904050009040100090403000904
                    050009040000FF40038000000000000000000000906052030100010000000000
                    0000000000000000000000000210000000000000009A00000050000004000000
                    00FFFF01000000070055006E006B006E006F0077006E00FFFF01000800000000
                    00000000000000FFFF010000000000FFFF00000200FFFF00000000FFFF000002
                    00FFFF000000000700000047169001000002020603050405020304877A002000
                    0000800800000000000000FF01000000000000540069006D006500730020004E
                    0065007700200052006F006D0061006E00000035169001020005050102010706
                    020507000000000000001000000000000000000000008000000000530079006D
                    0062006F006C000000332690010000020B0604020202020204877A0020000000
                    800800000000000000FF0100000000000041007200690061006C0000003B0690
                    018603020106000301010101010300000000000E081000000000000000010004
                    00000000008B5B534F0000530069006D00530075006E0000003B069001860302
                    0106000301010101010100000000000E08100000000000000000000400000000
                    00D19E534F0000530069006D0048006500690000004302900188090202030000
                    000000000001000000000008081000000000000000000010000000000050004D
                    0069006E0067004C00690055000000B065307D0E66D49A00003B069001020005
                    0000000000000000000000000000000010000000000000000000000080000000
                    00570069006E006700640069006E0067007300000020000400F10888180000A4
                    010000680100000000E59BA626E59BA626000000000200000000000000000000
                    0000000100010000000400031001000000000000000000000001000100000001
                    00000000000000210300000000000003002D001300210029002C002E003A003B
                    003F005D007D00A800B700C702C9021520162019201D20262036220130023003
                    30053009300B300D300F3011301530173001FF02FF07FF09FF0CFF0EFF1AFF1B
                    FF1FFF3DFF40FF5CFF5DFF5EFFE0FF0000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000028
                    005B007B00B70018201C2008300A300C300E3010301430163008FF0EFF3BFF5B
                    FFE1FFE5FF000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    00000000000807A005B4009C0082803200000010001900640000001900000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    00000002000000AF0200000000093383710000000000DC030000000000000000
                    000000000000000000000000000000000000004050FFFF120000000000000001
                    00310000000000000006006400610065006D006F006E0006006400610065006D
                    006F006E00000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000004F0062006A0065006300740050006F006F006C00
                    0000000000000000000000000000000000000000000000000000000000000000
                    000000000000000000000000160001010200000006000000FFFFFFFF00000000
                    000000000000000000000000000000009045609C8AA2C7019045609C8AA2C701
                    00000000000000000000000002004F006C006500500072006500730030003000
                    3000000000000000000000000000000000000000000000000000000000000000
                    00000000000000000000000018000201FFFFFFFFFFFFFFFFFFFFFFFF00000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    03000000940100000000000057006F007200640044006F00630075006D006500
                    6E00740000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000001A0002000500000007000000FFFFFFFF00000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    140000001A700000000000000500530075006D006D0061007200790049006E00
                    66006F0072006D006100740069006F006E000000000000000000000000000000
                    00000000000000000000000028000201FFFFFFFF08000000FFFFFFFF00000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    4D0000000010000000000000040000002D010200050000000902000000020D00
                    0000320A150064000100040000000000E508610020002500040000002D010000
                    0300000000000000000000000000000000000000000000004E414E4900000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    000000000000000000000000ECA5C100392009040000F052BF00000000000010
                    0000000000040000340500000E00626A626AFDCFFDCF00000000000000000000
                    0000000000000000040816001A7000009FA500009FA500000100000000000000
                    980000000000000000000000000000000000000000000000FFFF0F0000000000
                    00000000FFFF0F000000000000000000FFFF0F00000000000000000000000000
                    000000006C0000000000360D000000000000360D0000360D000000000000360D
                    000000000000360D000000000000360D000000000000360D0000140000000000
                    0000000000006A0D000000000000F20D000000000000F20D000000000000F20D
                    0000380000002A0E00000C000000360E00000C0000006A0D0000000000007B17
                    0000AE0100004E0E0000000000004E0E00003A000000880E000000000000880E
                    000000000000880E0000000000005C100000000000005C100000000000005C10
                    000000000000FA16000002000000FC16000000000000FC16000000000000FC16
                    000000000000FC16000000000000FC16000000000000FC160000240000002919
                    000020020000491B000044000000201700001500000000000000000000000000
                    000000000000360D0000000000005C1000000000000000000000000000000000
                    0000000000003A100000000000003A100000220000005C100000000000005C10
                    00000000000020170000000000000411000000000000360D000000000000360D
                    000000000000880E0000000000000000000000000000880E0000B20100003517
                    0000160000000411000000000000041100000000000004110000000000005C10
                    00004C000000360D000000000000880E000000000000360D000000000000880E
                    000000000000FA16000000000000000000000000000004110000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    00000000000000000000000000005C10000000000000FA160000000000000411
                    0000000000000411000000000000041100003A0000008216000040000000360D
                    000000000000360D000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    000000000000FA16000000000000880E000000000000420E00000C0000006094
                    DA347393C6016A0D000088000000F20D000000000000A81000001C000000C216
                    00000A0000000000000000000000FA160000000000004B170000300000007B17
                    000000000000CC1600002E0000008D1B000000000000C4100000400000008D1B
                    000000000000FA1600000000000004110000000000004A0D0000120000005C0D
                    00000E000000360D000000000000360D000000000000360D000000000000360D
                    0000000000000200D90000000D000D000D00080054801B52D179806220002000
                    2000200020002000200020002000200020002000200020002000200020002000
                    2000200020002000200020002000200020002000200020002000200020002000
                    2000200020002000200020002000200020002000200020002000200020002000
                    2000200020002000200020002000200020002000200020002000200013002000
                    460049004C0045004E0041004D004500200020005C002A0020004D0045005200
                    4700450046004F0052004D0041005400200014007E00570052004F0032003300
                    390037002E0064006F00630015000D000D000D000D002C7B1300200050004100
                    470045002000140031001500759820007151130020004E0055004D0050004100
                    470045005300200014003100150075980D000D000D000D000D000D000D000D00
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000004000002040000060400000804000090040000
                    92040000C6040000C8040000E0040000E2040000E4040000EA040000EC040000
                    EE040000FA040000FC040000FE0400000005000006050000080500001C050000
                    1E050000200500002205000024050000260500003205000034050000FD00F0FD
                    EB00EBE5EBFD00E1DAD7DACFDAE1DAD7DACFDAE1FD00FD000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    000000000000000000000F304A12006D4800046E48000475080104304A120000
                    0D036A00000000304A120055080107304A12006F28010B6D4800046E48000475
                    080109036A0000000055080118036A00000000434A14005508016D4800046E48
                    000475080100036F2801001B00040000020400000404000006040000E4040000
                    E6040000E8040000EA04000026050000280500002A0500002C0500002E050000
                    300500003205000034050000F9000000000000000000000000F3000000000000
                    000000000000F9000000000000000000000000E0000000000000000000000000
                    F9000000000000000000000000DA000000000000000000000000F90000000000
                    00000000000000D1000000000000000000000000F90000000000000000000000
                    00F3000000000000000000000000F9000000000000000000000000DA00000000
                    0000000000000000F9000000000000000000000000F900000000000000000000
                    0000F90000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000811000324011184680160846801612401
                    00051100118468016084680113100003240311841C0226640601000550C60800
                    0000FF0601050057440E0160841C026124030005100011846801608468010005
                    00001184E0016084E001000F000400000204000032050000FEFE000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    000000000000000002010102300031903801325002001FB0C33820B0C64121B0
                    080722B008072390A0052490A00525B0000017B0530318B0E0030C90A901006E
                    1EF0E0630000953793C923AF9752EAC164DF8C5C128FFF89504E470D0A1A0A00
                    00000D49484452000001D80000016E08030000001594F9C30000000173524742
                    00AECE1CE9000000097048597300001A6500001A6801CD678CC4000002E5504C
                    5445000000101010080808181818071011101818181010100F18060810182121
                    1930720131731A397B13397B05296C10296B002973002A6B0A29731031730031
                    7C01397C00326C0A397C0D307A1021631938841039831F4A85174A8C1284BC00
                    85BE1D8CC6028CC61883C60785C6108CC6292929212129212121212931393939
                    3131293131313931313229292A394230394229394A21397A29397B2939833142
                    4A304A5A20427B32417A3A5A723A5A6B315263304285204285284284314A8B39
                    4B8C394A8338528D3B4284395293284A8C385A953152943259932852933A637A
                    3A639C39738C39739C3A6B843A6CA5387BA63C8CB5228CC6398CC4278CC7338C
                    C63293CD3994CD399CCD2795D03294D52194CE4139395852525A5A514B42425A
                    5A5A524A4B4242424A4A4A5252524A4A424B525A495A6B43528C525A9D495395
                    5A5B954A5A934359935B639C5B6B9B52649D41639B5A73A4537BAC496BA6597C
                    B5516CA6446BA45373AE4973A4517BB44173AE4B84BC528CBE4C8CBD598CBE5B
                    84BD4484AC5A9CCF539CCD4094C64A9CCE4194CE419CCF5294C55A94C55A8DC5
                    5AA6D5635A5B7C7B74726B6B6B6B6B7B73746A6C6474726B636363646B9C6363
                    9B737BAD7C7AAC6C7BAC6B74A67373A57473AC646BA46373A5647CAD7C8C9464
                    84B4638CBD6C9BCE6594C56B94C7648CC564A5CC63A5D773AED67BB5DE7BADD5
                    6CAED66BA5D67BAEE0837B7B82847B9C94948C84849C9C9C958C8D9E9C948484
                    B58C94BD838CBD9394C6959CC79B9CC69DA5B693BEDF85B5DE9DA5C68CBEE094
                    BCE69AC6E8A59C9DBDBDB6ACACACB5B5AEA5A5A5AEA5A5BEBEBEB7BDD7BDBDD6
                    BDBEDEADB5D5ACAECFA5A5CDA4A6C7A4ADCFA5C6DEBEC6DDB7C5D5BED6EFBCD6
                    E6A5CFE7B6CDE6ACCEE6A6C6E8C6BDBDC8C6DECECFDEC5CDDDCECDC6C6C6C6DE
                    DEDECECECEDED7D6D5CECDD5D5D5DFDFD7C7DEEFC6D6EED6D7E7CEDDEEDED6E8
                    CED7EFCECDE7D6E6F7DFE7EFF6F7FFEFEFF7E8EFF8E6EFFFFFF8FFF0F0F0EFE8
                    E7E7E7E7FFFFFF9BA8CF37000060834944415478DAEDBD7B605C57792F6A3BB7
                    DC83B634B623C9C94DB9549C1E9A52B870648AFBD0234D6DA7B7841E326BAFBD
                    36BD9796E7BD49B05C2BB28CF189A36666EFD9122E3D3DE591184C8E6D99B122
                    FB70E8A1761B5F293A81521A681EE2CAB11253A01064C937D64889417FDFF57D
                    DFDA7BAFBD254B33D2CCD6286802893C9E97E6B77FEBF7BDBF0D73EBB7D7E56D
                    C3FA57B00EEC2FF4ED5A611DD8D7E36DECE4E8DA42761DD8E270CDA4D9E83AB0
                    AFBBDB44C634F9DAA2EC3AB0C5F035CF9AF8D0B575C6BEEE704D9B6C68666D7D
                    E875608BC0D56A32D71AAEEBC02E79BB9201BEAE3167671DD822F86AA6F9C8EC
                    9AFBDCEBC02E7EBB984FF3A8BECEAE0DF2AE03BBE8EDCA69FE661E39872F665E
                    5813C8AE03BBD84D9EC3261BD5393A96695A1B918A756017E36B9E379923AF6A
                    F74C64387FCBC85AA0EC3AB08BF0356BC6FCD709F468D78425B506819DFCFBCB
                    09F1D56CE21114AF48A4D78A85BCF6809DFE424D4B12C85E3C62726724CA57D3
                    8CDEB30E6C19717DA4D9A87DA2F2EF3371924BBEEAFA3A96E76973CD78B46B0D
                    D8E947EA52B5E7A62BFE3E6390CF899CC35319732D458CD718B0D3E7EA8C779F
                    AF2CAE854B6370EA4ABEEA285EC958A61939870B556D1CAF2D60A71FA9DDDC7A
                    BEB2AC298CBA99A1D3DC64915377621E5F6747AA3A41BBA6809D3ED76CB49DAB
                    30AEE36E9A3BA0AF3A6C578E7033AAAFB303666EF4B57560CBC3D7BACDB5E72A
                    4B93C2B8936682C7F47522332F623CC29B9A06AA5871D710B0F21CDEB2A3F2E7
                    B0C9981D3B7531021541FADAE3DC4C0F5CA9E26F6BED002B714DDD76FEBA7ECF
                    85C9F2E39AE69E6346519CC8A6638A2BF96A9A0353D5FC75AD1960A7CFD56E69
                    8BF83933E79BEFFD7E7971BDE49A0E63693612E36BDA1C8E9CC3838C37E5AB1A
                    D735032CF0356A0FCF9C6FDBBCF55CB9F9CA98C77934DE0411E348DC7F76B8EA
                    F9BA6680057DDD1EC175F67CB351FB857232B6F082D457C78AC7FD33663A7A32
                    CF0E4A7D3D53E5B8AE1160E7F375F67C6DCA78F46A397195F630F718D7A2FC13
                    531081E24E445F5F9DC7D7AA8C54AC0960A59F73737324DE3473AEC5A82D2FAE
                    A32E6736F839C1F53396CF8C9E81F8B07E455D1B74CC3747709D1D19AF4264D7
                    02B010F76F8EEB6BAAFE68396DE2C20B59E0AB1E859838D9C4453C623CDF1E2E
                    0C095E85458C6B005888FB6FFFBBA83DDC6AD47DF1FF2B27AEE38E3C72B9696B
                    7CCD488F96A7A39694B487CDA6933AAEAF0E33FE2B67AA2F5251E5C04E1790AF
                    317BF8DCF654C317CB9909407BD8CE99A67E0E9BA62D580C57D4D7E9085F793A
                    9DBFB8CED8D26E93F79EBB2AF93AEF1C366ABFA49FC385EF2D3BF38E860FC69B
                    84A37B351257EEB058BDC4B56189E2D909FDB348BE9AD92B55F8D55535B0D3C7
                    8CFAFBDA245F758E4CFF7D73CAF8B26E37BDF6744BFB32FD9EC2A8347C0AE36E
                    13E0AAA138964F73C7E63C1E6FE23CA6AF1EF0B51ABFBB6A0676F2FE548361A4
                    9ACF45F9BA5DEA6BC48B7CFA5EC3787499B8E6F8E88CD4572698298674BEC23D
                    D18CECEC304B370DC4F4D5AC525CAB19D8E9BD466363A3312FDE9432A2F6F0D3
                    ED9B8DFB9F5E8ECA1586A4ACBAC3598837E9518889FCBFE5525EE7C725E2F6B0
                    639AF92BD5F9ED552FB0573FB105706D3E371BC1B5D5A88DE2FA1DC9D7FBBEB3
                    9CCC28849A784EC2C56CA647F9AFE4F11ECD6E9A9A92E7702E1DB58767471CDE
                    D43B56A55F5FD5023BFD678624ACD116C9E7C87338D5108D4B3C7D474AE2BA9C
                    77280CB99CDB1693621A41712CDFC431621C203D75F6F425F05F4FCEB787754B
                    AAF06215452AAA15D8C9FBEB1B80AFB138A2B487BFA8F3F5B5A7EFDD62ECFDDE
                    B2701DCD99CC61929BC2E19AFF0A7C75845E173E75B689BBF3F4555A52E97C84
                    AFA3DCAD9E6A992A05767AEF16E26B14D7ED466304D702F2F57BCB3A8725AEDC
                    928495FFE87D921399797C3DC93993F6F09998BEA6A3FA0A3ED3AF64A6ABE51B
                    AC4E6027F718A4AFC1F754807378C796FAA39178D3D3F71BC6BEA797C5D72109
                    9EE4AB24ACCD9D485C02228B9A473B75C694489B717DCD996F8ED8C36060F3DC
                    3A6397E02BEAAB96A7BBFEC839690F6F698CD9C32DA9A8DDF4DAE5221903F492
                    FA2AFF11912AF02B525F3DC74C6B7C3D639AB6C7CD185F79CC1E2E8C6779DA7B
                    61661DD8C5F8FA897AE06B6D1897983D96AAD9DB6AD44471FD2ED8C39173F83B
                    F717575351189522AA6E2AAF7E110C9F892371FF75EAA4545C6E3645711DC9F1
                    B7F4C6F96AB26AAA47AD4260A7F76E257D0D71FDA2D1D06818755F88D8C3FFFC
                    7B29635FC41EBEDC914A1D2B4270A53DACF86AD92ADE74C9E5E333600FE7A4FF
                    AAF939674D5348A863B8025F27A2074053BA8A2CA7AA047672CFCDA4AF819F33
                    7DAC1E90AEFF52D41EBEDFA88FF839AF7D778F61743CB3F4B70B7E8E7090AE0E
                    C7FAA6C218F65B0D70A9B9DCD6701D306DF998742CFFEA984DD9B1385F9DEAAA
                    1FAF3A60A7F7A662FA3AF3082A6EC3D1E908AE600F5FD6BECBD7BEB7C748DDFB
                    7451B8428A4E005F953D7C519A4C82B334B71D3D232BCF616961D96668375DBB
                    269F2ECFEAA8DDF4829B4EBB2F6AEF5C05105711B0D370D04E521CB1F6EF025C
                    673FB71970AD7B346A37497DDD17F15F2F4BBEEE29220285FEABB48589AFE8AD
                    42C7644E7255BAB5A6D0F4F5B4BC0072A6760E5F1BCC5E1CF2CC5FCD4C2CCED7
                    F1D58F54540FB0AFECFDFC2BC057884BB4857144C957403AEABF4A5C5331142F
                    EF49A5EEFC4E117C1DF5A4DD2490B0AAEAE552463AAA963C85AD5CC41E1E90FA
                    2A157740C3957397C5E3C3E3AE6946F5F585ACF3D46A235B35C04ECA23F8734F
                    7F1EEDE1DBC27CCEF45144BAE65804D7CB1D5B8C3DDFD571FDDE7D92AFC5E82B
                    C4256C4B12160A2690AF57A05E4D525842AB478C25AEA0B89ABECE0E9A10A9F8
                    9598BEBABC296A0F5F72CDB7F4AD761F6DB5003BF980D1D850577B037DD5ECE1
                    02E82BD8C3DFD59FFE9D8ED4D63D45442A245FA1B449E26A4945852804D84D9C
                    098840D9A656172EF5D5649E6E0F4F0F70A9C1C23C128D0FE7A4BEEA276F61BC
                    37DDB4FA9E4F95003BB90721A578D3798DAF9B81AF7A5EFDDCF999EF746CA98F
                    FA39DF9DA7AF575F5910D7A11C673960ACA5F4B5703103A1260B23505A45B1F4
                    73B8E3E9E7F0F480BC001CDE9489FAAFCE3C7DCD49836B74D54B52AB03D8ABC7
                    A4A34AB798BE225FB5B8C493CDF55F007DFD6E24DE24F5F5DEA7755CA78E2D14
                    A9C07813984D3613547D88B832CB26BE92850CF49B3A933625B1CD93013BA5BE
                    620D54C46E9A1B75D366C41E9EBB94359B58156479AA02D8C97DC057C255E7EB
                    B1ADC0D7FA2F87B89E970F348C589EEE3BA0AF115CAF1EAD49ED2BCCE7AB2047
                    1550443F479EC3E0CF30409B93BE4E9CE5A385A9B31C0CAC98DD94937C8DD437
                    159E92FAEA8ECEE8E7B0CB4D365E05458BD5002C954A285CC33AD3C297F064AE
                    FB4218F7BFD082277314D7EFA13DACE33A7DD448B5CC6BB8C4923540154C5DEA
                    BB02FFD5B604B76DA6FAAE2052911D92F6B03C9FDF7C2660E734F0553E2D33A1
                    5F2EA34EDC1E1ECFF2A6EA88545401B093F76D0970ADD5F5B50665573B87FFFE
                    E66DF0A03DDFD5BFB9EFEF89F3159ED97E613EAEE0BF0ACAE7D0A98BFD1B4062
                    69EB2ABE9E847BE44D9A4D5A7FCEB501A85994FA1AD8C3856B0BD9C3C4D7AA88
                    40AD3EB093C70C23AAAF18A9207D6DA8D3FCD70B758874342EF19DFB5337C770
                    3DB6E5E696270A0BE22AE59407517E8C3709B0A46C3537E4A2F468051CD65031
                    93D7CF6113CA8EB313E1A93E70653C978EF2B570299B7EB31799A179E5D26AA1
                    BCEAC04A7BB821AAAFD3C7F6BD32377B0C2B28EA8E86F6F0F91A3C9AA3F1E1CB
                    FBE27C9DFC62BDD1F2C4F538AE907F95361303DC485F2F62E93011964EE6B133
                    708FF467C1C7D5ECE1617901487D0DE388AF8ECA031BF5357232BBF10CCF54C6
                    59AD59A9AB0DECB4C6578AFB4F3F526F1C7BFADC56E4AB760E3FDB8C7CDD13E3
                    EB965447EC1CDEB27921BEBAE0954A35E582BBC8D7B123525F255985ED77EC80
                    2505710ADBF2B8760E83BE327905847109E9E49892F6B14A1869603739917378
                    EA0CFF5536F10B09EC2B7B7C7D358CDB88AF4725A4F577D4623E47E72B39BAD1
                    7813DAC351BBE9F37546CB7C7D05FF15308518B13988B866B8642FB0531A5443
                    842B584CF038A6D7C15C1B00C399A7C3382294B13982A59D17E7EB6BA4B5F674
                    9AB3E1550A41AD2EB057237C9D46BED612CC31FFF5B956D2D730DE74FE3CE473
                    8C8E483EE7AAB487DB2EE8DFE5F4ACE2AB8DA73070767056E92B6AAEAFAF63A7
                    21626C0B2E3CDE7466CA7FD56B832624DFD399A03F07B3F41633237E8EB487D3
                    69E785882F3D004371A77F118FE2C97DF5813DBCE3EFF01CFED2960069E36818
                    3D3A0F0C6E303A42763EBBA5E60B92AFD13CDDF451C9D7272205E68FDC7B19E3
                    12C04E8BB23A7C607A2263A28D04D9567338B087D1A3E59CF274D360F8485CC1
                    F5D5E24D85516ECA07A6236AFADAB8CBD2FC45FD9DA52FCCF9F0AA858C5713D8
                    AB7BB7CCE36BC0E006BD2EFC390A366A71C427B71B70EB88DBC3A9E8393C7BAE
                    6E7387C4D5726C3C86115CCE4F66405FC194E2AAA218F80A7C968AABF475E234
                    7BA100E5FFE0FA84F1A6C228C3F299A8F57BA9372DF555FFE5A6CE984DAB88EB
                    6A023B795FC857DF1EAED7F8AAC59BC8A3D570BD509B428F361A6F7A54DAC34F
                    EAB84E3F52B3A5ED814F63562EA4AC078EAAC36C4299703D6922F090A5257D9D
                    1A30D3EED0308788715AC375083C1F16AB837941F29E451477421EF57CE4FAEA
                    7DBBAB07ECD5BDA1BED6629E6EFA9186E09E3AAD0EE639B0871B1BF684FAFACC
                    F6F8C90C2F78ECE654EC1C3E67A49A1FCBA0BE126EC049386D31E46FFBF1E1C2
                    45D0578184E554B78641450EA6AFB4B632175F0B70157005702FC0B5300B7C35
                    D351BF06F4958FAC6691F1AA013BF9677EDCDF305AB18F63FA682ACE5744E97C
                    3DD9C3215F9F40DBCAB83F92A7037D8DC69BA42166B43D8A3107CB3F8699AD98
                    0A7738AA2E7C42E2EA04028CB80E72546006E5A979ED1C46CFA7C909D4B4307A
                    FA22C41159445F27CE9A66F41C9EBD92B011B55AC05EFD5CDC1E9E79A42E8854
                    D47D19ECA6C2F9A3FF22F9DA88ECD4CEE1E77EBF81708DEBEBF60B91469F7375
                    A9ED8FF671D2571168AC850632FCD70CCF61A4B32427CDE59A82D42BBA431245
                    DD1E96169223CCDC0B018AE3399EED8D45A0E6A66188F560B4552FE91AC65502
                    76726FA8AF8AAF5F0CF5F516E2EB135BB61EBB0C6D1D8D91E8D2057C60CCCF99
                    3E6ACCB3879B8DD647F374C64629AB1C5A9FAFF934F7E018667E9DE9B53350DB
                    66C3A3E2FA9A73ACB416E51FCDA5E51B34455790CA03203E2AF571DE944B3652
                    B13AC04E47ECE198BE36923D5C38BFBDB1B1AE8588BD2F8C4B3CBB0391EE88D4
                    374DEFDD9C8A9DC3525FDB1EEB33A5A92454C23560AC7268D9E394CFC1F8307A
                    3F4A5FA15947622A896DA77B355C9D34347B846A8A7E9423D2B178D38019D357
                    184962263CA26F55809DD4F274EF26BE1EAB89EBEB05725D1B63FA7A8122C6F7
                    3F13DC73F9D9D7A6BF786B2CDEA4F4D5C2880481A4781A32979F99A57813DD25
                    8DE593FE398CE7B2C5B856B7F62AC425A4851C9EA98571E9CD4A0B5944F99A97
                    1E52F41C96B675E223FA5603D8ABFBB6C6F83A1BFAAF2ADE54B8B03D00BF51C3
                    F59936C5D710D73B6A1E39563FCF1EAE97F6701FF6BE0AD2D7A8C622E06C700A
                    D8892515D292527C3D239D211B9EE4B1A62CE8EB2C2461515F3DA6F75D8D437E
                    57BE458CAFE998FF2A7DE1A674E2A317570158C9D7C04A6A57F6B07F321BC6AD
                    5FC4F8F0139B4306EF094FDDBFDF8219592DDEF42F77A4205271478CAFCD92AF
                    D098AE188B0A1AA3AC9046F199BCB4AD2097673B6A6E0896AC49E3184E66E2EB
                    EC506E14F4953B39AE5949855147F2D569B263F630843C741B6E160E80E4476A
                    260FECD50752211789AF5F0AF95A83F6F0DC85DF0A71D5FAE99E27FF55B3A42E
                    DF8B2773DB13D17893D457690F537C58B9AD81D91452172315C2C21094EABB92
                    C060C41860977C050087202C3C946BE2303048B387A17E8AC5EC61798CA7D9B0
                    BE0C6F76983535ADC2A8D4C481D5EC6169FE9E9BF34B25747BF8B5F3F50BF2F5
                    093C9E8D3B42BE4EDE8111A8EDB17318F89AF1E3C314741281A31332971ADA31
                    53C7547C780023C6F0586E66AECCD1041179007B700C9B5A5C623C9796CFD4EC
                    6188544C9CE4667A30361A2A3642E8750AAC56B706B7F6276766347D55F1E10B
                    CDC163EA505F0B68633ED34C7C0D19FC5DE26BD46E9A79A426F5EEC732D28065
                    0A4031DF8FE5A4B236360048E2A507C0FA85C03D266DE5C99C46BECE4ABEA2CB
                    CBC01ED67075B01D5ABF6760627A201D5B220C7C8DEAEB544253DC12067632AC
                    33253EB69FC75209DD6E7AEDBC6621531CF1892F7E5FEA6B0DC511C378D3E516
                    2C3B8ED9C3E7C01EEEC3C89108908CFAB1EA60567465B620FF550203A95738BE
                    19F549BE2A71652A28A5DBC3A339D371245F43CF67DC7D733E6399F3ECA6185F
                    6707128A54240BECF47D5B75BE2298215F0DECE3283CD9163CA601E34D33D242
                    3EF6FDA7E91CD6E24DAFDC8F16725B349FF348FDE6D6C7FAAC303ECC102AE5AB
                    0A158920C02D1B4B26D4970F7CB5399DDB4D9931F93E33A3A4C9F2D51C790EBF
                    1AA2283D5A8BE7027BB870A91702CB6634AF2ECFE1185FAF490B39999A8A4481
                    9DFC5C7D63FCD6D0188B379D3762FAFA9A44BAA1BE8370BD33D4D7CBBF87FA1A
                    F573AE9FDB11C6878B252CCF2B7B184317586581F1A6D92161A2E042E5A9C6D7
                    171CCCF0B020D35E18CF36F15CCE34A371896116E7EBA069A2F7FCFA0276726F
                    9CAF3A75EBA9EFEA424B18BC405C0B4FB6187E4D85CED7EFEFC17B5AC24150DF
                    3F8FF6F0F6C7FAA82EDC3785E769AC501A2BD024968C1DB8260D1FF4730432FB
                    CD19B28773E0A8E2E5A055A9152E3950DC66DAE1997A294B23BF86E3FA6AC6F8
                    2A78D34032399F04819D3E7663581B8D5B95BED6EA7C857B9E6B0ECB8EEFD4CE
                    E136E4AB760E4F77D49F477D853C9D6E0A2F455969290DCF4E9F8505598AAFD8
                    7725FD1CE9A80ACCF0015F0B73B3583033CE4C27620FCF49BEC2B3CCE188FFFA
                    787C44DFEC60DA340713CAE52507ECE47DA945F8AAE2C39A3D5C8F756B7A044A
                    F77C2ECFB38727EFDD6218B529B29B5880A61DA0BA10636DAC7183645D5EFE11
                    C5D7EFBB9A1DC24264F9A09CE42B44210AA3701CC36A1E792984956C504E4C43
                    4A74FFF5DA088FF3750096305D9B7B9D013B19E6E91602F64B78219F6B8EF1B5
                    70A135BCE7DE67C2B8C4EFC7F5750AAF1BF25FC9CFE1BEB1E49FC5F158B12A6F
                    A3D6008E11650EF515A4AFA39298948D67E4BFBE3AEABE598C421C51622FB493
                    D96D62D882792DC24E289D9A8EEBEB6062B53249017B75DF227C95B74700B3E7
                    02763618F781575378F2B742BE6A79F5C93D464314D757F66CC593F9D13EC13D
                    11061135B358F7636DDF8F550900882162A6C0E7EB0C347059AA1F04E3C390CA
                    112CE74046966BFE2BD8C3504715EAEB2CC6FDE7E92B4F370D2657539110B057
                    A3FEEB7CC6DEF97C21EABFC2FCA6D72E6C0FCB8EC91E2E687C6DBB101C7DD3F7
                    6E6EF4F9AA69AAAD69AC88E46385622C656A6D0B0E6F7894B2872195E3A8620B
                    AA0B9F19F5E8C0158E950EFB73D0F3F16CDD1E1E1B9C9ABF726976C0345984AF
                    85B1C2DA07F6957DDB16E52BA6039E0BF595B2AD85E77E5FE32BEAEBD35FB82C
                    ADDF0E83621B81AD32F9096A99867893E6B7CE23ACEFC7FA805B84A68584C5D2
                    B626C255FA390A7307EA4C0B38418461EA5D7AB44E183196F630767185E7F044
                    9E9F1E74D2715C1D336A0FCF0EBA15EDDE4A04D8E9CF2D012BB2AD4D8FFBC3EF
                    7C4153DC3B9F87B3FA957B537FF68AEFBF6A8D797B6824C9A3FD6684AC37226C
                    6814DB1475B4844D1073AC83298C32EE40BC495E05E4BFD2D600B2A39B74CF27
                    9B96AA2C6D5D6D546A5AEA757CF4E2003038C2D711FE1676718D033BF9892D0D
                    8D4B23ABD9C380EBCCB3DB757D85EFF2F2EF190D757B76923D1CD6994EDE4FA3
                    C81FED87B884E6B70ACD8FB517F663A10046509E0E6CA7202EC139E0EA31F256
                    B155CF42CDF6748F76BC17064145966BE531E7135DF521714DA707A23EAEC59A
                    DC89B50DACD6C751CC4DE9ABE6E7185BA82EFCFB77A460F21EE1FA84AEAFC4D7
                    3ED3F230B7CA4BA7AC8DF5333C7F0DED2668E0C2E7FAFA9A8320329ED55A1D8C
                    B487D330DA58AB83B99249E3E88A3351BEA6391FBC1EE5AB99AE6CAD4CE5819D
                    DC77736369B8525C428F40611D0CB9AE748F660F4B7D455C1FEB132093BE41B4
                    A8C68A506385D25878B2FCEBE1698C3729ECA96E6DE629178B16A1CCC2C43862
                    013B72C6A5BECAD35BB389264E72EEC5E3FED70621C3138D35CAB31A93826B18
                    D8E9D2F8DAD84879F50BCDDB62F6F0BFDC7173D8201DF6BF4EDE4F23848E66E4
                    E9692F97B0A4B10CCA28461C3F41CFB9FBD48C3F9284097816D5851746B3D2A0
                    82B8048CE80BFD9C2B679AC0178AF3551ED7113F67FE90CD3508AC56B7561C61
                    3B2EA33DACF1B5E39FF11CD6F91ADA4D6A445F2BC4FD092655E3B42C8D852141
                    10ABC070244FDBC8CE518F5399B9903E2CF6494A17C71D1F97A7AECDA2A3C8B1
                    812B16F77F9CC5F57584F1A66CA5533C150676FAD8B69280351A8F16229145E8
                    A7435C3B36078D035A1DCC55B287B73F9631458EE6FAAC446321A0683B36393A
                    9445F7471C006454794A26939B958633D7F93A71BA89DB9E3ECAAD407C3507AE
                    EB030D86CC246A512B0BECE49E9AC6126FEDCF15E69E6BD3F8FAF40CEA6B9809
                    A0F8F06BF4FA1A5F1198656B2C3C59E0F011790D605E5DD9C39E89D93C0BCEE9
                    1711570C2A4A625B39AE9FC3D04F1019BD38353C31FB5F79DA8CD5A24ABEF646
                    D6A84D15D61AB025EB2B462A2E9CFFAD6D317BF8F21DE1A00A5A00F1FDF3FF02
                    717F8A403DD66FA287B952C2625B07BAB3306A91CEE15C1A2A28E082214B0AF9
                    2A50902379BA897C13545F4446F49999BC3CAB07F518F20CEA6B64ACF553F917
                    0B6B0BD8C9BD37978C2B247A5A757B789EBE225F27EFDF7C6C721AEB588DE647
                    F31C996AAD5863919994B9739F2A287D854885706C93A12535EE52E90C34E6E9
                    B89EC5864B4D5F61C401977C8DDAC323CC8C0D0183B90797D614B05A9F6469B7
                    809C86CF575D5FAFA3B41A46ED7DBFA7E24D19CE7248D5B2501615967BE3056D
                    B43198543E5FD3D098078F977C0D6C73581221EDE1B48EAB6982851CB587A59F
                    C3A37C1D1566DABDB89680D5EB4C97773376E29CDACBF7C7EDE157F6F8351560
                    37F59BC4392A575A99C64A1A52254C66CA5F1D007FB673695F5FB9EAB6F4F4FC
                    EB541E47F4E97C050B59C4F2EAB3C3AEF9AB117BB830E47089EB5A3A8AAF7E79
                    997C0D23152A8E786FD81440FAAAB74C439F241639803BC257E8C72A8DB5E198
                    1D9E2DBC00FAAA7A78A8B343EA2BBDA8B4AD30B75A406CA15F0F8252FA883E18
                    8A2B2D295D5F0B23600FEB43FB60CAAED95B919071A580D5E6862C13D73AF273
                    2E2FA0AFE13D181FE668C9E2BF56ACB18AB2F2EC1D1801142D013D3C261FF5ED
                    61BFD1C77C9C96098CD25C12186D1C398739E4DE07E7E96B26BABEC7E2A65B99
                    E16D1502767E9D69C937AA83B98CA5FEC4608A23BEA2B574ED782C837EA7A566
                    9AF2F298C548598EA58884B8373AE7EB2B0E3B66D49F5318CBFF3B313E7612EC
                    6133AEAFC0D798BE72338AEB534CF2B542EB2C2B03ECE4E78C861512D6388A5E
                    8DAEAF68377DFF1361EC02F2749C46D58A956AACD03456D0542005B8482BBEF6
                    52D9314E27C1FCEBC5BC29DDA20C8CD464FAC8AF93708670CD7F2D105F634B22
                    86A447EB5E9A5B43C06A737E967F6B7F16EDE1C6687CF8EA9E3062BCFDB10CD6
                    85DB2B27EC3C8D852B44502A8FBB6437414A9D518E16FD9CC2183584F0D86A9E
                    29790EDB0ED3E2FE532313A0AF3CB684C94BF3A8BE5E2B5437B0939FAF6B5CF9
                    4D2AAACED7B6BF075C5FD15AA6B12E1CEBD12AA1B1584A8E3DB281BECABFC7D6
                    016E0E0366131953504397171B598D35C6615C42DE737238976E8A2D7511BCC9
                    8B94C75CCA97B1A6A202C046FA2457826CFBEF85FA4AF1E1C82872BF2E9C9783
                    B2113F16BA7EA85B4BF2953C5A8837D1A85421F90AB8C2C86A465E5664350F14
                    37319DAF3014174215D121D643CC34B317F5F1286399263E5EC5C0BEF2B9B2C0
                    DAA8D754287D7D456730CC0DB1512F793934D68E6BAC45C7AE13DAC316C2CDA9
                    2E1C476A4227817C673336B2DAD6F5F5DA205445994DD173782817D7D74B596E
                    A647AB17D8E9BD5BCB056C630CD7C93D46D0F8DE26ED61F25FCB4CD85063E97A
                    C84E215F9B181DD792C2E8BF4EE4D528376EEBF588D74EA661B4B1C6571C8A6B
                    3B3C92578779516636A2AF63F9749333345BB5C04E1E352A812B9EC3117DEDC7
                    3DA15605359642136C781AEC61A6B23F8A8B57F25CBD8AA7EC618C545C1B80D3
                    9AF330FF0A11635CEA12F3734CC9D7C8399CE5693654BDC6D364F9F9EAC78727
                    3BA2FA0A39368BE8272AA2B1F802E0D98C664D7565582AAF2EE9C5E9ED7CBE4E
                    9C9547362C4D93E7B056178EB87A567CE9B714DD4CE41C1ECB98E9DC6839977F
                    9417D8E963758D65E76BDB73C8D74F44F94A95FBC4BE8A682C3E0963C282B6B7
                    D8DC334DDF6E120E8E057354BC69EAA4E98DE39C03A1D7409185CCD37D517D75
                    E3FA3A96E1B407A84A81BD5A017D6D34EE9B9DF35769F97CCD00ACC2EFCFA88C
                    1F8B4F92F48512288780267DA5117DF4762ADE343520FD1BF734442A78D399A8
                    BE4AECB3813D4C45CBA0AF91951092AFA2CC8DEEE50476F2D84AE34D0BDEDA9E
                    794DD7D70688FBC3FE579B074DAF95D0587A12018F48FB75E1B80C0FCBCB3D35
                    B27A6A00CB9F70459A660FE3D234BFB980183C7405F609C4F87A51EAABB63DDC
                    2F82AC1A6027F76D312A806BA371C785EFDFBF35C8C8427C186B58CA4AD998C6
                    EA942532FB7D57B8E4D0A686105F5F07B849E3671C53F75F0768ED6188EBEC00
                    CB0F8B05ECE1E8F28FC2E89195D3B77CC04E57C01EF635754F6334DEE400D398
                    9A7D69F3CAC48A49636DAA3886BCBA6F0F73727C8211B8E4BA824BCBB9CE577C
                    B63664F3DA30372D66BE259ACFB998E14D7C2882ABF52BEE58D5003BB9375521
                    5C1B55F53FFEB443DAC3EABB4F4063B19F5D11D619F1F5D5B1E074F7E388387A
                    D1A21894D677353548A3C8C3E55AD3C3E40B45E3C35732699345D6E3C1FA1EBE
                    62CA960BD845E710940FE1ED8FE6A16E4D65D62AA7B12CA39A6C19FE2DBC1992
                    E84A5E0DA8B6200A81A3A1CE70D50F6247FCD7419CB4A90DB19E7D5C3ED58EDB
                    C392AFE97404D717C00EAB9AA378D13904E523AEAA33656AA2A9A894C6B2BEAE
                    BE1C5D0FBEC60A3E724DE20AE141BA23E0ABA9C6F8A93E49DC1C8BB87A4CAB33
                    85B60EE63866B40E46FAAFA613B19BC6E515135DF3B29AC02EA7CE741937690F
                    9B3C075FB65F92583E8D8DF8B17D9DCD2D7D8C0A514963E10C1D1E3D6B62173C
                    6EFF3813E8AB509B99505FAF0D4AB6417C18FCD7B06E0D46DB822F14AD5B437B
                    387A0EC3C2C472783E6501F695BD9B1B2A0FABE46B9FE57FDB95232CF0757F5D
                    AAAEDBC349D44458FC5BEE527C18DE17F95A005CD55B28BE4A48C5A5A9411306
                    CB68FA0AA3A885748F627144C9D7A83DFCA26BA6CBB3A6B41CC026C35703F771
                    50F7318AA4A884C6C243FA0ED41A2D5D7D0E5E0CF4B784BA1A4763F92B0D61B4
                    B17F2830C4751AEA4BDD0CF675E9EB2C87B11E43E32B0C26BB98379BA2FE2BCE
                    442E4FF97819809DAC44BC69017D7DA08F0941D85490B2C2E9FBA491AA3DD8C7
                    44F0304559D56C60FBABEF405FD5400B55DF740D87806154836975E130F249D8
                    BABECE8C4FC97338CDA3EC7C111783EBDFEDF26B2A560E6C42F670F397338103
                    69574E6399D5BBBFD968EBCA84BB3E2C42D5F2E7B8D9AA0E06ED613ABB6DAA47
                    04C3D701E071E8BC660F33E8D04C87F67061D4393D7E9ACDE3ABFC0D239980B1
                    93CBAEA95831B02BAF0B2F4E5F1F90FEAB907EA53FC7A7BC84F56750580EE86B
                    F3C10CD31E66F94CB5E93FE6C989D01EC60324ADF45592152BA53C35C49A58F7
                    3803BEA6C3B8047418C8733DA6AFE3525FDDC85A26D8C037BE4AC026A5AF5FEE
                    93CE024482FC313E15D05818BED77BA0769BE42BA7A17DEA21CC1F2E830DB126
                    46F929DE44924F75E130A1CBB16D5A7B18B38739D390C6F5780CE2C3917893F4
                    5FA3F6F0983CABCDD1D50156F235097D6DC639B518BAB583C15B65D758B487EB
                    5375073378E8E2C39CAC47978B45469B7C79EF12D9C3A6A3D632D1398C4D58A0
                    0882E928C2DA4318DCA69DC3431E251D237C7D21679ADE788CAF2BC8E5AD0CD8
                    E907B626C1D7DA0768BE3F1056F873B7CAACB1F870B087DBBA7A85BA12E4DF3D
                    78E0B0174CEF230B0A72011047C40135B663713A87A53DECD100644675A65453
                    3188F5A95ADF15AE8BF6E2F91CE0AB13D1D72BD9261E895D2408ECE4E7B724A2
                    AF5FEE53D30380B07625088BD6B6D7B7DFD85CDBD597E3349F5A3EE970A7B1AB
                    D756B3BC6005299CC77CF892A421BE9780C93FD7C8CF51AD61C0D73194D6D1D7
                    28DEE4315D5FA1D30BAED1E85A612FAEAF63797F036AF2C026A6AFBDD209511B
                    24B1D4A8021A2BB1047D057BD82FA492CF7BA8B3D6A83D9EE5FE25C4212B2005
                    D36564A08325857C8599980EBD11A73C9D445A8C4FA3FF2AEFD1CEE11C68B319
                    8B3739600F47F5B5898B95D454AC00D8C9BD3509F195F9FB5FE5F72A2A445966
                    4B7B7873EDC10CF30BA9B8FD5067DDD69A837926FCB1B882E652ABEE0FF93F33
                    4DFA3A687175DEFB7C856D00D9334C12DB319DA83DEC096AA20E6E2FE6D2E9E8
                    00BEA9FC4A6BDB960FECD507B624C2D707FA4CE171BF9E41296CD93556FA3907
                    EA90AFEAD8958F07BEDE763C23B87A315CC8032F43E36E61662ACDD1BB36AC4A
                    B060701BDAC3E0D142D8423EC44EEBF6B0301D8769F1E1C2F814F8AF66345231
                    E6A65914D74221296027F7DE9C085F1FEB13AA3EA5921A2BEDE14FD6A6EABA7A
                    99FFA242E22A3D5A8854F884458DA579F3342E53D9C3D383925E6A7805C59BA6
                    81AF6A33B8D627F92AF015083FA2AD3DCC8F644D739EBE466D2BA9D5A5462A96
                    0B6C42F670F303D8C7214448D9CA682CDAC307FB981D1C030FEDAF355ABB3274
                    14F81A0B9716BE3F6578545C82961C02AD4D1C767CED714B35D24A5C75BEE2E4
                    039DAFA3D25595AF1365E71579271B7955C77530B6F1B262C04E7EFED60460C5
                    FA612C826115A4ACA7FC57C9CE9C159CE387255F417169B885A6B1F4EEF8B061
                    DFCFA13950525FC96E1AC4D21ADC36D014F2152632425994B6FC0366E542D628
                    128590FE6B4C5F671F67E6AF0CCC2400ECF4DE64F4F5609FAA38A229C31A61CB
                    A6B1CCCDBB9EE2ABBFBD5D3EFCA14F4ABE3E9681AC83626CD6531A8B848557CB
                    81AD3B3BE0EF241536D59982BE7A4458B087433F47401BA68619CCF2B322E354
                    E176312B8FEBC8BAAD57A58447C7F8550AD8AB0F24121F6EFE723FE7A46C9523
                    AC7BA2637FBEB33655DB95A1162BBC28405F6B0E1E4182523AE0A1E37D9E1D10
                    960EE6E159F473480AFCA1F3D7060459CDF249698852D154749CC86879DC1C9D
                    D57085DF23161FCECFE3EBB0BF61BCD2C05EDD9B4A24DE7410F7AB93B215AFB1
                    FE38F885D678883863B9DBDFBEB9F68E5B245F33CC7F281787A53DDCDA7D84FC
                    567CB4F3A9E696C3F4E7C0F9617CF0E230C4956CCA0DE03C9859B09073F40813
                    E34DAF8E4A4642BB8E83FAAA793E69496133125994FACA35DB8ACE6153952F57
                    1AD80AD585CFB3878FF5434120639AC616E3C7D23DE1F478758AEB4C0DB9EBF6
                    DF694011E46D109750BBDBB923FD9C94D19557A1267896F3409B51DFE532DC00
                    A1DE0032EF598E03BE603201E92BFAAFCADBA5BAB5C21017976647455A921AAA
                    0F0B215FA15E355AB73631AF2700D7949E297D4944E9C04EEF4DA46E0DEC61A8
                    94A0704FA8B14BF9B1BEA8FA1B95ECE02016DA7E25029CB9A7DA7168DF8E2E18
                    76AC42C4186F820C0F9C0A4458E740AB611C8058A3760460988996E181EB43B8
                    6269934DAE0FC69BC06432DDC12CD654B0A157B57378FE1AF02BD2F389ADB31C
                    34D586F14A037BF5685D63027C457B188956A2C62A3E05EB80B9D07E8E11D6ED
                    EF68C0C3E1604684EA8CFADA951782D629C917EE3DD066D474F679FEEBF9EFAB
                    AE1148FA517D13D8C3A8BE8099077613984CD0F4633226F9FA54445F1D9DAF85
                    8B5392AF69D3899EC3C35EBA296237CD142A03ECD5BD5B93B2872DA1F265BC24
                    3F56A7A8A592410165B9BF5609F5F5540B0EB16E3ED8CB58A0CEBDA0AFC73342
                    953BC1344C896BFD81BCA7E4D9CF09901ED37B9858670A96940D5B5D84274F69
                    3A8771542A3855BAB70A335585234C6D2DD3F891FC7886F3797C8D8DD49C1D29
                    D29F2D11D8A4EA600E625F3355F096E8C7CEA3ACBD3065495FE59B81BEDA2A93
                    6EA1BED61ECC6358841EEA1C6CDD56D399CF45D6BAF8E2800F6269A5AF02C7C8
                    C08022D2D7191C430F614B581D3034A39FC3F2CAD2820EE3D9B4A4753A9AA72B
                    803D7C32B6CED21DAD00B057F76D49A46E4DFA39CCC620008B6BAC285163854E
                    584D6399DB4F5B2E771CEC43EB87C057FA2A842A29B691AF7507F2422B6E0BCF
                    608C23DB34970B22C61E1599DB54B756788A8680A1856C6B7109374DF7847CCD
                    C2DECBB83D3CC063FEEBAB8366BA69B0507660278F2653177EB0CF54231FAC95
                    6BACF6B3BE284BEA2B0DB1EEEA53AFE0F4BBDE439DCD29E3509EE10E007C7AEF
                    81D6ADF5FBFB722CA86E73BC209C4C47BD64DE1C65641939B03CE4AB3A74A0AF
                    598B4B602DA31BC1150D8A687C7884A5D367A34B98B8699EBC5276C64E7F2E95
                    4C7CB85F50158AAFB1C5F9B151C6FABBEDD483991A90EA032DFDD79412734162
                    E99EDAF91F4F75DE461959615B843FD8C3B71CC8FBA167F07CBAA51515682C5D
                    488F53A4C2EFE692FAAA9630D1FE4458F18EC36742BB490D30F7CF61CAD146F5
                    7520523A35476B4A79B111A812809D4EC67F257B98A99AD0A8C62EEAC772E16B
                    1F170B849E54C5031DC8215F33943BE2704FFDEE3A8840210BC9FB917C4DD574
                    669C20C2C1DCEE9676AC9651571A8D331EBE08DB9D69A241A8AF0435F8AF186F
                    2A8C8E17485FBD285F21CD6E457B78245FAD743ABA0E649095B0ACA7786027F7
                    26A2AFD26E82A080A5EA4159D17EACA027A8A0E10281A75063258A2D38C45ADA
                    C33921E89EBB5206BE7D06875A0832A5405F1FC86B4B86DD43ED46EA40561952
                    42A5E6B0A6C2F3388E36A03C5DE1A91CDAC3F0C9083308F95F9A792187F3BDB4
                    7AFF711CC6C8A375307000A4E7F375A0688FB66860A78F2621AF8DF21C0E878E
                    96A4B1FEB411CB777BFC9DB1F38C62E9BFEEC6B587525F29D92BBCFE0E087F1B
                    755D79C20B1FD87BF04D29B0874357D8ED6E37EA3B7A1CFF4457D7156C755173
                    52037D0521B5B0E0CD3415AEA6991D94A72E5C0EFA1A3534A5BD085F67A4BE9A
                    67636B5E7829CB3F3614CDD7FA44CEE107FA39EA250A6C697EAC7A42D48FB5A3
                    66311ED4525F0D5F5FF16AE15EFF4E3C8E245F85A50083F8F00EB087733C906C
                    B7AB659BD1D9EF0A9FFFC2BFB06C1A6D2C02BE3A69BC3E415F45B00E04B66831
                    A9AFD135A538162CE4EBD4D4DCEC7F957C8DFB399C47228B4BD4546C289AAFC9
                    F45DF5E1441D9B6B942DD68FD529BB981FEB9EBA139744B476F562F5B0A49952
                    5CE3789E3C1FE014EAABB1BF3FC783C3DC3D0E7CED7779D027E053963155884C
                    7D573343E8E7C8CBD3925612F27508CB502D0A46EBFA8AF6B0A6AF63F9B313B0
                    063C82A244DA8C46A096AAA9280ED8ABCBDAC751B2BED63ED0275418F1861A2B
                    16D1D822FCD8DE8CDBD7824B846B0FF65249ABB4A4EE04BE1AADE0D11261E59B
                    F5A2FFDAA7ADA275A4BE4ABEE6784858FC60542C83A976EA930476AAA228F95A
                    43B8F6503AAA688271DB8CE82B4E98D7D76D0DA4B9CBE2FA0A6B0F230C7E75D8
                    5CBCA6A2286093AA337D00F6D3B1186197A3B1F308AB1EC1B3C73B4FD05AE1B6
                    AE2C2D369327F39E5B10E96EB487559562EFA75A53F5FBFBBDD0A6EE95FABAB9
                    E3D30EB36F4058F9FF0CE5E97254D86ED94EDA841AD299A7600E187D2EA9AF41
                    A4E2C52CCE1DF2C27378E2346E298DE9EBA0443AC657CEDF72726685C04E7E2E
                    117D6DA5B83F9BAFB1C5F9B1C26770E8C32AF7C6F64B23327FBEAD1EB7FA48BE
                    66E9C897FEEB5D5B29620C6DAD7059787937A7E24D5AF994D38D7CF5A0ED8E4E
                    08D70B34D652170FA9A9C00A0A5C26E00CD1924353C1CFF590E0A52C0CD430B5
                    7813ACB374A4C39489A29836A319D9C2084FF333632B3C8A13E26BED973F6D0A
                    E1F36C618D5DDC8FB5833CE9BC120A726DB33DDBA54B43FA9A5178F9FA5AF758
                    063B786CE6F575EECFECDF21F5359F0B60257B7867BFAB560F4BB5CC9EE8A382
                    B55063A1A6025B73E8DD1DAA35947CA5352F162EE00A23505993CEEAD06E3A8B
                    26467499C0AB106F8A461661BD40FECA0A8DA7A4EAC28F61C856C9E5F2FC5855
                    E534BFE689027DD96EDA8568507106FEBDDBBF732B59C8508F88018553FBB7D6
                    EE6C356A0FF4B130E7E774B748BE9E72F1BAC17B33DD6D2D87231A0BA2313C05
                    AD747EC216EB1161FE006678205BA0C65AC3BFC72962CCB473F82C84AA5874B4
                    31AE293D195D07C2978E402D096C52F6F0037D26599176D0895CB2C65A81A8CE
                    23ACFC31736287DA99D726ED617C3DE46B03E92BE344D8FECE1AA8A9303AF39E
                    50C7BAB487255FB7EDFC8ACBFDD43DCF74ED30B67E32CB83BA566AB4E7798F2B
                    8165C457ECDF1016B9D4DE10AD1760E3B3E3599C7C6087F54D1367A05F2F5607
                    333B0C6B4AE3FA6AE6975AD6B314B0939FBF3911FFF5CB7D82FC3E65D92ECF8F
                    F5EDE07975C5F27F99EE1ABA428DBA83AADE1F2B9E5006302E01860DCB774263
                    A8E46B3E1716AEB95D525F3BFA1D1E5C2B999E5623B5BBDF5516B8A5EA9E2C70
                    54E984F1C81EC6540EFE6AB6CAAB172E654CD31DCE60048A47F86ADA0E8FF115
                    E24D110B7906D6469C5C72FDEC12C04EEF3592CAABA31569051D8BCBF2636F4C
                    59E983AA9DEFD027C984E7C0985A650F371FCFA893DBEBDB57070C96F6B0232F
                    1D3FB2DCDDBE6DF3EEFE1CF323203CDF5D878A1B8441681A36151F53F499FA9A
                    218E8855C8F2339A1EE18AC91D689BB42483B5759638B25A8B4240A4E2F1B8BE
                    CA73989BD1B511CB0076F25802753006D4AD71AC60607E2A4C2CCB8F6561943F
                    A6B192AFB50AD75A5053A75F9E1050F104ECAC399051BEAE77B2132E64A89710
                    82F96AAAF4D5B17C7FCA76BBDB0C63E7492F28880C18EB0FD684BAF05955FCEF
                    81C105BDCFB4462D430348C01ED6F51596BA08A68D4A1D3B79666CD08CC51167
                    864D690F47701D5F70D5D686C5F535A9BE2B4E7D5796723A89AD65D35861674F
                    A8DDA5C676C957E6F5DC755F9FDBDF499ECFF1BCA0CC81D3DFD98C57DA7E3C87
                    955482BE1A929D41D9A9D4D756A3FECE7E97EBBD232C28BAC18A27F46166465D
                    AE124B8E5AA376A9D7E46A5710D3E212B0A61486E286EC9C3A99E6AEF483A315
                    4F2310BBD0F5B5304AE9E05280BD9AD0DC10F45FC9DE5523FE156C45FBB1623E
                    63F5F40ECF76A9DDE0C62F43DCDFEBE99014ECDAA922C647C8D2154E9EF85A7B
                    20C3E80340DE0DFDD78E7E8F0709C0EC89DB52A9DD276991AC083456A8A483FC
                    D161C25F2B1C4CFCC2BAF082745D194D0A63BAFF3A954FC30455AD0E064F66A9
                    D8B18A2773FE9AD2F45BCECC96046C827D57C2B1C8412541B4D4415BB41F1BFC
                    572C58572CF9BAD5D75779047B3D3BEBA509751BA2D82AED61EADA90FE6B0DF2
                    15EC261BDB3832599695FABAED0F809D42052BC11EAEDF8D1EAD82DAF1480F98
                    E593D71AF1F5555D5E6ADE1A94C050A194D0EB25C64EE303B5F8F0D8595AF312
                    8D188F58717D1DB5F8C223356F0CECE4D12D09CDE5B2B84A9E29775F6DCCB044
                    B17EAC08FF1B246035A3F8C8A11AE5BFD61D947C75BED2019036205FEB0FE6E9
                    5AB03DB2871B6AF7F7399CE6211FE9EACAF7B41B8D181F265633CB3DDEBAC5D8
                    7D2A67F930DACE6135DD80D16431F86883B3B8E30CF51546BA297B1897BA60C4
                    8B6ADB0AA1BE4A7B38B4752706C8C08AA8A9D4579345D7F7C0DA432C872C1ED8
                    E9BD89CE0D09092BEC28618BD058EDBF81C686E5146E4F9B11E5ABB6A6B42BA3
                    D07732640F1B07FA73F0AEF295F2076AEBF7B7A5364BFF95A9C13FDCCE74FFB2
                    517F573F2E0856ED9587DA77424D85C5E834A6E97C831358124E179FAA8CB9E4
                    F260A50CE9EB04183E53A0AF395D5FC74E628E36EAD1CE8C38F3F80A21CA8573
                    01370276FAF3B549E82BF65D9190220F03CAF292FC58FDBF9AC6A20866BB7D3F
                    07E78638FDBBC3B1D6359FCA53B114CFE53B31625CB3BFDFB3280495EFAAC5F6
                    8FCE7EC7E72B17BD3DF20447BE2AD7C7721EBCCBF85F3A33D448C949F0A5C8F2
                    3C624F11635C7B3877290333C8A8B68DE288637971A93075C6E49EA3EBEBD419
                    0B86BE99A7E311631E5FF3D26466C74BF263A78F25C657F925A090DA37A26C11
                    7E6CECBF56D00E09115DDFCF693E98656037D5846F0FF9575CCF21F5B556E92B
                    7826F0AE9903CD9806EAE8772DA118CB328776183577225FFD78F0A18E46A3E5
                    84AB82C16A10058C05E27E5A49F155859AE85225BEE6E5413A0413CA99906AEA
                    336FE2B48943C00662F6B0195FDF23D4E6BDE281BDFAF9E4E623D280C218616F
                    ACB162718D8DE663A5F973C8B7876F237B58E36B1DD4850BC8923A7EBC697F5F
                    CEA65C3BF2B5B1B1BEA32FC782DE3CB0878D0EB0ADB0BE0532E40FB6D76F6E3B
                    D54B6FCDFC561EA6441E4F03CFB78771AD30FAAF18BB18CB63DBB32467D41E86
                    ED2F8EBE306F7616F2AF317D9D93F6B0195DCB54580AD8E97D49F535433FF912
                    842D4D63A3F958E69E68DE16C49BE481DBB333E8C437DE0D7D57ACAF5F4A65FF
                    813A83F8EA71226CE620F17537469754AD14F8AFC69D740FD9C4CEA13B1B8D3B
                    7A5CF551A81699217CBE11AD2A63C65DAE7ABCFC3E8E8B7998C587714C1D4598
                    4E0F0BA7C38AE2D991B31747A142F14AD46E32A3FA1A8D546C58302ED19000AE
                    0DA8AF9E45332817D5D81BF9B18B3116299EEDDEA1E92BF34E687CC53E49D6DF
                    D9D9E76588AFF5FBFB984ABEE7BB00E9C6BA8EFE9CCAFA811576A29532B27E2C
                    84497DAD4FB59EC832B5A64769ACED0FAE08EBC22F65D07D41BB8A6A6526705C
                    39F6F271ADAF79E20C878871FAF4849ECC71799AC7E31269DE1BE1EBB8ABD754
                    6C58E81C4ECC7FB51CE10F010E295BBC1F1BF4D0C4FEEBD71567BB437DCDA0BE
                    D6E9F63058C89D467DE78903F030AA0B4757C4F6F9BAB33FC7855F3D9CE9BECD
                    D80CF6B008703D74679DD12E710DB2524A63FD3678A1702D601C91B682709A8F
                    38913719B9B38CC7F90A6B0FC37378049A3F4C331F5F2B4CEDF221AE2CDD9499
                    5D04D8E9CF25D327F9403F575DC46A2F4AC97EAC6FF75A612F4DA4AE38DBD5E6
                    3BCB50DDEF4A3F27B487A5FF8A2693D150DB86918A9ACE7E0C4A0821F298086A
                    3080AF1431CCBA2CDB532B2DA953393A0B70B1DD83ED46AAFD842B541AD9661E
                    FD0544D07CC262A4E2A2E42B2EE1934612D5C15C39CBB99FB5D5AA5E26CEE2AF
                    6F66345C85094385F21385A83DCC339118F178366DBA438B3036A17C0ED8C3C1
                    DC1674644BD75816D43AE9598080BAD913B7D0AF02622EFD9C4F77E8FE6B1E66
                    C574D6607F2CF8AFB742DF159E074EF6E0764D5FE1E53207FE63BEBBCD48ED54
                    8A8B6FE41CDA2DEDE19E2CA31603F8EC87FB444858F2691F9F852F9D07B2E1AF
                    B334794EFD06667EAAA0F9AFC160FA2099E3383C6E0FCB6779517D75E4E38616
                    D1D8E9A349F47134E0FCE19C3F6C0935CCA7AC28D28FB583FC2BAD56B21D8B85
                    7D92F2E4ECDA1ED8C3198B47F5F5605E5A52FD9D752183F767728C12B7F9AE7A
                    B287495FE55BF477D5D676DE869E0FB782C016E86BDBA96C104814CEE13FB8AB
                    C7561AEB57AEF3E16B173369EED14BA93E0E582BECF7C4FF3BE4EB458C549C49
                    038A1A8391AF90D68F9EC3DCE4D178D325B7291D8D2CC680BDBA2FA13AD30C13
                    82E9942D2A567C43CA62076A24562CFDD794B28721D99B3BD151E75FB1304944
                    7EF592AF01AEB71CE8A7894E929D075171A12E5CE5D77AA5E2CA5BEAAE53AE3F
                    2D08F96A187780FF2AFC4CEC439D755B76E72966180EA8E1677A155FB91FF7C7
                    F578547BA1ECE1B18C189F994021E6ECCCA46E37B1782F25CCED4BF78E473277
                    F29573D188F186385F937060A18F03E686A87F88B076897E6C98CD51652E42B3
                    8A59B65BC5111BEBBA7AE539ACEB2BD8C3CCEEEBBC25BC47DABA5CC5110F22DC
                    46C7A721CA8F483F86AE303C266C9E14525F8D5D27DC00441849529FAAEBCEF8
                    EBD0E803A9DD1F1679BEA4AF70E00A65BAA33D5C902613452AB0E2493F87415F
                    17B087B3517D85A1F3B14C4004D8ABC75289CDD113D60D08BB1C8DD5AD27644F
                    B63B3865EBBA3C790E77D647ED61D1D3591B30B816F415274C88CCC11D3E5F55
                    E765162DE486CDED708F9F0E047D4DB5803DCC1461718450CBF16CB413D7A612
                    577A96D4D75791AFA1E252D4F04A1EDA9E2D8E8FD5F47518B243F231C139FCEA
                    35482DE86B2310D7DC02CB7A3624AEAF842BC477C4821A5BAC1FAB696C10AAF0
                    F339215FE5FBED3AE4F4DFE5F3D530EA91AF117DED94B8F20CA4EFFC78D3EE4F
                    3B2AC29FC17B1AF0640EA31F0FEEAE4FED3A858A4BC7B038FC5E63736D77D66F
                    3C08345604A26F529EEE22246EE8B5D5198B2E0EAEEA7322CB044618961D67C2
                    31F4C367A75EE069331B89235E729A62433663C026D5C7F1583F5723BC8BA3EC
                    127EEC7CCA4A7DD515C5D875E0BE10E666C94EEEF57636077C85FC2B67994F75
                    F6789490C73A53C5CE2C9A60D21E3EE5F9563CE9EB16690F073E2EB70F4B7D6D
                    8352C758F37CD8A1ABFA38C6A4E7438DEF8E4867C01E46C555BF223F13F15F1D
                    C9F293FA7A3C9E754D89EB6B11BEC68758C7804D4A5FA53D2C1C4B855135C296
                    9A8FD5343612A16054171EF1AD42BEDED29DE7CCEBEF0C765418F5D21EE6A24F
                    42DAD9D385FA5AD3F11547B9A1192ABD007B58F87B3C245FDBEB8D5DA7B2EA14
                    81DA8B0777D76CAE3D71C4F247D44402256470919309F6B067539B0259BF17F3
                    9CBAF761A1CF99A8BE0AA6AFEF19C63115F3F435BD60E66E43C8D784FA24FB84
                    DFE9523E3F364258BF2E5C7BD7E0A7ED303704E430F85DEBF6497B58F449216D
                    A86D6F0BF2397401F5A2BE36A6EE220B59FE9375590EF4B5EDB8DFFC0C771FEE
                    A8335ABAB37EA2DDCFF7EBC16B3E3CE39FBA9C2E60EABB02BE1261E5557352D7
                    5758E16246228B908D4FBB517BD831A3EB67E3C026C3D706E340BF9ADB11D358
                    BBE47CEC8D34367BA2E546BF0AF6353347E7EBD6FD30BF09AA5DD4FEE1066367
                    8F472BDA39E96B23218D9FC13D7E28DB7357BDD17ECAB58239C6E2C1CEBA54DD
                    F12C6D7981FBDCFE3E5B672CBC18CC2287821746A56C2A8B0E45E2188B86E595
                    A7F57318AAA5D2A7357D05C5957C8DEAABDB7483F9400AD8C297B62492A8BB2F
                    CFD5C0B31B5376397E6C40599EEDBEE1156A34C37C7FD821DAA8D9C3F2C97D07
                    6A75CF27A78A08330794BEF67B8CC4347BBCB9FEC02E23D50AF1A6608E31F0B5
                    0DF84A197AE9D5F4ED6C3F9C8B5056DE86A7A1400D871C713FEE0FB146AACAF4
                    17E6CDC21C21387521627C26A2AF39A89788D9C3F1A1F37160BF9388BE1ABBB0
                    8D985355B5BD88515C9A1F1B6A2CE8EB0DDFBDF6780676B0E8FA0AF161A18889
                    47CAE6DD5F71F0AC041ADFE6F3157B7A245B4EECC29A8AF653BD3CE800600FED
                    AE4DB51ECFD0F607AC8AEB7FEF2D9BEF74FC5935349B1EF6419FE5B856180E20
                    650F9F76E041F844BA67765042B7903D8CC3C979544DC721DEF4E2A205E3890C
                    5C933E3E165F8A4509BB028D65565017BE800CD4BD17A2867DFB427BF8D60319
                    C9C5CCC1ED215F3B4E4175041523125FEFA43A53796FF6383A51DBDABA5D118C
                    B6660FDD778BB1BD3BABB63D005F4FEE348C6618F7E6C74DB070C2E19053C703
                    DD51A3DCC81E569BD530622C8534DDFBE2085C5A6A859EAEAFD13A98C2A5EC82
                    F6B00EEC647D22B8D61EF282119537D458B1023F367BA2EDC65768DD4117F239
                    5A046A3F4483F35DA1AD55BFBBCFE5944B931E2DA4E8EBE5394CD95DC9D7764C
                    03419E2E5818230EEFAE4BDD7622E30F3481FEBDDDB7A46ABA4E07B5EC6A79A6
                    25AF217FE9968959745CF84E76B6B28761560C1EC250F1A4D9C3830C37718676
                    D3EC3538879B1659E64EC05E4886B06D191E0C95BDB11F5B623E56A3AC7443B7
                    2DF2FEBB1E74204F17EAAB743B45EF81668DAF906DEDCB48BAF4520A01FC5755
                    1C97EDC66682ADAD27B21054562D00873B6E91F670C62FDF90FFCE4BBEEE908A
                    2B82EE13FC88CA62464FC8D7D734F7738E4A5F87B9A9D6FA70165D7B08965418
                    F79F193939359635CD45964313B05F4806D8376582E99295F063EDFC9ED4A2EF
                    DFFE492DDE64C01C02BBAF4BB39B308BFED0270FF4D8193F02E5E7E9B832B625
                    5F5DC67CAFD979F0BD755B6AA525E5A70A19F48DDC5CD39DD70BD789B0148AC6
                    B83FDAC3636779906154CB7A86A1B5962EE2F411DD7F35A17A26D457D0E0234E
                    9ABB8B2C8726601F4D06D8FF351B18AFC5079E8AD758EE7C65E762BF88D15017
                    6678EAF64127566FD7F6883D2C71DD7F6B7D67CF41F468B7EEC43A530A3EE321
                    BFB5AD47D54B600418ECE11D5D99A0DE4A78C0D7D6EE0CD70AD7A384B5581A6D
                    DD2B79D3F20765909A02311D1A3225EDE12B91B884B4ADC27CCECC88C77104F2
                    E822432808D8730D09011B8C972C29565C941F4B139CEE5CDCBC0FE388D27F65
                    7E2922FE0DCE2180194010A9A00CCF4EAA0B97F0F492781BEDD49B05239F5CDB
                    01FFB5F54446812A9173FB3AA5BE1ECC844653D0B0AB5C5CF9CF695F5FA978DC
                    CFCACD0E3B26E63279CC1E7620C7A7AD659A1DC941151C779F5A7A6ACCE5848E
                    E2D36C19942DDE8F85E4797B31BF8AE42BB0337B20F08D88AF5EEF7E0A493422
                    5F4F7AB86F09F88A2370536D27D05B951AEB9EE8CA7FBAF3D62DDBBB33FE790A
                    FDB63BB719CDDD79A667FCE394A54845C654FBA3B9ED9FC360F8D2F7C3F311FF
                    157203596DCD0BC31142DE6811739E0AB58900DBDA6F058C5DAEC62EE6C7CAE7
                    79A78A40D6300E9C14501851B735B807AA5E04EC670F2CE48E3E97B493FC57A5
                    AF182D84D6DADA839D600F6779901076FBFFC048C150A16873187D441546862B
                    7678760233EDF42CC5D7C7E177B3C842C638E2B5B182C2155AEF757DC534AF3B
                    5AD464B67349149C36DEF21FBC60115965FC58F876772EF9AB34439FA4D0F4B5
                    B101FA24C543FB354B6A27D5C1F0A049044E5DD206CB3DD1526FD43718DBA1F5
                    47B92CC057A3617B5756F01B1396FA7ACE9EE6C162361ED84DB645C93EEAE3B8
                    3628C1045C715948600F17861C8C5DB02570F5819D6C4F24F2D4DECFC2A1FCC5
                    C78A8BF263E921342971895FE600D41867BA420B799BB48719CE260E3E2AF635
                    9363AAF4F58E1359D5BDE19EA0D6DAED3D19BF63C862B94CA701FE2BC49917D2
                    582198BF0E1ED1A20A0AF3CCB52034AC1A42505FA70759BA777C844E5D9DAF02
                    DB6697E26B980478BA2E89DA89BAAE234B5376F97E2CFD5BCDFA5FE4F6298F5B
                    D907825886716B47BF2384A3478C779FCCA95962D9EE3B3002D5DAE3AACE12F7
                    C42E70978D5AE9AD723F20EC81DDB60387BB590B6AAC3FCAD1F2AB2AC1890AF5
                    D5A135E02A3E4C910A5A30CEB39A3DCCB8E589D812A645819D7BB6360964DB0E
                    7B016397172B5E3C1F8BA18F2591DDD595CBE8FE6B07D9C3B705CF4ADD011128
                    B70F96719C78D3D646156F52A3324F115FA1032068D8F4FADEDB90AAEBCEAA8C
                    E43C8D855FCB4F07F936B4ADEAC267071D48BD62A221E02B96D0C375A3D599A2
                    3DEC489378695CB544FB33750924028CB61E8FF98754D934D60F04A870C092B6
                    B1D1D27530B4928C8EAFC8ABCDF9941E313E29D999ED3AD063678F833DDC8075
                    A6444E574516A5BE06F31050D9E11E152C5D88B0D42D2082F610E12FFD067308
                    8F78B83F58B785A32C2C8FF1DEA83D2C84E9BE58C4624AAD34E699442C6389AC
                    FF0B161D2B5ED88F0D3B01F4A9B5A85DB9534B70B6B52E6A25312DB208FEABC7
                    9973BCADBEB3A7BF0D4791439F24F503015F71C4C1F14CD887EBF5BFD748D51D
                    CF53520E291BD358E829A49D1F14A1C2DF18E710A0DD849BD61C9ECED3394C57
                    3C3CC774B573187D87A2F81A2D667BDE684882B3EA3416E14AC8E5D515873327
                    FCB6497FAD86B5D4696C189A57D32FCF90A83D9C9728E2C49FDA9D2D141F3E95
                    554973D51E0FA3DC68F630733DB48781AF16ED1FBD2165B93F0E905A76F27EDC
                    1F775B40A802ED61D8D541E6B1B492C23E8E99110BE212CBDABBF37C63123ABB
                    BDC7D367CEFA13BB4AF563C399135A23A5FF6F7936DE518CB2601F076402427B
                    786B3B4C4C748EB7633985F25F551D0C77E92830DA8E67D5C062E744B7DB27ED
                    E1BAEE8C72686FA8B1CA8F5566B48DFBDD6787A1D4DF0646AB3E0E388789B076
                    C41E1ECA618DB13DBA9C4D594FD71A49713698122DFC7966256A6C387322AC3B
                    E57670CABBA7EE5AFA5781BE2B8F59873FD91AABA0E8EDD6EE69A3BA70D4D716
                    9FAFEA6272FA77D51FF8DF1B21FF2A9443BB1861557193D298916B1097A0FA2A
                    F068A178E2FA302DA985792B1CE3C3B3D08E057C851CAD3BBABCDD76CF24631B
                    F7784C11D5E6BEDA96ECC7063327AC60B183BFCEAAA8B8B1CF57A9AFE16FBDF9
                    0EA85BEBFDF3D0FA32B0CE545D2CB44C40EAAB7A63EF2B1D5853512B1517B79F
                    2DA1B1F22E8AA6625B2C1F1CF64C5512A5F2AF907AB5D5E821B28767879D71DC
                    1D219FC645B1B8CE6BCA7A36117FB6EDD35E30343AD87F5E6A5D717CBE53B0FE
                    B3E8B831DA4D7A1C51EAEB298FE9F5E6460AEA4CE9CB077B18CEEA5A1C3583CB
                    5A7C0B19DA6F6DBB38CA921F8B6631A38D9B78D564700DF8A0E9C7A718D5ADC1
                    EC0977740867E516CFD705DA289F494867FD1DAEFE98AD92F3B1F14EF6C08F55
                    4701D41EB52FF139F6672DD61BDA4D8D299C43E01ED7F97AC255478BB487B719
                    A8AF195505E29DE85043FB32823AC396D658AA21A64FEE715AE50E9ECF19E5E7
                    041134AA339DC5C56A39B2879DE2715DA0F1F9F9C6446CE39E704DBAB52C3F36
                    3E7B22D825E86FED9547E7C1C57F1363D7217178BFEED1E239DC15F2D5D87522
                    2BA9D38FCBDCDB6935CFF123EA5D9C1377190DFE106B2E4A242CDCEF70FF22C4
                    BEABEB181A566773C057A86284CA131A52B27C6013E3ACE7FBB16A565971F958
                    7123C6EA66319E033CDBB363A94FD1FEA990AF0DA95D503F0C7C0D806D93F6B0
                    E51C3AD087FA8A1E6D77AFFADC4E5F0750C0807813563116A7B10217E0F9535E
                    55A63D73C58F23DA44F690AFFE4283A5E3FE4B013BF7CF494517991D347E0B56
                    645DB1BEC1353A7B22083DA9B08577A275E9DFA3B635B4A43AF22E63AEA6AF50
                    17CEA447BBABBEB3AFA75D9DBA596AB3E26E0FE96BCDC10CAED25A1665F1FC66
                    1CEBC2AF0DC2C62595F3C928BE72357888DD68025B29C0261537EEF1C2FE356E
                    0753ED16D5D830A82162B327945ADBCA3466D99E96A272EE8195D48E96D4F116
                    6DA001B0D3E9BEB3BEB16EE79B7CFF555D5AFE928856790F7D96523556DE2FB4
                    4AB66BC3CC5F13AF5084A218355ED52EC11E5E04D864E2C6DBC0EBB163FB0417
                    D5585A6A6F69831383C60E3FE4E41BD9C2ED6F4B95749DC19C5A9DAF0D5B710E
                    81FBE7EDFE44CDC6546D7796938EC3A49206E2AB1A14B32CC212F4F9695A3F6B
                    A9D212CAAB530C19239625D9C38B013BF75C1245506041F9E2194C035FACAE58
                    6894B5C25D76414D6FF06F693775B7957269529F24CB1E8FFAAFD251EDD6EE81
                    3E497A43E0AB41F6B05F175E8AC6FA73A8FC3EEA916BA4AF34AF99FA38A4BE32
                    75ED0AD3796A66AE2CC026145D24DB58EDB40F4CA945FDD88528BB80597CE24D
                    25E15AB70722C68E6E0F635D384EA10E1E24ED617A6FAF87D6E3D5407C98FBE3
                    D844D19415FABE02F93BF3C101AEDAF4B8AA0BC7360F7FA4D46275A625023BF7
                    FCAD49E96C6403A8B27C6EA8B142D7D885FD58B087A948A9F8DBCE8CF45F7B75
                    BEEE807A895CF76E9DAF59F5E6D27F6D68A021D6221CDBE8A75A97D6586DD3AD
                    3F2428A7D2D4B03A00FA9AA1A903FC5B110CD92C17B0105D4C263FCBA31AEBAF
                    942A5E636384E5B6DBD7BAADB48FB11FF4F5508BCE5717CEF35D215FE1D4557C
                    3D81616803EB4CED651056B5F988209C2A18B7D4CC2FB29BC07F156810DBC5D4
                    C19404ECDCF389C58D631A6BDFC88F5D54637D4D939E684FC9155CBB0EE5DCE3
                    6D463830A8272B8FC4EE3BC3CFD90CC3A2721987967EAB8C6CB8AA568D4F2E4A
                    63F17F4144956A36D52263465939286DF22B68B8353A33575660938B1BFBC6EC
                    C2942D5163E517DF9C2AF953B4771D6A8FEAAB70437D35B6D69E80D18B5D077B
                    85D37367BDE2ABE06C0594B5C375D4C15A54AEF80AD5E4E4161599572F09D8B9
                    6713C9BC43DCD80A2B6556A8B1D27F6D5BC687365AEBA2F12621FDD7883D2C3D
                    DAC3ED359D3DA770C29BD12C2D6411198D5CB4C6AA4F2E02C2062E39D5994AFF
                    1547C2E2FCCC65E2BAC442A5A4AA65EC45085B9AC60A7759B8024D43F642FE15
                    B700FBF7FC32B64C77EF348CDADD77215FEBBBF2C25E2161C3621E75ECD2BC70
                    8C0F1361EDE5E9EBD2C0CE3D7F4B4216545828B380C616E5C7D243DC52EDE179
                    B7ADB741DCDF39BE53535C1849E21CBAAB0E6B2A0CBA07472CAF4863C375D414
                    3FB64D583A19D4B6C9DF7B59F67051C02665411DF6989E12107C791A0BFABAB2
                    CF8BFACA6D2D2E6150D4D039F407DA505C18EE66979FB2F6C8ACD457D3F6E7E9
                    2F9BAF45AC194DCC36E6E1081D15FFB54BD558C73DBCD28E06D0578B39BA470B
                    6A2AF5551B62DD8CFE2B5FB1C60A4D63718206E7C3230ECE920702A79DE5E35A
                    C462E0E4EA8D55AC3888FF96AAB1967BE2DDA9157E8E96303EEC5B55E0BF7A7F
                    1E0CED6B4CD5746186A70284753837B93FD86DB9F670B1C0CE3D9B54DC58D7D8
                    40424BF063DD136D2BBD048DFD79A83C0DABA58CED5D4770A743A0B80D5817CE
                    29855C5E8D659C764DE03DA6F3C2CC5C45814DAADEB8478493257958A559B4C6
                    9601D7C686B643CC3BD4AE8D4A3D7E447EDD8776FBB81A467DF7698BAB8AEEB2
                    539605CF5EA2AFB92CC0826D9C8CCEEA71C100B02235D6EB692F836618ED5DBA
                    FF8A75A64EF7EEF0CA6E86A52E94B050D7993FCF69E51A0B84A7672FDF7F2D09
                    D804E3C6229A63E58B6AAC5E40E17EA5B93C1FB155B387A12E5C9EC3776911E3
                    2EE86B0E081BACAA15E5212C57BB704BCEAB2F13D8B9E7EB12E26C4463FD389B
                    E6C78601AAA067870AFEFA5ACAF3098D46CD1E3E94F178AE7B7778324B5C3DC6
                    FD453CA4B1B6DA1C500E8D55B318255F67E6120136A9B8317A3D8B696CD87C19
                    E9DD714F6C2FF7E733B04F52EA6BE0BF1AA93AACF7D729EB6B6CD090B362CAAE
                    203EBC1C60138A1BB7F5C43516ABB984AFB114610DFA6BFD1DED6E7F5BD93F1C
                    7AABC2E9EE880EC545668AB8C6221C65D158F9B369AF1CD7E2819D7BBE31819B
                    4256D358C1F4BA624A857011AD2B767B5ACB8E6B431BC69B0EDF551F8E86EACE
                    5051167D1E616B1A6B9752F37443C25237746EC5E77049C0CE3D9754DC38642C
                    1A8842EFDDF1292BB45E2CD153FE091A0D06E673BA7786658CB046CDEFFA14BE
                    1FEB3784AAA6D795692C8DFC75CAC0D792804D30BA184CB0B3A394B55581A9DE
                    0AC0B33DE53F871B8D3F80FCEB839A3D5C471D7654E83BDF2C2E0B65D1B97BB1
                    0C7C2D0DD8A46CE34F7BA133B380C6FA794CA5B16E7F6B253ED5AE6EF05F430B
                    19EB4CE91F1ED558DBD758B1528D85ED676E59F85A22B0601B2736A7C2A7C13C
                    8D8D3602B83D2D15F94846FBA107776A7E8EE46BA5098BB196A1F2E05A22B049
                    D51B1FF67CF3C98E6A2CED38D2CC66B7BF3D55A14FD1FAA67095D6F683195B05
                    71038D15E5D658C1D2E5E26BC9C026586F1C42AB5116E724F1704847B66747C5
                    3E8F565341730896A0ECCAFD58D32B1BAE25032BFDD9A4E2C69A3FE36B2CB627
                    F91380B12E7C57253F8D1F98A83B986701616FACB12BF4635794575F39B0C9C5
                    8DB5D11251C206739EB215D2D7D867A93D9EC1EEB11861637EEC8A096B8A32E2
                    BA0C6093B48DFD4B3FAAB1FE0C0AAF7F47129F84E60FB3791A1BF36357162BF6
                    CAA9AFCB0436C1B8715028A337E6F897BAB48793D8ED557BFC88AA68E715D458
                    DCC7B1DAC0261637F6FCB5B07A638E2F745E897D92CBC515F771205305AF98C6
                    0AEEBE303337B7DAC0261637F6E2A3250237D6AA48BC69215C3301A92AE0C7FA
                    0FE062B4BCB82E13D8A4E2C6873DA657A45A6AD323E45F2B136F8A7F82FA83F9
                    9056E5F463557FAC0A4BF0F2EAEB0A804D2EF3CE17A22C777B92989C0D158ADA
                    30857252D6EF78407FBC2C79BA32019B5CC756C0D5609D0063CBE9BB5AC6BB4B
                    7B38985622300B5BAE58B1DFA22468E244F9715D3EB009C58D5B0E7B7E724E19
                    C83022ED707B6302B8FAFBE96E40D895E46303C2E29C9FA1F2E3BA0260E79EBB
                    35310B4A68A5E4D050DE964AE09AAA91FA2A820AACF91A6BAF5063D59C9C95D6
                    99961FD8A4BC1EC9594B6FFE707B7625A10230CF9496A917A9B125F9B1C10C0A
                    D319AD04AE2B0276EE7923A98C000FE79BBA5FD99E883D0CFEAB2D4AD158BB64
                    8DB57985F8BA426013EBEBC978FE362A96903DDC86FE6BC5096BF2CAF075A5C0
                    26641BB71EEFCD7AB028D975FABB6A138A0F539674118D152B8915ABD154DE53
                    33735509ECDCB3F589E85DE781FEDEBEDEBEEEAE8EDAC4F4D56295A66CA5F4B5
                    1CC026340FCAD8D67647677BCB6DCD491CFDA0AF6A745F453596794F550CD795
                    033BF75C630245150D3022C0308C44B666429F6450E05F393F366D578EAFE500
                    76EED9C644BEEEA46E92AF19E1B3CEAE881F8B8FE6EE5005712D07B073CFD5BD
                    8E9085BA70BF5C6209CA2E3B566C95B9BEA952C026631B2773DB5AD7759A0784
                    15A212B1629A975151BE9609D864E2C649F1956641578AB00476A5F95A2E6093
                    891B571ED62D75DD792ED468DDA534B6E47CAC08D6AB569CAF650356DAC6AF07
                    CA82FF4A7ECB3228BBA41FEB377DDA69E785D7E6D608B0AF07DBD8A8EBCA3035
                    9874391ABB841FEBEFF0E3DC1B9A995B33C0AE7D9DC538A2B08B266CA975C5FE
                    7E215E717D2D2FB06BDDEB81BE2B58BBACA64795ECC72E1D2BA68BA4FC756B95
                    063699EE8FCAF1F500CC97B0EC0A6B6C45EA602A0C6C3299F7CAC06AD41ECF63
                    1592DAAF50198D65C5EF7FAD2A6093A937AE08B0B89F0EE207F67209BB941F8B
                    47B3E925846B998105AF672D7216EAC2551552F11A5B8A1F2BAF18DCA26325A2
                    AF1500766D4617713F9D5F962E2A47D9A4F4B512C0AE41DB18F735873DD6CBF7
                    639788154B788712C3B5FCC0CE5D586BFE2CD499068BD84A206C89F958969CBE
                    5606D8B5163706FFD5D2166A2CD78F5D426399994B90AF1501567A3D6B28BC88
                    FB3898D6A95A213F96BB49F2B532C0CE3DB97680355ABB688E9E5A9D282A142B
                    36ED6471AD0CB06B276E4C7D92D1A6AF7210D60A9743F1E5EFA7AB3E60D78A6D
                    6CE0BC701EEDFA5AA61FABC78AB9368700AE9BCAF45DAD06B0601BAF0D7B588D
                    F0D316438A955336986AE06FAC7B2A695C2B06EC5A881BD37E3AAE564507B34B
                    58B01376B91ACBB5ADBFD827F9C2CCDCEB06D8EA8F1B83BEFADCD3262E698B39
                    96EBC7066B7F91FFDC1B4D9CAF9504166CE36AE66C03D4C1707F147D6016DBC1
                    2A8265FBB1BA976373530CAD02AE9504B6BAE3C6464DD7691EF4706866B15D34
                    656F142B5647336AEC2AF1B5B2C056B36D4C75A69A18061DAB22DC57B7BC58B1
                    609A1F6B3AABC2D70A035BBD7163C9D7233493CB2E3F61EDC08F655CAC0E5F2B
                    0D6CB5C68D255FF38CA6E889981F2B8AD6D885F2B16A7E937F0D98627466EE75
                    096C75C68DB14F922BD6958DB27EBB150BFCD8D5D2D72480ADC6B831CEF9412B
                    B8BC1A1BFE015F16EA87570DD7CA035B7D7163EC930CAA7C974FD885EA8A7D1F
                    16FB249DD5E36B12C0569B6D6CD41ECC7B8C919CAE4463E7D515070B0C559FE4
                    FF58455C9300B6BAE2C65BEABBF2161734F57865948D9BC5C1494C4F5C35BB29
                    3160AB296E8CFE2B14FC0BB5E8B27C1A6BE94F4C3B4FAD265F1302565A50D582
                    6B1DD44B70BB02840D9E88FA2A465717D78480AD96B8B1D17C2023B0488251B5
                    C48AFDD8050EE255B79B9204B63AE2C692AF4718CD6D51945DB11F3BFF24B631
                    9F333BF70B026C35D8C65017EE5898350D34B62C7E6C187CC27CACE9AD3A5F13
                    0476F5E3C646DDF13C61591EC2067EAC083015E5DD4FB736804D662FDEA27C95
                    7E0E82297C8D1565F1636DAEEF94AF0ABE260AECDC93AB193736EABAF3C1F15B
                    3E8D8D5156DA4DF6E8AB55806BA2C0AE66DC18EA60D4D2AD4A68AC6F3DB1558D
                    0FAF1AB0AB1737C6FD395440AC13B63C7EAC4658D3AA8A7338716057CB36067D
                    F557E3E91A5B363F96F63533D3AD165C930676EEC26A5016EC617FB56599291B
                    3E16D601F1F2EEA75B4BC0CE3D997CD838E8935C4063CB102BF68BCCEDD5A80B
                    AF1E6025B2099B503487A0FC84453F3678ACE0265BDD7CCE6A039BB46D6C6C86
                    3E0E8BA8554E8DC5FF524DB86036E7D5E1BFAE22B0734F26694119ADDD19FFAC
                    9D4FD9F2849E6CDC4F57257ECE2A029BA46D0C73B998BF7AB6DC7EACB0839C8E
                    E955D339BC5AC0CE3D97D0747FD0D7BC5D41C2FA299D55AB0BAF3260E72E24C4
                    57E86B16FE14C3F91ABBD258B14AABDB55A6AFAB086C327163A316E6ADF10A52
                    96F6B69BAB9F57AF1A6093F0670D03F6BFE2289E0A692C4D9997FE6B75E9EBAA
                    020B165465A135B65F983A62F2C508BB523F167EB238AB367D5D5D602B6D1B1B
                    35E7E7E62632265B4463575C570C7D5755780EAF2EB0958D1B1BCDE7E1FB9EC8
                    9A15A32CA0CEA5BE5645FEB59A80ADA4CE6EAB3F4FEF31953517D3D895C58A25
                    BFAB293E5C35C0562E6EDCD072DE7F8FA92CE79521ACC4B672FB5FD736B0D29F
                    AD08B086713E7C8F890C67E5D6589458A81FAE46BBA91A80AD4CDC58E96BC859
                    93AB493FE5F263713654B5D4AD5525B0105DAC98BE869C3569502521B2723F96
                    9EC4EDA1EAF35FAB0658B08D8D32F3F55C9C47601BC3626E3C7DCB40587C52F5
                    C587AB0BD872776C19F54FCC7F0FF0671906ED052B43AC980CEA6AC6B51A802D
                    6FDCD8D87E7EA1BD71601B8B6006DBCA288B4F4A7C4EED1A0476EE42F9FC59C3
                    7862E1EF7B22CB156E00CBCA34D6467DADCAB84475015BBEB8B15173EE46F60C
                    70D60F2DAEC88FC57A89EA8C23561DB0E59A6660D45DB8F17B400CCA626A14F1
                    0AFC58789A559D71C4EA0376EE89725056F275311E4D407451316F0594057BB8
                    CAEA60AA18D872C48D8DBAE7167F0F4096247465B16256EDE7703501BBF2B8F1
                    127CC5D3388371E3651316FF50CDF1A66A0476A571E345F535E4AC92D065692C
                    FEC11443AB3E87606D013BF764BDB112BE9E2F8647185D04E22DCF8F65BC8AFA
                    AED60CB073176E5936B246ED73C5BD07216B2FD38F95E056717CB86A815D7EDC
                    B8087D0D4F635325DD9641D874B5E6D5AB1C58882E564C5FFDDBD4114B3156C0
                    FF7C3C85BC05A3D6F00FC18C5ABAC1FE1CA70AEB11D704B092B3CB30A18CFA05
                    E3C33F78E9872FFDF087DFFC997EDF8F7EF8D24BFF4FD7DD0F03691FBEFB7D70
                    A3C396BD9FFE04583E8C3FDDFD309EC1F7BC8FFE7437F3F75D5DFF21BCF04BFF
                    1AE7EE8FFFE16BFFED337FF9D5AF7DEB7A70D7CF5F7AE987917FA29FE61708D8
                    E5D8C646F3F9855EA9F0D64D1BE56DD337F43B3FB8116FBF298978CF3BF1C737
                    3E8C42FAF0AFE19FDE798FFCF93DE183C43DEFDAA8FE74CF0738EA6BE14FF075
                    37DEFE93C8DBFDEB7F7AEBA64D9B366CD8B069D39FFEA37FE75737C66E9BFEF1
                    1715D8D2E3C6525F17E2EBDCF5DB37E0ED1FF43BDF4AF7BDEB035CBCEF26F533
                    1CBED6C3F4A777C2B9FC9BF8E3A6DF9688BFFFD7E941FFD37BEEF1FB38BEBD91
                    EEDAF04FFA9B7D48BD1B3DF56FD4DD7FB5217EFBF62F2CB0A5DAC646F30DF4F5
                    2704D587AFEB77D2D7BFE9BF1C31C5EFA8AFFA8D0F4310F88F08AEDF84F20A02
                    F6A6879978BF82EB97FE50708BECE1EB6FF3317A297CD99FFD6914BE8DFF9DEE
                    FF501CD7DFF8F92F2EB0A5D51B4BBEDEE065FE137D957FA9DFF74F6FC0FBDE0A
                    B6F17BFC2FFB77FE580AEB3BE9E7DF95F47DFF1BF1C75F63D6FBE8A70D37DD2D
                    82393FDFD8E43FEF5B21AE6F8B0348E7F4CB6F8DDFFFA1A4BEC46A0456DAC645
                    078E6FA0AF70FB087D95FF59BFEF3F6F50C04A6403607FEDFD82396FC71FFFE7
                    F749F6FEA1BADBBA5B1DD66F7C9F08F65D69587DC857801FF9B8DEFEE18F6ED4
                    8F5CFFD4BEDDBFDDF457BFD0C016DF6569A416B487F146A7E3A6AFEBF77D94BE
                    E8B7CB1FFFDFB70708FDA125EEF975C552E901FD36DDFB9EF7FF927AF4FB45D8
                    27F9B5907D37F9C7AAAFA47FFDF25CE19B0AF8CF68ECFEC80FA42D8EB76FFEF4
                    171B58B08D8BE16CC3F61BE37A9D807BEBCBFA9D1F0EBFF56F0747EA865FBFC7
                    B7A4DEFEC7D276FA5D92C9DF557CFDCD7BAC70FFEB0FF0CE8DF8DC8D0AD89715
                    2FFF1AFFF455FAC387E1097F433F7F6D15BEC12A05B6B8B8B1517FFEC6AFF075
                    FA52DFA6DB4E3F263A6D2CCCE95AB961D3DDBE25F54E693B29F26EA0BFDFF43B
                    4268FB9AE92CFF4BB4A9DEF0B3C8D5F251FAD34F3EF357F2F6D7608B17D401F1
                    373FFD31DC5E7E39C1A855B5025B8C6D1CAB0B8FDDFE9ABED48FE894FE1B0516
                    3CED6F436037BC8B29C1FD6D691FBF7FA36EEDFCDAC396D457BF5EE207F8776F
                    FD015E201BE93028DCBEC0994F5456C772E0C4FE601DD822E2C6DB6E3EBFD8F3
                    95F0FDC502F7BD41025BF898EE9D3C4CC06EBC479EC4EF8BDAB1D24E0EEB253E
                    A8CE5C42ECAB789F3AD3DF013F7F5392F533F80F80FED21BA22FF58697D7819D
                    5B326EBC98BECADBF58F13549148CF67E80BFE2C708FBEF437122AEF2441FE25
                    6133FB8FA268FCFAC361DCFF1F91B0B7FF5801FB36BCF3E3DA49FCC1E0697F2B
                    FFF4AD8DD197FAF0FA51AC38BB487871517D05B61062B7EB24F9F9DB4207F487
                    641AFD5FEF529125B27321BAF89E98EBF95F02380AEFC03357BA2C741DFC06DE
                    FB11CD5F0E02129BE03DBE1A7BA5BF49F0CBAB666017AB375E5C5F815CCA63FD
                    91769FCF20ED98FCEAF7F46FFE3D82D9F7DC1E83E36D41DCFE6B41ECE14F03AF
                    696EEE1DA1C4FE2870A16EFA4118A3BAC97762FF611D58FF34BE916D8C730816
                    BD7D83BED477E846B11F2FF8F15C1097FABA4F3804E77D92B10FAB07DDF41EE5
                    C66EF463C23F7BBB52D88262E6ED706D15E8DE4D1044FC878DCA96C6D3FEE7BF
                    E15F088542E17A21D9C1A8D50DEC8D6C6389EB5279D1BF8C46E389719B02B0E9
                    54DDB0E11B733FD5C8F930B3D9C3742AFFDADD967F267F503D5D9DAC1FF98B8F
                    FE09B17AE3B701D8DF08235C3FF9EAD7FF22F4947F4E4AFC9155F9E6AA1CD805
                    E3C646A4AF79E1DB75FABA377EFD079093FDE10F5FFA5779A7FAD2FF2A64DF5B
                    5F9EBB1E5276D3C3D2DBF9C34D2A802CFE48B1EF76F2527EBE715EAA06C34BEA
                    C0FDDF305CF1938F847F43A6960456F215489B2865AB1DD8B92716881B2F6E0F
                    E3EDC70A9437DC246FF25F6F787BA88090A0FD29B1E94FE6023506DBF8218BD9
                    2A3CF13B427CC0574C0AF07E701EAEE44BF917C63BBEFE8DFFFE5915ADFA37DF
                    0E9F70D35F7CF8C31FFCB0BC7DFCE3DF5A0756E36CA9F630DEFE358E81744D5E
                    BE3D348AFF766320853F7B47103316CC1294D0D97837E7EEFFADEE7F2BD0FD5B
                    9BE603FB3178ABC0A9D9B429E0F43B809C1F9BF7F86FAC031B4136721C2FD0D7
                    BCC0ED5BF1EFF46BD2C32143F82680E9B35AEAE733FE63EE86C24402F6EDF770
                    E77FF8A9FA0D5F0F88B9E9631FFEA8FCE74384F29FC2D35F7BEB7CC43F0E7FF1
                    E1F8BD9B7EB80E6C0459AD63CBD8B2505FF3FC5B3CC3BD49BA385FDF14D28CBE
                    F437A00372DD47E66EE9EDBC8F58F7EFB9189D9DFB3FC3F4B88AE77F0CECDBEB
                    859FD1A37E039DA9488069E3ED7EB4E2A537C681DDB81E798ADE9E6C87F0A281
                    66D36F9D2FA64EB0308F432FCFBDF6F13092A0523F6F2FE857C11B1F9647B10A
                    58FC7B9CCBF572C0F71F9131B649D539FD4C059DE96C7D29CC00DEFE0DF4A3FE
                    9B7E1004B7B7FF3CB9EF6C4D003B77F90BCDCD12D4547DCBD1CBC53DE383F2C0
                    D4FFF7D99FCD153E833F7FFCDBF2AF7FF497F8E367E8C1D73F0B7FF3AEDF86C9
                    88BFF3CE77BD53DEFE680431FF0BF5025FFFA78FE27F3FA38215850FD1EBFA21
                    87BFFAF8DB376EDA74FB473FF683B96FCB477E1610FCD647639FE1A349A6EFD6
                    06B07385EF3DF1F97DF77FF1C2E50A96F54E1D614D8C8B3FFEC0FFF1810F1C79
                    B154D7E4FA37FFF1DB3F9DAB9EDB1A0156423B337DB5C26F313592F14CD664E6
                    F2C3636BA4DEFF75006C12B799D9D1A181E191A1B1B552EEBF0E6C0907C3DCCC
                    9A67EB3AB0AFE3DB3AB0EBC0AEDFD6815DBFAD03BB7E5B0776FDB60EECFA6D1D
                    D87560D76FEBC0AEDFD6815DBF55E6F6FF039992165700FAED9C000000004945
                    4E44AE4260820000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    000000000000000000000000FEFF000005010200000000000000000000000000
                    0000000001000000E0859FF2F94F6810AB9108002B27B3D93000000068010000
                    110000000100000090000000020000009800000003000000A400000004000000
                    B000000005000000C000000006000000CC00000007000000D800000008000000
                    EC00000009000000FC00000012000000080100000A000000240100000C000000
                    300100000D0000003C0100000E000000480100000F0000005001000010000000
                    58010000130000006001000002000000A80300001E0000000200000031007300
                    1E00000001000000000073001E000000070000006461656D6F6E00001E000000
                    010000000061656D1E000000010000000061656D1E0000000B0000004E6F726D
                    616C2E646F7400001E000000070000006461656D6F6E00641E00000002000000
                    3200656D1E000000130000004D6963726F736F667420576F726420392E300000
                    4000000000000000000000004000000000F650267393C6014000000000F65026
                    7393C60103000000010000000300000000000000030000000000000003000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    000000000000000000000000050044006F00630075006D0065006E0074005300
                    75006D006D0061007200790049006E0066006F0072006D006100740069006F00
                    6E000000000000000000000038000200FFFFFFFFFFFFFFFFFFFFFFFF00000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    5600000000100000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    000000000000000000000000FEFF000005010200000000000000000000000000
                    000000000100000002D5CDD59C2E1B10939708002B2CF9AE30000000EC000000
                    0C00000001000000680000000F00000070000000050000008000000006000000
                    88000000110000009000000017000000980000000B000000A000000010000000
                    A800000013000000B000000016000000B80000000D000000C00000000C000000
                    CE00000002000000A80300001E000000080000006C696E6B6167650003000000
                    010000000300000001000000030000000000000003000000FC0A09000B000000
                    000000000B000000000000000B000000000000000B000000000000001E100000
                    010000000200000031000C100000020000001E00000005000000CCE2C4BF0003
                    0000000100000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    000000000000000000000000}
                end
              end
              object TabSheet17: TTabSheet
                Caption = #22270#29255
                ImageIndex = 1
                object Img_doc_pic: TImage
                  Left = 0
                  Top = 0
                  Width = 854
                  Height = 419
                  Align = alClient
                  Proportional = True
                  Stretch = True
                end
              end
            end
          end
        end
        object Memo_his: TMemo
          Left = 0
          Top = 528
          Width = 726
          Height = 65
          Align = alBottom
          Lines.Strings = (
            '')
          ScrollBars = ssBoth
          TabOrder = 1
        end
      end
    end
    object TabSheet19: TTabSheet
      Caption = 'Draw'
      Enabled = False
      ImageIndex = 10
      TabVisible = False
      OnShow = TabSheet19Show
    end
    object TabSheet2: TTabSheet
      Caption = 'Play'
      Enabled = False
      ImageIndex = 1
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 876
        Height = 73
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label4: TLabel
          Left = 9
          Top = 44
          Width = 18
          Height = 12
          Caption = '0/0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 43
          Top = 38
          Width = 224
          Height = 16
          AutoSize = False
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label7: TLabel
          Left = 44
          Top = 38
          Width = 224
          Height = 16
          AutoSize = False
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object ProgressBar1: TProgressBar
          Left = 44
          Top = 57
          Width = 225
          Height = 8
          Min = 0
          Max = 100
          Smooth = True
          TabOrder = 0
          OnMouseDown = ProgressBar1MouseDown
        end
        object Mp3player: TMediaPlayer
          Left = 456
          Top = 16
          Width = 85
          Height = 30
          VisibleButtons = [btPlay, btPause, btStop]
          Visible = False
          TabOrder = 1
        end
        object TrackBar1: TTrackBar
          Left = 288
          Top = 37
          Width = 113
          Height = 28
          Max = 20
          Orientation = trHorizontal
          PageSize = 1
          Frequency = 1
          Position = 0
          SelEnd = 0
          SelStart = 0
          TabOrder = 2
          ThumbLength = 11
          TickMarks = tmTopLeft
          TickStyle = tsAuto
          OnChange = TrackBar1Change
        end
        object MCBtnMP3: TMCBtn
          Left = 4
          Top = 7
          Width = 35
          Height = 24
          BevelOuter = bvNone
          Caption = 'MP3'
          TabOrder = 3
          OnClick = MCBtnMP3Click
          CColorr = clBlue
        end
        object MCBtnPre: TMCBtn
          Left = 49
          Top = 5
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '|<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = MCBtnPreClick
          CColorr = clBlue
        end
        object MCBtnPause: TMCBtn
          Left = 153
          Top = 5
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '||'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = MCBtnPauseClick
          CColorr = clBlue
        end
        object MCBtnPlay: TMCBtn
          Left = 205
          Top = 5
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = MCBtnPlayClick
          CColorr = clBlue
        end
        object MCBtnNext: TMCBtn
          Left = 85
          Top = 5
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '>|'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          OnClick = MCBtnNextClick
          CColorr = clBlue
        end
        object CheckBoxrandom: TCheckBox
          Left = 328
          Top = 9
          Width = 57
          Height = 24
          Caption = #38543#26426
          TabOrder = 8
        end
      end
      object Panel13: TPanel
        Left = 0
        Top = 73
        Width = 876
        Height = 520
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Splitter7: TSplitter
          Left = 383
          Top = 0
          Width = 9
          Height = 520
          Cursor = crHSplit
          Align = alRight
        end
        object CLBSong: TCheckListBox
          Left = 0
          Top = 0
          Width = 383
          Height = 520
          Align = alClient
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          ItemHeight = 16
          TabOrder = 0
          OnDblClick = CLBSongDblClick
        end
        object Panel22: TPanel
          Left = 392
          Top = 0
          Width = 484
          Height = 520
          Align = alRight
          BevelOuter = bvLowered
          Color = clBtnText
          TabOrder = 1
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Show'
      Enabled = False
      ImageIndex = 2
      TabVisible = False
      object Splitter2: TSplitter
        Left = 685
        Top = 31
        Width = 8
        Height = 562
        Cursor = crHSplit
        Align = alRight
      end
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 876
        Height = 31
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label5: TLabel
          Left = 170
          Top = 10
          Width = 24
          Height = 16
          Alignment = taCenter
          Caption = '0/0'
        end
        object MCBtn9: TMCBtn
          Left = 8
          Top = 4
          Width = 40
          Height = 25
          BevelOuter = bvNone
          Caption = 'JPG'
          TabOrder = 0
          OnClick = MCBtn9Click
          CColorr = clBlue
        end
        object MCBtn10: TMCBtn
          Left = 86
          Top = 3
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '>|'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = MCBtn10Click
          CColorr = clBlue
        end
        object MCBtn11: TMCBtn
          Left = 58
          Top = 3
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '|<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = MCBtn11Click
          CColorr = clBlue
        end
        object MCBtn12: TMCBtn
          Left = 115
          Top = 3
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '||'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = MCBtn12Click
          CColorr = clBlue
        end
        object MCBtn13: TMCBtn
          Left = 351
          Top = 3
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '[+]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = MCBtn13Click
          CColorr = clBlue
        end
        object MCBtnZoomIn: TMCBtn
          Left = 239
          Top = 3
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '+'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = MCBtnZoomInClick
          CColorr = clBlue
        end
        object MCBtnZoomOut: TMCBtn
          Left = 279
          Top = 3
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = MCBtnZoomOutClick
          CColorr = clBlue
        end
        object MCBtn14: TMCBtn
          Left = 319
          Top = 3
          Width = 28
          Height = 26
          BevelOuter = bvNone
          Caption = '[ ]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          OnClick = MCBtn14Click
          CColorr = clBlue
        end
      end
      object Panel14: TPanel
        Left = 693
        Top = 31
        Width = 183
        Height = 562
        Align = alRight
        Caption = 'Panel14'
        TabOrder = 1
        object ListBox1: TListBox
          Left = 1
          Top = 1
          Width = 181
          Height = 560
          Align = alClient
          ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
          ItemHeight = 16
          TabOrder = 0
          OnClick = ListBox1Click
        end
      end
      object Panel15: TPanel
        Left = 0
        Top = 31
        Width = 685
        Height = 562
        Align = alClient
        BevelInner = bvLowered
        FullRepaint = False
        TabOrder = 2
        object Image1: TImage
          Left = 2
          Top = 2
          Width = 621
          Height = 535
          Center = True
          Proportional = True
          Stretch = True
          Visible = False
          OnClick = Image1Click
          OnDblClick = Image1DblClick
          OnMouseDown = Image1MouseDown
          OnMouseMove = Image1MouseMove
          OnMouseUp = Image1MouseUp
        end
        object PaintBox3: TPaintBox
          Left = 2
          Top = 2
          Width = 681
          Height = 579
          Align = alClient
          OnMouseDown = PaintBox3MouseDown
          OnMouseMove = PaintBox3MouseMove
          OnMouseUp = PaintBox3MouseUp
          OnPaint = PaintBox3Paint
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Record'
      Enabled = False
      ImageIndex = 3
      TabVisible = False
      object MediaPlayer1: TMediaPlayer
        Left = 408
        Top = 16
        Width = 253
        Height = 30
        Visible = False
        TabOrder = 0
      end
      object MCBtnRecStart: TMCBtn
        Left = 64
        Top = 40
        Width = 73
        Height = 33
        BevelOuter = bvNone
        Caption = #24405#38899
        TabOrder = 1
        OnClick = MCBtnRecStartClick
        CColorr = clBlue
      end
      object MCBtnRecStop: TMCBtn
        Left = 168
        Top = 42
        Width = 68
        Height = 33
        BevelOuter = bvNone
        Caption = #20572#27490
        TabOrder = 2
        OnClick = MCBtnRecStopClick
        CColorr = clBlue
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Mobil'
      Enabled = False
      ImageIndex = 6
      TabVisible = False
      object Label11: TLabel
        Left = 80
        Top = 69
        Width = 24
        Height = 16
        Caption = 'SMC'
      end
      object Label12: TLabel
        Left = 56
        Top = 104
        Width = 72
        Height = 16
        Caption = 'Mobile No'
      end
      object Label13: TLabel
        Left = 64
        Top = 137
        Width = 56
        Height = 16
        Caption = 'Message'
      end
      object Label14: TLabel
        Left = 48
        Top = 340
        Width = 24
        Height = 16
        Caption = 'AT '
      end
      object Label18: TLabel
        Left = 80
        Top = 29
        Width = 32
        Height = 16
        Caption = #31471#21475
      end
      object Edit1: TEdit
        Left = 120
        Top = 64
        Width = 121
        Height = 24
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 120
        Top = 99
        Width = 121
        Height = 24
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 1
        Text = '133'
      end
      object Edit3: TEdit
        Left = 120
        Top = 133
        Width = 121
        Height = 24
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 2
        Text = 'hello '
      end
      object CheckBox1: TCheckBox
        Left = 261
        Top = 66
        Width = 69
        Height = 17
        Caption = #20813#25552#30701#20449
        TabOrder = 3
        OnClick = CheckBox1Click
      end
      object MCBtnSendMsg: TMCBtn
        Left = 344
        Top = 130
        Width = 112
        Height = 26
        BevelOuter = bvNone
        Caption = 'Send Msg'
        TabOrder = 4
        OnClick = MCBtnSendMsgClick
        CColorr = clBlue
      end
      object Memo1: TMemo
        Left = 48
        Top = 176
        Width = 417
        Height = 121
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        ScrollBars = ssBoth
        TabOrder = 5
      end
      object Memo2: TMemo
        Left = 48
        Top = 376
        Width = 425
        Height = 137
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        ScrollBars = ssBoth
        TabOrder = 6
      end
      object ComboBox3: TComboBox
        Left = 80
        Top = 336
        Width = 145
        Height = 24
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        ItemHeight = 16
        TabOrder = 7
        OnChange = ComboBox3Change
        Items.Strings = (
          '+GMM'
          '+GMR'
          '+GMI'
          '----'
          '+CDV'
          '+CHV')
      end
      object Edit4: TEdit
        Left = 256
        Top = 336
        Width = 121
        Height = 24
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 8
        Text = '10011'
        Visible = False
      end
      object MCBtnSendAT: TMCBtn
        Left = 397
        Top = 332
        Width = 69
        Height = 26
        BevelOuter = bvNone
        Caption = 'Send AT'
        TabOrder = 9
        OnClick = MCBtnSendATClick
        CColorr = clBlue
      end
      object MCBtnConnect: TMCBtn
        Left = 344
        Top = 22
        Width = 113
        Height = 25
        BevelOuter = bvNone
        Caption = 'Connect'
        TabOrder = 10
        OnClick = MCBtnConnectClick
        CColorr = clBlue
      end
      object EdCom: TEdit
        Left = 120
        Top = 24
        Width = 121
        Height = 24
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 11
        Text = 'COM4'
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Tool'
      Enabled = False
      ImageIndex = 4
      TabVisible = False
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 876
        Height = 614
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel16: TPanel
          Left = 0
          Top = 49
          Width = 876
          Height = 565
          Align = alClient
          Caption = 'Panel16'
          TabOrder = 0
          object StringGrid1: TStringGrid
            Left = 1
            Top = 1
            Width = 874
            Height = 563
            Align = alClient
            ColCount = 10
            DefaultColWidth = 60
            DefaultRowHeight = 20
            FixedCols = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColMoving]
            TabOrder = 0
          end
        end
        object Panel17: TPanel
          Left = 0
          Top = 0
          Width = 876
          Height = 49
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object MCBtn1: TMCBtn
            Left = 26
            Top = 12
            Width = 82
            Height = 24
            BevelOuter = bvNone
            Caption = #20851#38381#26174#31034#22120
            TabOrder = 0
            OnClick = ActCloseMonitorExecute
            CColorr = clBlue
          end
          object Button1: TButton
            Left = 320
            Top = 10
            Width = 75
            Height = 25
            Caption = 'Button1'
            TabOrder = 1
            OnClick = Button1Click
          end
        end
      end
    end
    object TabSheet18: TTabSheet
      Caption = 'XML'
      Enabled = False
      ImageIndex = 9
      TabVisible = False
      object Button4: TButton
        Left = 64
        Top = 264
        Width = 153
        Height = 25
        Caption = 'TMetaFile'
        TabOrder = 0
        OnClick = Button4Click
      end
      object Button2: TButton
        Left = 56
        Top = 72
        Width = 145
        Height = 81
        Caption = 'XML'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'About'
      ImageIndex = 7
      object Label15: TLabel
        Left = 48
        Top = 75
        Width = 120
        Height = 16
        Caption = 'daemon@e165lcom'
      end
      object Label16: TLabel
        Left = 56
        Top = 40
        Width = 72
        Height = 16
        Caption = 'MP3 Play '
      end
      object Label17: TLabel
        Left = 32
        Top = 104
        Width = 152
        Height = 16
        Caption = 'www.cubezone.com.cn'
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Test'
      ImageIndex = 7
      TabVisible = False
      object Image2: TImage
        Left = 793
        Top = 41
        Width = 234
        Height = 254
        Align = alLeft
      end
      object ListBox2: TListBox
        Left = 0
        Top = 295
        Width = 876
        Height = 298
        Align = alBottom
        ItemHeight = 16
        TabOrder = 0
      end
      object Memo7: TMemo
        Left = 0
        Top = 41
        Width = 793
        Height = 254
        Align = alLeft
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Panel28: TPanel
        Left = 0
        Top = 0
        Width = 876
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Button15: TButton
          Left = 46
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Query'
          TabOrder = 0
          OnClick = Button15Click
        end
        object Button11: TButton
          Left = 470
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Button11'
          TabOrder = 1
          OnClick = Button11Click
        end
        object Button16: TButton
          Left = 198
          Top = 8
          Width = 75
          Height = 25
          Caption = 'exec sql'
          TabOrder = 2
          OnClick = Button16Click
        end
        object Button19: TButton
          Left = 334
          Top = 8
          Width = 75
          Height = 25
          Caption = 'MFile'
          TabOrder = 3
          OnClick = Button19Click
        end
      end
    end
    object TabSheet20: TTabSheet
      Caption = 'Disk'
      ImageIndex = 11
      TabVisible = False
      object Button13: TButton
        Left = 32
        Top = 16
        Width = 113
        Height = 33
        Caption = #24341#23548#25159#21306
        TabOrder = 0
        OnClick = Button13Click
      end
      object Memo5: TMemo
        Left = 32
        Top = 72
        Width = 521
        Height = 537
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
  end
  object Timer1: TTimer
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 728
    Top = 112
  end
  object OpenDlg: TOpenDialog
    Filter = 'Mp3 files (*.mp3)|*.mp3|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Left = 696
    Top = 112
  end
  object ActionList1: TActionList
    Left = 760
    Top = 112
    object ActNew: TAction
      Caption = 'ActNew'
      OnExecute = ActNewExecute
    end
    object ActSave: TAction
      Caption = 'ActSave'
      OnExecute = ActSaveExecute
    end
    object ActLoad: TAction
      Caption = 'ActLoad'
      OnExecute = ActLoadExecute
    end
    object ActRemoveUnchecked: TAction
      Caption = 'ActRemoveUnchecked'
      OnExecute = ActRemoveUncheckedExecute
    end
    object ActCopyToOneNote: TAction
      Caption = 'ActCopyToOneNote'
      OnExecute = ActCopyToOneNoteExecute
    end
    object ActCloseMonitor: TAction
      Caption = 'ActCloseMonitor'
      OnExecute = ActCloseMonitorExecute
    end
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 4000
    OnTimer = Timer2Timer
    Left = 664
    Top = 112
  end
  object OpenDialog1: TOpenDialog
    Left = 632
    Top = 112
  end
  object XMLDoc: TXMLDocument
    FileName = 'C:\Documents and Settings\sysdaemon.LINKONE\'#26700#38754'\'#26032#24314' '#25991#26412#25991#26723'.html.xml'
    Left = 440
    Top = 112
    DOMVendorDesc = 'MSXML'
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 568
    Top = 112
  end
  object PM_Book: TPopupMenu
    Left = 472
    Top = 112
    object Poject1: TMenuItem
      Caption = 'Poject'
      OnClick = Poject1Click
    end
    object Work1: TMenuItem
      Caption = 'Word'
      OnClick = Work1Click
    end
    object rip1: TMenuItem
      Caption = 'Walk'
      OnClick = rip1Click
    end
    object Info1: TMenuItem
      Caption = 'Info'
      OnClick = Info1Click
    end
    object Ndelete: TMenuItem
      Caption = 'other..'
      OnClick = NdeleteClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Caption = #23646#24615
    end
  end
  object ImageList1: TImageList
    Left = 520
    Top = 112
    Bitmap = {
      494C010108000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000808080000000800080808000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000008080000080
      8000008080000080800000808000008080000000800000008000000000000000
      0000000000000000000000000000000000008080800080808000808080000000
      00000000000000000000808080008080800080808000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000080800000FFFF0000FF
      FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF00FFFFFF00000000008080800000808000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000080800000FFFF0000FF
      FF00808080000080800000808000008080000080800000808000008080000080
      80000080800000808000FFFFFF00000000000080800000808000FFFFFF00FFFF
      FF00C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000C0C0C000C0C0
      C000FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000808000FFFFFF00000000000080800000808000FFFFFF00FFFF
      FF00C0C0C00080808000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000808000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000C0C0C000C0C0
      C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000808000FFFFFF00000080008080800000808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000800000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000C0C0C000C0C0
      C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0
      C000C0C0C00000808000FFFFFF0000008000C0C0C00000808000FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000C0C0C0008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0
      C000C0C0C00000808000C0C0C000000080000000000000808000C0C0C000FFFF
      FF00FFFFFF00C0C0C000C0C0C0000000800000000000C0C0C000FFFFFF00FFFF
      FF00FFFFFF000080000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000C0C0C0008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C00000808000C0C0C00000008000000000008080800080808000FFFF
      FF00FFFFFF00FFFFFF0080808000C0C0C0000000000000000000FFFFFF00FFFF
      FF00FFFFFF0080808000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000C0C0C0000080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C00000808000C0C0C00000808000000000000080800000808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C0C0C000808080000000000000000000FFFF
      FF00C0C0C0008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000C0C0C0000080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000808000C0C0C00000808000000000008080800080808000FFFF
      FF00C0C0C000C0C0C000C0C0C00080808000FFFFFF0000000000000000008080
      8000C0C0C0008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000C0C0C0000080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000808000C0C0C000008080000000000000000000000000000000
      00000000000000000000000000000000000080808000C0C0C000800000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000C0C0C0000080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000FFFF00C0C0C000008080000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000C0C0C0000080
      8000008080000080800000808000808080008080800080808000C0C0C000C0C0
      C000C0C0C00000FFFF00C0C0C000008080000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000008080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000808000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080000080800000808000008080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008080000000FF0080808000FFFF
      FF00008080000000800000008000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0A0008080800080604000804020008060400080806000C0C0A0000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFF
      FF00C0C0C0000000800080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A4A0
      A00080806000C0A0A000F0CAA60040404000F0CAA600C080800080606000C080
      800000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080000000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00808080000000FF000080
      80000000800000008000FFFFFF00FFFFFF000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000000000C0A0A000C0A0
      A0000000000000000000F0CAA600C0808000F0CAA600F0CAA600F0CAA600C080
      6000C0808000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008000000080000000C0C0
      C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0000000FF00C0C0
      C0000080800080808000FFFFFF00FFFFFF000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      80000000000000000000000000000000000000000000C0C0C000A4A0A000FFFF
      FF00FFFFFF00FFFFFF000000000000000000F0CAA600F0CAA600F0CAA600F0CA
      A60080604000C0C0A0000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080000000C0C0C0008000
      0000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000
      FF000000FF00C0C0C000FFFFFF00FFFFFF0000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      80000080800000000000000000000000000000000000C0A0A000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000F0CAA600F0CAA600F0CA
      A600C0808000808060000000000000000000FFFFFF00FFFFFF00808080008000
      0000800000008000000080000000800000008000000080000000C0C0C000C0C0
      C00080000000C0C0C000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000FFFF000000
      FF0080808000FFFFFF00FFFFFF00FFFFFF000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      80000080800000808000000000000000000000000000A4A0A00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000F0CAA600F0CA
      A600F0CAA600806040000000000000000000FFFFFF00FFFFFF0080808000FFFF
      FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080000000C0C0C000FFFFFF00FFFFFF00C0C0C000008080000000
      000080808000C0C0C00000808000000000000000000080808000C0C0C0000000
      FF00C0C0C000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A0A00080806000A4A0
      A000FFFFFF00FFFFFF00FFFFFF0040404000806060008080600000000000C080
      800080606000804020000000000000000000FFFFFF00FFFFFF0080808000FFFF
      FF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00080000000FFFFFF00FFFFFF00C0C0C000C0C0C0000080
      0000C0C0C000C0C0C000808080000000000080808000C0C0C000C0C0C000C0C0
      C000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000C0A0A00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080606000FFFFFF000000000000000000F0CA
      A600F0CAA600806040000000000000000000FFFFFF00FFFFFF0080808000FFFF
      FF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00080000000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C0000080
      800000808000008080000000000000000000C0C0C000C0C0C000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000C0C0C000C0DCC000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080606000FFFFFF00FFFFFF00000000000000
      0000C0A08000808080000000000000000000FFFFFF00FFFFFF00808080008080
      8000808080008080800080808000808080008080800080808000C0C0C000C0C0
      C00080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C0008080
      800000808000C0C0C0000000000000808000C0C0C000C0C0C000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C0C0A000FFFFFF00FFFFFF00FFFFFF000000
      000080806000C0C0A0000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000C0C0C0008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000008000000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0DCC000C0DC
      C000FFFFFF00FFFFFF00FFFFFF00C0A0A000FFFFFF00FFFFFF00FFFFFF00C0A0
      A000A4A0A000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080800080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000008080000000000000808000C0C0C000C0C0C000C0C0C000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0DC
      C000C0C0C000C0DCC000000000008080800000000000C0C0C000A4A0A000C0A0
      A00000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C0000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000C0A0A000A4A0A000A4A0A000C0A0A000C0C0C0000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F80FFFFFFFFF00000001FFFFFFFF0000
      0001FFFFFFFF00000001FFFFFFFF00000001E00FE00F00000001EFEFEFEF0000
      0001EEEFEFEF00008001EEEFEFEF00008001E82FE82F00008003EEEFEFEF0000
      8003EEEFEFEF0000FF07EEEFEFEF0000FF87E00FE00F0000FF83FFFFFFFF0000
      FFC7FFFFFFFF0000FFEFFFFFFFFF0000FFFFFFFF00000000FFFFF01F00000000
      001FE00F00000000000FCC070000000000078303000000000003818300000000
      0001A1C3000000000000802300000000001FA06300000000001F803300000000
      001FC013000000008FF1C00700000000FFF9E28F00000000FF75F81F00000000
      FF8FFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
