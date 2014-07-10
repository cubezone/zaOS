package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Dictionary;
	
	import mx.core.IAssetLayoutFeatures;
	
	import qnx.ui.display.Image;
	import qnx.ui.events.SliderEvent;
	import qnx.ui.slider.Slider;
	import qnx.ui.text.Label;
	
	[SWF(width="1024", height="600", backgroundColor="#000000", frameRate="30")]
	public class zaPiano extends Sprite
	{
		private var finger:Dictionary = new Dictionary();
		
		private var m_keyimg:Dictionary = new Dictionary();
		private var m_keyimg_o:Dictionary = new Dictionary();
		
		private var m_key_b:Array = new Array();		
		private var m_key_w:Array = new Array();
		private var m_key_bb:Array = new Array();		
		private var m_key_ww:Array = new Array();
	
		private static var m_bmp_b:Bitmap;
		private static var m_bmp_bb:Bitmap;
		private static var m_bmp_bb1:Bitmap;
		private static var m_bmp_bb2:Bitmap;
		private static var m_bmp_bb3:Bitmap;
		private static var m_bmp_bb4:Bitmap;
		private static var m_bmp_bb5:Bitmap;
		private static var m_bmp_bb6:Bitmap;
		private static var m_bmp_k:Bitmap;
		private static var m_bmp_kk:Bitmap;
		private static var m_img_b:Image= new Image();
		private var m_sl_note:Slider = new Slider();
		
		private var m_note_b:Array = new Array();
		private var m_note_w:Array = new Array();
		
		public var m_keyboard:Sprite = new Sprite();
		
		
		public function zaPiano()
		{
			init_sound();
			loadimgk();			
			m_img_b.setImage("res/b.png");
			

			init_multifstouch();
			super();
		}
		
		private function chagekeyboard(evt:Event):void
		{   
			m_keyboard.x = -m_sl_note.value *99;				
		}   

		
		public function loadimgk():void
		{
			const IMAGE_URL:String = "res/k.png";			
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, ldr_complete);
			ldr.load(new URLRequest(IMAGE_URL));								
			function ldr_complete(evt:Event):void 
			{
				m_bmp_k = ldr.content as Bitmap;	
				loadimgb();
			}
		}
		
		public function loadimgb():void
		{
			const IMAGE_URL:String = "res/b.png";			
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, ldr_complete);
			ldr.load(new URLRequest(IMAGE_URL));								
			function ldr_complete(evt:Event):void 
			{
				m_bmp_b = ldr.content as Bitmap;	
				loadimgbb();
			}
		}
		
		public function loadimgbb():void
		{
			const IMAGE_URL:String = "res/bb.png";			
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, ldr_complete);
			ldr.load(new URLRequest(IMAGE_URL));								
			function ldr_complete(evt:Event):void 
			{
				m_bmp_bb = ldr.content as Bitmap;	
				loadimgbb1();
			}
		}
		
		public function loadimgbb1():void
		{
			const IMAGE_URL:String = "res/bb_1.png";			
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, ldr_complete);
			ldr.load(new URLRequest(IMAGE_URL));								
			function ldr_complete(evt:Event):void 
			{
				m_bmp_bb1 = ldr.content as Bitmap;	
				loadimgbb2();
			}
		}
		
		public function loadimgbb2():void
		{
			const IMAGE_URL:String = "res/bb_2.png";			
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, ldr_complete);
			ldr.load(new URLRequest(IMAGE_URL));								
			function ldr_complete(evt:Event):void 
			{
				m_bmp_bb2 = ldr.content as Bitmap;	
				loadimgbb3();
			}
		}
		
		public function loadimgbb3():void
		{
			const IMAGE_URL:String = "res/bb_3.png";			
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, ldr_complete);
			ldr.load(new URLRequest(IMAGE_URL));								
			function ldr_complete(evt:Event):void 
			{
				m_bmp_bb3 = ldr.content as Bitmap;	
				loadimgbb4();
			}
		}
		
		public function loadimgbb4():void
		{
			const IMAGE_URL:String = "res/bb_4.png";			
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, ldr_complete);
			ldr.load(new URLRequest(IMAGE_URL));								
			function ldr_complete(evt:Event):void 
			{
				m_bmp_bb4 = ldr.content as Bitmap;	
				loadimgkk();
			}
		}
		
		public function loadimgkk():void
		{
			const IMAGE_URL:String = "res/kk.png";			
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, ldr_complete);
			ldr.load(new URLRequest(IMAGE_URL));								
			function ldr_complete(evt:Event):void 
			{
				m_bmp_kk = ldr.content as Bitmap;	
				m_keyboard.graphics.beginFill(0,1);
				m_keyboard.graphics.drawRect(0,0,600,1024*7);
				m_keyboard.y = 0;
				addChild(m_keyboard);
				initkeyboard();
				
				var b:Sprite = new Sprite();
				
				b.graphics.beginFill(0xFF333333,1);
				b.graphics.drawRect(0,0,1024,50);
				b.graphics.endFill();			
				b.x = 0; b.y = 550;
				addChild(b);
				
				Add_Ad();
				
				m_sl_note.minimum = 0;
				m_sl_note.maximum = 33;	
				m_sl_note.x = 200;
				m_sl_note.y = 570;
				m_sl_note.width = 700;			
				m_sl_note.value = 20.5;				
				m_sl_note.addEventListener(SliderEvent.MOVE, chagekeyboard);
				chagekeyboard(null);
				addChild(m_sl_note);

			}
		}
			
		public function init_multifstouch():void
		{
			
			if (Capabilities.os.indexOf("PlayBook") > -1)
			{			
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
				stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			} 
			else
			{
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);                
			}
		}
		
		public function Add_Ad():void
		{
			var Img_browser:Image = new Image();
			Img_browser.setImage("res/broswer.png");
			Img_browser.setPosition(962, 560);
			Img_browser.buttonMode = true;
			Img_browser.addEventListener(MouseEvent.CLICK,onbtn_www);
			addChild(Img_browser);
		
			function onbtn_www(event:MouseEvent):void {
				flash.net.navigateToURL(new URLRequest("http://appworld.blackberry.com/webstore/content/44979"));		
			}
		}
		
		
		public function initkeyboard():void
		{		
			var k:Sprite;
			for (var i:int = 0 ;i <43 ; i++)
			{
				k = new Sprite();			
				if (i%7==1)
				{	
					k.graphics.beginBitmapFill(m_bmp_bb1.bitmapData);
					k.graphics.drawRect(0,0,m_bmp_bb1.width,m_bmp_bb.height);				
				}
				else if(i%7==2)
				{	
					k.graphics.beginBitmapFill(m_bmp_bb2.bitmapData);
					k.graphics.drawRect(0,0,m_bmp_bb.width,m_bmp_bb.height);				
				}
				else if(i%7==3)
				{	
					k.graphics.beginBitmapFill(m_bmp_bb3.bitmapData);
					k.graphics.drawRect(0,0,m_bmp_bb.width,m_bmp_bb.height);				
				}
				else if(i%7==4)
				{	
					k.graphics.beginBitmapFill(m_bmp_bb4.bitmapData);
					k.graphics.drawRect(0,0,m_bmp_bb.width,m_bmp_bb.height);				
				}
				else
				{
					k.graphics.beginBitmapFill(m_bmp_bb.bitmapData);
					k.graphics.drawRect(0,0,m_bmp_bb.width,m_bmp_bb.height);	
				}
				
				k.x=99*i;

				m_key_ww.push(k);
				//	k.buttonMode = true;
				//  k.addEventListener(MouseEvent.CLICK,on_key);		
				
				m_keyboard.addChild(k);	
				
				k = new Sprite();			
				k.graphics.beginBitmapFill(m_bmp_b.bitmapData);
				k.graphics.drawRect(0,0,m_bmp_b.width,m_bmp_b.height);				
				if (i%7==0)
				{
					var lb:Label = new Label();
					lb.text = "C" + (i/7 +1);
					lb.y = 520;
					lb.x = 30;
					k.addChild(lb);
				}
				
				k.x=99*i;
				m_key_w.push(k);
				m_keyboard.addChild(k);	
			}		
			
			for (i = 0 ;i < 42 ; i++)
			{	
				if (i%7==2 || i%7 == 6) 
				continue;
				
				k = new Sprite();
				k.graphics.beginBitmapFill(m_bmp_kk.bitmapData);
				k.graphics.drawRect(0,0,m_bmp_kk.width,m_bmp_k.height);		
				k.x = 61 + 99*i;
				k.y = -170;
				m_key_bb.push(k);
				//	k.buttonMode = true;
				//  k.addEventListener(MouseEvent.CLICK,on_key);						
				
				m_keyboard.addChild(k);
				
				k = new Sprite();
				k.y = -170;
				k.graphics.beginBitmapFill(m_bmp_k.bitmapData);
				k.graphics.drawRect(0,0,m_bmp_k.width,m_bmp_k.height);		
				k.x = 61 + 99*i;
				m_key_b.push(k);
				m_keyboard.addChild(k);
			}
			
		}
				
		public function onMouseDown(event:MouseEvent):void
		{
			var tPoint:Sprite = new Sprite();
			
			tPoint.graphics.beginFill(0xFF0000ff,0.5);
			tPoint.graphics.drawCircle(0,0,40);
			tPoint.graphics.endFill();			
			tPoint.x = event.stageX 
			tPoint.y = event.stageY-50;
			addChild(tPoint);
			finger[0] = tPoint;
			play_note(0, event.stageX , event.stageY);
		}
		
		public function onMouseUp(event:MouseEvent):void
		{
			var tPoint:Sprite = finger[0] as Sprite;
			delete finger[0];
			
			m_keyimg_o[0].visible = true;
			m_keyimg[0].visible = false;
			
			this.removeChild(tPoint);
						
			if (m_keyimg[0]!= null)
			delete m_keyimg[0];
			if (m_keyimg_o[0]!= null)
			delete m_keyimg_o[0];
		}
		
		
		public function onTouchBegin(event:TouchEvent):void
		{
			var tPoint:Sprite = new Sprite();
			
			tPoint.graphics.beginFill(0xFF0000ff,0.5);
			tPoint.graphics.drawCircle(0,0,40);
			tPoint.graphics.endFill();			
			tPoint.x = event.stageX ;
			tPoint.y = event.stageY-50;
			addChild(tPoint);
			finger[event.touchPointID] = tPoint;
			
			play_note( event.touchPointID,event.stageX , event.stageY);
		}
		
		public function onTouchEnd(event:TouchEvent):void
		{			
			var tPoint:Sprite = finger[event.touchPointID] as Sprite;
			this.removeChild(tPoint);
			delete finger[event.touchPointID];
			
			m_keyimg_o[event.touchPointID].visible = true;
			m_keyimg[event.touchPointID].visible = false;
			
			delete m_keyimg[event.touchPointID];		
			delete m_keyimg_o[event.touchPointID];	
		}
		
		public function onTouchMove(event:TouchEvent):void
		{
			var tPoint:Sprite = finger[event.touchPointID] as Sprite;
			tPoint.x=event.stageX;
			tPoint.y=event.stageY-50;
		}
		
		private function play_note(id:Number,key_x:Number,key_y:Number):void
		{
			if (key_y > 550)
				return;
			var img:Sprite;
			for(var i:int = 0; i <m_key_b.length ; i++)
			{
				img = m_key_b[i] as Sprite;
				if ((key_y < 245) 
				&& (key_x >= img.x+m_keyboard.x  && key_x <= img.x +m_keyboard.x  + img.width))
				{
					m_note_b[i].play();	
					img.visible = false;
					m_key_bb[i].visible = true;
					m_keyimg[id] = m_key_bb[i];
					m_keyimg_o[id] = img;
					return;
				}
			}
			
			for(i= 0; i <m_key_w.length ; i++)
			{
				img = m_key_w[i] as Sprite;
				if 	(key_x >= img.x+m_keyboard.x && key_x <= img.x +m_keyboard.x  + 99)
				{
					m_note_w[i].play();
					img.visible = false;
					m_key_ww[i].visible = true;
					m_keyimg[id] = m_key_ww[i];
					m_keyimg_o[id] = img;
					return;
				}
			}					
		}
				
		private function init_sound():void
		{
			for (var i:int = 1 ; i < 45 ; i ++)
				m_note_w.push(new Sound(new URLRequest("res/note/WK/WK_700_"+i+".mp3")));
			for (i = 1 ; i < 32 ; i ++)
				m_note_b.push(new Sound(new URLRequest("res/note/BK/BK_700_"+i+".mp3")));			
		}
		
//		private function on_key(e:Event):void
//		{		
//			for (var i:int = 0; i <10; i++)
//			{
//				if(e.target == m_key_w[i])
//				{	
//					if (i==0)
//						m_snd_btn_1.play();
//					else if (i==1)
//						m_snd_btn_2.play();
//					else if (i==2)
//						m_snd_btn_3.play();
//					else if (i==3)
//						m_snd_btn_4.play();
//					else if (i==4)
//						m_snd_btn_5.play();
//					else if (i==5)
//						m_snd_btn_6.play();
//					else if (i==6)
//						m_snd_btn_7.play();						
//				}
//			}
//		}
	}
}