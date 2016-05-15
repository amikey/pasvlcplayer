program FmxDemoPasLibVlc;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
