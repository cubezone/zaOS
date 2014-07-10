package
{
	import caurina.transitions.*;
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.utils.getDefinitionByName;
	
	import qnx.events.QNXApplicationEvent;
	import qnx.system.QNXApplication;
	
	import qnx.ui.buttons.IconButton;
	import qnx.ui.skins.SkinAssets;
	import zaChineseIME.*;	
	import zaSafeNote.*;
	
	[SWF(height="600", width="1024", 
     frameRate="30", backgroundColor="#000000")]
	
	public class zaApp extends Sprite
	{
		public var m_main:Sprite;
		public var m_ChineseIMEmain:zaChineseIME.zaMain= new zaChineseIME.zaMain();
		public var m_SafeNotemain:zaSafeNote.zaMain= new zaSafeNote.zaMain();
		public var m_sysmenu:Sprite = new Sprite();
		public var m_btn_IME:IconButton= new IconButton();
		public var m_btn_Note:IconButton= new IconButton();
		
		public function zaApp()
		{	
			super();		
			
			m_SafeNotemain.visible = false;
			m_SafeNotemain.y = 0;		
			addChild(m_SafeNotemain);		
			
			m_ChineseIMEmain.y = 0;
			addChild(m_ChineseIMEmain);
			
			initsysmenu();
			
			//initqnx();
		}

		private function initqnx():void
		{
//			QNXApplication.qnxApplication.addEventListener(qnx.events.QNXApplicationEvent.SWIPE_DOWN,openAddMenu);			
		}
		
		public function initsysmenu():void
		{			
			m_main = m_ChineseIMEmain;
			m_sysmenu.x = 0;
			m_sysmenu.y = -600;	
			m_sysmenu.graphics.beginFill(0x00404040,0.8);
			m_sysmenu.graphics.drawRoundRect(0,0,1024,600,40,40);
			m_sysmenu.graphics.endFill();

			m_sysmenu.graphics.beginFill(0x003A6EA5,1);
			m_sysmenu.graphics.drawRoundRect(0,0,1024,500,40,40);
			m_sysmenu.graphics.endFill();

			m_btn_IME.setIcon("zaChineseIME/res/icon86.png");
			m_btn_IME.x = 320;
			m_btn_IME.y = 200;			
			m_btn_IME.width=60;
			m_btn_IME.height=70;	
			m_sysmenu.addChild(m_btn_IME);
			m_btn_IME.addEventListener(MouseEvent.CLICK, onbtnclick_IME);
			
			m_btn_Note.setIcon("zaSafeNote/res/icon86.png");
			m_btn_Note.x = 600;
			m_btn_Note.y = 200;			
			m_btn_Note.width=60;
			m_btn_Note.height=70;	
			m_sysmenu.addChild(m_btn_Note);
			m_btn_Note.addEventListener(MouseEvent.CLICK, onbtnclick_note);
			
			addChild(m_sysmenu);
			
		}
		
		public function onbtnclick_IME(e:Event):void {
			m_main.visible = false;
			m_main = this.m_ChineseIMEmain;				
			m_main.visible = true;
			Tweener.addTween(m_sysmenu,
				{y:-600,
					transition:"easeInSine", alpha:1, delay:0,time:0.4});	
		}
		
		public function onbtnclick_note(e:Event):void {		
			m_main.visible = false;
			m_main = this.m_SafeNotemain;				
			m_main.visible = true;
			Tweener.addTween(m_sysmenu,
				{y:-600,
					transition:"easeInSine", alpha:1, delay:0,time:0.4});	
		}
		
		public function openAddMenu(event:QNXApplicationEvent):void {			
			if (m_sysmenu.y == 0)
				Tweener.addTween(m_sysmenu,
					{y:-600,
						transition:"easeInSine", alpha:1, delay:0,time:0.4});
			else			
				Tweener.addTween(m_sysmenu,
					{y:0,
						transition:"easeInSine", alpha:1, delay:0,time:0.4});	
		}

	}
}