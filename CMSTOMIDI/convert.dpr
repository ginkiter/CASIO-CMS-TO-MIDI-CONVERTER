program convert;

uses
  Forms,unit2;

{$R *.res}
       var
       cms:tcmsfile;
begin
  Application.Initialize;

  cms:=tcmsfile.create;
  try
  exitcode:=cms.convertfile(paramstr(1),paramstr(2),paramstr(3),false);
     except ;
     exitcode:=9;
     end;
   
  cms.Free;
  Application.Run;
end.
