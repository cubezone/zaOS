package
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
	import qnx.input.IMFConnection;
	
	[SWF(height="600", width="1024", 
     frameRate="30", backgroundColor="#000000")]
	public class zaChineseIME extends Sprite
	{	
		public var m_main:zaMain= new zaMain();
		
		public function zaChineseIME()
		{			
			super();			
			m_main.y = 0;		
			addChild(m_main);						
		}			
	}
}