unit MEvent;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin,Contnrs,ExtCtrls, StdCtrls, Buttons, CheckLst,MMSystem;


type
  TID3Rec = packed record
    Tag     : array[0..2] of Char;
    Title,
    Artist,
    Comment,
    Album   : array[0..29] of Char;
    Year    : array[0..3] of Char;
    Genre   : Byte;
end;

const
  MaxID3Genre=147;
  ID3Genre: array[0..MaxID3Genre] of string = (
    'Blues', 'Classic Rock', 'Country', 'Dance', 'Disco', 'Funk', 'Grunge',
    'Hip-Hop', 'Jazz', 'Metal', 'New Age', 'Oldies', 'Other', 'Pop', 'R&B',
    'Rap', 'Reggae', 'Rock', 'Techno', 'Industrial', 'Alternative', 'Ska',
    'Death Metal', 'Pranks', 'Soundtrack', 'Euro-Techno', 'Ambient',
    'Trip-Hop', 'Vocal', 'Jazz+Funk', 'Fusion', 'Trance', 'Classical',
    'Instrumental', 'Acid', 'House', 'Game', 'Sound Clip', 'Gospel',
    'Noise', 'AlternRock', 'Bass', 'Soul', 'Punk', 'Space', 'Meditative',
    'Instrumental Pop', 'Instrumental Rock', 'Ethnic', 'Gothic',
    'Darkwave', 'Techno-Industrial', 'Electronic', 'Pop-Folk',
    'Eurodance', 'Dream', 'Southern Rock', 'Comedy', 'Cult', 'Gangsta',
    'Top 40', 'Christian Rap', 'Pop/Funk', 'Jungle', 'Native American',
    'Cabaret', 'New Wave', 'Psychadelic', 'Rave', 'Showtunes', 'Trailer',
    'Lo-Fi', 'Tribal', 'Acid Punk', 'Acid Jazz', 'Polka', 'Retro',
    'Musical', 'Rock & Roll', 'Hard Rock', 'Folk', 'Folk-Rock',
    'National Folk', 'Swing', 'Fast Fusion', 'Bebob', 'Latin', 'Revival',
    'Celtic', 'Bluegrass', 'Avantgarde', 'Gothic Rock', 'Progressive Rock',
    'Psychedelic Rock', 'Symphonic Rock', 'Slow Rock', 'Big Band',
    'Chorus', 'Easy Listening', 'Acoustic', 'Humour', 'Speech', 'Chanson',
    'Opera', 'Chamber Music', 'Sonata', 'Symphony', 'Booty Bass', 'Primus',
    'Porn Groove', 'Satire', 'Slow Jam', 'Club', 'Tango', 'Samba',
    'Folklore', 'Ballad', 'Power Ballad', 'Rhythmic Soul', 'Freestyle',
    'Duet', 'Punk Rock', 'Drum Solo', 'Acapella', 'Euro-House', 'Dance Hall',
    'Goa', 'Drum & Bass', 'Club-House', 'Hardcore', 'Terror', 'Indie',
    'BritPop', 'Negerpunk', 'Polsk Punk', 'Beat', 'Christian Gangsta Rap',
    'Heavy Metal', 'Black Metal', 'Crossover', 'Contemporary Christian',
    'Christian Rock', 'Merengue', 'Salsa', 'Trash Metal', 'Anime', 'Jpop',
    'Synthpop'  {and probably more to come}
  );

const EID_PEN_COLOR = 1;
const EID_PEN_SIZE = 2;
const EID_PEN_MOVE = 3;
const EID_PEN_LINETO = 4;
const
bitraten:array[1..2,1..3,1..14] of word =
              (((32,64,96,128,160,192,224,256,288,320,352,384,416,448),
              (32,48,56,64,80,96,112,128,160,192,224,256,320,384),
              (32,40,48,56,64,80,96,112,128,160,192,224,256,320)),
              ((32,48,56,64,80,96,112,128,144,160,176,192,224,256),
              (8,16,24,32,40,48,56,64,80,96,112,128,144,160),
              (8,16,24,32,40,48,56,64,80,96,112,128,144,160)));
const freq    :array[1..2,0..2] of word =((44100,48000,32000),(22050,24000,16000));

type
   TVolumeRec = record
     case Integer of
       0: (LongVolume: Longint) ;
       1: (LeftVolume, RightVolume : Word) ;
     end;

const DeviceIndex=0  ;
       {0:Wave
        1:MIDI
        2:CDAudio
        3:Line-In
        4:Microphone
        5:Master
        6:PC-loudspeaker}


type TEvent = class
 public
    event_id :integer;
    x,y :integer;
    size:integer;
    color:integer;
    constructor Create(i_id,i_x,i_y,i_size,i_color:integer);
    procedure SavetoFile(FileHandle:TFileStream);
    procedure LoadFromFile(FileHandle:TFileStream);
 end;

type TDraw = class
 public
    m_list: TClassList;
    m_check : integer;
    constructor Create(c :integer);
    procedure SavetoFile(FileHandle:TFileStream);
    procedure LoadFromFile(FileHandle:TFileStream);    
end;



type TMFrame = class
 public
    m_bgcolorindex :integer;
    m_pencolorindex :integer;
    m_penthick :integer;
    m_grid :integer;
    m_x :integer;
    m_y :integer;
    m_caption :string;
    m_list:TClassList;
    constructor Create(x,y:integer;caption:string);
    procedure assignlayout( clb :TCheckListBox);
    procedure SavetoFile(FileHandle:TFileStream);
    procedure LoadFromFile(FileHandle:TFileStream);
end;

type TMFrames = class
public
    m_list:TClassList;
    m_filename :string;
    constructor Create(filename:string);
    function getframe_xy(x,y:integer): TMFrame;
    procedure SavetoFile(FileHandle:TFileStream);
    procedure LoadFromFile(FileHandle:TFileStream);    
end;

procedure FillID3TagInformation(mp3File:string; Title,Artist,Album,
   Year,Genre,Comment:TLabel);
function GetVolume:Cardinal;
procedure SetVolume(aVolume:Byte) ;

implementation

constructor TDraw.Create(c:integer);
begin
        m_check := c;
        m_list := TClassList.Create;
end;

procedure TDraw.LoadFromFile(FileHandle:TFileStream);
var i,len:integer;
    l_evn:Tevent;
Begin
       m_list.Clear;
       FileHandle.read(m_check,sizeof(integer));
       FileHandle.read(len,sizeof(integer));
       for i := 0 to len - 1 do
       begin
            l_evn := TEvent.Create(0,0,0,0,0);
            l_evn.LoadFromFile(filehandle);
            m_list.Insert(0,Tclass(l_evn));
       end;
end;

procedure TDraw.SavetoFile(FileHandle:TFileStream);
var i:integer;
Begin
       FileHandle.Write(m_check,sizeof(integer));
       FileHandle.Write(m_list.Count,sizeof(integer));
       for  i := m_list.Count - 1 downto 0 do
       begin
           TEvent(m_list[i]).SavetoFile(filehandle);
       end;
end;


constructor TMFrame.Create(x,y:integer;caption:string);
begin
        m_x := x;
        m_y := y;
        m_caption := caption;
        m_list := TClassList.Create;
end;

procedure TMFrame.assignlayout( clb :TCheckListBox);
var i :Integer;
begin
        clb.Clear;
        clb.Visible := false;
        for i :=  m_list.Count - 1 downto 0 do
        begin
            clb.Items.InsertObject(0,'±Ê»­'+inttostr( m_list.Count-i),TObject(TDraw(m_list[i]).m_list));
            clb.Checked[0] := true;
        end;
        clb.Visible := true;
end;

procedure TMFrame.LoadFromFile(FileHandle:TFileStream);
var i,len:integer;
    l_draw:TDraw;
   cap: array[0..100] of char;
Begin
       m_list.Clear;
       FileHandle.read(m_x,sizeof(integer));
       FileHandle.read(m_y,sizeof(integer));
       FileHandle.read(len,sizeof(integer));
       FileHandle.read(cap,len+1);
       m_caption := cap;
       FileHandle.read(m_bgcolorindex,sizeof(integer));
       FileHandle.read(m_pencolorindex,sizeof(integer));
       FileHandle.read(m_penthick,sizeof(integer));
       FileHandle.read(m_grid,sizeof(integer));
       FileHandle.read(len,sizeof(integer));
       for i := 0 to len - 1 do
       begin
            l_draw := TDraw.Create(0);
            l_draw.LoadFromFile(filehandle);
            m_list.Insert(0,Tclass(l_draw));
       end;
end;

procedure TMFrame.SavetoFile(FileHandle:TFileStream);
var i,len:integer;
    cap: array[0..100] of char;
Begin
      FileHandle.Write(m_x,sizeof(integer));
      FileHandle.Write(m_y,sizeof(integer));
      len :=length(m_caption);
      FileHandle.Write(len,sizeof(integer));
      strcopy(cap,pchar(m_caption));
      FileHandle.Write(cap,len+1);
      FileHandle.Write(m_bgcolorindex,sizeof(integer));
      FileHandle.Write(m_pencolorindex,sizeof(integer));
      FileHandle.Write(m_penthick,sizeof(integer));
      FileHandle.Write(m_grid,sizeof(integer));
       FileHandle.Write(m_list.Count,sizeof(integer));
       for i := m_list.Count - 1 downto  0 do
       begin
           TDraw(m_list[i]).SavetoFile(Filehandle);
       end;
end;

constructor TMFrames.Create(filename:string);
begin
       m_filename := filename;
       m_list := TClassList.Create;
end;

procedure TMFrames.LoadFromFile(FileHandle:TFileStream);
var i,len:integer;
    l_fra:TMFrame;
Begin
       m_list.Clear;
       FileHandle.read(len,sizeof(integer));
       for i := 0 to len - 1 do
       begin
           l_fra := TMFrame.Create(0,0,'');
           l_fra.LoadFromFile(filehandle);
           m_list.Insert(0,Tclass(l_fra));
       end;
end;

procedure TMFrames.SavetoFile(FileHandle:TFileStream);
var i:integer;
Begin
       FileHandle.Write(m_list.Count,sizeof(integer));
       for i := m_list.Count - 1 downto 0 do
       begin
            TMFrame(m_list[i]).SavetoFile(filehandle);
       end;
end;

function TMFrames.getframe_xy(x,y:integer): TMFrame;
var i :integer;
begin
        for i := 0 to m_list.count - 1 do
        begin
                if  (TMFrame(m_List[i]).m_x = x) and
                   (TMFrame(m_List[i]).m_y = y )then
                   begin
                        result := TMFrame(m_List[i]);
                        exit;
                   end
        end;
        result := nil;
end;

constructor TEvent.Create(i_id,i_x,i_y,i_size,i_color:integer);
begin
      event_id:= i_id;
      x:=i_x;
      y:=i_y;
      size:=i_size;
      color := i_color;
end;

procedure TEvent.LoadFromFile(FileHandle:TFileStream);
Begin
   FileHandle.Read(event_id,sizeof(integer));
   FileHandle.Read(x,sizeof(integer));
   FileHandle.Read(y,sizeof(integer));
   FileHandle.Read(size,sizeof(integer));
   FileHandle.Read(color,sizeof(integer));
end;

procedure TEvent.SavetoFile(FileHandle:TFileStream);
Begin
   FileHandle.Write(event_id,sizeof(integer));
   FileHandle.Write(x,sizeof(integer));
   FileHandle.Write(y,sizeof(integer));
   FileHandle.Write(size,sizeof(integer));
   FileHandle.Write(color,sizeof(integer));
end;


procedure FillID3TagInformation(mp3File:string;
   Title,Artist,Album,
   Year,Genre,Comment:TLabel);
var //fMP3: file of Byte;
    ID3 : TID3Rec;
    fmp3: TFileStream;
    s1,s2,s3,x:byte;
    Layer,
    MPEGVer   : Byte;
    Frequency,
    Bitrate   : Word;
begin
  fmp3:=TFileStream.Create(mp3File, fmOpenRead); 
  try
    fmp3.position:=1;
    fmp3.Read(s1,SizeOf(s1));
    fmp3.Read(s2,SizeOf(s2));
    fmp3.Read(s3,SizeOf(s3));
    fmp3.position:=fmp3.size-128;
    fmp3.Read(ID3,SizeOf(ID3));
  finally
    fmp3.free;
  end;

 { or the non Stream approach - as in ChangeID3Tag procedure
 try
   AssignFile(fMP3, mp3File);
   Reset(fMP3);
   try
     Seek(fMP3, FileSize(fMP3) - 128);
     BlockRead(fMP3, ID3, SizeOf(ID3));
   finally
   end;
 finally
   CloseFile(fMP3);
 end;
 }

 if ID3.Tag <> 'TAG' then begin
   Title.Caption:='Wrong or no ID3 tag information';
   Artist.Caption:='Wrong or no ID3 tag information';
   Album.Caption:='Wrong or no ID3 tag information';
   Year.Caption:='Wrong or no ID3 tag information';
   Genre.Caption:='Wrong or no ID3 tag information';
   Comment.Caption:='Wrong or no ID3 tag information';
 end else begin
   Title.Caption:=ID3.Title;
   Artist.Caption:=ID3.Artist;
   Album.Caption:=ID3.Album;
   Year.Caption:=ID3.Year;
   if ID3.Genre in [0..MaxID3Genre] then
     Genre.Caption:=ID3Genre[ID3.Genre]
   else
     Genre.Caption:=IntToStr(ID3.Genre);
     Comment.Caption:=ID3.Comment
    end;
    Title.Caption:='  ¸èÇú:  '+ID3.Title;
    Artist.Caption:='  ÑÝ³ª:  '+ID3.Artist;

     {MPEG Version}
 if s2 and 16 = 16 then mpegver:=1 else mpegver:=2;
 {Layer}
 if (s2 and 32 = 32) and (s2 and 64 <> 64) then layer:=1;
 if (s2 and 32 = 32) and (s2 and 64 =  64) then layer:=3;
 if (s2 and 32 <> 32) and (s2 and 64 = 64) then layer:=2;
 {Bitrate}
 x:=0;
 if s3 and 128 = 128 then x:=x+8;
 if s3 and  64 = 64  then x:=x+4;
 if s3 and  32 = 32  then x:=x+2;
 if s3 and  16 = 16  then x:=x+1;
 Bitrate:=bitraten[mpegver,layer,x];
 {Sample-Frequenz}
 x:=0;
 if s3 and 8 = 8 then x:=x+1;
 if s3 and 4 = 4 then x:=x+2;
 Frequency:=freq[mpegver,x];

end;

procedure SetVolume(aVolume:Byte) ;
var Vol: TVolumeRec;
begin
   Vol.LeftVolume := aVolume shl 8;
   Vol.RightVolume:= Vol.LeftVolume;
   auxSetVolume(UINT(DeviceIndex), Vol.LongVolume) ;
end;

function GetVolume:Cardinal;
var Vol: TVolumeRec;
begin
   AuxGetVolume(UINT(DeviceIndex),@Vol.LongVolume) ;
   Result:=(Vol.LeftVolume + Vol.RightVolume) shr 9;
end;

end.


