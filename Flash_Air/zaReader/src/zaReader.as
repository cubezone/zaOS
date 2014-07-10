package
{
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.errors.IOError;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import model.Record;
	
	import qnx.ui.data.DataProvider;
	import qnx.ui.display.Image;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	import qnx.ui.listClasses.ScrollDirection;
	import qnx.ui.listClasses.ScrollPane;
	import qnx.ui.text.Label;

//	import qnx.media.QNXStageWebView;
	
	
	[SWF(height="600", width="1024", 
     frameRate="30", backgroundColor="#000000")]
	public class zaReader extends Sprite
	{	
		[Embed(source="res/bg0.png")] 
		private var aa:Class;

		public var m_main:zaMain;
		
		public var m_login:zaLogin = new zaLogin();
		
		public var m_msg:Label = new Label();	
		private var m_bg2:Image = new Image();
		public var m_bg:int = 5;
		public var spr:Sprite = new Sprite();
		
		public function zaReader()
		{			
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			
			m_bg2.x = 0;
			m_bg2.y = 0;
				
			m_bg2.setImage(new aa());
			
			spr.addChild(m_bg2);
//			var m:Matrix = m_bg2.transform.matrix;
//			m = new Matrix();
//			
//			m.rotate(89.89*Math.PI/180);
//			m.translate(600,200);
//			m_bg2.transform.matrix= m;
//			
			
			addChild(spr);	
			

			m_main = new zaMain(); 
//			if (QNXStageWebView.isSupported)				
//				m_main.addWebview(this.stage);
			m_main.y = 2000;
			
			//m_mainp.visible = false;
			m_login.x = 0;		
		    addChild(m_main);
			addChild(m_login);			
			
			var LabTF:TextFormat;
			LabTF = m_msg.format;
			LabTF.size = 30;
			LabTF.color = 0xFFFFAA;	
			LabTF.bold = false;	
			m_msg.setPosition(110,450);
			m_msg.height = 60;
			m_msg.width = 1000;
			m_msg.format = LabTF;
			m_msg.text = "turn to landscape mode to login";
			addChild(m_msg);
			if (this.stage.stageWidth > 1000)
				m_msg.visible = false;
			else
			{
				m_login.visible = false;
				spr.rotation =90;
				spr.x =600;
			}
			
			﻿stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE,onOrientationChange);
			
		}
		
		public function setBg():void
		{
			this.m_bg ++;
			if (m_bg >5) m_bg = 0;
			m_bg2.setImage("res/bg"+m_bg+".png");
		}
		
		protected function onOrientationChange(event:StageOrientationEvent):void
		{		
			if (this.stage.stageWidth < 1000) 
				if (m_login.y < 1000) 
				{	
					m_msg.visible = true;
					m_login.visible = false;
				}
			
			if (this.stage.stageWidth > 1000) 
				if (m_login.y < 1000) 
				{	
					m_msg.visible = false;
					m_login.visible = true;
				}
	
			if( event["afterOrientation"].toString() == "rotatedRight")
			{						
				m_main.m_layout = 1;
				spr.rotation =90;
				spr.x =600;
			}
			if( event["afterOrientation"].toString() == "rotatedLeft")
			{				
				m_main.m_layout = 2;
				spr.rotation =90;
				spr.x =600;
			}
			if( event["afterOrientation"].toString() == "upsideDown")
			{	
				spr.rotation =0;
				spr.x = 0;
				m_main.m_layout = 3;
			}
			if( event["afterOrientation"].toString() == "default")				
			{		
				spr.rotation =0;
				spr.x = 0;
				m_main.m_layout = 4;
			}
			
			m_main.layout(m_main.m_layout);
		}			

		public function change():void
		{
			m_main.y = 0;					
			m_login.y = 2000 ;
			//Tweener.addTween(m_main,{y:0,transition:"easeOutexpo",alpha:1, delay:0,time:0.7});
			//Tweener.addTween(m_login,{y:600,transition:"easeOutexpo",alpha:0, delay:0,time:0.7});		
		}
		public function changeb():void
		{
			m_main.x = -1024;
			m_main.alpha = 0;
			m_login.x = 0;
			Tweener.addTween(m_main,{x:0,transition:"easeOutexpo",alpha:1, delay:0,time:0.7});
			Tweener.addTween(m_login, {x:1024,transition:"easeOutexpo",alpha:0, delay:0,time:0.7});
			removeChild(m_login);	
		}
		
	}
}