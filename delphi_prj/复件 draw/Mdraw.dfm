object Form1: TForm1
  Left = 192
  Top = 142
  BorderStyle = bsSingle
  Caption = 'Note For Sharp A230 '
  ClientHeight = 571
  ClientWidth = 790
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 552
    Width = 790
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 790
    Height = 552
    ActivePage = TabSheet3
    Align = alClient
    TabIndex = 2
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object Panel1: TPanel
        Left = 0
        Top = 33
        Width = 782
        Height = 491
        Align = alClient
        AutoSize = True
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object PaintBox2: TPaintBox
          Left = 27
          Top = 27
          Width = 560
          Height = 464
          Align = alClient
        end
        object Splitter1: TSplitter
          Left = 587
          Top = 27
          Width = 9
          Height = 464
          Cursor = crHSplit
          Align = alRight
          Beveled = True
          Color = clBtnFace
          ParentColor = False
        end
        object PaintBox1: TPaintBox
          Left = 27
          Top = 27
          Width = 560
          Height = 464
          Align = alClient
          OnMouseDown = paintbox1MouseDown
          OnMouseMove = paintbox1MouseMove
          OnMouseUp = paintbox1MouseUp
          OnPaint = PaintBox1Paint
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel4'
          TabOrder = 0
          object TabControl1: TTabControl
            Left = 52
            Top = 0
            Width = 730
            Height = 27
            Align = alClient
            TabOrder = 0
          end
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 52
            Height = 27
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 1
            object Button1: TButton
              Left = 28
              Top = 3
              Width = 22
              Height = 21
              Caption = '+'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnClick = Button1Click
            end
          end
        end
        object Panel2: TPanel
          Left = 596
          Top = 27
          Width = 186
          Height = 464
          Align = alRight
          BevelOuter = bvNone
          Caption = 'Panel2'
          TabOrder = 1
          object Panel6: TPanel
            Left = 0
            Top = 0
            Width = 186
            Height = 464
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object CLBAction: TCheckListBox
              Left = 0
              Top = 41
              Width = 186
              Height = 423
              OnClickCheck = CLBActionClickCheck
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
              ItemHeight = 13
              TabOrder = 0
            end
            object Panel11: TPanel
              Left = 0
              Top = 0
              Width = 186
              Height = 41
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              object ButtonRemove: TButton
                Left = 16
                Top = 8
                Width = 161
                Height = 25
                Action = ActRemoveUnchecked
                Caption = #21024#38500#26410#36873#30340#31508#30011
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
            end
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 27
          Width = 27
          Height = 464
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 2
          object TabControl2: TTabControl
            Left = 0
            Top = 25
            Width = 27
            Height = 439
            Align = alClient
            BiDiMode = bdLeftToRight
            MultiLine = True
            ParentBiDiMode = False
            TabOrder = 0
            TabPosition = tpLeft
          end
          object Panel9: TPanel
            Left = 0
            Top = 0
            Width = 27
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Button2: TButton
              Left = 3
              Top = 2
              Width = 22
              Height = 20
              Caption = '+'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnClick = Button2Click
            end
          end
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 782
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 242
          Top = 12
          Width = 28
          Height = 13
          AutoSize = False
          Caption = #39068#33394
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 373
          Top = 11
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
        object Label3: TLabel
          Left = 458
          Top = 10
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
        object ColorBox1: TColorBox
          Left = 269
          Top = 6
          Width = 97
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
        end
        object ComboBox1: TComboBox
          Left = 402
          Top = 7
          Width = 49
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
          Left = 485
          Top = 7
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
        object Button9: TButton
          Left = 6
          Top = 4
          Width = 36
          Height = 26
          Action = ActNew
          Caption = #26032#24314
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object Button10: TButton
          Left = 53
          Top = 4
          Width = 35
          Height = 26
          Action = ActLoad
          Caption = #25171#24320
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object Button11: TButton
          Left = 99
          Top = 4
          Width = 34
          Height = 26
          Action = ActSave
          Caption = #20445#23384
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object CopytoOneNote: TButton
          Left = 146
          Top = 4
          Width = 79
          Height = 26
          Action = ActCopyToOneNote
          Caption = 'To OneNote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object Panel8: TPanel
        Left = -117
        Top = 0
        Width = 899
        Height = 37
        BevelOuter = bvNone
        TabOrder = 0
        object Label4: TLabel
          Left = 165
          Top = 12
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
          Left = 197
          Top = 4
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
          Left = 197
          Top = 4
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
          Left = 197
          Top = 22
          Width = 225
          Height = 8
          Min = 0
          Max = 100
          Smooth = True
          TabOrder = 0
          OnMouseDown = ProgressBar1MouseDown
        end
        object ButtonPre: TButton
          Left = 51
          Top = 4
          Width = 26
          Height = 27
          Caption = '|<'
          TabOrder = 1
          OnClick = ButtonPreClick
        end
        object ButtonNext: TButton
          Left = 129
          Top = 4
          Width = 26
          Height = 27
          Caption = '>|'
          TabOrder = 2
          OnClick = ButtonNextClick
        end
        object ButtonMP3: TButton
          Left = 5
          Top = 5
          Width = 38
          Height = 26
          Caption = 'MP3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = ButtonMP3Click
        end
        object Mp3player: TMediaPlayer
          Left = 672
          Top = 0
          Width = 85
          Height = 30
          VisibleButtons = [btPlay, btPause, btStop]
          Visible = False
          TabOrder = 4
        end
        object ButtonPause: TButton
          Left = 77
          Top = 4
          Width = 26
          Height = 27
          Caption = '||'
          TabOrder = 5
          OnClick = ButtonPauseClick
        end
        object ButtonPlay: TButton
          Left = 103
          Top = 4
          Width = 26
          Height = 27
          Caption = '>'
          TabOrder = 6
          OnClick = ButtonPlayClick
        end
        object TrackBar1: TTrackBar
          Left = 432
          Top = 3
          Width = 113
          Height = 48
          Max = 20
          Orientation = trHorizontal
          PageSize = 1
          Frequency = 1
          Position = 0
          SelEnd = 0
          SelStart = 0
          TabOrder = 7
          ThumbLength = 11
          TickMarks = tmTopLeft
          TickStyle = tsAuto
          OnChange = TrackBar1Change
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      object Panel10: TPanel
        Left = -13
        Top = 0
        Width = 795
        Height = 32
        BevelOuter = bvNone
        TabOrder = 0
        object Button3: TButton
          Left = 9
          Top = 4
          Width = 89
          Height = 23
          Action = ActCloseMonitor
          Caption = #20851#38381#26174#31034#22120
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
  object Timer1: TTimer
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 736
  end
  object OpenDlg: TOpenDialog
    Filter = 'Mp3 files (*.mp3)|*.mp3|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Left = 704
  end
  object ActionList1: TActionList
    Left = 768
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
end
