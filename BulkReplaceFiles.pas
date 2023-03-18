unit BulkReplaceFiles;

interface

uses
  System.Classes, System.SysUtils;

type
  TFiles = class (TStringList)
    procedure LoadFilenames (const sDirectory, sFilter: string);
  end;

var
  Files : TFiles;

implementation

procedure TFiles.LoadFilenames (const sDirectory, sFilter: string);
var
  SearchRec: TSearchRec;
begin
  Self.Clear;
  try
    if FindFirst (sDirectory + sFilter, faAnyFile, SearchRec) = 0 then
      repeat
        Self.Add (sDirectory + SearchRec.Name);
      until FindNext (SearchRec) <> 0;
  finally
    FindClose (SearchRec);
  end;

end;

initialization

  Files := TFiles.Create;

finalization

  FreeAndNil (Files);

end.
