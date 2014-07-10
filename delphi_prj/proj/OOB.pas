unit OOB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,math,Contnrs, ComCtrls, ToolWin, Menus, ImgList, IdGlobal, StdCtrls,IniFiles,
  ExtCtrls,Uobj, Grids, ValEdit, jpeg;

type
  TMain = class(TForm)
    MainMenu1: TMainMenu;
    ToolBar1: TToolBar;
    ToolButtonLink: TToolButton;
    ToolButtonComm: TToolButton;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    aaa1: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Porject: TMenuItem;
    Delete1: TMenuItem;
    Save1: TMenuItem;
    Load1: TMenuItem;
    ToolButtonArrow: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Component: TMenuItem;
    Line: TMenuItem;
    Rect: TMenuItem;
    Elip: TMenuItem;
    tt: TMenuItem;
    ToolButton4: TToolButton;
    StatusBar1: TStatusBar;
    Image: TImage;
    bringtofront1: TMenuItem;
    BringToTop1: TMenuItem;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Saveas: TMenuItem;
    Panel2: TPanel;
    Splitter2: TSplitter;
    Panel3: TPanel;
    Panel4: TPanel;
    ComboBox1: TComboBox;
    Panel5: TPanel;
    Label2: TLabel;
    Button1: TButton;
    New: TMenuItem;
    ListBox2: TListBox;
    Panel6: TPanel;
    VLE: TValueListEditor;
    ListBox1: TListBox;
    Splitter3: TSplitter;
    Image1: TImage;
    Panel7: TPanel;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure delete1Click(Sender: TObject);
    procedure SaveToClick(Sender: TObject);
    procedure SaveToFile( FileHandle: TIniFile);
    procedure LoadFromFile( FileHandle: TIniFile);
    procedure Load1Click(Sender: TObject);
    procedure bringtofront1Click(Sender: TObject);
    procedure ReDraw();
    procedure BringToTop1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Sync();
    procedure VLEKeyPress(Sender: TObject; var Key: Char);
    procedure SaveasClick(Sender: TObject);
    procedure NewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
  private
    { Private declarations }
    m_list: TclassList;
    m_liblist :TClassList;
    m_tmpList: TClassList;
    R1 ,R2 :TRect;
    m_canvas :ptobj;
  public
      m_num : integer;
      m_seq :integer;
      m_filename :string;
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses UFormInfo;

{$R *.dfm}
procedure TMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    b :integer;
    flag : integer;
    toplayer :integer;
    t : Tobj;
begin
    if button = mbRight then
       exit;
   flag := 0;
   toplayer:=0;
   if not ToolButtonLink.Down and not ToolButtonComm.Down then
   begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       if TObj(m_List.Items[B]).m_selected = 1 then
       begin
         if  TObj(m_List.Items[B]).ptin(x,y) then
          begin
                toplayer:= 1;
                TObj(m_List.Items[B]).m_selected := 2;
                TObj(m_List.Items[B]).m_mousedown := 1;
                TObj(m_List.Items[B]).setstat(x,y);
                break;
          end
       end
   end;
   if toplayer= 0 then
   begin
    for B := m_List.Count - 1 downto 0 do
    begin
      with TObj(m_List.Items[B]) do
      begin
        if  ptin(x,y) and (flag = 0) then
        begin
           m_selected := 2;
           m_mousedown := 1;
           setstat(x,y);
           flag := 1;
        end
        else
          m_selected := 0;
        end;
    end;
   end;
   end;

    if (flag = 0) and (ToolButtonLink.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
    Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    m_canvas := ptobj(Image.Canvas);
    t := Tlink.Create(Image.Canvas,x,y,x,y);
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
    end;
    if (flag = 0) and (ToolButtonComm.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x,y,x,y);
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
    end;
    image.Canvas.Brush.Color:=clwhite;
    Sync;
    redraw;
end;

procedure TMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  i,b : integer;
  l_obj : Tobj;
  rp :integer;
begin
   rp := 0;
   for B := 0 to (m_List.Count - 1) do
    begin
      l_obj := Tobj(m_List.Items[B]);
      if l_obj.m_selected = 1 then
      begin
         l_obj.setstat(x,y);
      end;
      if l_obj.m_selected = 2 then
      begin
          l_obj.ResizeXY(x,y);
          if  l_obj.m_resizenode = 0 then
          l_obj.m_sourcename := ''
          else
          l_obj.m_targetname := '';

          for i := 0 to  (m_List.Count - 1) do
          begin
                if (l_obj <> Tobj(m_List.Items[i]))
                        then
                begin
                    if (l_obj.ClassName = 'TLink')
                    and (Tobj(m_List.Items[i]).ClassName = 'TComm')
                     and Tobj(m_List.Items[i]).Ptin(x,y)
                      then
                    begin
                      l_obj.ResizeXY( round((Tobj(m_List.Items[i]).m_sx + Tobj(m_List.Items[i]).m_x)/2) ,
                      round((Tobj(m_List.Items[i]).m_sy + Tobj(m_List.Items[i]).m_y)/2) );

                       if (l_obj.m_resizenode = 0) then
                          l_obj.m_sourcename := Tobj(m_List.Items[i]).m_name
                       else
                           l_obj.m_targetname := Tobj(m_List.Items[i]).m_name;

                       //avoid the start and end pointer point the same target.
                       if  l_obj.m_sourcename = l_obj.m_targetname then
                            l_obj.ResizeXY(x,y);
                        break;
                     end;

                    if (l_obj.ClassName = 'TComm')  and
                       (Tobj(m_List.Items[i]).ClassName = 'TLink')
                    then
                    begin

                      if l_obj.m_name = Tobj(m_List.Items[i]).m_sourcename then
                      begin
                      Tobj(m_List.Items[i]).m_resizenode := 0;
                      Tobj(m_List.Items[i]).ResizeXY( round((l_obj.m_sx + l_obj.m_x)/2),
                      round((l_obj.m_sy + l_obj.m_y)/2) );
                      end;

                      if l_obj.m_name = Tobj(m_List.Items[i]).m_targetname then
                      begin
                      Tobj(m_List.Items[i]).m_resizenode := 1;
                      Tobj(m_List.Items[i]).ResizeXY( round((l_obj.m_sx + l_obj.m_x)/2) ,
                      round((l_obj.m_sy + l_obj.m_y)/2) );
                      end;

                     end;
                end;
          end;
          rp := 1;
      end;
      if l_obj.m_selected = 3 then
      begin
          l_obj.MoveXY(x,y);
          //l_obj.m_targetname := '';
            if (l_obj.ClassName = 'TComm') then
            begin
             for i := 0 to  (m_List.Count - 1) do
             begin
               if (Tobj(m_List.Items[i]).m_targetname = l_obj.m_name)
                 and (Tobj(m_List.Items[i]).classname = 'TLink') then
             begin
                  Tobj(m_List.Items[i]).m_resizenode := 1;
                  Tobj(m_List.Items[i]).ResizeXY(round((l_obj.m_sx + l_obj.m_x)/2),
                   round((l_obj.m_sy+l_obj.m_y)/2));
             end;
                   if (Tobj(m_List.Items[i]).m_sourcename = l_obj.m_name)
                 and (Tobj(m_List.Items[i]).classname = 'TLink') then
             begin
                  Tobj(m_List.Items[i]).m_resizenode := 0;
                  Tobj(m_List.Items[i]).ResizeXY(round((l_obj.m_sx + l_obj.m_x)/2),
                   round((l_obj.m_sy+l_obj.m_y)/2));
             end;
            end;
          end;
           rp:=1;
      end;
    end;
    if rp = 1 then
      redraw();
end;

procedure TMain.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   b :integer;
   l_obj :Tobj;
begin
   ToolButtonArrow.Down := true;
   for B := 0 to (m_List.  Count - 1) do
    begin
      l_obj := Tobj(m_List.Items[B]);
      if l_obj.m_selected = 2 then
          l_obj.m_selected := 1;
      if l_obj.m_selected = 3 then
          l_obj.m_selected := 1;
      l_obj.m_mousedown := 0;
    end;
   redraw();
end;

procedure TMain.FormCreate(Sender: TObject);
begin
    m_list := TClassList.Create;
    m_liblist := TClassList.Create;
    r1.Left:=0; r1.Right:=1024;
    r1.Top:=0; r1.Bottom:=768;
    Image.Width:=1024*3;
    Image.Height:=800*3;
    R2:= R1;
    m_seq := 1;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    m_list.Free;
end;

procedure TMain.FormPaint(Sender: TObject);
begin
   redraw();
end;

procedure TMain.delete1Click(Sender: TObject);
var
   b:integer;
   n: integer;
begin
   n := (m_List.Count - 1);
   for B := 0 to n do
        if (TObj(m_List.Items[B]).m_selected =1) then
         begin
            m_List.Delete(b);
            break;
         end;
    screen.Cursor := 0;
    Sync;
    redraw();
end;

procedure TMain.SaveToClick(Sender: TObject);
var
   l_r :TIniFile;
begin
 if m_filename <> '' then
 begin
        l_r:=TIniFile.Create(m_filename);
        SaveToFile(l_r);
        l_r.Destroy;
        exit;
 end;

 if SaveDialog.Execute then
 begin
        l_r:=TIniFile.Create(SaveDialog.FileName);
        SaveToFile(l_r);
        l_r.Destroy;
  end;
end;

procedure TMain.SaveToFile( FileHandle: TIniFile);
var
    i : integer;
begin
    FileHandle.writeinteger('Glob','num',m_list.Count);
    for i := m_list.Count-1  downto 0 do
          Tobj(m_list.Items[i]).SavetoFile(i+1,filehandle);
end;

procedure TMain.LoadFromFile( FileHandle: TIniFile);
var
  i :integer;
  o :tobj;
  cls :string;
begin
    m_num := FileHandle.ReadInteger('Glob','num',0);
    for i := 1 to m_num do
    begin
        cls := FileHandle.ReadString(inttostr(i),'classname','');
        if cls = 'TLink' then
         begin
          o := Tlink.Create(image.canvas,0,0,0,0);
          o.m_name := FileHandle.ReadString(inttostr(i),'m_name','');
          m_seq := max(m_seq,strtoint(o.m_name));
          o.LoadfromFile(i,filehandle);
          m_list.Add(Tclass(o));
          o.m_list := m_list;
        end
        else if cls = 'TComm' then
        begin
          o := TComm.Create(Image.canvas,0,0,0,0);
          o.m_name := FileHandle.ReadString(inttostr(i),'m_name','');
          m_seq := max(m_seq,strtoint(o.m_name));
          o.LoadfromFile(i,filehandle);
          m_list.Add(Tclass(o));
           o.m_list := m_list;
        end;
    end;
end;

procedure TMain.Load1Click(Sender: TObject);
var
   fh:TIniFile;
begin
 if OpenDialog.Execute then
 begin
        m_list.Clear;
        listbox1.Clear;
        fh:=TIniFile.Create(OpenDialog.FileName);
        LoadFromFile(fh);
        fh.Free;
        m_filename := OpenDialog.FileName;

  end;
  sync();
  redraw();
end;

procedure TMain.Redraw();
var
   b :integer;
   o :tobj;
begin
    image.Canvas.FillRect(R2);
    for b := 0 to (m_List.Count - 1) do
        if TObj(m_List.Items[b]).ClassNameIs('TComm') then
               TObj(m_List.Items[b]).Draw;
                
    for b := 0 to (m_List.Count - 1) do
        if TObj(m_List.Items[b]).ClassNameIs('TLink') then
                TObj(m_List.Items[b]).Draw;

    for b := 0 to (m_List.Count - 1) do
        if (TObj(m_List.Items[b]).m_selected > 0 ) then
                TObj(m_List.Items[b]).Draw;
    canvas.CopyRect(R1,image.canvas,R2);
    if ComboBox1.Items.Count> 0  then
    begin
        m_tmplist := TClassList(m_liblist[ComboBox1.ItemIndex]);
        if  ListBox2.ItemIndex > -1 then
        begin
        o := Tobj(m_tmplist[ListBox2.ItemIndex]);
        Image1.Canvas.pen.color := clred  ;
        Image1.Canvas.Brush.Style := bsclear;
        Image1.Canvas.Brush.Color:=clwhite;
        Image1.Canvas.Rectangle( -1,-1,image1.Width+1,image1.Height+1);
        Image1.Canvas.Rectangle( 5,5 ,o.m_x - o.m_sx,o.m_y - o.m_sy);
        end;
    end;
end;

procedure TMain.bringtofront1Click(Sender: TObject);
var t:tobj;
    b :integer;
begin
    if m_list.Count > 1 then
     begin
           for b := (m_List.Count - 1) downto 1 do
                if (TObj(m_List.Items[b]).m_selected = 1) then
            begin
                 t := TObj(m_List.Items[b-1]);
                  m_List.Items[b-1] :=  m_List.Items[b];
                   m_List.Items[b] := Tclass(t);
            end;
     end;
    redraw();
end;

procedure TMain.BringToTop1Click(Sender: TObject);
var t:tobj;
    b :integer;
begin
     if m_list.Count > 1 then
     begin
            for b := 0 to (m_List.Count - 2) do
                if (TObj(m_List.Items[b]).m_selected = 1) then
                begin
                 t := TObj(m_List.Items[b+1]);
                  m_List.Items[b+1] :=  m_List.Items[b];
                   m_List.Items[b] := Tclass(t);
                end;
     end;
    redraw();
end;

procedure TMain.FormDblClick(Sender: TObject);
begin
   sync;
end;

procedure TMain.ListBox1Click(Sender: TObject);
var
  i,b: Integer;
begin
  for i := 0 to (ListBox1.Items.Count - 1) do begin
  try
    if  ListBox1.Selected[i] then
    begin
        for b := 0 to (m_List.Count - 1) do
        begin
       // if ( ListBox1.Items.Strings[i] = Tobj(m_List.Items[b]).m_name ) then
        if (TObj(ListBox1.Items.Objects[i]).m_name  = Tobj(m_List.Items[b]).m_name ) then
        begin
        Tobj(m_List.Items[b]).m_selected := 1;
        end
        else
        Tobj(m_List.Items[b]).m_selected := 0;
        end;
    end;
   finally
   { do something here }
  end;
  end;
  Sync;
  ReDraw;
  ListBox1.ItemIndex := 0;
end;

procedure TMain.VLEKeyPress(Sender: TObject; var Key: Char);
var
  b: Integer;
begin
  if (Key = #13) then
  begin
    for b := 0 to (ListBox1.Items.Count -1 ) do begin
  if Tobj(m_List.Items[b]).m_selected <> 1 then
      if TObj(m_List.Items[b]).m_name = VLE.Values['m_name'] then
      begin
      Application.MessageBox('名称已存在.', '提示', MB_OK);
      exit;
      end;
  end;
  for b := 0 to (ListBox1.Items.Count -1 ) do begin
  if Tobj(m_List.Items[b]).m_selected = 1 then
  begin
      TObj(m_List.Items[b]).m_name:= VLE.Values['m_name'];
      TObj(m_List.Items[b]).m_sourcename := VLE.Values['m_sourcename'];
      TObj(m_List.Items[b]).m_targetname := VLE.Values['m_targetname'];
      TObj(m_List.Items[b]).m_x := strtoint(VLE.Values['m_x']);
      TObj(m_List.Items[b]).m_y := strtoint(VLE.Values['m_y']);
      TObj(m_List.Items[b]).m_sx := strtoint(VLE.Values['m_sx']);
      TObj(m_List.Items[b]).m_sy := strtoint(VLE.Values['m_sy']);
      TObj(m_List.Items[b]).m_desc := (VLE.Values['m_desc']);
      TObj(m_List.Items[b]).m_code := (VLE.Values['m_code']);
  end;
  end;
  sync;
  ReDraw;
  end;
end;

procedure TMain.Sync();
var
  i,b :integer;
begin
   VLE.Strings.Clear;
   listbox1.Clear;
   for b := 0 to (m_list.Count - 1 ) do
   begin
           listbox1.AddItem(Tobj(m_list.Items[b]).m_desc,Tobject(m_list.Items[b]));
   end;
   for b := 0 to (m_List.Count - 1) do
    begin
    if (TObj(m_List.Items[b]).m_selected > 0) then
    begin
      VLE.Strings.Clear;
      VLE.InsertRow('m_name',TObj(m_List.Items[b]).m_name,true);
      VLE.InsertRow('m_sourcename',TObj(m_List.Items[b]).m_sourcename,true);
      VLE.InsertRow('m_targetname',TObj(m_List.Items[b]).m_targetname,true);
      VLE.InsertRow('ClassName',TObj(m_List.Items[b]).ClassName,true);
      VLE.InsertRow('m_x',inttostr(TObj(m_List.Items[b]).m_x),true);
      VLE.InsertRow('m_y',inttostr(TObj(m_List.Items[b]).m_y),true);
      VLE.InsertRow('m_sx',inttostr(TObj(m_List.Items[b]).m_sx),true);
      VLE.InsertRow('m_sy',inttostr(TObj(m_List.Items[b]).m_sy),true);
      VLE.InsertRow('m_desc',TObj(m_List.Items[b]).m_desc,true);
      VLE.InsertRow('m_code',TObj(m_List.Items[b]).m_code,true);
      for i := 0 to (ListBox1.Items.Count - 1) do begin
         if ( ListBox1.Items.Strings[i] = Tobj(m_List.Items[b]).m_name ) then
         begin
             ListBox1.Selected[i] := true;
         end
         else
             ListBox1.Selected[i] := false;
      end;
     end;
    end;
    ListBox2.clear;
    if m_liblist.Count > 0 then
    begin
    m_tmplist := TClassList(m_liblist.Items[ComboBox1.ItemIndex]);

    for b:= 0 to m_tmplist.count-1 do
    begin
        ListBox2.AddItem(Tobj(m_tmplist.Items[b]).m_desc,Tobject(m_tmplist.Items[b]));
    end;
    end;
    ListBox1.SetFocus;
    caption:= 'FLY [' + m_filename + ']';
end;

procedure TMain.SaveasClick(Sender: TObject);
var
   l_r :TiniFile;
begin
 if SaveDialog.Execute then
 begin
        l_r:=TIniFile.Create(SaveDialog.FileName);
        SaveToFile(l_r);
        l_r.Destroy;
        m_filename := SaveDialog.FileName;
  end;
end;

procedure TMain.NewClick(Sender: TObject);
begin
        m_list.Clear;
        m_seq := 0;
        sync;
        redraw;
end;

procedure TMain.Button1Click(Sender: TObject);
var
   filehandle:TIniFile;
   i,l_num:integer;
   cls :string;
   o :Tobj;
   lib :string;
begin
 if OpenDialog.Execute then
 begin
    filehandle :=TIniFile.Create(OpenDialog.FileName);
    m_tmplist := TClassList.Create;
    l_num := FileHandle.ReadInteger('Glob','num',0);
    for i := 1 to l_num do
    begin
        cls := FileHandle.ReadString(inttostr(i),'classname','');
        if cls = 'TLink' then
         begin
          o := Tlink.Create(image.canvas,0,0,0,0);
          o.m_name := FileHandle.ReadString(inttostr(i),'m_name','');
          o.LoadfromFile(i,filehandle);
          m_tmplist.Add(Tclass(o));
      filehandle.Free;
      m_liblist.Add(TClass(m_tmplist));
      lib :=  copy (OpenDialog.FileName,LastDelimiter('\',OpenDialog.FileName)+1,255);
      ComboBox1.AddItem(lib,TObject(o));
      ComboBox1.ItemIndex:= ComboBox1.Items.Count -1;
              end
        else if cls = 'TComm' then
        begin
          o := TComm.Create(Image.canvas,0,0,0,0);
          o.m_name := FileHandle.ReadString(inttostr(i),'m_name','');
          o.LoadfromFile(i,filehandle);
          m_tmplist.Add(Tclass(o));
      filehandle.Free;
      m_liblist.Add(TClass(m_tmplist));
      lib :=  copy (OpenDialog.FileName,LastDelimiter('\',OpenDialog.FileName)+1,255);
      ComboBox1.AddItem(lib,TObject(o));
      ComboBox1.ItemIndex:= ComboBox1.Items.Count -1;
        end;
    end;

  end;
  sync();
  redraw();
end;

procedure TMain.ComboBox1Change(Sender: TObject);
begin
   Sync;
   redraw;
end;

procedure TMain.ListBox2Click(Sender: TObject);
begin
        redraw;
end;

end.
