unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Arrow, Menus, acs_mixer, CADSys4, SdpoJoystick, A3nalogGauge,
  IndLed, LedNumber, AdvLed, BCGameGrid, BCSVGViewer, gpssignalplot, gpsskyplot,
  gpstarget, nmeadecode, gpsportconnected, uplaysound, ulazautoupdate,
  lNetComponents, config, cd10w, camera, map, ConectionCX10W, funcs, GPS;

const
     refJoy : integer = 127;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    A3nalogGauge1: TA3nalogGauge;
    AcsMixer1: TAcsMixer;
    AdvCamera: TAdvLed;
    AdvJoyB2: TAdvLed;
    AdvJoyB3: TAdvLed;
    AdvJoyB4: TAdvLed;
    AdvJoyB5: TAdvLed;
    AdvJoyB6: TAdvLed;
    AdvJoystick: TAdvLed;
    AdvJoyB1: TAdvLed;
    AdvMap: TAdvLed;
    AdvGPS: TAdvLed;
    AdvStart: TAdvLed;
    ArrowLeft: TArrow;
    ArrowUp: TArrow;
    ArrowRigth: TArrow;
    ArrowDown: TArrow;
    btGridCAM: TButton;
    btGridCAM1: TButton;
    Button1: TButton;
    btExit: TButton;
    GPSPortConnected1: TGPSPortConnected;
    Label10: TLabel;
    Label11: TLabel;
    lbB1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ledrotor1: TLEDNumber;
    ledrotor3: TLEDNumber;
    ledrotor2: TLEDNumber;
    ledrotor4: TLEDNumber;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    NMEADecode1: TNMEADecode;
    Panel1: TPanel;
    playsound1: Tplaysound;
    pnBaterry: TPanel;
    pnScreens: TPanel;
    pnNAV: TPanel;
    Panel3: TPanel;
    popTray: TPopupMenu;
    SdpoJoystick1: TSdpoJoystick;
    timerJoystick: TTimer;
    TrayIcon1: TTrayIcon;
    procedure AdvGPSChange(Sender: TObject; AState: TLedState);
    procedure AdvGPSClick(Sender: TObject);
    procedure AdvMapChange(Sender: TObject; AState: TLedState);
    procedure AdvCameraChange(Sender: TObject; AState: TLedState);
    procedure AdvCameraClick(Sender: TObject);
    procedure AdvMapClick(Sender: TObject);
    procedure AdvStartChange(Sender: TObject; AState: TLedState);
    procedure AdvStartClick(Sender: TObject);
    procedure ArrowUpChangeBounds(Sender: TObject);
    procedure lbB1Click(Sender: TObject);
    procedure btExitClick(Sender: TObject);
    procedure btGridCAM1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure gridCamClickControl(Sender: TObject; n, x, y: integer);
    procedure btGridCAMClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GPSSignalPlot1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure indLed1Click(Sender: TObject);
    procedure ledrotor1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure Shape1ChangeBounds(Sender: TObject);
    procedure timerJoystickTimer(Sender: TObject);

  private



  public
      X,Y,Z : byte;
      B1,B2,B3, B4,B5,B6 : byte;


      frmConnection : Tform;
      procedure AtivaJoystick();
      procedure DesativaJoystick();
      procedure ConfiguraJoy();
      procedure DesativaDrone();
      procedure AtivaDrone();
      procedure AtivouDrone();
      procedure AtivaGPS();
      procedure DesativaGPS();

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  TrayIcon1.Visible:=true;
end;

procedure TfrmMain.btGridCAMClick(Sender: TObject);
begin
  frmCam.gridCam.Visible:=not frmcam.gridCam.Visible;
end;

procedure TfrmMain.gridCamClickControl(Sender: TObject; n, x, y: integer);
begin

end;

procedure TfrmMain.btGridCAM1Click(Sender: TObject);
begin
  frmmap.gridMAP.Visible:= not frmmap.gridMAP.Visible;
end;

procedure TfrmMain.AdvCameraClick(Sender: TObject);
begin
    if frmCam.Visible then
  begin
    frmCam.hide;
    AdvCamera.Blink:= false;
    AdvCamera.State:=lsoff;
  end
  else
  begin
    frmCam.show;
    AdvCamera.Blink:= true;
    AdvCamera.State:=lson;
  end;
end;

procedure TfrmMain.AdvMapClick(Sender: TObject);
begin
    if frmMap.Visible then
  begin
    frmMap.hide;
    advmap.state:= lsoff;
    AdvMap.Blink:= false;
  end
  else
  begin
    frmMap.show;
    AdvMap.Blink:= true;
    advmap.state:= lson;

  end;
end;

procedure TfrmMain.AdvStartChange(Sender: TObject; AState: TLedState);
begin

end;

procedure TfrmMain.AtivaGPS();
begin
     AdvGPS.Blink:=false;
     advGPS.State:= lsOn;

end;

procedure TfrmMain.DesativaGPS();
begin
     frmmain.AdvGPS.Blink:=false;
     frmmain.advGPS.State:= lsOff;
end;

procedure TfrmMain.AtivaJoystick();
begin
  try
    SdpoJoystick1.Active:= true;
    AdvJoystick.State := lsOn;
    AdvJoystick.Blink:= false;
    timerJoystick.Enabled:= true;
     X := refJoy;
     Y := refJoy;
     Z := refJoy;
  Except
    AdvJoystick.State := lsOff;
    AdvJoystick.Blink:= false;
    Beep;
  end;
end;

procedure TfrmMain.DesativaJoystick();
begin
  timerJoystick.Enabled:= false;
  AdvJoystick.State := lsOff;
  AdvJoystick.Blink:= false;
end;


procedure TfrmMain.ConfiguraJoy();
begin
  if frmconfig.cbDevice.ItemIndex = 0 then
    SdpoJoystick1.DeviceWin:= dwJoystickID1
  else
    SdpoJoystick1.DeviceWin:= dwJoystickID2;

end;

procedure TFrmMain.AtivouDrone();
begin
     AdvStart.Blink:=false;
     AdvStart.State:= lsOn;
end;

procedure TfrmMain.AtivaDrone();
begin

    if frmConnection = nil then
    begin
      if (frmconfig.TipoAtivo = 0) then
      begin
         //Carregando o protocolo do drone
         frmConnection := TfrmConectionCX10W.Create(self);
         //Mostrando a tela
         TfrmConectionCX10W( frmconnection).show();
         //Pegando a configuracao
         TfrmConectionCX10W(frmconnection).PegaConfiguracao();

         //Dando Inicio ao HandShak
         TfrmConectionCX10W(frmconnection).InicioHandShake();
      end;
    end
    else
    begin
       //Mostrando a tela
       frmconnection.show();

    end;

end;

procedure TfrmMain.DesativaDrone();
begin
  if frmConnection <> nil then
  begin
      if (frmconfig.TipoAtivo = 0) then
      begin
         //Iniciando o desligamento do drone
         frmconnection.hide();

      end;
      TfrmConectionCX10W( frmConnection).Destroy;
      FreeAndNil(frmConnection);
  end;
end;

procedure TfrmMain.AdvStartClick(Sender: TObject);
begin
  if  AdvStart.State = lsOff then
  begin

    AdvStart.State:= lson;
    AdvStart.Blink:= True;
    SdpoJoystick1.Active:=false;
    ConfiguraJoy();
    AtivaJoystick();
    AtivaDrone();

  end
  else
  begin
    AdvStart.State:= lsoff;
    AdvStart.Blink:= false;
    DesativaJoystick();
    DesativaDrone();

  end;
end;

procedure TfrmMain.ArrowUpChangeBounds(Sender: TObject);
begin

end;

procedure TfrmMain.lbB1Click(Sender: TObject);
begin

end;

procedure TfrmMain.btExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.AdvCameraChange(Sender: TObject; AState: TLedState);
begin

end;

procedure TfrmMain.AdvMapChange(Sender: TObject; AState: TLedState);
begin

end;

procedure TfrmMain.AdvGPSChange(Sender: TObject; AState: TLedState);
begin

end;

procedure TfrmMain.AdvGPSClick(Sender: TObject);
begin
   if frmGPS.Visible then
  begin
    frmGPS.hide;
    advGPS.state:= lsoff;
    AdvGPS.Blink:= false;
  end
  else
  begin
    frmGPS.show;
    AdvGPS.Blink:= true;
    advGPS.state:= lson;

  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  frmConfig.showmodal;
end;

procedure TfrmMain.GPSSignalPlot1Click(Sender: TObject);
begin

end;

procedure TfrmMain.Image1Click(Sender: TObject);
begin

end;

procedure TfrmMain.indLed1Click(Sender: TObject);
begin

end;

procedure TfrmMain.ledrotor1Click(Sender: TObject);
begin

end;

procedure TfrmMain.MenuItem1Click(Sender: TObject);
begin
  frmconfig.show;
end;

procedure TfrmMain.MenuItem2Click(Sender: TObject);
begin
  frmMain.show;
  if frmConnection<>nil then
  begin
    frmConnection.show;
  end;
  if AdvCamera.State = lsOn then
  begin
    frmCam.show;
  end;
  if AdvMap.State = lsOn then
  begin
    frmMap.show;
  end;
end;

procedure TfrmMain.MenuItem3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.Shape1ChangeBounds(Sender: TObject);
begin

end;

procedure TfrmMain.timerJoystickTimer(Sender: TObject);
var
  X0, Y0, Z0 : double;

begin
  X0 := MAPA(0,65535,0,255,SdpoJoystick1.Axis[0].ToSingle);
  Y0 := MAPA(0,65535,0,255,SdpoJoystick1.Axis[1].ToSingle);
  Z0 := MAPA(0,65535,0,255,SdpoJoystick1.Axis[2].ToSingle);

  //Programação joy posicao padrao
  if (B5=255) then
  begin
    X := refJoy;
    y := refJoy;
    Z := refJoy;
  end;


  if (Y0 < 120) then
  begin
    ArrowUp.ArrowColor:=clRED;
    if (Y<255) then
    begin
         inc(Y);
    end;
    if (Y < refJoy) then
    begin
      Y := refJoy;
    end;
  end
  else
  begin
    ArrowUp.ArrowColor:=clBlack;
    if ((Y0=refJoy) and (Y>refJoy) and (B6 = 0)) then
    begin
      dec(Y);
    end;

  end;

  if (Y0 > 140) then
  begin
    ArrowDown.ArrowColor:=clRED;
    if (Y>0) then
    begin
        dec(Y);
    end;

    if (Y > refJoy) then
    begin
      Y := refJoy;
    end;
  end
  else
  begin
    ArrowDown.ArrowColor:=clBlack;
    if ((Y0=refJoy) and (Y<refJoy) and (B6 = 0)) then
    begin
      inc(Y);
    end;

  end;

  if ( X0 < 120) then
  begin
    ArrowLeft.ArrowColor:=clRED;
    if (X<255) then
    begin
         inc(X);
    end;
    if (X < refJoy) then
    begin
      X := refJoy;
    end;
  end
  else
  begin
    ArrowLeft.ArrowColor:=clBlack;
    if ((X0=refJoy) and (X>refJoy) and (B6 = 0)) then
    begin
      dec(X);
    end;

  end;

  if ( X0 > 140) then
  begin
    ArrowRigth.ArrowColor:=clRED;
    if (X>0) then
    begin
        dec(X);
    end;
    if (X > refJoy) then
    begin
      X := refJoy;
    end;
  end
  else
  begin
    ArrowRigth.ArrowColor:=clBlack;
    if ((X0=refJoy) and (X<refJoy) and (B6 = 0)) then
    begin
      inc(X);
    end;

  end;

  if frmMain.SdpoJoystick1.Buttons[0].ToBoolean then
  begin
    B1:=255;
    AdvJoyB1.State:= lsOn;
  end
  else
  begin
    B1:=0;
    AdvJoyB1.State:= lsOff;
  end;
  if frmMain.SdpoJoystick1.Buttons[1].ToBoolean then
  begin
    B2:=255;
    AdvJoyB2.State:= lsOn;
  end
  else
  begin
    B2:=0;
    AdvJoyB2.State:= lsOff;
  end;
  if frmMain.SdpoJoystick1.Buttons[2].ToBoolean then
  begin
    B3:=255;
    AdvJoyB3.State:= lsOn;
  end
  else
  begin
    B3:=0;
    AdvJoyB3.State:= lsOff;
  end;
  if frmMain.SdpoJoystick1.Buttons[3].ToBoolean then
  begin
    B4:=255;
    AdvJoyB4.State:= lsOn;
  end
  else
  begin
    B4:=0;
    AdvJoyB4.State:= lsOff;
  end;
  if frmMain.SdpoJoystick1.Buttons[4].ToBoolean then
  begin
    B5:=255;
    AdvJoyB5.State:= lsOn;
  end
  else
  begin
    B5:=0;
    AdvJoyB5.State:= lsOff;
  end;
  if frmMain.SdpoJoystick1.Buttons[5].ToBoolean then
  begin
    B6 := 255;
    AdvJoyB6.State:= lsOn;
  end
  else
  begin
    B6 := 0;
    AdvJoyB6.State:= lsOff;
  end;

  //X:= byte(trunc(X0) and $FF);
  //Y:= byte(trunc(Y0) and $FF);
  //Z:= byte(trunc(Z0) and $FF);

  ledrotor1.caption := inttostr(X);
  ledrotor2.caption := inttostr(Y);
  ledrotor3.caption := inttostr(Z);



end;

end.

