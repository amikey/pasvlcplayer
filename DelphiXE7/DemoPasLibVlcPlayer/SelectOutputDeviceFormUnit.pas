unit SelectOutputDeviceFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSelectOutputDeviceForm = class(TForm)
    OutputDevicesLB: TListBox;
    OkBtn: TButton;
    CancelBtn: TButton;
    OutputDevicesLabel: TLabel;
    procedure OkBtnClick(Sender: TObject);
    procedure OutputDevicesLBDblClick(Sender: TObject);
    procedure OutputDevicesLBDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SelectOutputDeviceForm: TSelectOutputDeviceForm;

implementation

{$R *.dfm}

procedure TSelectOutputDeviceForm.OkBtnClick(Sender: TObject);
begin
  if (OutputDevicesLB.ItemIndex < 0) then
  begin
    ModalResult := mrCancel;
  end
  else
  begin
    ModalResult := mrOK;
  end;
end;

procedure TSelectOutputDeviceForm.OutputDevicesLBDblClick(Sender: TObject);
begin
  if (OutputDevicesLB.ItemIndex > -1) then
  begin
    ModalResult := mrOK;
  end;
end;

procedure TSelectOutputDeviceForm.OutputDevicesLBDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  str : string;
begin
  with (Control as TListBox).Canvas do
  begin
    FillRect(Rect);
    str := (Control as TListBox).Items[Index];
    TextOut(Rect.Left + 2, Rect.Top + 1, Copy(str, Pos('|', str) + 1, MaxInt));
  end;
end;

end.
