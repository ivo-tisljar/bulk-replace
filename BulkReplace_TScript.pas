unit BulkReplace_TScript;

interface


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
    function ExecReplaceScript (s: string): string;
  end;


implementation

uses
  System.Classes, System.RegularExpressions, System.StrUtils, System.SysUtils;


function GetScriptType (const ScriptType: string): TScriptType;
var
  st : TScriptType;
begin
  Result := stInvalid;
  for st := Low(TScriptType) to High(TScriptType) do
    if ScriptType = ScriptTypeName[st] then
      Result := st;
end;


function ReplaceCrLfTab (s: string): string;
begin
  Result := ReplaceStr (ReplaceStr (ReplaceStr (s, '\r', #13), '\n', #10), '\t', #9);
end;


constructor TScript.Create (const xScriptType, xFind, xReplace: String);
begin
  inherited Create;
  ScriptType := GetScriptType (xScriptType);
  if ScriptType = stExtended then
    begin
      Find := ReplaceCrLfTab (xFind);
      Replace := ReplaceCrLfTab (xReplace);
    end
  else
    begin
      Find := xFind;
      Replace := xReplace;
    end;
end;


function TScript.ExecReplaceScript (s: string): string;
var
  res : string;
begin
  Result := s;
  repeat
    res := Result;
    case ScriptType of
      stText, stExtended:
        Result := ReplaceText (Result, Find, Replace);
      stRegExp:
        Result := TRegEx.Replace (Result, Find, Replace, [roIgnoreCase]);
    end;
  until (res = Result);
end;


end.
