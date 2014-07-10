package zaChineseIME
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import qnx.ui.buttons.Button;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.display.Image;
	import qnx.ui.text.Label;
	
	import zaChineseIME.model.RecordDAO;

	public class zaVersion extends Sprite
	{
		private var m_version:String = "1.3.2.130";
		public var m_sql:RecordDAO = new RecordDAO();
		public var m_stage:Sprite;
		private var Img_bg:Image = new Image();
		private var m_lab_title:Label = new  Label();
		public function zaVersion()
		{
			Img_bg.setImage("zaChineseIME/res/bg5.png");
			Img_bg.setPosition( 0, 0);
			addChild(Img_bg);	
		}
		
		public function checkversion(p:Sprite):void
		{
				var m_loader:URLLoader = new URLLoader();	
				m_loader.load(new URLRequest("http://www.bbcubezone.com/version.php?appid=chineseime"));
				m_loader.addEventListener(IOErrorEvent.IO_ERROR,on_load_error);
				m_loader.addEventListener(Event.COMPLETE,on_load_compelete);					
				// add 
				
				function on_load_error(event:Event):void
				{
					//get local reg;
					var ret:int;
					var v:String = m_sql.getver();
					if ( m_version < v)
					{
						ret = m_sql.addver();
						if ( ret >= 10)
						{
							addBtn();						
						}
					}
				}
				
				function addBtn():void
				{
					m_lab_title.width = 1024;
					
					var a:TextFormat = m_lab_title.format;
					a.color = 0xFFFFFF00;
					m_lab_title.format = a;		

					m_lab_title.autoSize = TextFieldAutoSize.NONE;
					m_lab_title.text = "当前版本："+m_version+"，更新到新版本" + m_loader.data +"?";
					m_lab_title.setPosition(360,200);
					m_lab_title.x = (1024-m_lab_title.textWidth)/2;
					
					addChild(m_lab_title);
					var btn_update :LabelButton = new LabelButton();
					btn_update.addEventListener(MouseEvent.CLICK, onbtn_version);	
					
					btn_update.setPosition(440,300);
					btn_update.label = "确定";
					addChild(btn_update);	
					m_stage.addChild(p);
				}
				
				function on_load_compelete(event:Event):void
				{
					var s:String = m_loader.data;
					m_sql.setver(s.replace(" ",""));
					if (m_version < s.replace(" ",""))
					{
						addBtn();						
					}	
				}
				
				function onbtn_version(e:MouseEvent):void {
					flash.net.navigateToURL(new URLRequest("appworld://content/44934"));
				}
			}
	}
}