package {
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Sound;
	import flash.media.Video;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	import org.osmf.traits.TimeTrait;
	
	import qnx.events.QNXApplicationEvent;
	import qnx.system.*;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.buttons.ToggleSwitch;
	import qnx.ui.display.Image;
	import qnx.ui.progress.ActivityIndicator;
	import qnx.ui.text.Label;
	import qnx.ui.text.TextInput;
	
	[SWF(height="700", width="1024", 
	frameRate="30", backgroundColor="#444444")]	
	
	public class zaCamera extends Sprite {
		private var video:Video;
		private var snapshot:BitmapData;
		
		private var m_timerarm:Timer;
		private var m_timershot:Timer;
		
		private var Img_a:Image = new Image();
		private var Img_b:Image = new Image();
		private var Img_c:Image = new Image();
		private var Img_bg:Image = new Image();
		
		private var ts_shotmode:ToggleSwitch= new ToggleSwitch();
		private var ta_begin:TextField= new TextField();
		private var ta_shot:TextField= new TextField();
		
		
		private var btn_shot:LabelButton = new LabelButton();
		private var btn_reset:LabelButton = new LabelButton();
		private var btn_save:LabelButton = new LabelButton();
		private var btn_hide:LabelButton = new LabelButton();
		private var btn_menu:LabelButton = new LabelButton();
		private var lb_save:Label = new Label();
		private var m_email:Label = new Label();
		private var m_bg:Sprite= new Sprite();
		private var LabTF:TextFormat = new TextFormat();
		private var m_bmps:Array=[];;
		private var m_file_name:String="DSC";
		private var m_shotmode:String = "Auto";
		private var m_mode :int=2;
		private var m_progress:ActivityIndicator;
		private var m_cameraname:String="1";
		
		private var m_pos:Array=[];
				
		public function zaCamera() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
				
			m_pos.push({x:30,y:120});
			m_pos.push({x:30 + 320 ,y:120});
			m_pos.push({x:30 + 320*2 ,y:120});
			m_pos.push({x:30,y:120+230 });
			m_pos.push({x:30 + 320 ,y:120+230 });
			m_pos.push({x:30 + 320*2 ,y:120+230 });
			
			m_pos.push({x:30,y:120});
			m_pos.push({x:30 + 320 ,y:120});
			m_pos.push({x:30 + 320*2 ,y:120});
			m_pos.push({x:30,y:120+230 });
			m_pos.push({x:30 + 320 ,y:120+230 });
			m_pos.push({x:30 + 320*2 ,y:120+230 });
			
			m_pos.push({x:20,y:120});
			m_pos.push({x:20 + 320 +10 ,y:120});
			m_pos.push({x:20 + 320*2 + 20 ,y:120});
			m_pos.push({x:20,y:120+230 +10 });
			m_pos.push({x:20 + 320 +10 ,y:120+230 +10});
			m_pos.push({x:20 + 320*2 + 20  ,y:120+230 +10});
			
			Img_bg.setImage("res/bg.jpg");
			Img_bg.setPosition( 0, 0);
			addChild(Img_bg);
			
			Img_a.setImage("res/A.png");
			Img_a.setPosition( 50, 27);
			Img_a.buttonMode = true;
			Img_a.addEventListener(MouseEvent.CLICK,onMode);
			addChild(Img_a);
			
			Img_b.setImage("res/B.png");
			Img_b.setPosition( 150, 25);
			Img_b.buttonMode = true;
			Img_b.addEventListener(MouseEvent.CLICK,onMode);
			addChild(Img_b);
			
			Img_c.setImage("res/C.png");
			Img_c.setPosition( 250, 25);
			Img_c.buttonMode = true;
			Img_c.addEventListener(MouseEvent.CLICK,onMode);
			addChild(Img_c);
			
			ts_shotmode.x = 400;
			ts_shotmode.y = 30;
			ts_shotmode.defaultLabel = "manual";
			ts_shotmode.selectedLabel = "Auto";
			addChild(ts_shotmode);
			
			var tf:TextFormat = ta_begin.defaultTextFormat;
			tf.size=24;
			tf.align=flash.text.TextFormatAlign.CENTER;
			ta_begin.defaultTextFormat = tf;					
			ta_begin.textColor = 0xCCCCCC;				
			ta_begin.x = 580;
			ta_begin.y = 33;
			ta_begin.height = 35;
			ta_begin.width = 110;	
			ta_begin.background = true;
			ta_begin.backgroundColor = 0x555555;
			ta_begin.alwaysShowSelection = true;
			ta_begin.type = TextFieldType.INPUT;
			ta_begin.text = "3";
			addChild(ta_begin);
			
			ta_shot.defaultTextFormat = tf;		
			ta_shot.textColor = 0xCCCCCC;
			ta_shot.x = 720;
			ta_shot.y = 33;
			ta_shot.height = 35;
			ta_shot.width = 110;			
			ta_shot.background = true;
			ta_shot.backgroundColor = 0x555555;
			ta_shot.alwaysShowSelection = true;
			ta_shot.type = TextFieldType.INPUT;
			ta_shot.text = "2";
			addChild(ta_shot);
			
			m_bg=new Sprite();
			m_bg.graphics.beginFill(0xFFFFFF,1);
			m_bg.graphics.drawRect(0,0,320*3 + 20,230*2 +20);			
			m_bg.graphics.endFill();
			var bg:Image = new Image();
			bg.setImage("res/sd.jpg");			
			bg.setPosition(10,240);
			m_bg.addChild(bg);
			m_bg.x= 20;
			m_bg.y= 10 +100;
			m_bg.width=320*3 + 20;
			m_bg.height=230*2 +20;		
			addChild(m_bg);
//			QNXApplication.qnxApplication.addEventListener(qnx.events.QNXApplicationEvent.SWIPE_DOWN, openAddMenu);
			trace(Camera.names);
			var camera:Camera = Camera.getCamera(m_cameraname);
			if (camera == null)
			{
				camera = Camera.getCamera();
			}
			if (camera != null) {
				
				camera.setMode(320*2,230*2,20);
				camera.addEventListener(ActivityEvent.ACTIVITY, activityHandler);
				video = new Video(camera.width/2, camera.height/2);
				video.attachCamera(camera);				
				
				video.x = 30;
				video.y = 20+ 100;
				addChild(video);
				snapshot =new BitmapData(video.width,video.height);	
				
				btn_shot.label = "Shot";
				btn_shot.setPosition(750,520+ 100);
				btn_shot.addEventListener(MouseEvent.CLICK,onbtn_shot);
				addChild(btn_shot);
				
				btn_hide.label = "Front Camera";
				btn_hide.setPosition(500,520+ 100);
				btn_hide.addEventListener(MouseEvent.CLICK,onbtn_changecamera);
				addChild(btn_hide);
				
				btn_reset.label = "Reset";
				btn_reset.setPosition(350,520+ 100);
				btn_reset.width =120;
				btn_reset.addEventListener(MouseEvent.CLICK,onbtn_reset);
				addChild(btn_reset);
				
				btn_save.label = "Save";
				btn_save.setPosition(200,520+ 100);
				btn_save.width =120;
				btn_save.addEventListener(MouseEvent.CLICK,onbtn_save);
				btn_save.enabled = false;
				addChild(btn_save);
				
				btn_menu.label = "Menu";
				btn_menu.setPosition(60,520+ 100);
				btn_menu.width =120;
				btn_menu.addEventListener(MouseEvent.CLICK,onbtn_menu);
				addChild(btn_menu);
				
				
				LabTF.size = 20;
				LabTF.color = 0xFFFF88;	
				lb_save.format = LabTF;
				lb_save.text = "";
				lb_save.x = (1024 - lb_save.textWidth)/2;
				lb_save.y = 565 + 100;		
				lb_save.width = 400;
				lb_save.height = 30;
				addChild(lb_save);
				
				LabTF.size = 20;
				LabTF.color = 0x88FF88;				
				m_email.x = 420;
				m_email.y = 565 + 100;		
				m_email.width = 380;
				m_email.height = 30;
				m_email.format = LabTF;
				m_email.text="bbcubezone@gmail.com";
			//	addChild(m_email);				
				m_progress = new ActivityIndicator();
				m_progress.x = 480;
				m_progress.y = 580;
				m_progress.width = 50;
				m_progress.height = 50;											
				//addChild(m_progress);				
			} else {
				trace("You need a camera.");
			}
			y = -100;
		}
		
		private function onbtn_shot(event:MouseEvent):void
		{
			if (this.ts_shotmode.selected)
			{
				this.btn_shot.enabled = false;
				this.playbtnpress();
				this.m_timerarm = new Timer(Number(ta_begin.text)*1000,1);
				m_timerarm.addEventListener(TimerEvent.TIMER_COMPLETE,ontimer);
				this.m_timerarm.start();				
			}
			else
				takeSnapshot(event);
		}
		
		private function onbtn_reset(event:MouseEvent):void
		{	
			playbtnpress();
			for (var i:int = 0; i < m_bmps.length ; i ++)
				removeChild(m_bmps[i]);
			m_bmps =[];
			video.x = 30;
			video.y = 20 + 100;
			video.visible = true;
			btn_save.enabled = false;
			lb_save.text ="";
		}		
		
		private function onbtn_menu(event:MouseEvent):void
		{
			if (btn_menu.label=="Menu")
			{	
				btn_menu.label = "Hide";				
				btn_menu.setPosition(850,30);
			}
			else
			{
				btn_menu.label = "Menu";
				btn_menu.setPosition(60,520+ 100);
			}
			
			openAddMenu(null);
		}
		
		private function onbtn_save(event:MouseEvent):void
		{					
			playbtnpress();
			m_progress.animate(true);
			lb_save.text = "saving... ";
			lb_save.x = (1024 - lb_save.textWidth)/2;
			this.btn_save.enabled = false;
			
			var t:Timer = new Timer(100,1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE,savetimer);
			function savetimer(e:TimerEvent):void
			{
				savephoto();			
				m_progress.animate(false);
				btn_save.enabled = true;
			}
			t.start();
		}

		private function onbtn_changecamera(event:MouseEvent):void
		{		
			playbtnpress();
			video.attachCamera(null);
			if (m_cameraname=="1")
			{
				m_cameraname ="0";
				btn_hide.label = "Rear Camera";
			}
			else
			{
				m_cameraname = "1";
				btn_hide.label = "Front Camera";
			}
			var camera:Camera = Camera.getCamera(m_cameraname);		
			camera.setMode(320*2,230*2,20);						
			camera.addEventListener(ActivityEvent.ACTIVITY, activityHandler);			
			video.attachCamera(camera);				
		}
		
		private function activityHandler(event:ActivityEvent):void {
			trace("activityHandler: " + event);
		}
		
		private function ontimer(e:TimerEvent):void{
			playbtnpress();
			this.m_timershot = new Timer(Number(ta_shot.text)*1000,6);
			m_timershot.addEventListener(TimerEvent.TIMER,ontimershot);
			m_timershot.addEventListener(TimerEvent.TIMER_COMPLETE,ontimershotcomplete);
			this.m_timershot.start();			
		}
	
		private function ontimershot(e:TimerEvent):void{
			this.takeSnapshot(null);
		}
		private function ontimershotcomplete(e:TimerEvent):void{
			this.btn_shot.enabled = true;			
		}
		
		public function onMode(event:MouseEvent):void {
			if (event.target == Img_a)
			{
				m_mode = 1;
			}
			if (event.target == Img_b)
			{
				m_mode = 2;
			}
			if (event.target == Img_c)
			{
				m_mode = 3;
			}
			setMode();
		}
		
		public function setMode():void
		{
			if (m_mode == 1)
			{
				m_bg.visible = false;
				
			}
			if (m_mode == 2)
			{
				m_bg.visible = true;
				m_bg.x = 20;
				m_bg.width = 320*3+20;
				m_bg.height = 230*2+20;
			}				
			if (m_mode == 3)		
			{
				m_bg.visible = true;
				m_bg.x = 10;
				m_bg.width = 320*3+40;
				m_bg.height = 230*2+30;
			}
			relayout();			
		}
		
		public function relayout():void
		{
			var i:int=0;
			for (i ;i < m_bmps.length; i++)
			{
				Tweener.addTween(m_bmps[i],
					{x:m_pos[(m_mode-1)*6+i].x ,
					 y:m_pos[(m_mode-1)*6+i].y ,
					transition:"linear",alpha:1, delay:0,time:0.3});				
			}
			
			if ( m_bmps.length <6)
				Tweener.addTween(video,
					{x:m_pos[(m_mode-1)*6+i].x ,
						y:m_pos[(m_mode-1)*6+i].y ,
						transition:"linear",alpha:1, delay:0,time:0.3});	
		}
			
		public function openAddMenu(event:QNXApplicationEvent):void {
			if ( y < 0)
				Tweener.addTween(this,{y:0,transition:"linear",alpha:1, delay:0,time:0.3});			
			else 
				Tweener.addTween(this,{y:-100,transition:"linear",alpha:1, delay:0,time:0.3});
		}

		private function savephoto():void
		{
			
			var jpgencode:JPGEncoder =new JPGEncoder(100);					
			var streamw:FileStream = new FileStream();
			var l_out:String = new String();
			
			var six_snapshot:BitmapData;
			var l_x:int ;
			var l_y:int ;
			
			m_file_name = "CG" + getDT(new Date());
			if(m_mode ==1)
			{
				l_x = video.width*3 ;
				l_y = video.height*2 ;
			}
			if(m_mode ==2)
			{	l_x = video.width*3 + 20;
				l_y = video.height*2 + 20;
			}
			if(m_mode ==3)
			{	
				l_x = video.width*3 + 40;
				l_y = video.height*2 + 30;
			}
			
			six_snapshot = new BitmapData(l_x,l_y);
			
			six_snapshot.fillRect(new Rectangle(0,0,l_x,l_y),0xFFFFFFFF);
			
			for (var i:int = 0 ; i<	m_bmps.length ; i ++)
			{
				var l_bmp:Bitmap = m_bmps[i];
				
				if(m_mode ==1)
				{
					l_x = 30;
					l_y = 120;
				}
				if(m_mode ==2)
				{
					l_x = 20;
					l_y = 110;
				}					
				if(m_mode ==3)
				{
					l_x = 10;
					l_y = 110;
				}
				
				six_snapshot.copyPixels(l_bmp.bitmapData,
					new Rectangle(0,0,l_bmp.width,l_bmp.height),
					new Point(l_bmp.x-l_x,l_bmp.y-l_y));				
			}				
			
			File.documentsDirectory.parent.resolvePath("photos/CameraGun").createDirectory();
			l_out = "photos/CameraGun/"+m_file_name+"-"+m_bmps.length+ ".jpg";
			six_snapshot.lock();
			
			for(var a:int = 0;  a< six_snapshot.width;a ++ )
			{
				for(var b:int = 0; b< six_snapshot.height; b ++ )
				{						
						var t:uint = six_snapshot.getPixel(a,b);
						var c:uint = ((t & 0xFF0000)/0x10000 + (t & 0x00FF00)/0x100 + (t & 0xFF))/3;
						
						c = c - c%40;
						
						c = c*0x10000+ c*0x100 + c;
						
						six_snapshot.setPixel(a,b,c);						
				}
			}
			six_snapshot.unlock();
			streamw.open(File.documentsDirectory.parent.resolvePath(l_out),FileMode.WRITE);			
			streamw.writeBytes(jpgencode.encode(six_snapshot));
			streamw.close();
			
			lb_save.text =  m_file_name +".jpg saved.";
			lb_save.x = (1024 - lb_save.textWidth)/2;
		}
		

		private function hidecamera(event:MouseEvent):void
		{
			video.visible = ! video.visible;
			if(video.visible)
				btn_hide.label = "Hide Camera";
			else
				btn_hide.label = "Show Camera";						
		}
		
	
		
		public function playshotpress():void
		{
			var _soundObj:Sound = new Sound(); 		
			_soundObj.load(new URLRequest("res/Laser.mp3"));  
			_soundObj.play(); 
			//	_soundObj.addEventListener(IOErrorEvent.IO_ERROR,onError);
		}
		
		public function playbtnpress():void
		{
			var _soundObj:Sound = new Sound(); 		
			_soundObj.load(new URLRequest("res/btn121.mp3"));  
			_soundObj.play(); 
			//	_soundObj.addEventListener(IOErrorEvent.IO_ERROR,onError);
		}
		
	
		
		private function takeSnapshot(event:MouseEvent):void
		{
			playshotpress();
			if (m_bmps.length == 6)
			{
				btn_shot.label = "Shot full, Try reset" ;				
				return
			}
			//draw the current state of the Video object into 
			//the bitmap object with no transformations applied
			snapshot.draw(video,new Matrix());
			var bmp:Bitmap = new Bitmap(snapshot.clone());
			bmp.width = video.width;
			bmp.height = video.height;			
			
			var n:int = m_bmps.length;
			
			Tweener.addTween(bmp,
				{x:m_pos[(m_mode-1)*6+n].x ,
					y:m_pos[(m_mode-1)*6+n].y ,
					transition:"linear",alpha:1, delay:0,time:0.3});			
			
			m_bmps.push(bmp);
			
			n++;
			
			btn_shot.label = "Shot " +m_bmps.length ;
			
			if (n==6)
			{
				btn_shot.label = "Shot full!" ;
				btn_save.enabled = true;
				video.visible = false;
			} 			
			else
			{
				Tweener.addTween(video,
					{x:m_pos[(m_mode-1)*6+n].x ,
						y:m_pos[(m_mode-1)*6+n].y ,
						transition:"linear",alpha:1, delay:0,time:0.3});
				
			}
			addChild(bmp);				
		}
				
		private function getDT(d:Date):String
		{
			var date:Number = d.getDate();
			var month:Number = d.getMonth();
			var hours:Number = d.getHours();
			var minutes:Number = d.getMinutes();
			var seconds:Number = d.getSeconds();
			var sb:String = new String();
			sb += d.getFullYear();
			if (month + 1 < 10)
			{
				sb += "0";
			}
			sb += month + 1;
			
			if (date < 10)
			{
				sb += "0";
			}
			sb += date;
			
			if (hours < 10)
			{
				sb += "0";
			}
			sb += hours;
			
			if (minutes < 10)
			{
				sb += "0";
			}
			sb += minutes;
			
			if (seconds < 10)
			{
				sb += "0";
			}
			sb += seconds;
			return sb;
		}
	}
}