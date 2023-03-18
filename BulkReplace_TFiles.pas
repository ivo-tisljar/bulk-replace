unit BulkReplace_TFiles;

interface


uses
  System.Classes, System.SysUtils;


type
  TFiles = class (TStringList)
    procedure LoadFilenames (const sDirectory, sFilter: string; const IncludeSubDirectories: boolean);
    procedure LoadFilenamesSubDir (const sDirectory, sFilter: string; const IncludeSubDirectories: boolean);
    procedure ProcessAllFiles;
  end;


var
  Files : TFiles;


implementation


uses
  BulkReplace_TScripts;


procedure TFiles.LoadFilenames (const sDirectory, sFilter: string; const IncludeSubDirectories: boolean);
begin
  Self.Clear;
  LoadFilenamesSubDir (sDirectory, sFilter, IncludeSubDirectories);
end;


procedure TFiles.LoadFilenamesSubDir (const sDirectory, sFilter: string; const IncludeSubDirectories: boolean);
var
  SearchRec: TSearchRec;
begin
  try
    if FindFirst (sDirectory + sFilter, faAnyFile, SearchRec) = 0 then
      repeat
        Self.Add (sDirectory + SearchRec.Name);
      until FindNext (SearchRec) <> 0;
    FindClose (SearchRec);
    if IncludeSubDirectories And (FindFirst (sDirectory + '*', faDirectory, SearchRec) = 0) then
      repeat
        if (SearchRec.Name <> '.') And (SearchRec.Name <> '..') then
          LoadFilenamesSubDir (sDirectory + SearchRec.Name + '\', sFilter, True);
      until FindNext (SearchRec) <> 0;
  finally
    FindClose (SearchRec);
  end;
end;


procedure TFiles.ProcessAllFiles;
var
  iFile : integer;
  CurrentFile : TStringList;
begin
  try
    CurrentFile := TStringList.Create;
    for iFile := 0 to Count-1 do
      begin
        CurrentFile.LoadFromFile (Strings[iFile], TEncoding.UTF8);
        CurrentFile.Text := Scripts.ExecAllReplaceScripts (CurrentFile.Text);
        CurrentFile.SaveToFile (Strings[iFile], TEncoding.UTF8);
      end;
  finally
    FreeAndNil (CurrentFile);
  end;
end;


initialization

  Files := TFiles.Create;


finalization

  FreeAndNil (Files);

end.
