program BulkReplace;

uses
  Vcl.Forms,
  BulkReplaceMain in 'BulkReplaceMain.pas' {FormMain},
  BulkReplace_TScripts in 'BulkReplace_TScripts.pas',
  BulkReplace_TFiles in 'BulkReplace_TFiles.pas',
  BulkReplace_TScript in 'BulkReplace_TScript.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
