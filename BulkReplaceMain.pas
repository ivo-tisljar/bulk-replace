unit BulkReplaceMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  BulkReplace_TFiles, BulkReplace_TScripts;

type
  TFormMain = class(TForm)
    LabelScript: TLabel;
    EditScript: TEdit;
    LabelFilter: TLabel;
    EditFilter: TEdit;
    LabelDirectory: TLabel;
    EditDirectory: TEdit;
    ButtonReplace: TButton;
    LabelReport: TLabel;
    MemoReport: TMemo;
    CheckBoxSubDirectories: TCheckBox;
    procedure ButtonReplaceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.ButtonReplaceClick(Sender: TObject);
begin
  LoadScripts (EditScript.Text);
  Files.LoadFilenames (EditDirectory.Text, EditFilter.Text, CheckBoxSubDirectories.Checked);
  Files.ProcessAllFiles;
end;

end.
