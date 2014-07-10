package{
	import avmplus.FLASH10_FLAGS;
	
	import caurina.transitions.Tweener;
	
	import flash.desktop.Icon;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.errors.IOError;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.StageWebView;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	import flash.utils.flash_proxy;
	
	import model.*;
	
	import org.osmf.elements.F4MElement;
	import org.osmf.events.TimeEvent;
	
	import qnx.media.QNXStageWebView;
	import qnx.ui.buttons.IconButton;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.data.DataProvider;
	import qnx.ui.display.Image;
	import qnx.ui.events.SliderEvent;
	import qnx.ui.listClasses.DropDown;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	import qnx.ui.listClasses.ScrollDirection;
	import qnx.ui.listClasses.ScrollPane;
	import qnx.ui.slider.Slider;
	import qnx.ui.text.Label;
	import qnx.ui.text.TextInput;
	
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
		
		private var m_lab_pages:Label = new Label();
		private var m_timerarm:Timer ;
		
		private var m_scroll:ScrollPane = new ScrollPane();
		private var m_dirlist:List= new List();
		private var m_readhislist:List= new List();
		private var m_DropDown:DropDown = new DropDown();
		private var m_im_pre :Image = new Image();
		private var m_im_nxt :Image = new Image();
		private var m_im_mu :Image = new Image();
		
		private var externalXML:XML;    
		private var loader:URLLoader;
		private var LabTF :TextFormat = new TextFormat();
		private var LabTFa :TextFormat = new TextFormat();
		
		private var m_bg :Sprite = new Sprite();
		private var btn_next :LabelButton = new LabelButton();
		private var btn_increaseFont :LabelButton = new LabelButton();
		private var btn_decreaseFont :LabelButton = new LabelButton();
		private var btn_pre :LabelButton = new LabelButton();
		private var btn_bg :LabelButton = new LabelButton();
		
		private var btn_close :LabelButton = new LabelButton();
		private var btn_back :IconButton = new IconButton();
		private var btn_bookmark :IconButton = new IconButton();
		private var btn_nav :IconButton = new IconButton();
		private var btn_bookmarknew :IconButton = new IconButton();
		private var btn_dir :IconButton = new IconButton();
		private var btn_bookmarkdel :IconButton = new IconButton();
		private var btn_menu :IconButton = new IconButton();
		private var m_TA_page:TextField = new TextField();
		private var m_slide:Slider = new Slider();
		private var m_readhisarr:Array=[];
		private var m_files:Array=[];
		private var m_dirs:Array=[];
		private var m_bg2:Image = new Image();
		private var m_sql:RecordDAO = new RecordDAO();
		
		private var m_f:zaFile = new zaFile();
		private var mysql:RecordDAO = new RecordDAO();
		private var m_hisscreen:Sprite = new Sprite();
		private var m_config:Sprite = new Sprite();
		private var m_hisscreenv:Boolean = true;
		public var m_layout:int = 4;
		public var m_curscreen:Sprite;
		
		
		public var m_oldcontrol:Boolean;		
		public var m_epubfile:zaePubFile = null;
///		public var m_webview:QNXStageWebView;		
		
		
		public var m_curfile:String ="";
		
		public function zaMain()
		{

//			m_bg2.x = 0;
//			m_bg2.y = 00;
//			m_bg2.setImage("res/bg2.jpg");
//			addChild(m_bg2);			
			
///			m_webview =  new QNXStageWebView();
			LabTF.color = 0xFFFFFF;
			LabTF.size = 32;
			LabTF.bold = true;
			caption.setPosition(30,5);
			caption.height = 60;
			caption.width = 1000;
			caption.format = LabTF;
			caption.text ="Text Reader";
	//		addChild(caption);
			
			
			m_dirlist.setPosition(10,70);
			m_dirlist.width = 560; 
			m_dirlist.height = 350; 
			m_dirlist.rowHeight = 70;
			m_dirlist.selectionMode = ListSelectionMode.SINGLE; 
			m_dirlist.allowDeselect = false; 
			m_dirlist.setSkin(zaCatlogCellrender);			
			
			m_dirlist.addEventListener(MouseEvent.CLICK,handleSelectDirFile);
			
			//addChild(m_dirlist);
			m_config.x = 222;
			m_config.y = 50;			
			m_config.graphics.beginFill(0x00004084,0.9);
			m_config.graphics.drawRoundRect(0,0,580,140,40,40);
			m_config.graphics.endFill();
			m_config.graphics.lineStyle(4,0xBBBBBB);
			m_config.graphics.drawRoundRect(0,0,580,140,40,40);		
			m_config.graphics.endFill();
				
			addChild(m_config);
			
			m_hisscreen.x = 222;
			m_hisscreen.y = 50;			
			m_hisscreen.graphics.beginFill(0x00004084,0.9);
			m_hisscreen.graphics.drawRoundRect(0,0,580,440,40,40);
			m_hisscreen.graphics.endFill();
			m_hisscreen.graphics.lineStyle(4,0xBBBBBB);
			m_hisscreen.graphics.drawRoundRect(0,0,580,440,40,40);
			m_hisscreen.graphics.endFill();
			
			m_curscreen = m_hisscreen;
				
			m_readhislist.setPosition(10,70);
			m_readhislist.width = 560; 
			m_readhislist.height = 350; 
			m_readhislist.rowHeight = 70;
			m_readhislist.selectionMode = ListSelectionMode.SINGLE; 
			m_readhislist.allowDeselect = false; 
			m_readhislist.setSkin(zaReadHisCellRender);			
			m_readhisarr = m_sql.findall("");
			m_dirlist.visible = false;
			if (m_readhisarr== null)
			{
				this.onbtn_dir(null);
				m_readhisarr=[];
			}	
			else
				this.onbtn_bookmark(null);
			
			m_readhislist.dataProvider = new DataProvider(m_readhisarr) ;
			m_readhislist.addEventListener(MouseEvent.CLICK,handleReadHis);
			
			m_hisscreen.addChild(m_dirlist);
			
			m_hisscreen.addChild(m_readhislist);
			
			addChild(m_hisscreen);
		
			var a :Array=[];

			m_slide.minimum = 1;
			m_slide.maximum = 40;
			m_slide.width = 500;
			
			m_slide.addEventListener( SliderEvent.MOVE, onslider_change );   
			m_slide.addEventListener( SliderEvent.END, this.onslider_gotpage );
					
			a.push({label:"auto"});
			a.push({label:"utf-8"});
			a.push({label:"unicode"});
			a.push({label:"cn-gb"});
			a.push({label:"UTF-16BE"});
			a.push({label:"UTF-16LE"});
			a.push({label:"US-ASCII"});
			a.push({label:"GB2312"});
			a.push({label:"Big5"});
			a.push({label:"Big5-HKSCS"});
			a.push({label:"windows-1250"});
			a.push({label:"windows-1252"});
			a.push({label:"shift-jis"});
			a.push({label:"ISO-8859-1"});
			
			m_DropDown.dataProvider = new DataProvider(a);
			m_DropDown.addEventListener(Event.SELECT,onDropDown);
		
			
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

			LabTFa.color = 0xFFFFCC;
			LabTFa.size = 20;
			LabTFa.bold = false;	
			

		
			m_notes.x=0;
			m_notes.y=0;	
			m_notes.height = 440;
			m_notes.width = 650;	
			m_notes.multiline=true;					
			m_notes.defaultTextFormat= LabTFa;
			m_notes.autoSize = TextFieldAutoSize.LEFT;
			//m_notes.type = TextFieldType.INPUT;
			m_notes.selectable = false;
			m_notes.wordWrap = true;
			m_notes.doubleClickEnabled = true;			
				//tf.underline = true;
			//tf.letterSpacing=10;
			var ff:Array = flash.text.Font.enumerateFonts(true);
			var fnt:Font = ff[31];
			m_notes.addEventListener(MouseEvent.CLICK, onbtn_notes);
			tf.size = 24;	
			tf.leading = 5;
			tf.indent =40;
			//tf.bold = true;
			tf.font = "微软雅黑";
			m_notes.defaultTextFormat = tf;
			
			m_notes.background = false;
			m_notes.backgroundColor = 0x33CC33;
			
			m_scroll.x = 363;
			m_scroll.y =  50;
			
			m_scroll.height = 550;
			m_scroll.width = 650;
			
			m_scroll.scrollDirection = ScrollDirection.VERTICAL;
			m_scroll.setScrollContent( m_notes ); 			
			
			//m_bg.addChild(m_scroll);	
			
			//addChild(m_bg);
			
			addChild(m_scroll);

			btn_increaseFont.label = "F+";

			btn_increaseFont.width=50;
			btn_increaseFont.height=40;		
			
			btn_decreaseFont.label = "F-";

			btn_decreaseFont.width=50;
			btn_decreaseFont.height=40;	
			
			m_TA_page.x = 620;
			m_TA_page.y = 5;
			m_TA_page.height = 35;
			m_TA_page.width = 80;			
			m_TA_page.alwaysShowSelection = true;
			m_TA_page.type = TextFieldType.INPUT;
			
		    tf = m_TA_page.defaultTextFormat;
			tf.size=24; 
			tf.align=flash.text.TextFormatAlign.CENTER;
			
			m_TA_page.defaultTextFormat = tf;					
			m_TA_page.textColor = 0xCCCCCC;			
			m_TA_page.wordWrap = false;
			m_TA_page.htmlText="<font size=24 color=red>aaa</font>" 
			
			m_TA_page.background = true;
			m_TA_page.backgroundColor = 0x555555;
			
			this.m_hisscreen.addChild(m_TA_page);
			
			btn_pre.label = "<<";

			btn_pre.width=60;
			btn_pre.height=40;		
			
			btn_next.label = ">>";

			btn_next.width=60;
			btn_next.height=40;		
			
			btn_bg.label = "Change Background";
			
			btn_bg.width=360;
			btn_bg.height=40;	
			
			btn_bookmarknew.setIcon("res/bookmark30add.png");
			btn_bookmarknew.width= 80;
			btn_bookmarknew.height=80;	
			
			btn_bookmark.setIcon("res/bookmark70.png");
			btn_bookmark.x = 20;
			btn_bookmark.y = 20;
			btn_bookmark.width =100;
			btn_bookmark.height=100;	
			
			btn_dir.setIcon("res/dir70.png");
			btn_dir.x = 130;
			btn_dir.y = 20;			
			btn_dir.width= 100;
			btn_dir.height= 100;
			
			btn_nav.setIcon("res/textReader70.png");
			btn_nav.x = 240;
			btn_nav.y = 20;
			btn_nav.width =100;
			btn_nav.height=100;	
			
			btn_bookmarkdel.setIcon("res/Delete30.png");
			btn_bookmarkdel.x = 20;
			btn_bookmarkdel.y = 10;			
			btn_bookmarkdel.width= 50;
			btn_bookmarkdel.height=50;	
			
			btn_back.setIcon("res/back40.png");
			btn_back.x = 450;
			btn_back.y = 10;			
			btn_back.width=100;
			btn_back.height=50;	
			this.m_hisscreen.addChild(btn_back);
			
			btn_menu.setIcon("res/menu.png");
			btn_menu.width=50;
			btn_menu.height=40;	
			
			//btn_next.rotationX = 10;			
			btn_next.addEventListener(MouseEvent.CLICK, onbtn_next);
			btn_bg.addEventListener(MouseEvent.CLICK, onbtn_bg);
			btn_increaseFont.addEventListener(MouseEvent.CLICK, onbtn_increaseFont);
			btn_decreaseFont.addEventListener(MouseEvent.CLICK, onbtn_decreaseFont);
			btn_pre.addEventListener(MouseEvent.CLICK, onbtn_pre);
			btn_bookmark.addEventListener(MouseEvent.CLICK, onbtn_bookmark);
			btn_nav.addEventListener(MouseEvent.CLICK, onbtn_nav);
			btn_bookmarkdel.addEventListener(MouseEvent.CLICK, onbtn_bookmarkdel);
			btn_bookmarknew.addEventListener(MouseEvent.CLICK, onbtn_bookmarknew);
			btn_dir.addEventListener(MouseEvent.CLICK, onbtn_dir);
			btn_menu.addEventListener(MouseEvent.CLICK, onbtn_menu);
			btn_back.addEventListener(MouseEvent.CLICK, onbtn_back);
			
			this.m_hisscreen.addChild(btn_next);
			this.m_hisscreen.addChild(btn_pre);
			this.m_hisscreen.addChild(btn_bg);
			
			this.m_hisscreen.addChild(btn_increaseFont);
			this.m_hisscreen.addChild(btn_decreaseFont);
			
			btn_bookmarknew.x= 480;
			btn_bookmarknew.y= 30;			
			
			m_config.addChild(btn_bookmark);
			m_config.addChild(btn_nav);
			
			m_config.addChild(btn_bookmarknew);
			//addChild(btn_menu);
			m_hisscreen.addChild(btn_bookmarkdel);
			m_config.addChild(btn_dir);
			
			m_DropDown.x = 20;
			m_DropDown.y = 13;
			m_DropDown.width = 250;
			m_hisscreen.addChild(m_DropDown);
			
			tf = m_lab_pages.format ;
			tf.size = 16;
			tf.color = 0xFFFFFF;
			m_lab_pages.format = tf;
			m_lab_pages.x = 800;
			m_lab_pages.y = 0;
			
			this.m_hisscreen.addChild(this.m_slide);
			this.m_hisscreen.addChild(m_lab_pages);
			
			m_im_pre.setImage("res/ll.png");
			m_im_pre.buttonMode = true;
			m_im_pre.addEventListener(MouseEvent.CLICK,onbtn_pre);
			this.addChild(this.m_im_pre);
			
			m_im_nxt.setImage("res/rr.png");
			m_im_nxt.setPosition(930,350);
			//m_im_nxt.alpha = 0.2;
			m_im_nxt.buttonMode = true;
			this.addChild(this.m_im_nxt);
			m_im_nxt.addEventListener(MouseEvent.CLICK,onbtn_next);
			
			m_im_mu.setImage("res/m.png");
			m_im_mu.setPosition(920,30);
			//m_im_mu.alpha = 0.5;
			m_im_mu.buttonMode = true;
			this.addChild(this.m_im_mu);
			m_im_mu.addEventListener(MouseEvent.CLICK,this.onbtn_menu);
			
			layout_btn(4);
			layout_view(4);
//			Multitouch.inputMode = MultitouchInputMode.GESTURE;		
//			m_notes.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoom);
//			m_notes.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
			tf = m_notes.defaultTextFormat;
			tf.color = 0x888888;
			m_notes.setTextFormat(tf);
			m_notes.defaultTextFormat = tf;
			//this.m_im_mu.alpha = 1;
			
			m_im_nxt.alpha = 0.9;
			m_im_pre.alpha = 0.8;
			m_im_mu.alpha = 0.8;

///			m_webview.addEventListener(MouseEvent.CLICK,onViewClick);
			initdir();	
			//this.onbtn_menu(null);

			super();
		}		

		public function onViewClick(e:MouseEvent):void {
///			if(this.isPortrait())
///				this.m_webview.viewPort = new Rectangle(150,200,300,624);
///			else
///				this.m_webview.viewPort = new Rectangle(200,150,624,300);
///			startEpubtimer();
		}	
		

	public function startEpubtimer():void		
	{
		this.m_timerarm = new Timer(1400,1);
		m_timerarm.addEventListener(TimerEvent.TIMER_COMPLETE,onEpubtimer);
		this.m_timerarm.start();	
	}
	
	private function onEpubtimer(e:TimerEvent):void
	{			
		if(this.isPortrait())
		{}
///			m_webview.viewPort = new Rectangle(0,0,600,1024);
///		else
///			m_webview.viewPort = new Rectangle(0,0,1024,600);			
	}
		
		public function addWebview(a:Stage):void
		{
		
///			m_webview.stage = a;
///			m_webview.zoomToFitWidthOnLoad = true;
///			m_webview.blockPopups = true;
///			m_webview.userStyleSheet = "res/aa.css";
///			m_webview.defaultFontSize = 28;
///			m_webview.defaultTextEncoding = "UTF-8";
///			m_webview.zOrder = -1;
		}
		
		public function openEpub(o:File):void
		{
			m_epubfile = new zaePubFile();
			m_epubfile.f_load = this.onEpubload;
			m_epubfile.f_unZip = this.onEpubunZip;
					
			m_epubfile.test("file://"+o.nativePath);
		}
		
		public function onEpubload():void
		{
			this.onbtn_menu(null);
			m_epubfile.nextpage();
			epubupdate();
		}
		
		public function onEpubunZip(i:int):void
		{
			m_notes.text = "loading... " + i;
			this.stage.invalidate();
		}
		
		public function onepubnext(e:Event):void
		{
			m_epubfile.nextpage();
			epubupdate();
		}
		
		public function onepubpre(e:Event):void
		{
			m_epubfile.prepage();
			epubupdate();
	
		}
		
		private function epubupdate():void
		{
			var ss:String = m_epubfile.m_epubpages[m_epubfile.m_pagenum];
			var s:String = File.applicationStorageDirectory.nativePath + "/"+ss;
			m_notes.text = "                 Page:" + 
			m_epubfile.m_pagenum + "/" + m_epubfile.m_epubpages.length+" "+ss;
			//m_scroll.update();

			var m_loader:URLLoader = new URLLoader();		
			m_loader.load(new URLRequest("file://"+s));

			m_loader.addEventListener(IOErrorEvent.IO_ERROR,on_load_error);
			m_loader.addEventListener(Event.COMPLETE,on_load_compelete);	
			function on_load_error(event:Event):void
			{
				m_notes.text = "load error occur.";
			}
			function on_load_compelete(event:Event):void
			{
				var fileDes:File ;	
			
				var myCSS:StyleSheet = new flash.text.StyleSheet();
				
				var ll:URLLoader=  new URLLoader();
				ll.load(new URLRequest("file://"+File.applicationStorageDirectory.nativePath+"/OPS/css/main.css"));
				ll.addEventListener(Event.COMPLETE,on_ll_compelete);
				function on_ll_compelete(event:Event):void
				{
					myCSS.parseCSS(ll.data);
					m_notes.styleSheet = myCSS;
					var s:String= m_loader.data;
					var myPattern:RegExp = /<p><\/p>/g;
					s=s.replace(myPattern,"");
					m_notes.htmlText=s;
					m_scroll.scrollY = 0;				
					m_scroll.update();
				}				
			};

///			m_webview.loadURL("file://"+s);	
		}
		
		public function isPortrait():Boolean
		{
			if (this.m_layout == 1 || this.m_layout == 2)
				return true;
			else
				return false;
		}
		
		public function configdet(cfg:String):void
		{

			this.m_dirlist.visible = false;
			this.m_DropDown.visible = false;
			this.m_readhislist.visible = false;
			this.btn_bookmarkdel.visible = false;			
			this.btn_increaseFont.visible= false;
			this.btn_decreaseFont.visible= false;
			this.m_slide.visible = false;
			this.m_TA_page.visible = false;
			this.btn_next.visible = false;
			this.btn_pre.visible = false;
			this.m_lab_pages.visible = false;
			this.btn_bg.visible = false;
			
			if ( cfg == "openDir")
			{
				this.m_dirlist.visible = true;
				this.m_DropDown.visible = true;	
				this.btn_increaseFont.visible= true;
				this.btn_decreaseFont.visible= true;
			}
			if ( cfg == "bookmark")
			{
				this.m_readhislist.visible = true;
				this.btn_bookmarkdel.visible = true;				
			
			}
			if ( cfg == "nav")
			{
				this.m_slide.visible = true;
				this.m_TA_page.visible = true;
				this.btn_next.visible = true;
				this.btn_pre.visible = true;
				this.m_lab_pages.visible = true;
				this.btn_bg.visible = true;
			}				
				
		}
		

		public function onbtn_notes(e:MouseEvent):void {
			//if ( e.stageY < 350 && e.stageY > 250) 
			
			this.m_im_mu.visible = true;	
			this.m_im_pre.visible = true;	
			this.m_im_nxt.visible = true;
			starttimer();
			//ontimer(null);
			//this.onbtn_menu(e);
		}
		
		public function starttimer():void		
		{
			this.m_timerarm = new Timer(1400,1);
			m_timerarm.addEventListener(TimerEvent.TIMER_COMPLETE,ontimer);
			this.m_timerarm.start();	
		}
				
		private function ontimer(e:TimerEvent):void
		{			
			if (this.m_notes.height > 100)
			{
				if (!this.m_hisscreenv )
					this.m_im_mu.visible = false;
				
				this.m_im_pre.visible = false;	
				this.m_im_nxt.visible = false;
			}
			else
			{   
				this.m_im_mu.visible = true;	
				this.m_im_pre.visible = true;	
				this.m_im_nxt.visible = true;
			}				
		}
		
		public function layout_btn(i:int):void
		{
			
			if (i==1 || i ==2) //portrait
			{
				btn_menu.x= 60;
				btn_menu.y= 10;
				if (this.m_curfile == "EEPUB")
				{
					m_im_pre.setPosition(30,0);
					m_im_nxt.setPosition(530,0);
					m_im_mu.setPosition(270,30);
					m_im_pre.visible = true;
					m_im_nxt.visible = true;
				}
				else
				{
					m_im_pre.setPosition(30,700);
					m_im_nxt.setPosition(510,700);
					m_im_mu.setPosition(500,20);
				}
			
				if (!this.m_hisscreenv)
				{
					if (this.m_curfile == "EPUB")
					{
///						m_webview.zOrder = 0;
///						m_webview.viewPort = new Rectangle(0,60,600,964);
					}
				}
				else
				{	
///					m_webview.zOrder = -1;
				}
			}	
			
			if (i==3 || i==4) //landscape
			{			
				btn_menu.x= 290;
				btn_menu.y= 5;
				
				btn_increaseFont.x= 300;
				btn_increaseFont.y= 15;
				
				btn_decreaseFont.x= 380;
				btn_decreaseFont.y= 15;
				
				this.m_slide.x = 40;
				this.m_slide.y = 200;
				
				btn_pre.x= 100;
				btn_pre.y= 295;
				
				btn_next.x= 400;
				btn_next.y= 295;
				
				btn_bg.x= 100;
				btn_bg.y= 95;
				
				m_TA_page.x = 250;
				m_TA_page.y = 300;
				
				this.m_lab_pages.x=280;
				this.m_lab_pages.y=170;
				
				if (this.m_curfile == "EEPUB")
				{
					m_im_pre.setPosition(30,0);
					m_im_nxt.setPosition(935,0);
					m_im_pre.visible = true;
					m_im_nxt.visible = true;
					m_im_mu.setPosition(470,30);
				}
				else
				{
					m_im_pre.setPosition(30,270);
					m_im_nxt.setPosition(915,270);
					m_im_mu.setPosition(920,20);				
				}
				caption.x = 50;			
		
				
				if (!this.m_hisscreenv)
				{
						if (this.m_curfile == "EPUB")
						{
///							m_webview.zOrder = 0;
///							m_webview.viewPort = new Rectangle(0,60,1024,540);
						}
				}
				else
				{ 
///					m_webview.zOrder = -1;
				}
			}
		}
		
		
		public function layout_view(i:int):void
		{
			if(i==1) // protrait;
			{
			//	m_dirlist.visible = false;
			//	m_bg2.visible  =false;
				m_scroll.x = 0;
				m_scroll.y = 0;				
				m_notes.x = 0;	
				
				if( this.m_hisscreenv)
				{
					this.m_curscreen.x = 10;			
				}
				else
				{
					this.m_curscreen.x = 610;				 
				}
				
				m_hisscreen.y =  (1024 - 400)/2;
				m_config.y =  (1024 - 200)/2;
				
				LabTFa = m_notes.defaultTextFormat;
				m_notes.width = 601;	
				m_scroll.width = 601;
				LabTFa.color = 0x000000;
///				m_notes.background = true;
///				m_notes.backgroundColor = 0xFFFFFF;
				m_notes.defaultTextFormat = LabTFa;
				m_notes.setTextFormat(LabTFa);
				m_scroll.height = 1024;
//				if(this.m_curfile == "EPUB" && m_epubfile)
//				{
//					m_epubfile.modifyCSS("#FFFFFF","#000000");
//					epubupdate();
//				}
				//m_im_nxt.alpha = 0.5;
				//m_im_pre.alpha = 0.5;
				
			}
			else if (i==2)// protrait;
			{
			//	m_dirlist.visible = false;
			//	m_bg2.visible  =false;
				m_scroll.x = 0;
				m_scroll.y = 0;
				m_notes.x = 0;
				
				if( this.m_hisscreenv)
				{
					this.m_curscreen.x = 10;
				}
				else
				{
					this.m_curscreen.x = 610;
				}
				
				m_hisscreen.y =  (1024 - 400)/2;
				m_config.y =  (1024 - 200)/2;
				
				
				LabTFa = m_notes.defaultTextFormat;
				m_notes.width = 601;	
				
				m_scroll.width = 601;
				LabTFa.color = 0xFFFFFF;
///				m_notes.background = true;
///				m_notes.backgroundColor = 0x333333;
				m_notes.defaultTextFormat = LabTFa;
				m_notes.setTextFormat(LabTFa);				
				m_scroll.height = 1024;
//				if(m_curfile == "EPUB" && m_epubfile)
//				{
//					m_epubfile.modifyCSS("#333333","#FFFFFF");				
//					epubupdate();
//				}
				//m_im_nxt.alpha = 0.2;
				//m_im_pre.alpha = 0.2;
			}
			else if (i==3)
			{
			//	m_bg2.visible  = true;
			//	m_dirlist.visible = true;								
				m_scroll.x = 0;
				m_scroll.y = 0;
				m_notes.x = 0;
				
				m_scroll.height = 600;				
				m_notes.width = 1024;	
				m_scroll.width = 1024;
				if( this.m_hisscreenv)
				{
					this.m_curscreen.x = 222;
				}
					else
				{
					this.m_curscreen.x = 1200;
				}
				
				m_hisscreen.y =  (600 - 400)/2;
				m_config.y =  (600 - 200)/2;
				
				LabTFa = m_notes.defaultTextFormat;				
				LabTFa.color = 0x000000;
				m_notes.defaultTextFormat = LabTFa;
///				m_notes.background = true;
///				m_notes.backgroundColor = 0xFFFFFF;
				m_notes.setTextFormat(LabTFa);	
//				if(m_curfile == "EPUB" && m_epubfile)
//				{
//					m_epubfile.modifyCSS("#FFFFFF","#333333");				
//					epubupdate();
//				}
				//m_im_nxt.alpha = 0.5;
				//m_im_pre.alpha = 0.5;
			}
			else if (i==4)
			{
			//	m_bg2.visible  = true;
			//	m_dirlist.visible = true;
				m_scroll.x = 0;
				m_scroll.y = 0;
				m_notes.x = 0;
				
				m_scroll.height = 600;
				m_notes.width = 1024;	
				m_scroll.width = 1024;
				
				if( this.m_hisscreenv)
				{					
					this.m_curscreen.x = 222;					
				}
				else
				{
					this.m_curscreen.x = 1200;				
				}
				
				m_hisscreen.y =  (600 - 400)/2;
				m_config.y =  (600 - 200)/2;
			
				LabTFa = m_notes.defaultTextFormat;
				LabTFa.color = 0xFFFFFF; 
				m_notes.defaultTextFormat = LabTFa;
///				m_notes.background = true;
///				m_notes.backgroundColor = 0x333333;				
				m_notes.setTextFormat(LabTFa);
//				if(m_curfile == "EPUB" && m_epubfile)
//				{
//					m_epubfile.modifyCSS("#333333","#FFFFFF");				
//					epubupdate();
//				}
				//m_im_nxt.alpha = 0.2;
				//m_im_pre.alpha = 0.2;
			}
		}
		
		public function layout(i:int):void {
			layout_view(i);
			layout_btn(i);
		}
		
		public function initdir():void {
			m_dirs.push(File.documentsDirectory);
			m_files = File.documentsDirectory.getDirectoryListing();			
			m_files.unshift(File.documentsDirectory);			
			m_dirlist.dataProvider = new DataProvider(m_files) ;
		}
		
		public function onDropDown(e:Event):void {
			var l:String;
			
			if (m_DropDown.selectedIndex < 0) return;
			
			if (m_DropDown.selectedItem.label != "auto")
			{	
				m_f.m_auto = false;
				m_f.setfileCharset(m_DropDown.selectedItem.label);
			}
			else
				m_f.m_auto = true;
			
			handleSelectDirFile(null);
		}
		
		public function handleReadHis(e:Event):void {
			if (this.m_readhislist.selectedItem != null)
			{
				//m_hisscreen.visible = false;
				openReadHis(this.m_readhislist.selectedItem as Record);				
			}
		}
		
		public function handleSelectDirFile(e:Event):void {
			var l:String;		
			var o:File = m_dirlist.selectedItem as File;
			
			if (o !=null)
			{
				if (o.isDirectory)
				{												
					m_files = [];			
					if (m_dirlist.selectedIndex == 0) //return up
					{
						if (m_dirs.length == 1) 
							return;
						m_dirs.pop();						
						o = m_dirs[m_dirs.length-1];
						m_files = o.getDirectoryListing();
						if ( m_dirs.length>1)						
						  m_files.unshift(m_dirs[m_dirs.length-2]);
						else
						{ 						  						 
						  m_files.unshift(File.documentsDirectory);
						}
					}
					else
					{					
						m_files = o.getDirectoryListing();
						m_files.unshift(m_dirs[m_dirs.length-1]);					
						m_dirs.push(o);		
					}
					m_dirlist.dataProvider = new DataProvider(m_files) ;
					
					var ff:File =m_dirs[m_dirs.length-1] as File; 	
					this.m_notes.text = "Current dir: " + ff.nativePath.substr(ff.nativePath.indexOf("shared/")); 	
					
					if (m_files.length > 1)
						m_dirlist.selectedIndex = 1;
					else
						m_dirlist.selectedIndex = 0;
				}
				else 
				{
					if (o.extension.toUpperCase() == "TXT")
					{
						m_notes.text = "             Loading " + o.name + " ..."
						opentext(o);
						m_curfile = "TXT";
///						m_webview.viewPort = new Rectangle(0,0,0,0);
					}
					else if (o.extension.toUpperCase() == "EPUB")
					{
						m_notes.text = "             Loading " + o.name + " ..."
					    openEpub(o);
						m_curfile = "EPUB";
					}
					else						
					{
						m_notes.text = o.name + " isn't a text file.";
						m_curfile = "N/A";
///						m_webview.viewPort = new Rectangle(0,0,0,0);
					}
				}
			}
		}
		
		public function opentext(ofile:File):void
		{
			
//				if (ofile.size > 50*1024)
//				{  
//					m_notes.text = "50K limited, File is too large to read ," + Math.ceil(ofile.size/1024) + "K"; 
//					return ;
//				}
				
				var f:File = m_dirs[m_dirs.length-1].resolvePath(ofile.name);
				m_f.assignfile(f);
				var cnt:String ="";
				if (f.size <3*1024)
					cnt = m_f.nextpageall();
				else
				{
					cnt = m_f.nextpage();	
					m_f.m_page --;
				}	
				m_notes.text = "File:" + m_f.fname() +"\n"+
							    "Page: " + m_f.page() + " " +
					           " Size: " + m_f.totalpage() + "K   " +
							   " Charset:" + m_f.getfileCharset()+"\n\n" +
					            cnt;
				this.m_slide.maximum = m_f.totalpage();
				this.m_slide.value = m_f.page();		
				this.onslider_change(null);
			
					
			m_scroll.scrollY = 0;
			m_scroll.update();			
			//fix the bug ,update will put the m_scroll to the top of the screen.
			if (m_hisscreenv)
				this.setChildIndex(m_hisscreen,this.numChildren-1);	
		}
			
		public function openReadHis(o:Record):void
		{
			
			var f:File;
			var fn:String = "";

			fn = o.dir.replace(File.documentsDirectory.nativePath,"")+"/"+o.file;
			fn = fn.substr(1);
			f = File.documentsDirectory.resolvePath(fn);
			
			if (!f.exists)// window paltform
			{
				fn = o.dir.replace(File.documentsDirectory.nativePath,"")+"\\"+o.file;
				fn = fn.substr(1);
				f = File.documentsDirectory.resolvePath(fn);
			}
			
			if (f.extension.toUpperCase() == "EPUB")
			{
				this.m_curfile = "EPUB";
				this.openEpub(f);
	
				m_epubfile.m_cover_image;
				this.m_epubfile.gotoPage(Number(o.page)-1);
				this.epubupdate();
				
///				this.m_webview.defaultFontSize = Number(o.font); 
///				this.m_webview.scrollPosition.y = Number(o.scrollY);
				return;
			}
			
			this.m_curfile = "TXT";
			m_f.assignfile(f);
			
			var cnt:String ="";
			if (f.size <3*1024)
				cnt = m_f.nextpageall();
			else
			{
				m_f.setstartpage(Number(o.page));
				cnt = m_f.nextpage();	
				m_f.m_page --;
			}	
			LabTFa = m_notes.getTextFormat();
			LabTFa.size = o.font;
			m_notes.setTextFormat(LabTFa);			
			m_notes.defaultTextFormat = LabTFa;
			m_scroll.update();
			
			m_notes.text = "Page: "+m_f.page() + "/" +m_f.totalpage()+ "\n" + cnt;
			
			this.m_slide.maximum = m_f.totalpage();
			this.m_slide.value = m_f.page();
			this.onslider_change(null);
			
			m_scroll.scrollY = Number(o.scrollY);
			m_scroll.update();
			//fix the bug ,update will put the m_scroll to the top of the screen.
			if (m_hisscreenv)
			 this.setChildIndex(m_hisscreen,this.numChildren-1);
		}
		
		public function onSwipe(event:TransformGestureEvent):void {			
			if(event.offsetX == -1) {
				m_notes.text = "\n"+m_f.nextpage();
			//	m_notes.text = "Page: "+m_f.page() + "/" +m_f.totalpage()+ "\n" +  m_notes.text;
				m_scroll.scrollY = 0;
				m_scroll.update();	
					
			} else if(event.offsetX == 1) {
				m_notes.text = "\n"+m_f.prepage();
				m_scroll.scrollY = 0;
				m_scroll.update();	
			}
		
		}
		
		public function onZoom(event:TransformGestureEvent):void {
			LabTFa = m_notes.getTextFormat();
			LabTFa.size = int(LabTFa.size) * event.scaleX;	
			if (LabTFa.size < 16)
				LabTFa.size = 16 ;
			m_notes.setTextFormat(LabTFa);			
			m_scroll.update();

		}
		
		public function onbtn_increaseFont(e:Event):void {
			playbtnpress();
			if (this.m_curfile == "EPUB")
			{
///				this.m_webview.defaultFontSize *= 1.1;				
///				return;
				m_notes.styleSheet = null;
			}	
			
			LabTFa = m_notes.getTextFormat();
			LabTFa.size = int(LabTFa.size) * 1.1;	
			if (LabTFa.size < 16)
				LabTFa.size = 16 ;
			m_notes.setTextFormat(LabTFa);			
			m_notes.defaultTextFormat = LabTFa;
			m_scroll.update();
		}
		
		public function onbtn_decreaseFont(e:Event):void {
			playbtnpress();
			if (this.m_curfile == "EPUB")
			{
///				this.m_webview.defaultFontSize /= 1.1;				
///				return;
				m_notes.styleSheet = null;
			}	
			LabTFa = m_notes.getTextFormat();
			
			LabTFa.size = int(LabTFa.size) / 1.1;	
			m_notes.setTextFormat(LabTFa);		
			m_notes.defaultTextFormat = LabTFa;
			m_scroll.update();
		}
		
		public function onbtn_back(e:Event):void 
		{
			playbtnpress();
			
			Tweener.addTween(m_curscreen,
				{x:-600,transition:"easeInSine", alpha:1, delay:0,time:0.3});
			
			m_curscreen = m_config;
			
			if(!this.isPortrait())
			{
				m_config.y = 200;
				Tweener.addTween(m_config,
					{x:220,transition:"easeInSine", alpha:1, delay:0.5,time:0.3});					
			}
			else
			{
				m_config.y = 400;
				Tweener.addTween(m_config,
					{x:10,transition:"easeInSine", alpha:1, delay:0.5,time:0.3});	
			}	
			this.setChildIndex(m_config,this.numChildren-1);	
			
		}
		
		
		public function onbtn_menu(e:Event):void 
		{
			
			if(e)
			playbtnpress();

			this.setChildIndex(m_curscreen,this.numChildren-1);
			m_hisscreenv = !m_hisscreenv;
			
			//layout_btn(m_layout);
			
			var a:TextFormat;			
			m_notes.styleSheet = null;
			if (!m_hisscreenv) 
			{
				//this.layout_btn(this.m_layout);
				//this.m_im_mu.alpha = 0.5;
				this.m_notes.alpha = 1;	
				a = this.m_notes.defaultTextFormat;
				if (this.m_layout == 2 || this.m_layout == 4)
					a.color = 0xFFFFFFFF;
				if (this.m_layout == 1 || this.m_layout == 3)
					a.color = 0xFF000000;	
				m_notes.defaultTextFormat = a;
				this.m_notes.setTextFormat(a);
				Tweener.addTween(this.m_curscreen,
					{x:-600,transition:"easeInSine", alpha:1, delay:0,time:0.3});
			}
			else
			{
					
			//	this.m_notes.alpha = 0.5;
			//	this.m_im_mu.alpha = 1;
				m_curscreen.x = -600;		
				a = this.m_notes.defaultTextFormat;
				a.color = 0xFF999999;
    			m_notes.defaultTextFormat = a;
				m_notes.setTextFormat(a);
				
			    if ( this.isPortrait())
				{				
					Tweener.addTween(m_curscreen,
						{x:10,transition:"easeInSine", alpha:1, delay:0,time:0.3});
				}
				else
				{				
					Tweener.addTween(m_curscreen,
					{x:222,transition:"easeInSine", alpha:1, delay:0,time:0.3});
				}
			}
			
		}
		
		public function playbtnpress():void
		{
			var _soundObj:Sound = new Sound(); 					
			_soundObj.load(new URLRequest("res/btn121.mp3"));  
			_soundObj.play(); 
			//	_soundObj.addEventListener(IOErrorEvent.IO_ERROR,onError);
		}
		
		public function onbtn_dir(e:Event):void 
		{
			if (e)
				playbtnpress();
			
			m_curscreen = m_hisscreen;
			Tweener.addTween(m_config,
				{x:-600,transition:"easeInSine", alpha:1, delay:0,time:0.3});
			m_hisscreen.x = -600;
			Tweener.addTween(m_hisscreen,
				{x:(this.isPortrait()?10:220),transition:"easeInSine", alpha:1, delay:0.5,time:0.3});
			
			this.configdet("openDir");			
			
		}
		
		public function onbtn_nav(e:Event):void 
		{
			if (e)
				playbtnpress();
	
			m_curscreen = m_hisscreen;
			Tweener.addTween(m_config,
				{x:-600,transition:"easeInSine", alpha:1, delay:0,time:0.3});
			m_hisscreen.x = -600;
			Tweener.addTween(m_hisscreen,
				{x:this.isPortrait()?10:220,transition:"easeInSine", alpha:1, delay:0.5,time:0.3});
			
			this.configdet("nav");	
		}
		
		
		public function onbtn_bookmark(e:Event):void 
		{
			if (e)
				playbtnpress();
			
			m_curscreen = m_hisscreen;
			Tweener.addTween(m_config,
				{x:-600,transition:"easeInSine", alpha:1, delay:0,time:0.3});
			m_hisscreen.x = -600;
			Tweener.addTween(m_hisscreen,
				{x:this.isPortrait()?10:220,transition:"easeInSine", alpha:1, delay:0.5,time:0.3});
			
			this.configdet("bookmark");
		}
		
		public function onbtn_bookmarknew(e:Event):void {
			playbtnpress();
			var o:Record = new Record();
			o.title = "Read His";
			o.updatetime = getDT(new Date());
			
			if (this.m_curfile == "EPUB")
			{				
				o.dir =  m_epubfile.m_filename.replace("file://","");
				o.file = File.documentsDirectory.resolvePath(m_epubfile.m_filename).name;				
				o.dir = o.dir.replace("/"+o.file,"");
				
				o.page = String(this.m_epubfile.m_pagenum);
				o.content = m_epubfile.m_epubpages[m_epubfile.m_pagenum];
///				o.font = String(this.m_webview.defaultFontSize);
///				o.scrollY = String(this.m_webview.scrollPosition.y);
				o.font = String(m_notes.defaultTextFormat.size);
				o.scrollY = String(m_scroll.scrollY);
			}
			else
			{
				o.dir = File(m_dirs[m_dirs.length-1]).nativePath;
				//o.dir = m_f.pathname();				
				o.file = m_f.fname();
				o.page = String(m_f.page());
				o.content = m_notes.text.substr(0,50);
				o.font = String(m_notes.defaultTextFormat.size);
				o.scrollY = String(m_scroll.scrollY);
			}
			mysql.insert(o);		
			m_readhislist.dataProvider.addItemAt(o,0);
		}
		
		public function onbtn_bookmarkdel(e:Event):void {
			playbtnpress();
			var o:Record = new Record();
			o = m_readhislist.selectedItem as Record;
			m_sql.del(o);
			m_readhislist.removeItem(o);
		}
		
		
		public function onbtn_pre(e:Event):void {
			playbtnpress();
			if (m_curfile == "EPUB")
			{
				this.layout_btn(this.m_layout);
				this.onepubpre(e);
				return;
			}
			m_notes.text = m_f.prepage();
			m_notes.text = "Page: "+ m_f.page()  + "/" +m_f.totalpage()+ "\n" +  m_notes.text;
			m_scroll.scrollY = 0;
			m_scroll.update();
			m_slide.value = m_f.page();
			onslider_change(null);
		}
		
		public function onslider_gotpage(e:Event):void {
		    m_notes.text = m_f.gotopage(Math.round(this.m_slide.value));
			m_notes.text = "Page: "+ m_f.page()  + "/" +m_f.totalpage()+ "\n" +  m_notes.text;
			m_scroll.scrollY = 0;
			m_scroll.update();			
		}
		
		public function onslider_change(e:Event):void {
			 if (m_f.totalpage() > 0)				 
			 	this.m_lab_pages.text = ""+Math.round(this.m_slide.value)+"/" +m_f.totalpage();
			 else
				this.m_lab_pages.text = "-";
		}
		
		public function onbtn_bg(e:Event):void
		{
			zaReader(this.parent).setBg();
		}
		
		public function onbtn_next(e:Event):void {			
			playbtnpress();
			//epub
			if (m_curfile == "EPUB")
			{
				
				this.layout_btn(this.m_layout);
				this.onepubnext(e);
				return;
			}
			
			// goto page
			if (this.m_TA_page.text != "")
			{
				m_notes.text = m_f.gotopage(Number(this.m_TA_page.text));
				m_notes.text = "Page: "+ m_f.page()  + "/" +m_f.totalpage()+ "\n" +  m_notes.text;
				m_scroll.scrollY = 0;
				m_scroll.update();
				m_TA_page.text = "";
				onslider_change(null);
				return;
			}
			
			//
			m_notes.text = m_f.nextpage();
			m_notes.text = "Page: "+m_f.page() + "/" +m_f.totalpage()+ "\n" +  m_notes.text;
			m_slide.value = m_f.page();
			onslider_change(null);
			m_scroll.scrollY = 0;
			m_scroll.update();		
		}		
		
		public function onbtn_prefile(e:Event):void {
			if (m_dirlist.selectedIndex < 0 ) 
				return ; 
			var i:int = 0;
			for (i = m_dirlist.selectedIndex;i > 0 ; i--)
			{
				var o:File = m_dirlist.dataProvider.data[i];
				if (o.extension.toUpperCase() == "TXT")
				{
					m_dirlist.selectedIndex = i;
					this.opentext(o);
				}
				else
					continue;
			}
	   }
	  
		public function onbtn_nextfile(e:Event):void {
	
			if (m_dirlist.selectedIndex < 0 ) 
				return ; 
			for (var i:int = m_dirlist.selectedIndex;i<m_dirlist.size ; i++)
			{
				var o:File = m_dirlist.dataProvider.data[i];
				if (o.extension.toUpperCase() == "TXT")
				{
					m_dirlist.selectedIndex = i;
					this.opentext(o);
				}
				else
					continue;
			}
		}
		
		public function errorHandler(e:IOErrorEvent):void {
			msg.text = "无法获取天气信息数据!";
		}
		
		public function swap(event:MouseEvent):void {
			zaReader(this.parent).change();			
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
	}
}