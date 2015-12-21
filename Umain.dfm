object Metrika: TMetrika
  Left = 398
  Top = 205
  Width = 1310
  Height = 640
  BorderIcons = [biSystemMenu]
  Caption = #1040#1085#1072#1083#1080#1079' '#1082#1086#1076#1072' '#1087#1086' '#1084#1077#1090#1088#1080#1082#1077' '#1061#1086#1083#1089#1090#1077#1076#1072
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object __Label_Class: TLabel
    Left = 8
    Top = 8
    Width = 42
    Height = 19
    Caption = 'Class:'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label_UniqueOperator: TLabel
    Left = 440
    Top = 32
    Width = 260
    Height = 19
    Caption = #1063#1080#1089#1083#1086' '#1091#1085#1080#1082#1072#1083#1100#1085#1099#1093' '#1086#1087#1077#1088#1072#1090#1086#1088#1086#1074' (n1):'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label_UniqueOperand: TLabel
    Left = 440
    Top = 72
    Width = 253
    Height = 19
    Caption = #1063#1080#1089#1083#1086' '#1091#1085#1080#1082#1072#1083#1100#1085#1099#1093' '#1086#1087#1077#1088#1072#1085#1076#1086#1074' (n2):'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label_Operator: TLabel
    Left = 440
    Top = 120
    Width = 219
    Height = 19
    Caption = #1054#1073#1097#1077#1077' '#1095#1080#1089#1083#1086' '#1086#1087#1077#1088#1072#1090#1086#1088#1086#1074' (N1):'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label_Operand: TLabel
    Left = 440
    Top = 168
    Width = 212
    Height = 19
    Caption = #1054#1073#1097#1077#1077' '#1095#1080#1089#1083#1086' '#1086#1087#1077#1088#1072#1085#1076#1086#1074' (N2):'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label_Volume: TLabel
    Left = 440
    Top = 296
    Width = 260
    Height = 19
    Caption = #1054#1073#1098#1077#1084' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'( V = N * log2(n) ):'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label_Dictionary: TLabel
    Left = 440
    Top = 208
    Width = 249
    Height = 19
    Caption = #1057#1083#1086#1074#1072#1088#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' ( n = n1 + n2 ):'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label_Length: TLabel
    Left = 440
    Top = 248
    Width = 246
    Height = 19
    Caption = #1044#1083#1080#1085#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' ( N = N1 + N2 ):'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo_Class1: TMemo
    Left = 8
    Top = 32
    Width = 409
    Height = 281
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      '')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Clean_But: TButton
    Left = 8
    Top = 320
    Width = 161
    Height = 41
    Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1082#1086#1076
    TabOrder = 1
    OnClick = Clean_ButClick
  end
  object Edit_UniqueOperator: TEdit
    Left = 800
    Top = 32
    Width = 129
    Height = 21
    TabOrder = 2
  end
  object Edit_UniqueOperand: TEdit
    Left = 800
    Top = 72
    Width = 129
    Height = 21
    TabOrder = 3
  end
  object Edit_AllOperator: TEdit
    Left = 800
    Top = 120
    Width = 129
    Height = 21
    TabOrder = 4
  end
  object Edit_AllOperand: TEdit
    Left = 800
    Top = 168
    Width = 129
    Height = 21
    TabOrder = 5
  end
  object Analyze_But: TButton
    Left = 256
    Top = 320
    Width = 161
    Height = 41
    Caption = #1040#1085#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1082#1086#1076
    TabOrder = 6
    OnClick = Analyze_ButClick
  end
  object Edit_Dictionary: TEdit
    Left = 800
    Top = 208
    Width = 129
    Height = 21
    TabOrder = 7
  end
  object Edit_Length: TEdit
    Left = 800
    Top = 248
    Width = 129
    Height = 21
    TabOrder = 8
  end
  object Edit_Volume: TEdit
    Left = 800
    Top = 296
    Width = 129
    Height = 21
    TabOrder = 9
  end
  object Exit_But: TButton
    Left = 120
    Top = 456
    Width = 161
    Height = 41
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 10
    OnClick = Exit_ButClick
  end
  object xpmnfst1: TXPManifest
    Left = 1264
  end
end
