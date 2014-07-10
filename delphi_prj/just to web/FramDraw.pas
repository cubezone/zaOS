unit FramDraw;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit,UObj, ExtCtrls, ComCtrls;

type
  TFormDraw = class(TForm)
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet_sql: TTabSheet;
    ValueListEditor1: TValueListEditor;
    Memo1: TMemo;
    Panel1: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    TabSheet3: TTabSheet;
    Memo2: TMemo;
    TabSheet4: TTabSheet;
    Memo3: TMemo;
    TabSheet5: TTabSheet;
    Memo_import: TMemo;
    Button4: TButton;
    TabSheet6: TTabSheet;
    Memo_partition: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     m_obj : ttable;
  end;

var
  FormDraw: TFormDraw;

implementation

{$R *.dfm}

procedure TFormDraw.Button1Click(Sender: TObject);
var i :integer;
begin

    m_obj.m_data.Clear;
    for i := 0 to ValueListEditor1.Strings.Count - 1 do
    m_obj.m_data.Add(ValueListEditor1.Values[inttostr(i)]);
    m_obj.m_desc := edit1.Text;
    m_obj.m_index := memo3.Text;
    m_obj.m_partition := memo_partition.Text;    
    formdraw.Close;
end;

procedure TFormDraw.Button2Click(Sender: TObject);
begin
   ValueListEditor1.Strings.Insert(ValueListEditor1.Row-1,'');
end;

procedure TFormDraw.Button3Click(Sender: TObject);
begin
   ValueListEditor1.Strings.Insert(ValueListEditor1.Row,'');
end;

procedure TFormDraw.PageControl1Change(Sender: TObject);
var i :integer;
   l_str,l_cname,l_type,l_name,l_desc :string;
   l_pos : integer;
   l_sql :string;
begin
    memo1.Lines.Clear;    
    if TabSheet_sql.TabIndex = pagecontrol1.ActivePageIndex then
    begin
     l_pos := pos('--',edit1.Text);
     if l_pos > 0 then
      l_str := copy(edit1.Text,0,l_pos-1)
     else
     l_str := edit1.Text;

     l_sql := 'drop table '+ l_str +';'+ #13#10;
     l_sql := l_sql +  'create table '+edit1.Text + #13#10;
     l_sql := l_sql +'('+ #13#10;
    for i := 0 to  ValueListEditor1.Strings.Count -1 do
    begin
     l_str := copy(ValueListEditor1.Values[inttostr(i)],0,200);
     l_pos := pos('^',l_str);
     l_cname := copy(l_str,1,l_pos-1);
     l_str := copy(l_str,l_pos+1,200);
     l_pos := pos('^',l_str);
     l_type := copy(l_str,1,l_pos-1);
     l_str := copy(l_str,l_pos+1,200);
     l_pos := pos('^',l_str);
     l_name := copy(l_str,1,l_pos-1);
     l_str := copy(l_str,l_pos+1,200);
     l_pos := pos('^',l_str);
     l_desc := copy(l_str,1,l_pos-1);
     l_str := copy(l_str,l_pos+1,200);

     if i =  ValueListEditor1.Strings.Count -1 then
          l_sql := l_sql +l_name + ' ' + l_type + ' --' + l_cname+ #13#10
      else
          l_sql := l_sql +l_name + ' ' + l_type + ', --' + l_cname+ #13#10;
    end;
    l_sql := l_sql + ')'+#13#10;
    l_sql := l_sql + memo_partition.text +';' +#13#10;
    l_sql := l_sql + memo3.text+#13#10;
    memo1.Text := l_sql;
    end;
end;

procedure TFormDraw.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if not self.Focused then
     self.SetFocus;
end;

procedure TFormDraw.Button4Click(Sender: TObject);
var i,b : integer;
  l_pos,l_tag : integer;
  l_str :string;
  l_ostr,l_name,l_cname,l_type :string;
begin
    screen.Cursor := crHourGlass;
    b:=0;
    l_tag := 0;
    ValueListEditor1.Strings.Text:='';
    for i := 0 to Memo_import.Lines.Count -1 do
    begin
    l_pos := pos('CREATE TABLE',uppercase(Memo_import.Lines[i]));
    if l_pos > 0 then
    begin
     edit1.Text := copy(Memo_import.Lines[i],14,200);
    end;
    if (pos(',',Memo_import.Lines[i]) > 0) or (l_tag = 1) then
    begin

      l_str := trim(Memo_import.Lines[i]);
      l_str := StringReplace(l_str,'  ',' ',[rfReplaceAll]);
      l_str := StringReplace(l_str,'  ',' ',[rfReplaceAll]);
      l_str := StringReplace(l_str,'  ',' ',[rfReplaceAll]);
      l_str := StringReplace(l_str,'  ',' ',[rfReplaceAll]);
      l_str := StringReplace(l_str,'  ',' ',[rfReplaceAll]);                        
      l_tag := 1;
      if pos(',',Memo_import.Lines[i]) = 0 then
      begin
      l_pos := pos('--',l_str);
      if l_pos > 0 then
      l_str := copy(l_str,1,l_pos-1) + ','+ copy(l_str,l_pos,200)
      else
      l_str := l_str + ',';
      l_tag  := 0;
      end;
      l_pos := pos(' ',l_str);
      l_name  := copy(l_str,0,l_pos -1);
      l_str := copy(l_str,l_pos+1,200);
      if (pos('(',l_str) > 0) and (pos('(',l_str) < pos(',',l_str)) then
      begin
        l_pos :=  pos(',',l_str);
        l_pos := l_pos + pos(',',copy(l_str,l_pos+1,200));
      end
      else
        l_pos := pos(',',l_str);
      l_type := copy(l_str,0,l_pos -1);
      l_str := copy(l_str,l_pos+1,200);
      l_pos := pos('--',l_str);
      if l_pos = 0 then
       l_cname := l_name
      else
       l_cname := copy(l_str,l_pos+2,200);
      l_ostr := l_cname + '^'+l_type + '^'+l_name +'^';
      ValueListEditor1.Values[inttostr(b)]:=l_ostr;
      b:=b+1;
    end
    else
     l_tag := 0;
    end;
    screen.Cursor := 0;
end;

end.
