unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, Buttons, Tabs, ComCtrls, OleCtrls,
  SHDocVw, DB, DBClient, Grids, DBGrids,unit2, MidiFile, FileCtrl,registry,
  MidiType, MidiOut;

type


  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    Label3: TLabel;
    ts: TTabSet;
    OpenDialog1: TOpenDialog;
    Memo3: TMemo;
    memo1: TRichEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    se1: TSpinEdit;
    rb1: TRadioButton;
    cds: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    rb5: TRadioButton;
    Button2: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    TabSheet3: TTabSheet;
    DirectoryListBox2: TDirectoryListBox;
    DriveComboBox2: TDriveComboBox;
    Button3: TButton;
    FileListBox1: TFileListBox;
    FileListBox2: TFileListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    MidiFile1: TMidiFile;
    MidiOutput1: TMidiOutput;
    ComboBox1: TComboBox;
    CheckBox2: TCheckBox;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure printmemo1(cms:tcmsfile;start,b_end,l:integer) ;
    procedure printwindow;
    procedure loadfiletowindow(id:integer);
    procedure tsChange(Sender: TObject; NewTab: Integer;
    var AllowChange: Boolean);
    procedure se1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo3Exit(Sender: TObject);
    procedure rb1Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure cdsBeforePost(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure FileListBox2Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FileListBox1DblClick(Sender: TObject);
    procedure MidiFile1MidiEvent(event: PMidiEvent);
    procedure MidiFile1UpdateEvent(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
      MidiOpened : boolean;
    procedure SentAllNotesOff;

    procedure MidiOpen;
    procedure MidiClose;
    { Public declarations }
  end;



var
  Form1: TForm1;
   cms,cms2:tcmsfile;
   fn:tstringlist;
   midiopened:boolean;
implementation

{$R *.dfm}
     {��������� �������� ���������� ������ �����}
procedure TForm1.MidiOpen;
begin
  if not (ComboBox1.Text = '') then                   // ���� ComboBox  ��������, ��
  begin
    MidiOutput1.ProductName := ComboBox1.Text;        // ProductName ������������� ��������� ����� ComboBox
    MidiOpened := MidiOutput1.Open;                                 // ����������� ��������������� ���������� ������
  
  end;
end;

{��������� ��� �������� ���������}
procedure TForm1.MidiClose;
begin
  if MidiOpened then                                  // ��������� ������� �� �����-���� ����������
  begin                                               // ��������� �����
    MidiOutput1.Close;
    MidiOpened := False;
  end;
end;

{��������� ������ ���� ���}
procedure TForm1.SentAllNotesOff;
var
  mEvent : TMyMidiEvent;
  Channel : integer;
begin
  mEvent := TMyMidiEvent.Create;
  for Channel:= 0 to 15 do                            // ������� ���� 16 �������
  begin
    mEvent.MidiMessage := $B0 + Channel;
    mEvent.data1 := $78;
    mEvent.data2 := 0;
    if MidiOpened then
      MidiOutput1.PutMidiEvent(mEvent);
  end;
  mEvent.Destroy;
end;
function GetRegistryValue(KeyName: string): string;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    // False because we do not want to create it if it doesn't exist
    Registry.OpenKey('Software\SAMS\CSM', True);
    Result := Registry.ReadString(keyname);
  finally
    Registry.Free;
  end;
end;

function SetRegistryValue(KeyName,val: string): string;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_write);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    // False because we do not want to create it if it doesn't exist
    Registry.OpenKey('Software\SAMS\CSM', true);
    registry.WriteString(keyname,val);
  finally
    Registry.Free;
  end;
end;
{ csmfile }



procedure TForm1.Button1Click(Sender: TObject);
  var f,sf:string; i:integer;
begin
opendialog1.FilterIndex:=2;
if OpenDialog1.Execute then  begin
     f := OpenDialog1.FileName;
     i:= ts.Tabs.Add(extractfilename(f));
     fn.Add(f);
     ts.TabIndex:=i;
     caption:= ExtractFileDir(application.ExeName)+'\files.txt';
     fn.SaveToFile(ExtractFileDir(application.ExeName)+'\files.txt');
       end;
end;

procedure TForm1.printmemo1(cms:tcmsfile;start,b_end,l:integer);
var i,j,k:integer;
    s1,s2,s:string;
     b:byte;
     n:word;
begin
s:='';  s1:='';
k:=start;
if b_end<start then B_end:=start+b_end;
if b_end> cms.buffersize then b_end:=cms.buffersize;
n:=trunc((b_end-start)/l);
while k<b_end do begin

s:=s+format('%.4d  %.4x',[round(k/l),k])+'   ';
s1:='';s2:='';
i:=1;
while i<=l do begin
if (k<b_end) then begin
                                    b:=cms.buffer[k];
                                    s1:=s1+format('%.2x',[b])+' ';
                                    if b>32 then s2:=s2+chr(b) else s2:=s2+'.';
                                           end
                                      else begin
                                        s1:=s1+'   ';
                                        s2:=s2+' ';
                                            end;
inc (k);
                  inc(i);
                  if b=$fc then i:=l+1;
                  if k=$3ef then i:=l+1;
                 end;
s:=s+s1+s2+chr($0d)+chr($0a);

          end ;

memo1.text:=s;

end;

procedure TForm1.loadfiletowindow(id:integer);

begin

label3.Caption:=fn[id];
cms.loaddata(fn[id]);

if fileexists(ExtractFileDir(application.ExeName)+'\ds\'+inttostr(id)) then
memo3.Lines.LoadFromFile(ExtractFileDir(application.ExeName)+'\ds\'+inttostr(id));
end;

procedure TForm1.tsChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  label3.Caption:=fn[NewTab];
  loadfiletowindow(newtab);
  printwindow;
end;

procedure TForm1.se1Change(Sender: TObject);
begin
if se1.Text='' then exit;
printwindow;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
thisDevice : integer;
begin
  for thisDevice := 0 to MidiOutput1.NumDevs - 1 do               // ��� ���� ��������� ������ �����
  begin
    MidiOutput1.DeviceID := thisDevice;
    ComboBox1.Items.Add(MidiOutput1.ProductName);                 // ������ �������� ���� ������ � ComboBox
  end;
  ComboBox1.ItemIndex := 0;
  MidiOpened := False;
  MidiOpen;

filelistbox2.Directory:=getregistryvalue('CMSDir');
filelistbox1.Directory:=getregistryvalue('midiDir');
cms:=tcmsfile.Create;
fn:=tstringlist.Create;
if fileexists(ExtractFileDir(application.ExeName)+'\files.txt') then begin
fn.LoadFromFile(ExtractFileDir(application.ExeName)+'\files.txt');
for i:=0 to fn.Count-1 do begin
   ts.Tabs.Add(extractfilename(fn[i])) ;
   end;
end;
end;

procedure TForm1.Memo3Exit(Sender: TObject);
begin
memo3.Lines.SaveToFile(ExtractFileDir(application.ExeName)+'\ds\'+inttostr(ts.tabindex));
end;

procedure TForm1.printwindow;
begin
if rb1.Checked then   printmemo1(cms,se1.Value,99999999,16);


if rb5.Checked then   printmemo1(cms,cds.fieldbyname('start').Value,cds.fieldbyname('end').Value,cds.fieldbyname('len').Value);
end;

procedure TForm1.rb1Click(Sender: TObject);
begin
cds.FileName:=   ExtractFileDir(application.ExeName)+'/data.cds';
cds.Open;
printwindow;
end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
begin
if not cds.Eof then    printwindow;
end;

procedure TForm1.cdsBeforePost(DataSet: TDataSet);
begin
if cds.fieldbyName('len').isnull then   cds.FieldbyName('len').value:=16;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

cms.tracks[1].addev($3c,$64,0,$4c,0 );
cms.tracks[1].addev($ff,$02,0,0,0 );
cms.tracks[3].addev($39,$64,0,$4c,96 );
cms.tracks[3].addev($44,$64,0,$4a,128 ) ;
cms.tracks[3].addev($49,$64,0,$4c, 256);
cms.newfile('g:/musicdat/newfile.cms',edit1.text)




end;

procedure TForm1.FormShow(Sender: TObject);
begin
ts.TabIndex:=0;

end;

procedure TForm1.Button4Click(Sender: TObject);
    var mf,sf:string;

begin

opendialog1.FilterIndex:=1;

if checkbox1.Checked then  OpenDialog1.Execute ;

 mf:= OpenDialog1.FileName;


cms.convertfile(mf,'g:\musicdat\newfile.cms',Edit1.text,false);
memo1.Text:=cms.logtext;

end;


procedure TForm1.Button3Click(Sender: TObject);
var s:String;
begin

 MidiFile1.StopPlaying;
  SentAllNotesOff;
s:= filelistbox2.Directory+'\'+edit2.Text;
setregistryvalue('midiDir',filelistbox1.FileName);
setregistryvalue('CMSDir',filelistbox2.FileName);

cms.convertfile(filelistbox1.FileName,s,Edit1.text,false);
memo1.Text:=cms.logtext;

filelistbox2.Update;
filelistbox2.FileName:=s;
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
  end;
procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
edit2.text:=translit(edit2.text);
end;



procedure TForm1.FileListBox1Change(Sender: TObject);
var s,s1:string;
i:integer;
begin
s:=extractfilename(  filelistbox1.FileName);

  s:=copy(s,1,pos('.',s)-1);    s1:='';
  edit1.Text:=s;
  edit2.Text:=s+'.cms';
 if checkbox2.Checked  then begin

        if not fileexists(filelistbox1.FileName) then exit;
        if not midiopened then exit;
 MidiFile1.StopPlaying;
  SentAllNotesOff;
midifile1.Filename:=filelistbox1.FileName;
midifile1.ReadFile;
midifile1.StartPlaying;
memo1.Text:='';
                   end;


end;

procedure TForm1.FileListBox2Change(Sender: TObject);
begin
edit2.Text:=extractfilename(filelistbox2.FileName);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
deletefile( filelistbox2.FileName);
filelistbox2.Update;

end;

procedure TForm1.FileListBox1DblClick(Sender: TObject);
begin
tabsheet3.Show;
end;

procedure TForm1.MidiFile1MidiEvent(event: PMidiEvent);
var
  mEvent : TMyMidiEvent;
begin
  mEvent := TMyMidiEvent.Create;
  if not (event.event = $FF) then
  begin
    mEvent.MidiMessage := event.event;
    mEvent.data1 := event.data1;
    mEvent.data2 := event.data2;
    MidiOutput1.PutMidiEvent(mEvent);
  end
  else
  begin
    if (event.data1 >= 1) and (event.data1 < 15) then
    begin
      Memo1.text:=memo1.Text+(event.str);
    end
  end;
  mEvent.Destroy;
end;

procedure TForm1.MidiFile1UpdateEvent(Sender: TObject);
begin
  // ���������� ���������� �������
  Edit3.Text := MyTimeToStr(MidiFile1.GetCurrentTime);
  Edit3.Update;
  if MidiFile1.Ready then
    begin
      MidiFile1.StopPlaying;
      SentAllNotesOff;
    end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
try
 MidiFile1.StopPlaying;
  SentAllNotesOff;
  MidiClose;
  MidiOPen;

  except
  end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin

 MidiFile1.StopPlaying;
  SentAllNotesOff;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 
 MidiFile1.StopPlaying;
  SentAllNotesOff;
  midioutput1.Close;
end;

end.
