object FrmServerValue: TFrmServerValue
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = '  Adjust Server Settings'
  ClientHeight = 219
  ClientWidth = 187
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 23
    Top = 14
    Width = 70
    Height = 13
    Caption = 'Hum Limit Time'
  end
  object Label2: TLabel
    Left = 23
    Top = 42
    Width = 69
    Height = 13
    Caption = 'Mon Limit Time'
  end
  object Label3: TLabel
    Left = 23
    Top = 70
    Width = 67
    Height = 13
    Caption = 'Zen Limit Time'
  end
  object Label4: TLabel
    Left = 23
    Top = 98
    Width = 66
    Height = 13
    Caption = 'Soc Limit Time'
  end
  object Label5: TLabel
    Left = 23
    Top = 126
    Width = 69
    Height = 13
    Caption = 'NPC Limit Time'
  end
  object CheckBox1: TCheckBox
    Left = 23
    Top = 155
    Width = 138
    Height = 17
    Caption = 'View 1100X message'
    TabOrder = 0
  end
  object SpinEdit1: TSpinEdit
    Left = 107
    Top = 11
    Width = 56
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnKeyPress = SpinEdit1KeyPress
  end
  object SpinEdit2: TSpinEdit
    Left = 107
    Top = 39
    Width = 56
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object SpinEdit3: TSpinEdit
    Left = 107
    Top = 67
    Width = 56
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object SpinEdit4: TSpinEdit
    Left = 107
    Top = 95
    Width = 56
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object SpinEdit5: TSpinEdit
    Left = 107
    Top = 123
    Width = 56
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object BitBtn1: TBitBtn
    Left = 49
    Top = 185
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 6
  end
end
