package zaSafeNote
{
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	import qnx.ui.data.DataProvider;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	import qnx.ui.listClasses.ScrollDirection;
	import qnx.ui.listClasses.ScrollPane;
	import qnx.ui.text.Label;
	
	
	[SWF(height="600", width="1024", 
     frameRate="30", backgroundColor="#444444")]
	public class zaSafeNote extends Sprite
	{	
		public var m_main:zaMain= new zaMain();
		public var m_login:zaLogin= new zaLogin();	
		
		public function zaSafeNote()
		{			
			super();
			
			m_main.y = 600;
			m_login.x = 0;		
			addChild(m_main);			
			addChild(m_login);			
			
		}	
		public function change():void
		{
			m_main.y = 600;
			m_login.x = 0;
			m_login.alpha = 0;
			Tweener.addTween(m_main,{y:0,transition:"easeOutexpo",alpha:1, delay:0,time:0.7});
			Tweener.addTween(m_login,{y:600,transition:"easeOutexpo",alpha:0, delay:0,time:0.7});								
		}
		public function changeb():void
		{
			m_main.x = -1024;
			m_main.alpha = 0;
			m_login.x = 0;
			Tweener.addTween(m_main,{x:0,transition:"easeOutexpo",alpha:1, delay:0,time:0.7});
			Tweener.addTween(m_login, {x:1024,transition:"easeOutexpo",alpha:0, delay:0,time:0.7});						
		}
		
	}
}