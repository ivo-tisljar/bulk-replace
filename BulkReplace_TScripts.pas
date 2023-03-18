unit BulkReplace_TScripts;

interface


uses
  System.Generics.Collections,
  BulkReplace_TScript;


type
  TScripts = class (TList<TScript>)
    procedure AddScript (const xScriptType, xFind, xReplace: String);
    procedure DeleteAll;
    function  ExecAllReplaceScripts (s: string): string;
  end;


var
  Scripts : TScripts;


procedure LoadScripts (const ScriptFile: string);


implementation

uses
  System.Classes, System.SysUtils;


procedure LoadScripts (const ScriptFile: string);
var
  ScriptList  : TStringList;
  CurrentLine : integer;
begin
  try
    Scripts.DeleteAll;
    ScriptList := TStringList.Create;
    ScriptList.LoadFromFile (ScriptFile, TEncoding.UTF8);
    CurrentLine := 0;
    with ScriptList do
      while (CurrentLine < Count - FieldsCount + 1) do
        begin
          Scripts.AddScript (Strings[CurrentLine], Strings[CurrentLine + 1], Strings[CurrentLine + 2]);
          Inc (CurrentLine, FieldsCount + SeparatorLinesCount);
        end;
  finally
    FreeAndNil (ScriptList);
  end;
end;


procedure TScripts.DeleteAll;
begin
  while Count > 0 do
    begin
      FreeAndNil (List[Count - 1]);
      Delete (Count - 1);
    end;
end;


procedure TScripts.AddScript (const xScriptType, xFind, xReplace: String);
begin
  Scripts.Add (TScript.Create (xScriptType, xFind, xReplace));
  if List[Count - 1].ScriptType = stInvalid then
    raise Exception.Create('Neispravan tip skripte: ' + xScriptType);
end;


function TScripts.ExecAllReplaceScripts (s: string): string;
var
  iScript : integer;
begin
  Result := s;
  for iScript := 0 to Scripts.Count - 1 do
    Result := Scripts[iScript].ExecReplaceScript (Result);
end;


initialization

  Scripts := TScripts.Create;


finalization

  FreeAndNil (Scripts);

end.
