unit MEvent;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, ExtCtrls, StdCtrls, Buttons, CheckLst,MMSystem;


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

 procedure FillID3TagInformation(mp3File:string; Title,Artist,Album,
   Year,Genre,Comment:TLabel);
 function GetVolume:Cardinal;
 procedure SetVolume(aVolume:Byte) ;
implementation

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
begin
  fmp3:=TFileStream.Create(mp3File, fmOpenRead); 
  try
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


