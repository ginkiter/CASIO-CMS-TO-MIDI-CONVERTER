object Form1: TForm1
  Left = 233
  Top = 168
  Width = 1115
  Height = 510
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1099
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label3: TLabel
      Left = 104
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Label3'
    end
    object Button1: TButton
      Left = 24
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Open file'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Memo3: TMemo
      Left = 808
      Top = 1
      Width = 290
      Height = 47
      Align = alRight
      Lines.Strings = (
        'Memo3')
      TabOrder = 1
      OnExit = Memo3Exit
    end
  end
  object Panel2: TPanel
    Left = 321
    Top = 70
    Width = 778
    Height = 404
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object memo1: TRichEdit
      Left = 1
      Top = 1
      Width = 776
      Height = 402
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'memo2')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object ts: TTabSet
    Left = 0
    Top = 49
    Width = 1099
    Height = 21
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    OnChange = tsChange
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 70
    Width = 321
    Height = 404
    ActivePage = TabSheet1
    Align = alLeft
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = #1042#1089#1077
      object se1: TSpinEdit
        Left = 136
        Top = 8
        Width = 121
        Height = 22
        MaxValue = 999999999
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = se1Change
      end
      object rb1: TRadioButton
        Left = 8
        Top = 8
        Width = 113
        Height = 17
        Caption = 'rb1'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = rb1Click
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 56
        Width = 320
        Height = 217
        DataSource = DataSource1
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'aname'
            Width = 144
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'start'
            Width = 41
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'end'
            Width = 46
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'len'
            Width = 25
            Visible = True
          end>
      end
      object rb5: TRadioButton
        Left = 8
        Top = 32
        Width = 113
        Height = 17
        Caption = 'rb4'
        TabOrder = 3
        OnClick = rb1Click
      end
      object Button2: TButton
        Left = 208
        Top = 336
        Width = 75
        Height = 25
        Caption = 'Button2'
        TabOrder = 4
        OnClick = Button2Click
      end
      object Button4: TButton
        Left = 8
        Top = 288
        Width = 43
        Height = 25
        Caption = 'midi'
        TabOrder = 5
        OnClick = Button4Click
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 336
        Width = 49
        Height = 17
        Caption = 'n'
        TabOrder = 6
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Midi convert'
      ImageIndex = 1
      object DriveComboBox1: TDriveComboBox
        Left = 0
        Top = 8
        Width = 145
        Height = 19
        DirList = DirectoryListBox1
        TabOrder = 0
      end
      object DirectoryListBox1: TDirectoryListBox
        Left = 0
        Top = 32
        Width = 145
        Height = 265
        FileList = FileListBox1
        ItemHeight = 16
        TabOrder = 1
      end
      object FileListBox1: TFileListBox
        Left = 144
        Top = 32
        Width = 145
        Height = 265
        ItemHeight = 13
        Mask = '*.kar;*.mid'
        TabOrder = 2
        OnChange = FileListBox1Change
        OnDblClick = FileListBox1DblClick
      end
      object ComboBox1: TComboBox
        Left = 32
        Top = 312
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        Text = 'ComboBox1'
        OnChange = ComboBox1Change
      end
      object CheckBox2: TCheckBox
        Left = 208
        Top = 320
        Width = 97
        Height = 17
        Caption = 'Play'
        TabOrder = 4
        OnClick = CheckBox2Click
      end
      object Edit3: TEdit
        Left = 184
        Top = 344
        Width = 121
        Height = 21
        TabOrder = 5
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'CMS '#1092#1072#1081#1083
      ImageIndex = 2
      object SpeedButton1: TSpeedButton
        Left = 272
        Top = 8
        Width = 23
        Height = 22
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
          3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
          33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
          33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
          333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
          03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
          33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
          0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
          3333333337FFF7F3333333333000003333333333377777333333}
        NumGlyphs = 2
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 272
        Top = 328
        Width = 23
        Height = 22
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333FF3FFFF3FFF33FF003000030003
          300077377773777F377703330033370337037FFF77F3377FF77F700007333300
          0003777777333377777F303003333330370337F77F333337377F303073333333
          070337F77F333333777F3700733333333003377773333333377F330033333333
          30033377F3333333377F33073333333333033377333333333373333333333333
          33333333FF3333333FF3333973333333793333377FF3333377F3333999333339
          993333377733333777F33339933333339933333773FF333377F3333939733379
          39333337377FFF77373333333399999333333333337777733333}
        NumGlyphs = 2
        OnClick = SpeedButton2Click
      end
      object DirectoryListBox2: TDirectoryListBox
        Left = 0
        Top = 32
        Width = 145
        Height = 265
        FileList = FileListBox2
        ItemHeight = 16
        TabOrder = 0
      end
      object DriveComboBox2: TDriveComboBox
        Left = 0
        Top = 8
        Width = 145
        Height = 19
        DirList = DirectoryListBox2
        TabOrder = 1
      end
      object Button3: TButton
        Left = 0
        Top = 328
        Width = 131
        Height = 25
        Caption = #1050#1086#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 2
        OnClick = Button3Click
      end
      object FileListBox2: TFileListBox
        Left = 144
        Top = 32
        Width = 145
        Height = 265
        ItemHeight = 13
        Mask = '*.CMS'
        TabOrder = 3
        OnChange = FileListBox2Change
      end
      object Edit1: TEdit
        Left = 144
        Top = 304
        Width = 121
        Height = 21
        TabOrder = 4
        Text = 'Pesnya'
      end
      object Edit2: TEdit
        Left = 144
        Top = 328
        Width = 121
        Height = 21
        TabOrder = 5
        Text = 'Edit2'
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'midi|*.mid|csm|*.csm|ac7|*.ac7'
    Left = 648
    Top = 96
  end
  object cds: TClientDataSet
    Aggregates = <>
    FileName = 'data.cds'
    FieldDefs = <
      item
        Name = 'aname'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'start'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'end'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'len'
        DataType = ftSmallint
      end>
    IndexDefs = <
      item
        Name = 'cdsIndex1'
        Fields = 'start'
      end>
    IndexName = 'cdsIndex1'
    Params = <>
    StoreDefs = True
    BeforePost = cdsBeforePost
    Left = 345
    Top = 230
  end
  object DataSource1: TDataSource
    DataSet = cds
    OnDataChange = DataSource1DataChange
    Left = 393
    Top = 230
  end
  object OpenDialog2: TOpenDialog
    Left = 696
    Top = 104
  end
  object SaveDialog1: TSaveDialog
    Left = 361
    Top = 134
  end
  object MidiFile1: TMidiFile
    Bpm = 0
    OnMidiEvent = MidiFile1MidiEvent
    OnUpdateEvent = MidiFile1UpdateEvent
    Left = 505
    Top = 118
  end
  object MidiOutput1: TMidiOutput
    Left = 537
    Top = 118
  end
end
