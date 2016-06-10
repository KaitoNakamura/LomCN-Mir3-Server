object FrmMsgClient: TFrmMsgClient
  Left = 0
  Top = 0
  Caption = 'FrmMsgClient'
  ClientHeight = 148
  ClientWidth = 190
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MsgClient: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = MsgClientConnect
    OnDisconnect = MsgClientDisconnect
    OnRead = MsgClientRead
    OnError = MsgClientError
    Left = 80
    Top = 48
  end
end
