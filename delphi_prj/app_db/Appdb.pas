unit Appdb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, Provider, DBClient, DBLocal,
  DBLocalB,SqlExpr, StdCtrls, ExtCtrls, ComCtrls, ActnList,IniFiles;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Query1: TQuery;
    Database1: TDatabase;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Query: TButton;
    Edit001: TEdit;
    Memo1: TMemo;
    DBGrid2: TDBGrid;
    Memo2: TMemo;
    TabSheet3: TTabSheet;
    DBGrid3: TDBGrid;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    DBGrid4: TDBGrid;
    DBGrid5: TDBGrid;
    DBGrid6: TDBGrid;
    Edit002: TEdit;
    Edit003: TEdit;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo5: TMemo;
    Memo6: TMemo;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Panel3: TPanel;
    Edit061: TEdit;
    Edit062: TEdit;
    Edit063: TEdit;
    Button06: TButton;
    Panel4: TPanel;
    Edit051: TEdit;
    Edit052: TEdit;
    Edit053: TEdit;
    Button05: TButton;
    Panel5: TPanel;
    Edit041: TEdit;
    Edit042: TEdit;
    Edit043: TEdit;
    Button04: TButton;
    Panel6: TPanel;
    Edit031: TEdit;
    Edit032: TEdit;
    Edit033: TEdit;
    Button03: TButton;
    Panel7: TPanel;
    Edit011: TEdit;
    Edit012: TEdit;
    Edit013: TEdit;
    Button01: TButton;
    Panel8: TPanel;
    Edit021: TEdit;
    Edit022: TEdit;
    Edit023: TEdit;
    Button02: TButton;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    Panel9: TPanel;
    Edit071: TEdit;
    Edit072: TEdit;
    Edit073: TEdit;
    Button07: TButton;
    DBGrid7: TDBGrid;
    Memo7: TMemo;
    DBGrid8: TDBGrid;
    Memo8: TMemo;
    DBGrid9: TDBGrid;
    Memo9: TMemo;
    Panel10: TPanel;
    Edit081: TEdit;
    Edit082: TEdit;
    Edit083: TEdit;
    Button08: TButton;
    Panel11: TPanel;
    Edit091: TEdit;
    Edit092: TEdit;
    Edit093: TEdit;
    Button09: TButton;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    Splitter0: TSplitter;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Splitter7: TSplitter;
    Query2: TQuery;
    DataSource2: TDataSource;
    Query3: TQuery;
    DataSource3: TDataSource;
    Query4: TQuery;
    DataSource4: TDataSource;
    Query5: TQuery;
    DataSource5: TDataSource;
    Query6: TQuery;
    DataSource6: TDataSource;
    Query7: TQuery;
    DataSource7: TDataSource;
    Query8: TQuery;
    DataSource8: TDataSource;
    Query9: TQuery;
    DataSource9: TDataSource;
    ActionList1: TActionList;
    Action_Exec: TAction;
    Splitter8: TSplitter;
    Timer1: TTimer;
    CheckBox10: TCheckBox;
    procedure Database1BeforeConnect(Sender: TObject);
    procedure Button09Click(Sender: TObject);
    procedure Button01Click(Sender: TObject);
    procedure Button02Click(Sender: TObject);
    procedure Button03Click(Sender: TObject);
    procedure Button04Click(Sender: TObject);
    procedure Button05Click(Sender: TObject);
    procedure Button06Click(Sender: TObject);
    procedure Button07Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button08Click(Sender: TObject);
    procedure QueryClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Database1BeforeConnect(Sender: TObject);
begin
  with Sender as TDataBase do
  begin
    if LoginPrompt = False then
    begin
      Params.Values['User_Name'] := 'oldcdr';
      Params.Values['Password'] := 'oldcdr123';
    end;
  end;
end;

procedure TForm1.Button09Click(Sender: TObject);
var ls :string;
begin
        Query9.Close;
        Query9.SQL.Clear;
        ls := memo9.Text;
        ls := stringreplace(ls,':p1',edit091.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit092.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit093.Text,[rfReplaceAll]);
        Query9.SQL.Add(ls);
        Query9.Open;
        Query9.Active;
end;

procedure TForm1.Button01Click(Sender: TObject);
var ls :string;
begin
        Query1.Close;
        Query1.SQL.Clear;
        ls := memo1.Text;
        ls := stringreplace(ls,':p1',edit011.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit012.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit013.Text,[rfReplaceAll]);
        Query1.SQL.Add(ls);
        Query1.Open;
        Query1.Active;
end;

procedure TForm1.Button02Click(Sender: TObject);
var ls :string;
begin
        Query2.Close;
        Query2.SQL.Clear;
        ls := memo2.Text;
        ls := stringreplace(ls,':p1',edit021.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit022.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit023.Text,[rfReplaceAll]);
        Query2.SQL.Add(ls);
        Query2.Open;
        Query2.Active;

end;

procedure TForm1.Button03Click(Sender: TObject);
var ls :string;
begin
        Query3.Close;
        Query3.SQL.Clear;
        ls := memo3.Text;
        ls := stringreplace(ls,':p1',edit031.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit032.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit033.Text,[rfReplaceAll]);
        Query3.SQL.Add(ls);
        Query3.Open;
        Query3.Active;
end;

procedure TForm1.Button04Click(Sender: TObject);
var ls :string;
begin
        Query4.Close;
        Query4.SQL.Clear;
        ls := memo4.Text;
        ls := stringreplace(ls,':p1',edit041.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit042.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit043.Text,[rfReplaceAll]);
        Query4.SQL.Add(ls);
        Query4.Open;
        Query4.Active;
end;

procedure TForm1.Button05Click(Sender: TObject);
var ls :string;
begin
        Query5.Close;
        Query5.SQL.Clear;
        ls := memo5.Text;
        ls := stringreplace(ls,':p1',edit051.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit052.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit053.Text,[rfReplaceAll]);
        Query5.SQL.Add(ls);
        Query5.Open;
        Query5.Active;
end;
procedure TForm1.Button06Click(Sender: TObject);
var ls :string;
begin
        Query6.Close;
        Query6.SQL.Clear;
        ls := memo6.Text;
        ls := stringreplace(ls,':p1',edit061.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit062.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit063.Text,[rfReplaceAll]);
        Query6.SQL.Add(ls);
        Query6.Open;
        Query6.Active;
end;

procedure TForm1.Button07Click(Sender: TObject);
var ls :string;
begin
        Query7.Close;
        Query7.SQL.Clear;
        ls := memo7.Text;
        ls := stringreplace(ls,':p1',edit071.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit072.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit073.Text,[rfReplaceAll]);
        Query7.SQL.Add(ls);
        Query7.Open;
        Query7.Active;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  MyIniFile: TIniFile;
begin
  MyIniFile := TIniFile.Create('App_db.ini');
  with MYIniFIle do
  begin
        memo1.Text := stringreplace(readstring('Query1','SQL',''),'?X?',#13#10,[rfReplaceAll]);
        memo2.Text := stringreplace(readstring('Query2','SQL',''),'?X?',#13#10,[rfReplaceAll]);
        memo3.Text := stringreplace(readstring('Query3','SQL',''),'?X?',#13#10,[rfReplaceAll]);
        memo4.Text := stringreplace(readstring('Query4','SQL',''),'?X?',#13#10,[rfReplaceAll]);
        memo5.Text := stringreplace(readstring('Query5','SQL',''),'?X?',#13#10,[rfReplaceAll]);
        memo6.Text := stringreplace(readstring('Query6','SQL',''),'?X?',#13#10,[rfReplaceAll]);
        memo7.Text := stringreplace(readstring('Query7','SQL',''),'?X?',#13#10,[rfReplaceAll]);
        memo8.Text := stringreplace(readstring('Query8','SQL',''),'?X?',#13#10,[rfReplaceAll]);
        memo9.Text := stringreplace(readstring('Query9','SQL',''),'?X?',#13#10,[rfReplaceAll]);
        edit001.Text := readstring('Edit','edit001','');
        edit002.Text := readstring('Edit','edit002','');
        edit003.Text := readstring('Edit','edit003','');
        edit011.Text := readstring('Edit','edit011','');
        edit012.Text := readstring('Edit','edit012','');
        edit013.Text := readstring('Edit','edit013','');
        edit021.Text := readstring('Edit','edit021','');
        edit022.Text := readstring('Edit','edit022','');
        edit023.Text := readstring('Edit','edit023','');
        edit031.Text := readstring('Edit','edit031','');
        edit032.Text := readstring('Edit','edit032','');
        edit033.Text := readstring('Edit','edit033','');
        edit041.Text := readstring('Edit','edit041','');
        edit042.Text := readstring('Edit','edit042','');
        edit043.Text := readstring('Edit','edit043','');
        edit051.Text := readstring('Edit','edit051','');
        edit052.Text := readstring('Edit','edit052','');
        edit053.Text := readstring('Edit','edit053','');
        edit061.Text := readstring('Edit','edit061','');
        edit062.Text := readstring('Edit','edit062','');
        edit063.Text := readstring('Edit','edit063','');
        edit071.Text := readstring('Edit','edit071','');
        edit072.Text := readstring('Edit','edit072','');
        edit073.Text := readstring('Edit','edit073','');
        edit081.Text := readstring('Edit','edit081','');
        edit082.Text := readstring('Edit','edit082','');
        edit083.Text := readstring('Edit','edit083','');
        edit091.Text := readstring('Edit','edit091','');
        edit092.Text := readstring('Edit','edit092','');
        edit093.Text := readstring('Edit','edit093','');
  end;
  MyIniFile.Free;
  memo1.Height := round(pagecontrol1.Height*0.38);
  memo2.Height := round(pagecontrol1.Height*0.38);
  memo3.Height := round(pagecontrol1.Height*0.38);
  memo4.Height := round(pagecontrol1.Height*0.38);
  memo5.Height := round(pagecontrol1.Height*0.38);
  memo6.Height := round(pagecontrol1.Height*0.38);
  memo7.Height := round(pagecontrol1.Height*0.38);
  memo8.Height := round(pagecontrol1.Height*0.38);
  memo9.Height := round(pagecontrol1.Height*0.38);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  MyIniFile: TIniFile;
begin
  MyIniFile := TIniFile.Create('App_db.ini');
  with MYIniFIle do
  begin
        writestring('Query1','SQL',stringreplace(memo1.Text,#13#10,'?X?',[rfReplaceAll]));
        writestring('Query2','SQL',stringreplace(memo2.Text,#13#10,'?X?',[rfReplaceAll]));
        writestring('Query3','SQL',stringreplace(memo3.Text,#13#10,'?X?',[rfReplaceAll]));
        writestring('Query4','SQL',stringreplace(memo4.Text,#13#10,'?X?',[rfReplaceAll]));
        writestring('Query5','SQL',stringreplace(memo5.Text,#13#10,'?X?',[rfReplaceAll]));
        writestring('Query6','SQL',stringreplace(memo6.Text,#13#10,'?X?',[rfReplaceAll]));
        writestring('Query7','SQL',stringreplace(memo7.Text,#13#10,'?X?',[rfReplaceAll]));
        writestring('Query8','SQL',stringreplace(memo8.Text,#13#10,'?X?',[rfReplaceAll]));
        writestring('Query9','SQL',stringreplace(memo9.Text,#13#10,'?X?',[rfReplaceAll]));
        writestring('Edit','edit001',edit011.Text);
        writestring('Edit','edit002',edit012.Text);
        writestring('Edit','edit003',edit013.Text);
        writestring('Edit','edit011',edit011.Text);
        writestring('Edit','edit012',edit012.Text);
        writestring('Edit','edit013',edit013.Text);
        writestring('Edit','edit021',edit021.Text);
        writestring('Edit','edit022',edit022.Text);
        writestring('Edit','edit023',edit023.Text);
        writestring('Edit','edit031',edit031.Text);
        writestring('Edit','edit032',edit032.Text);
        writestring('Edit','edit033',edit033.Text);
        writestring('Edit','edit041',edit041.Text);
        writestring('Edit','edit042',edit042.Text);
        writestring('Edit','edit043',edit043.Text);
        writestring('Edit','edit051',edit051.Text);
        writestring('Edit','edit052',edit052.Text);
        writestring('Edit','edit053',edit053.Text);
        writestring('Edit','edit061',edit061.Text);
        writestring('Edit','edit062',edit062.Text);
        writestring('Edit','edit063',edit063.Text);
        writestring('Edit','edit071',edit071.Text);
        writestring('Edit','edit072',edit072.Text);
        writestring('Edit','edit073',edit073.Text);
        writestring('Edit','edit081',edit081.Text);
        writestring('Edit','edit082',edit082.Text);
        writestring('Edit','edit083',edit083.Text);
        writestring('Edit','edit091',edit091.Text);
        writestring('Edit','edit092',edit092.Text);
        writestring('Edit','edit093',edit093.Text);
  end;
  MyIniFile.Free;
end;
procedure TForm1.Button08Click(Sender: TObject);
var ls :string;
begin
        Query8.Close;
        Query8.SQL.Clear;
        ls := memo8.Text;
        ls := stringreplace(ls,':p1',edit081.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit082.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit083.Text,[rfReplaceAll]);
        Query8.SQL.Add(ls);
        Query8.Open;
        Query8.Active;
end;


procedure TForm1.QueryClick(Sender: TObject);
var ls :string;
begin
        if checkbox1.Checked then
        begin
        Query1.Close;
        Query1.SQL.Clear;
        ls := memo1.Text;
        ls := stringreplace(ls,':p1',edit001.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit002.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit003.Text,[rfReplaceAll]);
        Query1.SQL.Add(ls);
        Query1.Open;
        Query1.Active;
        end;
        if checkbox2.Checked then
        begin
        Query2.Close;
        Query2.SQL.Clear;
        ls := memo2.Text;
        ls := stringreplace(ls,':p1',edit001.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit002.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit003.Text,[rfReplaceAll]);
        Query2.SQL.Add(ls);
        Query2.Open;
        Query2.Active;
        end;
        if checkbox3.Checked then
        begin
        Query3.Close;
        Query3.SQL.Clear;
        ls := memo3.Text;
        ls := stringreplace(ls,':p1',edit001.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit002.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit003.Text,[rfReplaceAll]);
        Query3.SQL.Add(ls);
        Query3.Open;
        Query3.Active;
        end;

        if checkbox4.Checked then
        begin
        Query4.Close;
        Query4.SQL.Clear;
        ls := memo4.Text;
        ls := stringreplace(ls,':p1',edit001.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit002.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit003.Text,[rfReplaceAll]);
        Query4.SQL.Add(ls);
        Query4.Open;
        Query4.Active;
        end;

        if checkbox5.Checked then
        begin
        Query5.Close;
        Query5.SQL.Clear;
        ls := memo5.Text;
        ls := stringreplace(ls,':p1',edit001.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit002.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit003.Text,[rfReplaceAll]);
        Query5.SQL.Add(ls);
        Query5.Open;
        Query5.Active;
        end;

        if checkbox6.Checked then
        begin
        Query6.Close;
        Query6.SQL.Clear;
        ls := memo6.Text;
        ls := stringreplace(ls,':p1',edit001.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p2',edit002.Text,[rfReplaceAll]);
        ls := stringreplace(ls,':p3',edit003.Text,[rfReplaceAll]);
        Query6.SQL.Add(ls);
        Query6.Open;
        Query6.Active;
        end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
        if checkbox10.Checked then
        begin
                button01.Click;
        end;
end;

end.
