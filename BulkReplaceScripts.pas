unit BulkReplaceScripts;

interface

uses
  System.Generics.Collections;

const
  FieldsCount = 3;
  SeparatorLinesCount = 1;

type
  TScriptType = (stText, stExtended, stRegExp, stInvalid);

const
  ScriptTypeName : array [TScriptType] of string =(
    'txt',
    'ext',
    'reg',
    '');

type
  TScript = class (TObject)
    ScriptType : TScriptType;
    Find       : string;
    Replace    : string;
    constructor Create (const xScriptType, xFind, xReplace: String);
  end;

type
  TScripts = class (TList<TScript>)
    procedure DeleteAll;
    procedure AddScript (const xScriptType, xFind, xReplace: String);
  end;

var
  Scripts : TScripts;

procedure LoadScripts (const ScriptFile: string);


implementation

uses
  System.Classes, System.SysUtils;


function GetScriptType (const ScriptType: string): TScriptType;
var
  st : TScriptType;
begin
  Result := stInvalid;
  for st := Low(TScriptType) to High(TScriptType) do
    if ScriptType = ScriptTypeName[st] then
      Result := st;
end;


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


constructor TScript.Create (const xScriptType, xFind, xReplace: String);
begin
  inherited Create;
  ScriptType := GetScriptType (xScriptType);
  Find := xFind;
  Replace := xReplace;
end;


procedure TScripts.AddScript (const xScriptType, xFind, xReplace: String);
begin
  Scripts.Add (TScript.Create (xScriptType, xFind, xReplace));
  if List[Count - 1].ScriptType = stInvalid then
    raise Exception.Create('Neispravan tip skripte: ' + xScriptType);
end;


initialization

  Scripts := TScripts.Create;


finalization

  FreeAndNil (Scripts);

end.
