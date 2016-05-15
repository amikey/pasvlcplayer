{$I ..\..\source\compiler.inc}
program DemoPasLibVlcPlayer;

uses
  Forms,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas',
  PasLibVlcClassUnit in '..\..\source\PasLibVlcClassUnit.pas',
  PasLibVlcPlayerUnit in '..\..\source\PasLibVlcPlayerUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  FullScreenFormUnit in 'FullScreenFormUnit.pas' {FullScreenForm},
  SetEqualizerPresetFormUnit in 'SetEqualizerPresetFormUnit.pas' {SetEqualizerPresetForm},
  SelectOutputDeviceFormUnit in 'SelectOutputDeviceFormUnit.pas' {SelectOutputDeviceForm};

{$R *.res}

begin
  {$IFDEF DELPHI2007_UP}
  ReportMemoryLeaksOnShutdown := TRUE;
  {$ENDIF}
  
  Application.Initialize;
  {$IFDEF DELPHI2007_UP}
  Application.MainFormOnTaskbar := True;
  {$ENDIF}
  Application.Title := 'PasLibVlcPlayerDemo';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSetEqualizerPresetForm, SetEqualizerPresetForm);
  Application.CreateForm(TSelectOutputDeviceForm, SelectOutputDeviceForm);
  Application.Run;
end.
