package util
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class LabelButton extends Sprite
	{
		private var txt:TextField;
		
		public function LabelButton(label:String)
		{
			super();
			
			txt = new TextField();
			txt.text = label;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.type = TextFieldType.DYNAMIC;
			txt.setTextFormat(new TextFormat("宋体", 12, 0xffffff));
			txt.mouseEnabled = false;
			txt.x = txt.y = 3;
			
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0x333333, 1);
			bg.graphics.drawRoundRect(0, 0, txt.width + 6, txt.height + 6, 6, 6);
			bg.graphics.endFill();
			bg.addChild(txt);
			addChild(bg);
			bg.useHandCursor = bg.buttonMode = true;
		}
	}
}