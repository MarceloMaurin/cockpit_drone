program drone;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, opengpsx, mplayercontrollaz, LazSerialPort, sdposeriallaz, laz_acs,
  lnetvisual, main, config, cd10w, About, Camera, map, joystick, ConectionCX10W,
  funcs, GPS
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(Tfrmconfig, frmconfig);
  Application.CreateForm(TfrmCam, frmCam);
  Application.CreateForm(TfrmMap, frmMap);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmGPS, frmGPS);
  Application.Run;
end.

