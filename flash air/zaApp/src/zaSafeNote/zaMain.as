package zaSafeNote
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.errors.IOError;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import zaSafeNote.model.*;
	
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.data.DataProvider;
	import qnx.ui.display.Image;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	import qnx.ui.listClasses.ScrollDirection;
	import qnx.ui.listClasses.ScrollPane;
	import qnx.ui.text.Label;
	import qnx.ui.text.TextInput;
	
	[SWF(height="600", width="1024", 
	frameRate="30", backgroundColor="#4444FF")]	
	
	public class zaMain extends Sprite
	{
		
		private var caption:Label = new Label();
		
		private var msg:TextField = new TextField();
		private var m_title:TextField = new TextField();
		private var m_username:TextField = new TextField();
		private var m_password:TextField = new TextField();
		private var m_updatetime:TextField = new TextField();	
		private var m_notes:TextField = new TextField();
		
		private var m_lab_title:Label = new  Label();
		private var m_lab_username:Label = new  Label();
		private var m_lab_password:Label = new Label();		
		private var m_lab_updatime:Label = new Label();
		private var m_lab_notes:Label = new Label();
		
		
		private var m_scroll:ScrollPane = new ScrollPane();
		private var m_catlist:List= new List();
		private var m_list:List= new List();
		
		private var externalXML:XML;    
		private var loader:URLLoader;
		private var LabTF :TextFormat = new TextFormat();
		private var LabTFa :TextFormat = new TextFormat();
		
		private var m_bg :Sprite = new Sprite();
		private var btn_save :LabelButton = new LabelButton();
		
		private var btn_del :LabelButton = new LabelButton();
		private var btn_new :LabelButton = new LabelButton();
		private var btn_menu :LabelButton = new LabelButton();
		
		private var m_saved:Boolean = false;
		private var m_mails:Array=[];	
		private var m_catlogs:Array=[];
		private var m_bg2:Image = new Image();
		private var m_sql:RecordDAO = new RecordDAO();
		public function zaMain()
		{
			m_catlist.setPosition(0,100);
			m_catlist.width = 380; 
			m_catlist.height = 500; 
			m_catlist.rowHeight = 80;
			m_catlist.selectionMode = ListSelectionMode.SINGLE; 
			m_catlist.allowDeselect = false; 
			m_catlist.setSkin(zaCatlogCellrender);
						
			m_bg2.x = 0;
			m_bg2.y = 0;
		
			m_bg2.setImage("zaSafeNote/res/bg2.jpg");
			addChild(m_bg2);
			
			m_catlogs = m_sql.findall("");
			
			m_catlist.dataProvider = new DataProvider(m_catlogs) ;
			m_catlist.addEventListener(MouseEvent.CLICK,handleSelect1);
			
			addChild(m_catlist);
			
			LabTF.color = 0xFFFFFF;
			LabTF.size = 32;
			LabTF.bold = true;		
			
			caption.setPosition(130,10);
			caption.height = 60;
			caption.width = 1000;
			caption.format = LabTF;
			caption.text ="语  录";
			addChild(caption);
			
			LabTF.size = 18;
			LabTF.color = 0xFF8888;	
			LabTF.bold = false;	
			
			msg.x =410;
			msg.y =10;
			msg.height = 60;
			msg.width = 1000;
			msg.alwaysShowSelection = true;
			msg.type = TextFieldType.INPUT;
			
			msg.wordWrap = true;
			msg.htmlText="<font size=24 color=red>aaa</font>" 
			var tf:TextFormat = msg.defaultTextFormat;
			tf.size=24;
			tf.color=0xDDDDDD;
			tf.align=flash.text.TextFormatAlign.LEFT;
			
			m_lab_title.text = "Title:";
			m_lab_username.text = "UserName:";
			m_lab_password.text = "Password:";
			m_lab_updatime.text = "WebSite:";
			m_lab_notes.text = "Notes:";
			
			m_lab_title.setPosition(40,60);
			m_lab_username.setPosition(40,120);
			m_lab_password.setPosition(40,180);
			m_lab_updatime.setPosition(40,240);			
			m_lab_notes.setPosition(40,300);
			
			m_lab_title.format = tf;
			m_lab_username.format = tf;
			m_lab_password.format = tf;
			m_lab_updatime.format = tf;			
			m_lab_notes.format = tf;
			
//			m_bg.addChild(m_lab_title);
			
//			m_bg.addChild(m_lab_username);
//			m_bg.addChild(m_lab_password);	
//			m_bg.addChild(m_lab_updatime);
//			
//			m_bg.addChild(m_lab_notes);
			
			//msg.defaultTextFormat = tf;	
			//msg.format = LabTF;
			//addChild(msg);			
			
			m_bg.graphics.beginFill(0x444444,0);			
			m_bg.graphics.lineStyle(1,0x666666,0);
			m_bg.graphics.drawRoundRect(0,0,635,590,10,10);			
			m_bg.graphics.endFill();		
			
			m_bg.x = 380;
			m_bg.y = 5;
			
			LabTFa.color = 0xFFFFCC;
			LabTFa.size = 30;
			LabTFa.bold = false;	
			
			tf.color = 0xFFFFFF;
			
			m_title.x = 10;
			m_title.y = 20;
			m_title.height = 30;
			m_title.width = 625;
		//	m_title.border = true;
		//	m_title.borderColor = 0xFFAAAAFF;
		
			m_title.alwaysShowSelection = true;
			m_title.type = TextFieldType.INPUT;
			m_title.defaultTextFormat = tf;
			m_bg.addChild(m_title);
							
			tf.size = 20;
			
			m_updatetime.x = 180;
			m_updatetime.y = 90;
			m_updatetime.height=20;
			m_updatetime.width = 300;
			m_updatetime.defaultTextFormat = tf;
			//m_bg.addChild(m_updatetime);
			
			tf.color = 0x000000;
			
			m_notes.x=10;
			m_notes.y=10;	
//			m_notes.border = true;
//			m_notes.borderColor = 0xFFAAAAFF;						
//			
			m_notes.height = 530;
			m_notes.width = 625;	
			m_notes.multiline=true;			
			m_notes.type = TextFieldType.INPUT;
			//m_notes.autoSize = flash.text.TextFieldAutoSize.LEFT;
			m_notes.wordWrap = true;
		
			m_notes.defaultTextFormat = tf;	
			
			m_scroll.x = 10;
			m_scroll.y = 90;
			m_scroll.height = 540;
			m_scroll.width = 630;	
			m_scroll.scrollDirection = ScrollDirection.VERTICAL;
			m_scroll.setScrollContent( m_notes ); 
			
			m_bg.addChild(m_scroll);	
			
			addChild(m_bg);
			
			btn_save.label = "保存";
			btn_save.x=20;
			btn_save.y= 50;
			btn_save.width=80;
			btn_save.height=40;		
			
			
			btn_del.label = "删除";
			btn_del.x= 110;
			btn_del.y= 50;
			btn_del.width=80;
			btn_del.height=40;		
			
			btn_new.label = "新建";
			btn_new.x= 200;
			btn_new.y= 50;
			btn_new.width=80;
			btn_new.height=40;		
			
			btn_menu.label = "菜单";
			btn_menu.x= 290;
			btn_menu.y= 50;
			btn_menu.width=80;
			btn_menu.height=40;		
			
			//btn_save.rotationX = 10;			
			btn_save.addEventListener(MouseEvent.CLICK, onbtn_save);
			btn_del.addEventListener(MouseEvent.CLICK, onbtn_delete);
			btn_new.addEventListener(MouseEvent.CLICK, onbtn_new);
			btn_menu.addEventListener(MouseEvent.CLICK, onbtn_menu);
			
			addChild(btn_save);
			addChild(btn_del);
			addChild(btn_new);
			addChild(btn_menu);
//			stage.scaleMode = StageScaleMode.NO_SCALE;
//			stage.align = StageAlign.TOP_LEFT;

			
		//	﻿stage.addEventListener(Event.RESIZE ,onOrientationChange);
			
			super();
		}
		
		public function onbtn_menu(e:Event):void {			
			var a:zaApp = this.parent as zaApp;
			a.openAddMenu(null);
		}
		
		public function onOrientationChange(e:Event):void 
		{

			stage.scaleMode=StageScaleMode.NO_SCALE;
			if ( stage.width > 100)
				m_title.text = "lands";
			else
				m_title.text = "portrait";
		} 
		
		public function readTXT():void {
		var file:File = File.applicationStorageDirectory.resolvePath("a.txt");		
		var aa:Array = File.userDirectory.getDirectoryListing();
		var stream:FileStream= new FileStream();
		stream.open(file, FileMode.READ);
		this.m_notes.text  = stream.readMultiByte(stream.bytesAvailable,"cn-gb");
		stream.close();		
		}
		
		public function handleSelect1(e:Event):void {
			var l:String;		
			var o:Record = m_catlist.selectedItem as Record;
			if (o !=null)
			{
				m_title.text = o.title;			
				m_updatetime.text= o.updatetime;		
				m_notes.text = o.notes;				
				//m_notes.htmlText = "<font color =\"#000000\" size=\"24\">"+o.notes+"</font>";
				m_scroll.update();
			}
		}
				
		public function onbtn_save(e:Event):void {
			
			var o:Record = m_catlist.selectedItem as Record;
			var n:int = m_catlist.selectedIndex;
			if (o != null)
			{							
				o.title = m_title.text;		
				m_updatetime.text = getDT(new Date());
				o.updatetime = m_updatetime.text;
				o.notes = m_notes.text;			
				m_sql.update(o);	
				m_catlogs = m_sql.findall("");			
				m_catlist.dataProvider = new DataProvider(m_catlogs) ;				
				m_catlist.scrollIndexVisible(n);
				m_catlist.invalidate();				
				m_catlist.selectedIndex = 0;
			}
		}
		
		public function onbtn_delete(e:Event):void {
			var o:Record = m_catlist.selectedItem as Record;
			var n:int = m_catlist.selectedIndex;
			if (o != null)
			{							
				o.title = m_title.text;
				o.updatetime = m_updatetime.text;
				o.notes = m_notes.text;			
				m_sql.del(o);	
				m_catlogs = m_sql.findall("");			
				m_catlist.dataProvider = new DataProvider(m_catlogs) ;				
				m_catlist.scrollIndexVisible(n);
				m_catlist.invalidate();
			}
			if (n>0)
				m_catlist.selectedIndex = n -1;
			else
				m_catlist.selectedIndex = 0;
		}
		
		public function onbtn_new(e:Event):void {
			var o:Record = m_catlist.selectedItem as Record;
				o = new Record();
				m_title.text = "";
				o.title = m_title.text;
				m_updatetime.text = getDT(new Date());
				o.updatetime = m_updatetime.text;
				m_notes.text = "";
				o.notes = m_notes.text;				
				m_sql.insert(o);
				m_catlogs = m_sql.findall("");			
				m_catlist.dataProvider = new DataProvider(m_catlogs) ;
				m_catlist.invalidate();	
				m_catlist.selectedIndex =0;
		}
		
		public function errorHandler(e:IOErrorEvent):void {
			msg.text = "无法获取天气信息数据!";
		}
		
		public function swap(event:MouseEvent):void {
			zaSafeNote(this.parent).change();			
		}
		
		private function getDT(d:Date):String
		{
			var date:Number = d.getUTCDate();
			var month:Number = d.getUTCMonth();
			var hours:Number = d.getUTCHours();
			var minutes:Number = d.getUTCMinutes();
			var seconds:Number = d.getUTCSeconds();
			var sb:String = new String();
			sb += d.getFullYear() + "/";
			if (month + 1 < 10)
			{
				sb += "0";
			}
			sb += month + 1 + "/";
			
			if (date < 10)
			{
				sb += "0";
			}
			sb += date + " ";
			
			if (hours < 10)
			{
				sb += "0";
			}
			sb += hours  + ":";
			
			if (minutes < 10)
			{
				sb += "0";
			}
			sb += minutes + ":";
			
			if (seconds < 10)
			{
				sb += "0";
			}
			sb += seconds;
			return sb;
		}
	}
}