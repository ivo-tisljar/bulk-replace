object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = ' Bulk Replace v1.0'
  ClientHeight = 401
  ClientWidth = 624
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  DesignSize = (
    624
    401)
  TextHeight = 16
  object LabelScript: TLabel
    Left = 24
    Top = 24
    Width = 62
    Height = 16
    Caption = 'Script File:'
    FocusControl = EditScript
  end
  object LabelFilter: TLabel
    Left = 24
    Top = 64
    Width = 90
    Height = 16
    Caption = 'Filename Filter:'
    FocusControl = EditFilter
  end
  object LabelDirectory: TLabel
    Left = 24
    Top = 104
    Width = 107
    Height = 16
    Caption = 'Working Directory:'
    FocusControl = EditDirectory
  end
  object LabelReport: TLabel
    Left = 24
    Top = 232
    Width = 101
    Height = 16
    Caption = 'Execution Report:'
    FocusControl = MemoReport
  end
  object EditScript: TEdit
    Left = 168
    Top = 21
    Width = 429
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'D:\HtmlFilter-test\bulk text replace script file.txt'
  end
  object EditFilter: TEdit
    Left = 168
    Top = 61
    Width = 429
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = '*.html'
  end
  object EditDirectory: TEdit
    Left = 168
    Top = 101
    Width = 429
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = 'D:\HtmlFilter-test\html-edit\rrif-2023-01\'
  end
  object ButtonReplace: TButton
    Left = 24
    Top = 184
    Width = 573
    Height = 33
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Replace in Files'
    TabOrder = 3
    OnClick = ButtonReplaceClick
  end
  object MemoReport: TMemo
    Left = 24
    Top = 254
    Width = 573
    Height = 124
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object CheckBoxSubDirectories: TCheckBox
    Left = 168
    Top = 145
    Width = 153
    Height = 17
    Caption = ' Include SubDirectories'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
end
