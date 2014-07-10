unit OOB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,math,Contnrs, ComCtrls, ToolWin, Menus, ImgList, IdGlobal, StdCtrls,IniFiles,
  ExtCtrls,Uobj, Grids, ValEdit, jpeg,Clipbrd, xmldom, XMLIntf, msxmldom,
  XMLDoc, Buttons, OleServer, Word2000,Umysql;

type
  TMain = class(TForm)
    MainMenu1: TMainMenu;
    ToolBar1: TToolBar;
    ToolButtonLink: TToolButton;
    ToolButtonComm: TToolButton;
    PopupMenu1: TPopupMenu;
    aaa1: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Porject: TMenuItem;
    Delete1: TMenuItem;
    Save1: TMenuItem;
    Load: TMenuItem;
    ToolButtonArrow: TToolButton;
    ToolButtonOpen: TToolButton;
    ToolButtonSave: TToolButton;
    ToolButton3: TToolButton;
    Component: TMenuItem;
    Line: TMenuItem;
    Rec: TMenuItem;
    Elip: TMenuItem;
    tt: TMenuItem;
    ToolButtonTable: TToolButton;
    StatusBar1: TStatusBar;
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
    Splitter3: TSplitter;
    Image1: TImage;
    Panel7: TPanel;
    ToolButtonIF: TToolButton;
    ToolButtonline: TToolButton;
    ToolButtonEClip: TToolButton;
    ToolButtonRoundRect: TToolButton;
    ToolButtonImage: TToolButton;
    ToolButton7: TToolButton;
    ccc1: TMenuItem;
    ddd1: TMenuItem;
    eee1: TMenuItem;
    PopupMenuObj: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Eclip1: TMenuItem;
    Rect1: TMenuItem;
    RoundRect1: TMenuItem;
    Red: TMenuItem;
    Blue: TMenuItem;
    Yellow: TMenuItem;
    N1: TMenuItem;
    SendtoBack1: TMenuItem;
    N2: TMenuItem;
    ImageList1: TImageList;
    XMLDoc: TXMLDocument;
    ColorDialog1: TColorDialog;
    N3: TMenuItem;
    ToolButtonText: TToolButton;
    ScrollBox1: TScrollBox;
    EditInput: TEdit;
    TV: TTreeView;
    PaintBox1: TPaintBox;
    Image: TImage;
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
    procedure SaveToFile( FileHandle: TXMLDocument);
    procedure LoadFromFile( FileHandle: TXMLDocument);
    procedure LoadClick(Sender: TObject);
    procedure bringtofront1Click(Sender: TObject);
    procedure ReDraw();
    procedure BringToTop1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure Sync();
    procedure VLEKeyPress(Sender: TObject; var Key: Char);
    procedure SaveasClick(Sender: TObject);
    procedure NewClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ScrollBar_VChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditInputClick(Sender: TObject);
    procedure EditInputExit(Sender: TObject);
    procedure Rect1Click(Sender: TObject);
    procedure Eclip1Click(Sender: TObject);
    procedure RoundRect1Click(Sender: TObject);
    procedure RedClick(Sender: TObject);
    procedure BlueClick(Sender: TObject);
    procedure YellowClick(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure SendtoBack1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure EditInputKeyPress(Sender: TObject; var Key: Char);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure ScrollBox1Resize(Sender: TObject);
  private
    { Private declarations }
    m_list: TClassList;
    m_liblist :TClassList;
    m_tmpList: TClassList;
    m_showdot :boolean;
    R1 ,R2 :TRect;
    l_batselect:TRect;
    m_modify:boolean;
    l_batchselect : integer;
//    m_canvas :ptobj;
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
    b,C :integer;
    t : Tobj;
    l_tv: TTreeNode;

begin

 main.KeyPreview := true;
 editinput.Visible := false;
 if button = mbRight then
 begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  (t.ptin(x,y)) then
       begin
        t.m_selected := 1;
        sync;
        redraw;
        popupmenuobj.Popup(scrollbox1.Left +x ,scrollbox1.top +y+40);
       end
   end;
   exit;
 end;
 c:= 0;
 //x := round((x+5) div 10) * 10;
 //y := round((y+5) div 10) * 10;
 if ToolButtonarrow.Down then
 begin
  l_batchselect := 1;
  l_batselect.Left := x;
  l_batselect.Top := y;
   editinput.Tag := -1;

   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  (t.ptin(x,y)) then
       begin
          t.m_osx := t.m_sx ; t.m_osy := t.m_sy;
          t.m_ox := t.m_x ; t.m_oy := t.m_y;
          t.m_oselected := t.m_selected;
          l_batchselect := 0;
          if ([ssShift,ssLeft] = Shift ) then
          begin
             if  (t.m_selected = 1 )
              then
              begin
                 t.m_selected := 0;
                 t.m_mousedown := 0;
                 t.setstat(x,y);
                 break;
              end
              else
              begin
                t.m_selected := 2;
                t.m_mousedown := 1;
                t.setstat(x,y);
              end;
             C:=1;
             break;
          end
          else// no shift
          begin
            if  t.m_selected = 1 then
            begin
              t.m_selected := 2;
              t.m_mousedown := 1;
              t.setstat(x,y);
              editinput.Tag := b; //record the obj id.
//              memo1.Tag := b;
              C:=1;
            end;
            break;
          end;
          break;
       end
   end; // for


   if ([ssShift,ssLeft] = Shift) or (C = 1)then  //多选 被选择
   begin
        for B := (m_List.Count - 1) downto 0 do
        begin
            t := TObj(m_List.Items[B]);
            if t.m_selected = 1 then
            begin
                t.m_selected := 2;
                t.m_mousedown := 1;
                t.setstat(x,y);
            end
        end
   end
   else
   begin //全不选择
        for B := (m_List.Count - 1) downto 0 do
        begin
                t := TObj(m_List.Items[B]);
                if t.ptin(x,y) then
                begin
                    t.m_selected := 2;
                    t.m_mousedown := 1;
                    t.setstat(x,y);
                    break;
                end
                else
                begin
                    t.m_selected := 0;
                    t.m_mousedown := 0;
                    t.setstat(x,y);
                end;
        end;
        for B := B -1 downto 0 do
        begin
            t := TObj(m_List.Items[B]);
            t.m_selected := 0;
            t.m_mousedown := 0;
            t.setstat(x,y);
        end;

   end;
 end;



    if (ToolButtonLink.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
   // m_canvas := ptobj(Image.Canvas);
    t := Tlink.Create(Image.Canvas,x-20,y-20,x,y);
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
    l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName) then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if (ToolButtonLine.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
    Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    //m_canvas := ptobj(Image.Canvas);
    t := Tline.Create(Image.Canvas,x-20,y-20,x,y);
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
    l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if  (ToolButtonComm.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x-80,y-40,x,y);
    t.m_dstyle := 1;    
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
    l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if  (ToolButtonTable.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TTable.Create(Image.Canvas,x-100,y-160,x,y);
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if  (ToolButtonEclip.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x-80,y-40,x,y);
    t.m_dstyle := 2;
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;


    if  (ToolButtonRoundRect.Down = true) then
   begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x-140,y-30,x,y);
    t.m_dstyle := 3;
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if  (ToolButtonImage.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x-32,y-32,x,y);
    t.m_dstyle := 4;
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;

    if  (ToolButtonText.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TComm.Create(Image.Canvas,x-80,y-40,x,y);
    t.m_dstyle := 5;
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x,y);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;


    if  (ToolButtonIF.Down = true) then
    begin
    for B := 0 to (m_List.Count - 1) do
       Tobj(m_List.Items[B]).m_selected := 0;
    m_seq := m_seq + 1;
    t := TIF.Create(Image.Canvas,x-100,y-30,x,y);
    t.m_name := inttostr(m_seq);
    t.m_targetname:= '';
    t.m_selected := 2;
    t.m_mousedown := 1;
    t.setstat(x+20,y+20);
    m_list.Insert(0,TClass(t));
    t.m_list := m_list;
       l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = t.ClassName then
      begin
        tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> t.ClassName)  then
    begin
      l_tv := tv.Items.Add(nil,t.ClassName);
      tv.Items.AddChild(l_tv,t.m_name).ImageIndex := 4;
    end;
    end;
    Sync;
    redraw;
end;

procedure TMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  i,b : integer;
  l_obj : Tobj;
  rp :integer;
  rec : Trect;
begin
    rp := 0;
 //   x := round((x + 5) div 10) * 10;
 //   y := round((y + 5) div 10) * 10;
   l_batselect.Bottom := Y;
   l_batselect.Right := X;
   if self.l_batchselect = 1 then
   begin
      rp := 1;
      for B := 0 to (m_List.Count - 1) do
      begin
         l_obj := Tobj(m_List.Items[B]);
         if not l_obj.IsLink  then
         begin
           if IntersectRect(rec,l_batselect,Rect(l_obj.m_sx,l_obj.m_sy,l_obj.m_x,l_obj.m_y))
           then
           begin
             l_obj.m_selected := 1;
             l_obj.m_mousedown := 1;
              editinput.Visible := false;
//              memo1.Visible := false;
           end
           else
           begin
             l_obj.m_selected := 0;
             l_obj.m_mousedown := 0;
           end
         end
      end;
   end;

   for B := 0 to (m_List.Count - 1) do
    begin
      l_obj := Tobj(m_List.Items[B]);
      if l_obj.m_selected = 1 then
      begin
         l_obj.setstat(x,y);
      end;

      if l_obj.m_selected = 2 then   //resize
      begin             
          l_obj.ResizeXY(x,y);
          if  l_obj.m_resizenode = 0 then
          l_obj.m_sourcename := ''
          else
          l_obj.m_targetname := '';

          for i := m_List.Count - 1 downto 0 do
          begin
                if (l_obj <> Tobj(m_List.Items[i]))
                then
                begin
                    if (l_obj.IsLink and not Tobj(m_List.Items[i]).IsLink)
                     and Tobj(m_List.Items[i]).Ptin(x,y) then
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

                    if (not l_obj.IsLink and Tobj(m_List.Items[i]).IsLink)
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

      if l_obj.m_selected = 3 then  //move
      begin
          if( l_obj.IsLink ) and ((l_obj.m_tx <> X) or (l_obj.m_ty <> Y)) then
          begin
             l_obj.m_sourcename := '';
             l_obj.m_targetname := '';
          end;
          l_obj.MoveXY(x,y);
          //l_obj.m_targetname := '';
          if (not l_obj.IsLink) then
            begin
             for i := 0 to  (m_List.Count - 1) do
             begin
               if (Tobj(m_List.Items[i]).m_targetname = l_obj.m_name)
                 and (Tobj(m_List.Items[i]).IsLink) then
             begin
                  Tobj(m_List.Items[i]).m_resizenode := 1;
                  Tobj(m_List.Items[i]).ResizeXY(round((l_obj.m_sx + l_obj.m_x)/2),
                   round((l_obj.m_sy+l_obj.m_y)/2));
             end;

             if (Tobj(m_List.Items[i]).m_sourcename = l_obj.m_name)
                 and (Tobj(m_List.Items[i]).IsLink()) then
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
   l_si :tsize;
begin
   ToolButtonArrow.Down := true;
   l_batchselect := 0;
   for B := 0 to (m_List.  Count - 1) do
    begin
      l_obj := Tobj(m_List.Items[B]);
      if l_obj.m_selected = 2 then
        l_obj.m_selected := 1
      else if l_obj.m_selected = 3 then
      begin
          if (l_obj.m_osx = l_obj.m_sx) and (l_obj.m_osy = l_obj.m_sy) and
          (l_obj.m_ox = l_obj.m_x) and  (l_obj.m_oy = l_obj.m_y)
          and (l_obj.m_oselected = 1)
          then
          begin
            main.KeyPreview := false;
            editinput.Visible := not editinput.Visible;
//            memo1.Visible := not memo1.Visible;
            editinput.Left := l_obj.m_sx -5 + scrollbox1.Left;
            editinput.Top := round((l_obj.m_sy+l_obj.m_y)/2)+ scrollbox1.Top;
            gettextextentpointW(l_obj.m_canvas.Handle,pwidechar(l_obj.m_desc),length(l_obj.m_desc),l_si);
//            edit1.Width := max(20 + length(l_obj.m_desc)*6,l_obj.m_x- l_obj.m_sx+10);
            editinput.Width := max(l_obj.m_x - l_obj.m_sx+10,l_si.cx);
            editinput.Text := l_obj.m_desc;
            editinput.SetFocus;
            editinput.SelectAll;
            l_obj.m_selected := 0;
          end
          else
           l_obj.m_selected := 1
      end;
      l_obj.m_mousedown := 0;
    end;
   redraw();
end;

procedure TMain.FormCreate(Sender: TObject);
begin
    m_list := TClassList.Create;
    m_liblist := TClassList.Create;
    r1.Left:=0; r1.Right:=1024*2;
    r1.Top:=0; r1.Bottom:=768*2;
    Image.Width:=1024*2;
    Image.Height:=768*2;
    R2:= R1;
    m_seq := 0;
    m_showdot := true;
    image.Canvas.Brush.Color:=clwhite;
    image.Canvas.pen.Width := 1;
    m_modify := false;


end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if m_modify then
     if  application.MessageBox('保存当前的文件？', '提示', MB_OKCANCEL)= IDOK	then
      SaveToClick(self);
    m_list.Free;
end;

procedure TMain.FormPaint(Sender: TObject);
begin
//   redraw();
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
        Screen.Cursor := crHourGlass;
        SaveToFile(xmldoc);
        xmldoc.SaveToFile(m_filename);
        m_modify  := false;
        l_r.Destroy;
        Screen.Cursor := crarrow;

        exit;
 end
 else if SaveDialog.Execute then
 begin
        l_r:=TIniFile.Create(SaveDialog.FileName);
        Screen.Cursor := crHourGlass;
        SaveToFile(xmldoc);
        xmldoc.SaveToFile(SaveDialog.FileName);
        m_modify  := false;
        m_filename := SaveDialog.FileName;
        l_r.Destroy;
         Screen.Cursor := crarrow;
  end;
end;

procedure TMain.SaveToFile( FileHandle: TXmldocument);
var
    i : integer;
    vnode,vsubnode : IXMLNOde;
begin
    filehandle.LoadFromStream(Tstringstream.Create('<?xml version="1.0" standalone="yes"?><content></content>'));
    filehandle.Active := true;
    for i := m_list.Count-1  downto 0 do
          Tobj(m_list.Items[i]).SavetoFile(i+1,filehandle);
end;

procedure TMain.LoadFromFile( FileHandle: TXMLDocument);
var
  i :integer;
  o :tobj;
  cls :string;
  vnode : IXMLNODE;
  l_tv : ttreenode;
begin
    tv.Items.Clear;
    m_num := FileHandle.DocumentElement.ChildNodes.Count;
    for i := 0 to m_num - 1 do
    begin
//        cls := FileHandle.ReadString(inttostr(i),'classname','');
        vnode := FileHandle.DocumentElement.ChildNodes[i];
        cls := vnode.childNodes['classname'].text;
          o := nil;
          if cls = 'TLink' then
          o := Tlink.Create(image.canvas,0,0,0,0)
          else if (cls = 'TComm')  then
           o := TComm.Create(Image.canvas,0,0,0,0)
          else if (cls = 'TEcllipse')  then
          begin
           o := TComm.Create(Image.canvas,0,0,0,0);
           o.m_dstyle:=2;
          end
          else if (cls = 'TLine')  then
           o := Tline.Create(Image.canvas,0,0,0,0)
          else if  (cls = 'TTable') then
          o := TTable.Create(Image.canvas,0,0,0,0)
          else if   (cls = 'TIF') then
          o := TIF.Create(Image.canvas,0,0,0,0)
          else if (cls = 'TRoundrect')  then
          begin
           o := TComm.Create(Image.canvas,0,0,0,0);
           o.m_dstyle:=3;
          end;



        //  o.m_name := FileHandle.ReadString(inttostr(i),'m_name','');
          o.m_name := vnode.ChildNodes['m_name'].Text;
          m_seq := max(m_seq,strtoint(o.m_name));
          o.LoadfromFile(i,filehandle);
    l_tv := tv.Items.GetFirstNode;
    while l_tv <> nil do
    begin
      if l_tv.Text = cls then
      begin
        tv.Items.AddChild(l_tv,o.m_name).ImageIndex := 4;
        break;
      end;
      l_tv := l_tv.getNextSibling;
    end;

    if (l_tv = nil ) or (l_tv.Text <> cls)  then
    begin
      l_tv := tv.Items.Add(nil,cls);
      tv.Items.AddChild(l_tv,o.m_name).ImageIndex := 4;
    end;
          m_list.Add(Tclass(o));
          o.m_list := m_list;
    end;
end;

procedure TMain.LoadClick(Sender: TObject);
var
   fh:TIniFile;
begin
 if OpenDialog.Execute then
 begin
        m_list.Clear;
        fh:=TIniFile.Create(OpenDialog.FileName);
        xmldoc.LoadFromFile(OpenDialog.FileName);
        LoadFromFile(xmldoc);
        fh.Free;
        m_filename := OpenDialog.FileName;
  end;
  sync();
  redraw();
  m_modify := false;
end;

procedure TMain.Redraw();
var
   b,n,flag,maxx,maxy :integer;
   o,o1 :tobj;
begin
    image.Canvas.Brush.Color := clwhite;
    image.Canvas.FillRect(R2);
{   image.Canvas.Pen.Style := psInsideFrame;
    image.Canvas.Pen.Color := clRed;
    image.Canvas.MoveTo(0,0);
    image.Canvas.LineTo(500,500);
}

   if m_showdot then
   begin
     image.Canvas.Pen.Color := clblack;
    for b := 0 to round(image.Width/10) do
    begin
      for n :=0 to  round(image.height/10) do
      begin
         image.Canvas.MoveTo(b*10,n*10);
         image.Canvas.LineTo(b*10+1,n*10);
      end;
    end;
   end;
   maxx := 400;
   maxy:= 400;
   o := nil ; o1 := nil;
   //先画对象
    for b := 0 to (m_List.Count - 1) do
    begin
           maxx :=  max(TObj(m_List.Items[b]).m_x+100,maxx);
           maxy := max(TObj(m_List.Items[b]).m_y+100,maxy);
           if not TObj(m_List.Items[b]).IsLink then
           TObj(m_List.Items[b]).Draw;
    end; // for

   //后画线
    for b := 0 to (m_List.Count - 1) do
    begin
           maxx :=  max(TObj(m_List.Items[b]).m_x+100,maxx);
           maxy := max(TObj(m_List.Items[b]).m_y+100,maxy);
        if TObj(m_List.Items[b]).IsLink then
        begin
           flag := 0;
            for n := 0 to (m_List.Count - 1) do
            begin
              if TObj(m_List.Items[n]).m_name = TObj(m_List.Items[b]).m_sourcename then
              begin
                o := TObj(m_List.Items[n]);
                flag:= flag + 1;
              end;
              if TObj(m_List.Items[n]).m_name = TObj(m_List.Items[b]).m_targetname then
              begin
                 o1 := TObj(m_List.Items[n]);
                 flag:= flag + 2;
              end;
            end;
            // 根据线连接的对象大小，重新计算线的起点和终点
            if ( flag = 0 ) then
            Tlink(m_List.Items[b]).SetDRect(
            Rect(0,0,0,0),
            Rect(0,0,0,0))
            else  if ( flag = 1) then
            Tlink(m_List.Items[b]).SetDRect(
            Rect(o.m_sx,o.m_sy,o.m_x,o.m_y),
            Rect(0,0,0,0))
            else  if ( flag = 2) then
             begin
              caption := Tobj(m_List.Items[b]).ClassName;
             Tlink(m_List.Items[b]).SetDRect(
              Rect(0,0,0,0),
              Rect(o1.m_sx,o1.m_sy,o1.m_x,o1.m_y)
              )
             end
            else
            Tlink(m_List.Items[b]).SetDRect(
            Rect(o.m_sx - 5 ,o.m_sy - 5,o.m_x + 5,o.m_y + 5),
            Rect(o1.m_sx - 5,o1.m_sy - 5,o1.m_x+ 5,o1.m_y+ 5));
        TObj(m_List.Items[b]).Draw;
        end;
    end; // for

    if l_batchselect = 1 then
    begin
      image.Canvas.Brush.Color := clBlack;
      image.Canvas.FrameRect(l_batselect);
      image.Canvas.Brush.Color := clwhite;
    end;

   paintbox1.Width := max(maxx,scrollbox1.Width);
   paintbox1.Height := max(maxy,scrollbox1.Height);
   paintbox1.canvas.CopyRect(paintbox1.ClientRect,image.canvas,paintbox1.ClientRect);

 //   paintbox1.canvas.StretchDraw(R1,image.Picture.Graphic);
//   canvas.CopyRect(R2,image.canvas,r1);
//
//   if    maxx > paintbox1.width  then    paintbox1.width := maxx;
//    if maxy > paintbox1.Height then paintbox1.height := maxy;


 {
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
  }
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

procedure TMain.VLEKeyPress(Sender: TObject; var Key: Char);
var
  b: Integer;
begin
  if (Key = #13) then
  begin

  for b := 0 to (m_List.Count -1 ) do
  begin
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
  b :integer;
  l_tv :ttreenode;
begin
   VLE.Strings.Clear;
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

      if tv.Focused then
      begin
        l_tv := tv.Items.GetFirstNode;
        while l_tv <> nil do
        begin
         if l_tv.Text = TObj(m_List.Items[b]).m_name then
            l_tv.Selected := true;
        l_tv := l_tv.GetNext;
        end;
      end;
      break;
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
    caption:= 'FLY [' + m_filename + ']';
    m_modify := true;
end;

procedure TMain.SaveasClick(Sender: TObject);
var
   l_r :TiniFile;
   lxmldoc :Txmldocument;
begin
 if SaveDialog.Execute then
 begin
     l_r:=TIniFile.Create(SaveDialog.FileName);
     lxmldoc := Txmldocument.Create(SaveDialog.FileName);
     SaveToFile(lxmldoc);
     lxmldoc.Free;
     lxmldoc.SaveToFile();
     l_r.Destroy;
     m_filename := SaveDialog.FileName;
  end;
end;

procedure TMain.NewClick(Sender: TObject);
begin
    m_list.Clear;
    m_seq := 0;
    m_filename := '';
    sync;
    redraw;
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

procedure TMain.ScrollBar_VChange(Sender: TObject);
begin;
end;

procedure TMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var l_obj : tobj;
    b :integer;
    li : Tbitmap;
    l_rect : trect;
    l_tag : integer;
begin
   l_tag := 0;
   if (key = ord('D')) and  (Shift = [ssCtrl]) then
      m_showdot := not m_showdot;
   if (key = ord('W')) and  (Shift = [ssCtrl]) then
   begin
      for B := 0 to (m_List.Count - 1) do
     begin
         l_obj := Tobj(m_list.Items[b]);
          if l_obj.m_selected <> 0 then
          begin
              if  l_obj.m_shadow = 1 then
                 l_obj.m_shadow := 0
              else
                 l_obj.m_shadow := 1
          end
     end;
   end;
  if (key = ord('C')) and  (Shift = [ssCtrl]) then
  begin

     for B := 0 to (m_List.Count - 1) do
     begin
         l_obj := Tobj(m_list.Items[b]);
         if l_obj.m_selected <> 0 then
         begin
           l_obj.m_selected := 0;
           if l_tag = 0 then
           begin
             l_rect := rect(l_obj.m_sx,l_obj.m_sy,l_obj.m_x+3,l_obj.m_y+3);
             l_tag := 1
           end
           else
           begin
             l_rect.Left := min ( l_rect.Left, l_obj.m_sx -3);
             l_rect.top  := min ( l_rect.top, l_obj.m_sy -3);
             l_rect.right := max ( l_rect.Right, l_obj.m_x +3 );
             l_rect.Bottom := max ( l_rect.Bottom, l_obj.m_y +3);
           end
        end
     end;

     if l_tag <> 0 then
     begin

     redraw;
     li := tbitmap.Create;
     li.Width := l_rect.Right - l_rect.Left;
     li.Height := l_rect.Bottom - l_rect.Top + 30;
      li.Canvas.CopyRect(rect(0,0,li.Width,li.Height-30),image.Canvas,l_rect);
      if li.Width > 200 then
         li.Canvas.Textout(round(li.Width/2)- 35,
        li.Height-20,' 联创科技 ');
     clipboard.Assign(li);
      li.Free;
     end;

  end;

  if (key = ord('A')) and  (Shift = [ssCtrl]) then
   begin
   for B := 0 to (m_List.Count - 1) do
    begin
      l_obj := Tobj(m_List.Items[B]);
      if (not l_obj.IsLink) then
      l_obj.m_selected := 1;
   end;
   end;
  if editinput.Visible then
    editinput.SetFocus;
  Sync;
  redraw;
end;

procedure TMain.EditInputClick(Sender: TObject);
begin
    main.KeyPreview := false;
end;

procedure TMain.EditInputExit(Sender: TObject);
begin
    editinput.Visible := false;
end;

procedure TMain.Rect1Click(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_dstyle := 1;
       end
   end;
    sync;
   redraw;
end;

procedure TMain.Eclip1Click(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_dstyle := 2;
       end
   end;
    sync;
   redraw;
end;

procedure TMain.RoundRect1Click(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_dstyle := 3;
       end
   end;
    sync;
   redraw;
end;

procedure TMain.RedClick(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_fillcolor := $99bbff;
       end
   end;
    sync;
   redraw;

end;

procedure TMain.BlueClick(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_fillcolor := $ffeedd;
       end
   end;
    sync;
   redraw;
end;

procedure TMain.YellowClick(Sender: TObject);
var b:integer;
    t : tobj;
begin
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
        t.m_fillcolor := $88ffff;
       end
   end;
    sync;
   redraw;
end;

procedure TMain.MenuItem4Click(Sender: TObject);
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

procedure TMain.SendtoBack1Click(Sender: TObject);
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

procedure TMain.N3Click(Sender: TObject);
var b,l_flag:integer;
    t : tobj;
begin
   l_flag := 0;
   for B := (m_List.Count - 1) downto 0 do
   begin
       t := TObj(m_List.Items[B]);
       if  t.m_selected > 0 then
       begin
       if (l_flag = 0)  then
       begin
       ColorDialog1.Color := t.m_fillcolor;
       if  ColorDialog1.Execute then
       begin
         t.m_fillcolor := ColorDialog1.Color;
         l_flag := 1;
       end;
       end
       else
          t.m_fillcolor := ColorDialog1.Color;
       end;
   end;
    sync;
   redraw;
end;

procedure TMain.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
       main.FormMouseDown(Sender,button,shift,x,y);
end;

procedure TMain.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
        main.FormMouseMove(Sender,shift,x,y);
end;

procedure TMain.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
         main.FormMouseUp(Sender,button,shift,x,y);
end;

procedure TMain.TVChange(Sender: TObject; Node: TTreeNode);
var b :integer;
begin
       for b := (m_List.Count-1 ) downto 0 do
            if (TObj(m_List.Items[b]).m_name = node.Text) then
                TObj(m_List.Items[b]).m_selected := 1
            else
                TObj(m_List.Items[b]).m_selected := 0;
        sync;
     redraw;
end;

procedure TMain.EditInputKeyPress(Sender: TObject; var Key: Char);
var l_obj : tobj;
    l_si :tsize;
begin
    l_obj := Tobj(m_List.Items[editinput.Tag]);
    if (key = chr(13)) then
    begin
        main.KeyPreview := true;
        l_obj.m_desc := editinput.Text;
        editinput.Visible := false;
     end;
    gettextextentpointW(canvas.Handle,pwidechar(editinput.text),length(editinput.text),l_si);
    editinput.Width := max(l_obj.m_x - l_obj.m_sx+10,l_si.cx);
    redraw;
end;

procedure TMain.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      main.FormMouseDown(Sender,button,shift,x,y);
end;

procedure TMain.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
        main.FormMouseMove(Sender,shift,x,y);
end;

procedure TMain.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    main.FormMouseUp(Sender,button,shift,x,y);
end;

procedure TMain.PaintBox1Paint(Sender: TObject);
begin
      redraw;
end;

procedure TMain.ScrollBox1Resize(Sender: TObject);
begin
     paintbox1.SetBounds(10,10,
     max(scrollbox1.Width, paintbox1.Width),
     max(scrollbox1.Height, paintbox1.Height)) ;
end;

end.
