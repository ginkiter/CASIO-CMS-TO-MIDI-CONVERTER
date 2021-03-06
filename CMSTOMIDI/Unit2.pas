unit Unit2;

interface

{$R myres.res}

  uses windows,forms,classes,sysutils,MidiFile;
type
   ttrackevent=record
   b1,b2,b3,b4,b5:byte;

   end;

ttrack=class(tobject)
data:array[1..1110000] of ttrackevent;
buffer:array[1..10110000] of byte;
buffersize:integer;
oldtick:integer;
sum:word;
tracklen:integer;
count:integer;



public

procedure addev(b1,b2,b3,b4:byte;tick:integer);
procedure settracklen;
procedure makebuffer;

constructor create;
end;

tcmsfile = class (tobject)
  private
    procedure makenew;



   public
   buffer:array[1..$ffffff] of byte;// �����
   buffersize:integer;
   nbuffer:array[1..$fffff] of byte;// �����
   nbuffersize:integer;
      chstats:longword;
 //  filename:string;
   logtext:string;
   tracks:array[0..16] of ttrack;
   procedure loaddata(ff:string);
   procedure savedata;
   procedure newfile(nf,sn:string);
   constructor create;
   procedure clear;

   function convertfile(midifilename,csmfilename,songname:string;makelog:boolean):integer;
   procedure setttp(attp:integer);
   end;

   var ttp:longword=1;

implementation

procedure tcmsfile.clear;

var i:integer;
begin
     for i:=0 to 16 do begin
             tracks[i].count:=0;
             tracks[i].tracklen:=0;

                       end;
      tracks[0].addev($22,$ff,$ff,0,0);
      for i:=1 to 16 do tracks[i].addev($fc,0,0,0,0);
        for i:=1 to 16 do tracks[i].sum:=0;
        chstats:=0;
end;

constructor tcmsfile.create;
var i:integer;
begin
  inherited;
  tracks[0]:=ttrack.Create;

  for i:=1 to 16 do tracks[i]:=ttrack.Create;

  clear;


end;

procedure tcmsfile.loaddata(ff:string);
var f:tfilestream;
begin
  f:=tfilestream.Create(ff,fmOpenRead	);
buffersize:=f.Size;
f.ReadBuffer(buffer,f.Size);
  f.Free;
end;

procedure tcmsfile.makenew;
begin

end;
  function Translit(s: string): string;
const
  rus: string = '�������������������������������������Ũ��������������������������';
  lat: array[1..66] of string = ('a', 'b', 'v', 'g', 'd', 'e', 'yo', 'zh', 'z', 'i', 'y', 'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f', 'kh', 'ts', 'ch', 'sh', 'shch', '''', 'y', '''', 'e', 'yu', 'ya', 'A', 'B', 'V', 'G', 'D', 'E', 'Yo', 'Zh', 'Z', 'I', 'Y', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F', 'Kh', 'Ts', 'Ch', 'Sh', 'Shch', '''', 'Y', '''', 'E', 'Yu', 'Ya');
var
  p, i, l: integer;
begin
  Result := '';
  l := Length(s);
  for i := 1 to l do
  begin
    p := Pos(s[i], rus);
    if p<1 then Result := Result + s[i] else Result := Result + lat[p];
  end;
end  ;
procedure tcmsfile.newfile(nf,sn:string);
var f:tfilestream; i,k,n,m:integer;
      rf:tresourcestream;
tl,maxlen,bufadr:integer;
begin
//loaddata(ExtractFileDir(application.ExeName)+'/5sername.cms');
   rf:=tresourcestream.Create(hinstance,'forma',RT_RCDATA);

buffersize:=rf.Size;
rf.ReadBuffer(buffer,rf.Size);


     rf.Free;


 f:=tfilestream.Create(nf,fmcreate);

 for i:=0 to buffersize do nbuffer[i]:=buffer[i];  //����� ���
 sn:=sn+'                          ';
 sn:=translit(sn);
 for i:=0 to 11   do nbuffer[i+$11e]:=ord(sn[i]);

 k:=$14f;      maxlen:=0; bufadr:=$178;
 for i:=0 to 16 do begin
 tl:= tracks[i].tracklen;
 if tl>0 then begin
 if  maxlen<tracks[i].tracklen then   maxlen:=tracks[i].tracklen;
 nbuffer[k]:=tracks[i].tracklen;
 nbuffer[k+1]:=tl shr 8;
 nbuffer[k+2]:=tl shr 16;
 nbuffer[k+3]:=tl shr 24;

 nbuffer[k+4]:= (tl div 96) div 4   ;
 nbuffer[k+5]:= $0;
 nbuffer[k+8]:= (tl div 96) mod 4 ;
 nbuffer[k+9]:= tl mod 96;

 end;

  bufadr:=bufadr+tracks[i].buffersize;
 if i<16 then begin
  nbuffer[k+10]:= bufadr;
  nbuffer[k+11]:= bufadr shr 8;
               end;
  nbuffer[k+14-18]:=tracks[i].buffersize;
  nbuffer[k+15-18]:=tracks[i].buffersize shr 8;
  nbuffer[k+16-18]:=tracks[i].buffersize shr 16;
  nbuffer[k+17-18]:=tracks[i].buffersize shr 24;
 k:=k+18;


                   end;
 nbuffer[$2a1]:=maxlen;
 nbuffer[$2a2]:=maxlen shr 8;
 nbuffer[$2a3]:=maxlen shr 16;
 nbuffer[$2a4]:=maxlen shr 24;

 nbuffer[$2a4+1]:= (maxlen div 96) div 4   ;
 nbuffer[$2a4+2]:= $0;
 nbuffer[$2a4+5]:= (maxlen div 96) mod 4 ;
 nbuffer[$2a4+6]:= maxlen mod 96;

for i:=16 downto 0 do begin
                 chstats:=chstats shl 1  ;
                 if tracks[i].count>1 then chstats :=chstats or 1;


                 end;
 nbuffer[$289]:=chstats;
 nbuffer[$28a]:=chstats shr 8;
nbuffer[$28b]:=chstats shr 16;

 k:=$03ed; m:=$2dc;
 for n:=0 to 16 do
 for i:=1 to  tracks[n].buffersize do begin nbuffer[k]:=tracks[n].buffer[i]; inc(k);inc(m);end ;

 nbuffer[$0d]:=m ;
 nbuffer[$0e]:=m shr 8;
 nbuffer[$119]:=m;
 nbuffer[$11A]:=m shr 8;


              nbuffer[k]:=$fc;   inc(k);
              nbuffer[k]:=$00;   inc(k);
              nbuffer[k]:=$00;   inc(k);

 f.WriteBuffer(nbuffer,k);
 f.Free;
 clear;
end;

procedure tcmsfile.savedata;
var f:tfilestream;
begin

end;
{ ttrack }

procedure ttrack.addev(b1, b2, b3, b4: byte;tick:integer);
var delta:integer;
begin
//delta:=((tick-oldtick) * 96 ) div ttp;
delta:=tick*96 div ttp -sum;
data[count].b5 :=delta;
if delta > $ff then begin
                    inc(count);
                    data[count].b1:=$FF;
                    data[count].b2:=delta shr 8;
                    data[count].b3:=delta shr 16;
                    data[count].b4:=0;
                    data[count].b5:=0;
                    end;
inc(count);
data[count].b1:=b1;
data[count].b2:=b2;
data[count].b3:=b3;
data[count].b4:=b4;
data[count].b5:=0;



settracklen;
sum:=sum+delta;
oldtick:=tick;
makebuffer;

end;



function tcmsfile.convertfile(midifilename, csmfilename,songname: string; makelog:boolean): integer;
var i,t,n,j,k,l,ttonext:word;
      trk:tmiditrack;
      ev:pmidievent;
      mf:tmidifile;
function noteon(b:byte):boolean; begin result:= b shr 4 =$9;end;
function noteoff(b:byte):boolean; begin result:= b shr 4 =$8;end;
function chan(b:byte):byte; begin result:= b and $0F +1 ; end;
procedure lineadd (s:string); begin logtext:=logtext+s+chr($0d)+chr($0a);end;

begin



logText:='';
 if not fileexists (midifilename) then begin
                                       exit;result:=1;
                                       end     ;


 mf:=       tmidifile.Create(nil);
 mf.Filename:=midifilename;

 mf.ReadFile;
 setttp(mf.TicksPerQuarter);
lineadd('song '+mf.Filename);

lineadd('bpm  '+inttostr(mf.Bpm));
tracks[0].addev($a0,06,mf.Bpm,0,0);
lineadd('tpqr  '+inttostr(mf.TicksPerQuarter));
lineadd('tracks  '+inttostr(mf.NumberOfTracks));

lineadd('fpt  '+floattostr(mf.GetFusPerTick));
for t:=0 to mf.NumberOfTracks-1 do begin
trk:=mf.GetTrack(t);
lineadd('track  '+inttostr(t+1));
lineadd(format('name %s',[trk.getName]));
lineadd(format('instrument %s',[trk.getInstrument]));

for j:=0 to trk.getEventCount-1 do begin
ev:=trk.getEvent(j);
if makelog then lineadd(format ('event:%.2x data1:%.2x data2:%.2x  dticks:%.8d time:%.10d mtime:%.10d  len:%.10x str:%s',[ev.event,ev.data1,ev.data2,ev.dticks,ev.time,ev.mtime,ev.len,ev.str]));
case ev.event shr 4 of
$9:  begin                 //nn vv - Note On (��������� ����)
           if ev.data2>0 then  begin
               l:=0;k:=j+1;

              repeat
              if (noteoff(trk.getEvent(k).event) and (trk.getEvent(k).data1=ev.data1) and (chan(trk.getEvent(k).event)=chan(ev.event))) then l:=trk.getEvent(k).time-ev.time;    // ����������� �� ����������
              if  (trk.getEvent(k).data2=0) and (noteon(trk.getEvent(k).event) and (trk.getEvent(k).data1=ev.data1) and (chan(trk.getEvent(k).event)=chan(ev.event))) then l:=trk.getEvent(k).time-ev.time;    // ���� ����  � vol =0
              inc(k);
              until  (l>0) or (k>=trk.getEventCount-1);
              l:=(l *96 ) div mf.TicksPerQuarter ;
              if l=0 then lineadd('bad note');
              if l=0 then l:=1;
              tracks[chan(ev.event)].addev(ev.data1,ev.data2,l shr 8,l,ev.time);
                                 end   ;


     end;

$A: begin //nn pp - Key Pressure (Polyphonic Aftertouch, �������� �� �������)
    end;
$B: begin //cc vv - Control Change (����� �������� �����������)
          tracks[chan(ev.event)].addev($80,$b0,ev.data1,ev.data2,ev.time);
    end;
$C: begin //pp    - Program Change (����� ��������� (������, �����������))
          tracks[chan(ev.event)].addev($A1,0,0,ev.data1,ev.time);
            lineadd(format('tone %d %.2x %.2x',[ev.time, ev.event,ev.data1,ev.data2]));
    end;
$D: begin //pp    - Channel Pressure (Channel Aftertouch, �������� � ������)
    end;
$E: begin //ll mm - Pitch Bend Change (������� ��������� ������ ���� � ������)
    end;
      else begin
      // lineadd(format('skip %.2x %.2x',[ev.event,ev.data1,ev.data2]));
            end;

end;

end;

lineadd('end track ----------------------')
       end;

     newfile(csmfilename,songname);
     result:=0;
     mf.Free;
end;

constructor ttrack.create;
begin
inherited;
count:=0;
makebuffer;
end;

procedure ttrack.makebuffer;

var k,i: integer;
begin
k:=1;
for   i:=1 to count do begin
buffer[k]:=data[i].b1;  inc(k);
buffer[k]:=data[i].b2;  inc(k);
buffer[k]:=data[i].b3;         inc(k);
buffer[k]:=data[i].b4;                inc(k);
buffer[k]:=data[i].b5;                       inc(k);
                       end;
  buffersize:=k-1;
end;

procedure ttrack.settracklen;
var i:integer;
begin
tracklen:=0;
for i:=1 to count do begin
case  data[i].b1 of
$ff:begin
      tracklen:=tracklen+(data[i].b2 shl 8)+ (data[i].b3 shl 16)
    end
else tracklen:=tracklen+data[i].b5
     end;
     end;
end;

procedure tcmsfile.setttp(attp: integer);
begin
ttp:=attp;
end;

end.
