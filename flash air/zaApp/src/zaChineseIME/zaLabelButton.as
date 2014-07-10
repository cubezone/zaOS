package zaChineseIME
{
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.display.Image;
	import qnx.ui.text.Label;

	public class zaLabelButton extends Sprite
	{
		[Embed(source="zaChineseIME/res/btn_copy_b.png")] 
		private var copy_bb:Class;
		[Embed(source="zaChineseIME/res/bb.png")] 
		private var bb:Class;
		[Embed(source="zaChineseIME/res/btn_copy.png")] 
		private var copy:Class;
		[Embed(source="zaChineseIME/res/aa.png")] 
		private var aa:Class;

		public var m_char:String = "";
		public var m_img_b:Image = new Image();
		public var m_img:Image = new Image();
		public var m_lable:Label = new Label();
		public function zaLabelButton()
		{
			
			setstyle("","A");
		}
		public function showdown():void
		{
			var a:TextFormat = m_lable.format;
			a.color=0xFFFFFFFF;
			m_lable.format = a;
			m_img.visible=false;
		}
		public function showup():void
		{
			var a:TextFormat = m_lable.format;
			a.color=0x00000000;
			m_lable.format = a;
			m_img.visible=true;
		}
		
		public function setstyle(img:String,c:String):void
		{
			if(c.length>1 && c.length <7)
			m_img_b.setImage(new copy_bb());
				else
			m_img_b.setImage(new bb());		
			m_img_b.setPosition(0,0);
			
			if(c.length>1 && c.length <7)
				m_img.setImage(new copy());
			else
				m_img.setImage(new aa());
			m_img.setPosition(0,0);
			
			addChild(m_img_b);
			addChild(m_img);
			
			m_lable.autoSize = TextFieldAutoSize.RIGHT;
			m_lable.text = c;
			var a:TextFormat = m_lable.format;
			var ss:TextFormat;

			a.color=0xFFFFFFFF;
			m_lable.height = 60;
			if(c.length>1)
			{
				a.size = 20;
				m_lable.format = a;
				m_lable.setPosition(10,15);	

			}
			else
			{
				a.size = 30;
				m_lable.format = a;
				m_lable.setPosition(30,8);	
			}
			
			if(c.length>1 && c.length <7)
				m_lable.setPosition(25,17);	
			
			m_lable.mouseEnabled = false;
			m_lable.mouseChildren = false;
			addChild(m_lable);
			showup();
		}
	}
}