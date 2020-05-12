unit Unit3;

interface
uses classes,sysutils;
type

tmidfile=class (tobject)
filename:string;
trkcount:integer;
constructor create;
function open:boolean;
procedure close;



end ;

implementation

{ tmidfile }

procedure tmidfile.close;
begin

end;

constructor tmidfile.create;
begin

end;

function tmidfile.open: boolean;
begin

end;

end.
 