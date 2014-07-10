package zaChineseIME
{
	import caurina.transitions.Tweener;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.ClipboardTransferMode;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.sampler.StackFrame;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.osmf.net.StreamingURLResource;
	
	import qnx.notificationManager.Indication;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.data.DataProvider;
	import qnx.ui.display.Image;
	import qnx.ui.listClasses.DropDown;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	import qnx.ui.listClasses.ScrollDirection;
	import qnx.ui.listClasses.ScrollPane;
	import qnx.ui.listClasses.TileList;
	import qnx.ui.text.Label;
	import qnx.ui.text.TextInput;
	
	import zaChineseIME.model.*;
	
//	[SWF(height="600", width="1024", 
//	frameRate="30", backgroundColor="#444444")]	
	
	public class zaMain extends Sprite
	{
		
		private var caption:Label = new Label();
		
		private var msg:TextField = new TextField();
		private var m_input:TextField = new TextField();
		private var m_username:TextField = new TextField();
		private var m_password:TextField = new TextField();
		private var m_updatetime:TextField = new TextField();	
		private var m_output:TextField = new TextField();
		
		private var m_lab_title:Label = new  Label();
		private var m_lab_username:Label = new  Label();
		private var m_lab_password:Label = new Label();		
		private var m_lab_updatime:Label = new Label();
		private var m_lab_notes:Label = new Label();
		
		private var m_lab_now:Label = new Label();
		
		
		private var m_scroll:ScrollPane = new ScrollPane();
		private var m_singlechar:TileList= new TileList();
		private var m_mutilchar:TileList= new TileList();
		private var m_list:List= new List();
		
		private var externalXML:XML;    
		private var loader:URLLoader;
		private var LabTF :TextFormat = new TextFormat();
		private var LabTFa :TextFormat = new TextFormat();
		
		private var m_bg :Sprite = new Sprite();
		private var btn_clear :zaLabelButton = new zaLabelButton();
		private var btn_copy :zaLabelButton = new zaLabelButton();
		private var btn_back :LabelButton = new LabelButton();
		private var btn_return :LabelButton = new LabelButton();
		private var btn_mode :LabelButton = new LabelButton();
		private var btn_lower :LabelButton = new LabelButton();
		private var btn_menu :LabelButton = new LabelButton();
		private var btn_save :LabelButton = new LabelButton();
		private var btn_export :LabelButton = new LabelButton();
		private var btn_import :LabelButton = new LabelButton();
		private var m_inputmethod:int = 0;
		private var m_lower:int = 0;
		
		private var m_mails:Array=[];	
		private var m_singarray:Array=[];
		private var m_mutilarray:Array=[];
		private var m_btns:Array=[];	
		private var m_modedd:DropDown = new DropDown();	
		
		private var m_bg2:Image = new Image();
		private var m_sql:RecordDAO = new RecordDAO();
		private var m_lastchar:String = "";
		private var o:Record;
		
		private static var m_snd_btn:Sound = new Sound(new URLRequest("zaChineseIME/res/btn121.mp3"));
		private static var m_snd_btn_clear:Sound = new Sound(new URLRequest("zaChineseIME/res/Laser.mp3"));
		private static var m_snd_btn_choose:Sound = new Sound(new URLRequest("zaChineseIME/res/clickclear.mp3"));
	
		private var m_pyinput:PinYinVector = new PinYinVector();
		
		private var Img_bg:Image = new Image();
		private var m_demo:Boolean = false;
		

		
		public function zaMain()
		{
			Img_bg.setImage("zaChineseIME/res/bg5.png");
			Img_bg.setPosition( 0, 0);
			addChild(Img_bg);
			init();
			
			var v:zaVersion = new zaVersion();
			v.m_stage = this;
			v.checkversion(v);
			super();
		}	
		
//		public function checkversion():void
//		{
//			var m_loader:URLLoader = new URLLoader();	
//			var a:URLRequest;
//			m_loader.load(new URLRequest("http://www.bbcubezone.com/version.php?appid=chineseime"));
//			m_loader.addEventListener(IOErrorEvent.IO_ERROR,on_load_error);
//			m_loader.addEventListener(Event.COMPLETE,on_load_compelete);					
//			// add 
//			
//			function on_load_error(event:Event):void
//			{
//				//get local reg;
//				var ret:int;
//				var v:String = m_sql.getver();
//				if ( m_version < v)
//				{
//					ret = m_sql.addver();
//					if ( ret < 10)
//						init();
//					else
//						addBtn();
//				}
//				else
//					init();
//			}
//			
//			function addBtn():void
//			{
//				m_lab_title.width = 1024;
//				var a:TextFormat = m_lab_title.format;
//				a.color = 0xFFFFFF00;
//				m_lab_title.format = a;		
//				m_lab_title.text = "当前版本："+m_version+",更新到新版本" + m_loader.data +"?";
//				m_lab_title.setPosition(360,200);
//				addChild(m_lab_title);
//				var btn_update :LabelButton = new LabelButton();
//				btn_update.addEventListener(MouseEvent.CLICK, onbtn_version);	
//				
//				btn_update.setPosition(440,300);
//				btn_update.label = "确定";
//				addChild(btn_update);		
//			}
//			
//			function on_load_compelete(event:Event):void
//			{
//				var s:String = m_loader.data;
//				m_sql.setver(s.replace(" ",""));
//				if (m_version < s.replace(" ",""))
//				{
//					addBtn();
//				}	
//				else
//				{
//					init();
//				}
//			}
//			
//			function onbtn_version(e:MouseEvent):void {
//				flash.net.navigateToURL(new URLRequest("appworld://content/44934"));
//			}
//		}
		
		public function init():void{

			m_sql.m_func_callback = this.Showmsg;
			//			m_singlechar.setPosition(800,10);
			//			m_singlechar.width = 200; 
			//			m_singlechar.height = 300; 
			//			m_singlechar.rowHeight = 30;
			//			m_singlechar.selectionMode = ListSelectionMode.SINGLE; 
			//			m_singlechar.allowDeselect = false; 
			//			m_singlechar.setSkin(zaCatlogCellrender);
			
			m_singlechar = new TileList();			
			m_singlechar.setPosition(0,280);
			m_singlechar.scrollDirection = ScrollDirection.HORIZONTAL;
			m_singlechar.rowHeight = 52;
			m_singlechar.width =1024;
			m_singlechar.height = 52;
			m_singlechar.selectionMode =ListSelectionMode.SINGLE;			
			m_singlechar.allowDeselect = false;
			m_singlechar.rowCount = 1;
			m_singlechar.columnCount = 2;
			m_singlechar.cellPadding = 5;
			m_singlechar.columnWidth = 55;				
			m_singlechar.setSkin(zaCatlogCellrender);
			
			//m_singarray = m_sql.findall(0,"");
			
			m_singlechar.dataProvider = new DataProvider(m_singarray) ;
			m_singlechar.addEventListener(MouseEvent.CLICK,handleSelect1);
			
			addChild(m_singlechar);
			
			m_mutilchar = new TileList();			
			m_mutilchar.setPosition(0,220);
			m_mutilchar.scrollDirection = ScrollDirection.HORIZONTAL;
			m_mutilchar.rowHeight = 52;
			m_mutilchar.width =1024;
			m_mutilchar.height = 52;
			m_mutilchar.selectionMode =ListSelectionMode.SINGLE;			
			m_mutilchar.allowDeselect = false;
			m_mutilchar.rowCount = 1;
			m_mutilchar.columnCount = 2;
			m_mutilchar.cellPadding = 5;
			m_mutilchar.columnWidth = 150;				
			m_mutilchar.setSkin(zaCatlogCellrender);
			m_mutilchar.dataProvider = new DataProvider([]) ;
			m_mutilchar.addEventListener(MouseEvent.CLICK,handleSelect2);
			
			addChild(m_mutilchar);
			
			LabTF.color = 0xEEEEEE;
			LabTF.size = 32;
			LabTF.bold = true;		
			
			caption.setPosition(20,10);
			caption.height = 60;
			caption.width = 600;
			caption.format = LabTF;
			caption.text ="中文输入外挂 Chinese IME";
			//	addChild(caption);
			
			LabTF.size = 20;
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
			tf.size= 40;
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
			//			m_bg.addChild(m_lab_notes);
			
			//			msg.defaultTextFormat = tf;	
			//			msg.format = LabTF;
			//			addChild(msg);			
			
			m_bg.graphics.beginFill(0x777777,0);			
			m_bg.graphics.lineStyle(0,0x666666,0);
			m_bg.graphics.drawRoundRect(0,0,1000,200,10,10);			
			m_bg.graphics.endFill();		
			
			m_bg.x = 10;
			m_bg.y = 10;
			m_bg.width = 1000;
			m_bg.height =210;
			
			tf.color = 0xFFAAAAFF;
			
			m_input.x = 10;
			m_input.y = 140;
			m_input.height = 55;
			m_input.width = 400;						
			m_input.borderColor = 0xFFAAAAFF;
			m_input.addEventListener(MouseEvent.CLICK,onbtn_input);
			m_input.alwaysShowSelection = true;
			m_input.defaultTextFormat = tf;
			m_bg.addChild(m_input);
			
			m_input.width = m_input.textWidth + 40;
			//			m_input.x = (1024 - m_input.width)/2 - 15;;
			
			tf.color = 0xFFFFFFFF;
			
			m_updatetime.x = 180;
			m_updatetime.y = 90;
			m_updatetime.height=20;
			m_updatetime.width = 300;
			m_updatetime.border = true;
			m_updatetime.borderColor = 0xFFAAAAFF;
			m_updatetime.alwaysShowSelection = true;
			m_updatetime.type = TextFieldType.INPUT;
			m_updatetime.defaultTextFormat = tf;
			//m_bg.addChild(m_updatetime);
			
			tf.size= 24;
			m_output.x=10;
			m_output.y=10;	
			
			m_output.height = 115;
			m_output.width = 650;	
			m_output.multiline=true;		
			m_output.alwaysShowSelection = true;
			m_output.type = TextFieldType.INPUT;
			//m_output.autoSize = "left";
			m_output.alwaysShowSelection = true;
			m_output.wordWrap = true;		
			m_output.defaultTextFormat = tf;
			
			m_scroll.x = 190;
			m_scroll.y = 6;
			m_scroll.height = 120;
			m_scroll.width = 660;				
			m_scroll.borderColor = 0xFFBBBBBB;	
			m_scroll.scrollDirection = ScrollDirection.VERTICAL;
			m_scroll.setScrollContent( m_output ); 
			
			m_bg.addChild(m_scroll);	
			
			if ( m_demo)
				m_output.text = "此版本为Chinese IME的演示版 . \n\n" +
					"完整版本 : http://appworld.blackberry.com/webstore/content/44934";
			
			m_scroll.scrollY  = 0;
			addChild(m_bg);
			
			var l_btn:zaLabelButton;			
			for (var i:int=0; i<50 ; i++)
			{
				l_btn = new zaLabelButton();	
				l_btn.mouseEnabled = true;
				
				l_btn.x = i* 100+15;
				l_btn.y = 350;
				//				if ( m_demo)
				//					if ((i >11) && (i<15)) 
				//						l_btn.enabled = false;
				addChild(l_btn);
				m_btns.push(l_btn);
			}
			
			
			
			btn_clear.setstyle(null, "清除");
			btn_clear.x=890;
			btn_clear.y=10;	
			
			btn_back.label = "Delete";
			btn_back.x= 890;
			btn_back.y= 85;
			btn_back.width=100;
			btn_back.height=40;		
			
			btn_copy.setstyle(null,"复制");
			btn_copy.x= 890;
			btn_copy.y= 80;	
			
			btn_mode.label = "拼音简体";
			btn_mode.x= 30;
			btn_mode.y= 25;
			btn_mode.width=100;
			btn_mode.height=40;	
			
			var dda:Array = [];
			dda.push({label:"0拼音简体"});
			dda.push({label:"1倉頡繁体"});
			dda.push({label:"2English"});
			//	dda.push({label:"3Russian"});
			//	dda.push({label:"4Korean"});
			dda.push({label:"5拼音繁体"});			
			
			m_inputmethod = 0;
			
			m_modedd.dataProvider = new DataProvider(dda);
			m_modedd.addEventListener(Event.SELECT,onDDselect);
			m_modedd.x = 20;
			m_modedd.y = 25;
			m_modedd.width = 170;
			
			
			btn_menu.label = "Menu";
			btn_menu.x= 20;
			btn_menu.y= 85;
			btn_menu.width=80;
			btn_menu.height=40;	
			
			btn_lower.label = "UPPER";
			btn_lower.x= 110;
			btn_lower.y= 85;
			btn_lower.width=80;
			btn_lower.height=40;	
			
			btn_save.label = "Save";
			btn_save.x= 30;
			btn_save.y= 145;
			btn_save.width=100;			
			btn_save.height=40;	
			btn_save.visible = false;
			
			btn_export.label = "Export";
			btn_export.x= 210;
			btn_export.y= 145;
			btn_export.width=100;			
			btn_export.height=40;	
			btn_export.visible = false;
			
			btn_import.label = "Import";
			btn_import.x= 745;
			btn_import.y= 145;
			btn_import.width=100;			
			btn_import.height=40;	
			btn_import.visible = false;
			
			//btn_clear.rotationX = 10;		
			btn_copy.addEventListener(MouseEvent.MOUSE_DOWN, onbtn_copy);
			btn_copy.addEventListener(MouseEvent.MOUSE_UP, onbtn_copy);
			
			btn_clear.addEventListener(MouseEvent.MOUSE_UP, onbtn_clear);	
			btn_clear.addEventListener(MouseEvent.MOUSE_DOWN, onbtn_clear);	
			
			btn_back.addEventListener(MouseEvent.CLICK, onbtn_back);
			btn_mode.addEventListener(MouseEvent.CLICK, onbtn_mode);
			btn_lower.addEventListener(MouseEvent.CLICK, onbtn_lower);
			btn_menu.addEventListener(MouseEvent.CLICK, onbtn_menu);
			btn_save.addEventListener(MouseEvent.CLICK, onbtn_save);
			btn_export.addEventListener(MouseEvent.CLICK, onbtn_export);
			btn_import.addEventListener(MouseEvent.CLICK, onbtn_import);
			
			
			addChild(btn_clear);			
			//addChild(btn_back);	
			//addChild(btn_mode);
			addChild(btn_lower);	
			addChild(btn_menu);
			addChild(btn_save);
			addChild(btn_export);
			addChild(btn_import);	
			addChild(m_modedd);
			addChild(btn_copy);
			
			tf.color = 0xFFFFAA;
			m_lab_now.format = tf;
			m_lab_now.height = 40;
			addChild(m_lab_now);
			
			changinputmode(m_inputmethod,m_lower);
		}
		
		public function initdb():void {
			this.m_sql.findall(0,0,"a");
		}	
		
		public function querylengend(a:String):void {
			
			m_singarray = null;
			m_mutilarray = m_sql.findlengend(m_inputmethod,a);
			if (m_singarray == null)
			{				
				m_singlechar.visible = false;
				m_mutilchar.rowCount =2;
				m_mutilchar.height = 110;
			}	
			else
			{
				m_singlechar.visible = true;				
				m_mutilchar.rowCount =1;
				m_mutilchar.height = 52;
			}
			
			if (m_mutilarray == null)
			{
				m_mutilchar.visible = false;
				m_singlechar.y = 220;
				m_singlechar.rowCount =2;
				m_singlechar.height = 110;
			}	
			else
			{
				m_mutilchar.visible = true;				
				m_singlechar.y = 280				
				m_singlechar.rowCount =1;
				m_singlechar.height = 52;
			}
			
			m_mutilchar.dataProvider = new DataProvider(m_mutilarray);
			m_singlechar.dataProvider = new DataProvider(m_singarray);
			
			m_singlechar.selectedIndex = -1;		
			m_mutilchar.selectedIndex = -1;
		}
		
		public function query(e:Event):void {
			//m_singarray= m_sql.findall(m_inputmethod,m_input.text);
			
			if (m_input.length == 0 )
			{
				m_singlechar.dataProvider = new DataProvider([]);	
				m_mutilchar.dataProvider = new DataProvider([]);
				return;
			}
				
			if (this.m_pyinput.basehasit(m_pyinput.querysinglechar().toLocaleLowerCase())== true)
				m_singarray= m_sql.findall(0,m_inputmethod,m_pyinput.querysinglechar());
			else
				m_singarray= m_sql.findall(1,m_inputmethod,m_pyinput.querysinglechar());
			
			if (m_input.length > 1 )
				m_mutilarray = m_sql.findcizu(m_inputmethod,this.m_pyinput);
			else
				m_mutilarray = null;
			
			
			if (m_singarray == null)
			{				
				m_singlechar.visible = false;
				m_mutilchar.rowCount =2;
				m_mutilchar.height = 110;
			}	
			else
			{
				m_singlechar.visible = true;	
				//sortsingle();
				m_mutilchar.rowCount =1;
				m_mutilchar.height = 52;
			}
		
			if (m_mutilarray == null)
			{
				m_mutilchar.visible = false;
				m_singlechar.y = 220;
				m_singlechar.rowCount =2;
				m_singlechar.height = 110;
			}	
			else
			{
				m_mutilchar.visible = true;	
				sortmutil();			
				m_singlechar.y = 280				
				m_singlechar.rowCount =1;
				m_singlechar.height = 52;
			}
			
			m_mutilchar.dataProvider = new DataProvider(m_mutilarray);
			m_singlechar.dataProvider = new DataProvider(m_singarray);
			
			m_singlechar.selectedIndex = -1;		
			m_mutilchar.selectedIndex = -1;
		}
	
		public function sortsingle():void
		{
			for (var i:int =0; i < m_singarray.length ;i ++)
			{
				var r:Record = m_singarray[i];
				var s:String = r.pinyin_full;
				var pri:int = 0;
				var pri_step:int = 100;
				var w:int = 0;
				var cc:int = 0;
				var py_str:String;	
				var pc:pychar;
				var l_mis:Boolean=false;
				py_str = m_pyinput.querysinglechar().toLocaleLowerCase();				
				pri = r.priority;
				var n:int;
				for ( n= 0; n < s.length ; n++)
				{					
					var l_c:String = s.charAt(n);
					if (n < py_str.length)
					{	
						if (l_c!=py_str.charAt(n))
						{
						   		l_mis = true;
						  		 break;
						}
					}
					pri_step -= 0;								
				}
				if (n == s.length)
					pri += 1000;
				
				if (l_mis)
					r.priority = -10000;
				else					
					r.priority = pri;
				l_mis = false;
			}			

			m_singarray.sortOn("priority",Array.DESCENDING);
		}
		
		public function sortmutil():void
		{
			for (var i:int =0; i < m_mutilarray.length ;i ++)
			{
				var r:Record = m_mutilarray[i];
				var s:String = r.pinyin_full;
				var pri:int = 0;
				var pri_step:int = 100;
				var w:int = 0;
				var cc:int = 0;
				var py_str:String;	
				var pc:pychar;
				var l_mis:Boolean=false;
				pc =  m_pyinput.m_py_decode_list[w];
				py_str = pc.py.toLocaleLowerCase();
				pri = r.priority;
				var n:int;
				for ( n= 0; n < s.length ; n++)
				{					
					var l_c:String = s.charAt(n);
					if (l_c==' ') 
					{						
						if (n != 0 && cc < py_str.length)
						{
							l_mis = true;
							break;
						}							
						cc=0;
						w++;	
						if (w <m_pyinput.m_py_decode_list.length)
							py_str = m_pyinput.m_py_decode_list[w].py.toLocaleLowerCase();
						else
							break;
					}
					else
					{
						if (cc < py_str.length)
						{	
							if (l_c!=py_str.charAt(cc))
							{
								l_mis = true;
								break;
							}
						}
						if (cc == py_str.length -1)
						{
							if (n < s.length -1)
							if (s.charAt(n+1) =="")
								pri += 1000;
							if (n == s.length -1)
								pri += 1000;
						}

					//	pri += 50;
						cc++;
					}					
				}
				if (n == s.length)
					pri += 1000;
				
				if (l_mis)
					r.priority = -10000;
				else					
					r.priority = pri;
				l_mis = false;
				var a:String = r.priority.toString();
				for (n =0 ; n <= 6-a.length; n ++)
					a = "0"+a;
				r.priorityS = a;
			}			
			m_mutilarray.sortOn("priorityS",Array.DESCENDING);
		}
				
		public function onDDselect(e:Event):void {
			if (this.m_modedd.selectedIndex < 0) return;
			var language:String = m_modedd.selectedItem.label;
			m_inputmethod = Number(language.substr(0,1));
			changinputmode(m_inputmethod,m_lower);
			m_pyinput.reset(m_inputmethod);
			m_input.text =m_pyinput.getdecode();
		}
		
		public function handleSelect1(e:MouseEvent):void {
			playchoose();
			o = m_singlechar.selectedItem as Record;
			m_lab_now.text = o.priority.toString();
			m_lab_now.text = "";
			m_lab_now.alpha = 1;
			m_lab_now.x = e.stageX ;
			m_lab_now.y = e.stageY ;			
			
			var p:Point = getCaretLocation(m_output);
			var ic:int = m_output.caretIndex;
			
//			Tweener.addTween(m_lab_now,
//				{x:p.x+ m_scroll.x ,y:p.y+67-45 ,
//				{x:this.m_input.x+30 ,y:m_input.y ,					
//					transition:"easeInSine", alpha:1, delay:0,time:0.3});	
			Tweener.addTween(m_lab_now,
				{x:p.x+ 1500 ,y:p.y+1500,
					transition:"easeInSine", alpha:1, delay:0.3,time:0});	
			
			var ts:String = m_output.text.substr(0,m_output.caretIndex);
			var ts2:String = m_output.text.substr(m_output.caretIndex);
			var adds:String = "";
		
			adds = o.cn.substr(0,1);
			//m_output.text = ts + adds + ts2 ;
			
			m_pyinput.match( adds,o.pinyin_full);
			if (m_pyinput.matchover())
			{
				adds = m_pyinput.getdecode();
				m_output.text = ts + adds + ts2 ;
				m_output.setSelection(ic+adds.length,ic+adds.length);
				
				
				//			m_output.appendText(m_lab_now.text);
				//			m_output.setSelection(m_output.text.length,m_output.text.length);
				
				m_scroll.scrollY = m_output.height;
				m_scroll.update();	
				if (m_pyinput.newword())
				{
					var l_rec:Record = new Record();
					l_rec.cn = m_pyinput.getdecode();
					l_rec.pinyin = m_pyinput.getmutilchar();
					l_rec.pinyin_full = m_pyinput.getmutilchar_full();
					m_sql.save(m_inputmethod,l_rec);
				}				
				m_pyinput.reset(this.m_inputmethod);
				m_input.text = m_pyinput.getdecode();
				
				m_input.width = m_input.textWidth + 40;
//*				m_input.x = (1024 - m_input.width)/2 -15;			
				
				m_sql.update1(m_inputmethod,o);
				querylengend(o.cn);	
			}
			else
			{
				m_input.text = m_pyinput.getdecode();
				
				m_input.width = m_input.textWidth + 40;
//*				m_input.x = (1024 - m_input.width)/2 -15;			
				
				l_rec = new Record();
				l_rec.cn = o.cn;
				l_rec.cn = m_lastchar + l_rec.cn;
				m_sql.update2(m_inputmethod,l_rec);
				m_lastchar = o.cn;
				
				query(null);
			}
		}		
		
		public function handleSelect2(e:MouseEvent):void {
			playchoose();						
			o = m_mutilchar.selectedItem as Record;
			m_lab_now.text = o.cn;
			m_lab_now.alpha = 1;
			m_lab_now.x = e.stageX ;
			m_lab_now.y = e.stageY ;
			var ic:int = m_output.caretIndex;
			var p:Point = getCaretLocation(m_output);
			Tweener.addTween(m_lab_now,
				{x:p.x+ m_scroll.x ,y:p.y+67-45,
					transition:"easeInSine", alpha:1, delay:0,time:0.3});	
			Tweener.addTween(m_lab_now,
				{x:p.x+ 1500 ,y:p.y+1500,
					transition:"easeInSine", alpha:1, delay:0.3,time:0});	
			var ts:String = m_output.text.substr(0,ic);
			var ts2:String = m_output.text.substr(ic);
			var adds:String = "";
			if (this.m_inputmethod ==2 && m_output.text.length >0)
				adds = " " + m_lab_now.text;
			else
			{
				adds = m_lab_now.text;
			}	
						
			m_scroll.scrollY = m_output.height;
			m_scroll.update();	
			
			m_pyinput.match(m_lab_now.text,o.pinyin_full);
			if (m_pyinput.matchover())
			{				
				adds = m_pyinput.getdecode();
				if (m_inputmethod >0 && m_inputmethod <5)
					adds = " "+adds;
				m_output.text = ts + adds + ts2 ;				
				m_output.setSelection(ic+adds.length,ic+adds.length);
				
				m_pyinput.reset(this.m_inputmethod);
			}
			m_input.text = m_pyinput.getdecode();
			m_input.width = m_input.textWidth + 40;
//*			m_input.x = (1024 - m_input.width)/2 -15;			
			
			m_sql.update2(m_inputmethod,o);					
			
			query(null);
		}		
		
		public function onbtn_input(e:Event):void {
			playchoose();
			var ic:int = m_output.caretIndex;
			var ts:String = m_output.text.substr(0,ic);
			var ts2:String = m_output.text.substr(ic);
			m_output.text = ts + m_input.text +  ts2;
			m_output.setSelection(ic+m_input.length,ic+m_input.length);
			m_pyinput.reset(this.m_inputmethod);
			m_input.text= m_pyinput.getdecode();
		}
		
		public function onbtn_copy(e:Event):void {
			var o:zaLabelButton = e.currentTarget as zaLabelButton;
			if (e.type == MouseEvent.MOUSE_DOWN)
			{
				o.showdown();
				playbtnclear();
				return;
			}
			o.showup();

			
			Tweener.addTween(m_output,
				{transition:"easeInSine",x:btn_copy.x, y:btn_copy.y,					
					delay:0,time:0.3});
			
			Tweener.addTween(m_output,
				{transition:"easeInSine",x:0, y:0,					
					delay:0.3,time:0.3});
			
			Clipboard.generalClipboard.clear();
			if (m_output.selectedText.length > 0)
				Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,this.m_output.selectedText);
			else
				Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,this.m_output.text);			
		}
		
		public function Showmsg():void
		{
			this.m_input.text = m_sql.m_msg;
			m_input.width = m_input.textWidth + 40;
//*			m_input.x = (1024 - m_input.width)/2 - 15;;
		}
			
		public function onbtn_export(e:Event):void {
			this.m_sql.export(m_inputmethod);
		}
		
		public function onbtn_import(e:Event):void {
			this.m_sql.importIn(m_inputmethod);
		}
		
		public function onbtn_save(e:Event):void {
		
			o = new Record();
			if (m_output.text.length > 0)
			{
				if (m_output.selectedText.length > 0)
					o.cn = m_output.selectedText;
				else
					o.cn = m_output.text.substr( m_output.caretIndex - m_input.text.length,m_input.text.length);
			}
			else 
				return;
			 
			if (m_input.text.length > 0)
				o.pinyin = m_input.text.toLocaleLowerCase();
			else 
				return;
			
			playbtnclear();
			
			m_lab_now.text = o.cn;
			m_lab_now.alpha = 1;
	
			var ic:int = m_output.caretIndex;
			var p:Point = getCaretLocation(m_output,o.cn.length);
			m_lab_now.x = p.x + m_scroll.x;
			m_lab_now.y = p.y + 67-45;
		
			Tweener.addTween(m_lab_now,
				{y:p.y+m_scroll.y+67-45+40,
					transition:"easeInSine", alpha:1, delay:0,time:0.4});	
			Tweener.addTween(m_lab_now,
				{y:p.y+m_scroll.y+1000,
					transition:"easeInSine", alpha:1, delay:0.4,time:0});	
			
			
//			Tweener.addTween(m_output,
//				{transition:"easeInSine", y:200,					
//					delay:0,time:0.3});
//			
//			Tweener.addTween(m_output,
//				{transition:"easeInSine",y:0,					
//					delay:0.3,time:0.3});			
			
			m_sql.save(m_inputmethod,o);	
			//m_output.setSelection(m_output.text.length-1,m_output.text.length-1);
			m_input.text = "";
		}
		
		public function onbtn_backspace(e:Event):void {
			var o:zaLabelButton = e.currentTarget as zaLabelButton;
			if (e.type == MouseEvent.MOUSE_DOWN)
			{
				o.showdown();
				playbtnpress();
				return;
			}
			o.showup();
			
			if (m_input.text.length ==0)
			{
				onbtn_back(null);				
				return;
			}
			m_pyinput.undo();
			m_input.text = m_input.text.substr(0,m_input.text.length -1);
			m_input.text = m_pyinput.getdecode();
			m_input.width = m_input.textWidth + 40;
//*			m_input.x = (1024 - m_input.width)/2 - 15;
			
			query(null);
		}
		
		public function onbtn_mode(e:Event):void {
			playbtnpress();
			m_inputmethod ++ ;
			if (m_inputmethod == 6 ) 
				 m_inputmethod = 0;			
			changinputmode(m_inputmethod,m_lower);
		}
		
		public function onbtn_lower(e:Event):void {
			playbtnpress();
			m_lower ++;
			if (m_lower == 2 ) m_lower = 0; 
			if (m_lower == 1) 
				btn_lower.label = "lower";
			else
				btn_lower.label = "UPPER";			
			changinputmode(m_inputmethod,m_lower);
		}	
		
		public function onbtn_menu(e:Event):void {
			playbtnpress();
			var a:zaApp = this.parent as zaApp;
			a.openAddMenu(null);
		}
		
		public function changinputmode(inputmode:int,big:int):void
		{
			var r_c:String;
			var i:int ;
			var l_btn:zaLabelButton;
			var x:int;
			var y:int;
			if (inputmode == 0)
			{
				btn_copy.setstyle(null,"复制");
				btn_clear.setstyle(null,"清除");
				this.btn_save.label = "保存";				
			}
			else
			{
				btn_copy.setstyle(null,"copy");
				btn_clear.setstyle(null,"Clear");
				this.btn_save.label = "Save";
			}
			
			if (inputmode == 3)
			{
				btn_mode.label = "Russian";
				r_c = "Аа Бб Вв Гг Дд Ее Ёё Жж Зз Ии Йй Кк " +
					"Лл Мм Нн Оо Пп Рр Сс Тт Уу Фф Хх !! " +
					"Цц Чч Шш Щщ Ъъ Ыы Ьь Ээ Юю Яя ";
				
				r_c = "Йй Чч Уу Кк Ее Нн Гг Шш Щщ Ээ Хх Ъъ "; 
				r_c += "Фф Ыы Вв Аа Пп Рр Оо Лл Дд Жж Зз !! ";
				r_c += ".. Яя Цц Сс Мм Ии Тт Ьь Бб Юю Ёё ,, "; 
				
				x = 15;   //90*70
				y = 350;
				
				for (i = 0 ; i< m_btns.length ; i++)
				{
					l_btn = m_btns[i];
					l_btn.removeEventListener(MouseEvent.MOUSE_DOWN,onbtn_new);
					l_btn.removeEventListener(MouseEvent.MOUSE_UP,onbtn_new);
					l_btn.m_lable.text = r_c.substr(i*3+big,1);
					
					if ( x + 82 > 1024)
					{
						y += 85 - 21;
						x = 15;
					}	
					
					l_btn.x = x;
					l_btn.y = y;
			//		l_btn.width = 82;
					//l_btn.height = 70;
					x += 83;
					
					if (l_btn.m_lable.text == "^")
					{
						l_btn.m_lable.text = "BkSpace";
						l_btn.addEventListener(MouseEvent.MOUSE_DOWN,this.onbtn_backspace);
						l_btn.addEventListener(MouseEvent.MOUSE_UP,this.onbtn_backspace);
					}
					else
					{			
						l_btn.addEventListener(MouseEvent.MOUSE_DOWN,onbtn_new);
						l_btn.addEventListener(MouseEvent.MOUSE_UP,onbtn_new);
					}
				}				
			}
			else 
			{
				r_c =  "Qq Ww Ee Rr Tt Yy Uu Ii Oo Pp "; 
				r_c += "Aa Ss Dd Ff Gg Hh Jj Kk Ll ^^ ";
				r_c += "。. Zz Xx Cc Vv Bb Nn Mm ，,    ";
				r_c += "?? !! \"\" \\\\ @@ %% && ** (( )) ";
				r_c += "11 22 33 44 55 66 77 88 99 00 ";
				
				x = 15;   //90*70
				y = 350;
				
				for (i = 0 ; i< m_btns.length ; i++)
				{
					l_btn = m_btns[i];
					l_btn.removeEventListener(MouseEvent.MOUSE_DOWN,onbtn_new);
					l_btn.removeEventListener(MouseEvent.MOUSE_UP,onbtn_new);
					l_btn.m_lable.text = r_c.substr(i*3+big,1);
					
					
					if ( x +100 > 1024)
					{
						y += 85 - 21;
						x = 15;
					}	
					l_btn.x = x;
					l_btn.y = y;
			//		l_btn.width = 90;
					//l_btn.height = 70;
					
					x += 98;
					if (x%5 ==0)
						x += 20;
					
					if (l_btn.m_lable.text == "^")
					{
						l_btn.m_lable.text = "BkSpace";
						l_btn.setstyle("","BkSpace");
						l_btn.addEventListener(MouseEvent.MOUSE_DOWN,onbtn_backspace);
						l_btn.addEventListener(MouseEvent.MOUSE_UP,onbtn_backspace);
					}
					else
					{	
						l_btn.addEventListener(MouseEvent.MOUSE_DOWN,onbtn_new);
						l_btn.addEventListener(MouseEvent.MOUSE_UP,onbtn_new);
					}
				}
			}
			m_mutilchar.dataProvider = new DataProvider([]);
			m_singlechar.dataProvider = new DataProvider([]);
		}
				
		public function onbtn_back(e:Event):void {
			
			var ic: int = m_output.caretIndex;
			if (ic > 0)
			{
				if ( ic < m_output.length)
				{
					m_output.text = m_output.text.substr(0,ic-1)+m_output.text.substr(ic);
					m_output.setSelection(ic-2,ic-1);
				}
				else
				{
					
					m_output.text = m_output.text.substr(0,ic-1);
					m_output.setSelection(ic-2,ic-1);
				}
				
			}
			else if ( m_output.text.length > 0)
			{
					m_output.text = m_output.text.substr(1);	
					m_output.setSelection(0,0);
			}			
		}		
		
		public function onbtn_new(e:Event):void {			
			var o:zaLabelButton = e.currentTarget as zaLabelButton;
			if (e.type == MouseEvent.MOUSE_DOWN)
			{
				o.showdown();
				playbtnpress();
				return;
			}
			o.showup();
			
			
			var ltxt:String = o.m_lable.text;
			if (ltxt == " ")
			{
				
			}
			else if (  !((ltxt >= "a" && ltxt <= "z") ||
				(ltxt >= "A" && ltxt <= "Z"))
			)				
			{
				var ic:int = m_output.caretIndex;
				var ts:String = m_output.text.substr(0,ic);
				var ts2:String = m_output.text.substr(ic);
				
				m_output.text = ts + ltxt + ts2;
				m_output.setSelection(ic+1,ic+1);
			}
			else
			{
				m_pyinput.addchar(ltxt);
				m_input.text = m_pyinput.getdecode();	
				m_input.width = m_input.textWidth + 40;
//*				m_input.x = (1024 - m_input.width)/2 - 15;			
				query(null);
			}
		}
		
		public function onbtn_clear(e:Event):void {
			var o:zaLabelButton = e.currentTarget as zaLabelButton;
			if (e.type == MouseEvent.MOUSE_DOWN)
			{
				o.showdown();
				playbtnclear();
				return;
			}
			o.showup();
			m_output.text = "";			
		}		
		
		public function errorHandler(e:IOErrorEvent):void {
			msg.text = "!";
		}		
		
		private function getDT(d:Date):String
		{
			var date:Number = d.getDate();
			var month:Number = d.getMonth();
			var hours:Number = d.getHours();
			var minutes:Number = d.getMinutes();
			var seconds:Number = d.getSeconds();
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
		
		public function playbtnpress():void
		{
//			var _soundObj:Sound = new Sound(); 					
//			_soundObj.load(new URLRequest("res/btn121.mp3"));  
			m_snd_btn.play(); 
		//	_soundObj.addEventListener(IOErrorEvent.IO_ERROR,onError);
		}
		
		public function playbtnclear():void
		{
			m_snd_btn_clear.play(); 
//			var _soundObj:Sound = new Sound(); 		
//			_soundObj.load(new URLRequest("res/clickclear.mp3"));  
//			_soundObj.play(); 
//			//	_soundObj.addEventListener(IOErrorEvent.IO_ERROR,onError);
		}
		
		public function playchoose():void
		{
			m_snd_btn_choose.play();
//			var _soundObj:Sound = new Sound(); 					
//			_soundObj.load(new URLRequest("res/Laser.mp3"));  
//			_soundObj.play(); 
			//	_soundObj.addEventListener(IOErrorEvent.IO_ERROR,onError);
		}
		
	
		public function getCaretLocation(tf : TextField ,a:int=0):Point {   
	
			var index : Number = tf.caretIndex;   
			var x : Number, y : Number;   
			var rect :Rectangle;   
			index -= a;
			if ('' == tf.text.charAt(index)) {   
				if (0 == index) {   
					// the TextArea is empty   
					x = 2;   
					y = 2;   
				} else if ('\n' == tf.text.charAt(index - 1) || '\r' == tf.text.charAt(index - 1)) {   
					// at the start of a new line, and also at the end of a the line   
					// use lineHeight * lineIndex + yPadding as y   
					x = 2;   
					y = tf.getLineMetrics(0).height * (tf.getLineIndexOfChar(index - 1) + 1) + 2;   
				} else {   
					// at the end of a line   
					// use the bounds of the charater to the left of caret, and add the width of it to x   
					rect = tf.getCharBoundaries(index - 1);   
					x = rect.x + rect.width;   
					y = rect.y;   
				}   
			} else {   
				if ('\n' == tf.text.charAt(index) || '\r' == tf.text.charAt(index)) {   
					// at the start of a line, but not at the end of the line   
					x = 2;   
					y = tf.getLineMetrics(0).height * tf.getLineIndexOfChar(index) + 2;   
				} else {   
					// in middle of a line   
					rect = tf.getCharBoundaries(index);   
					x = rect.x;   
					y = rect.y;   
				}   
			}   
			return new Point(x, y);   
		}  
	}
}