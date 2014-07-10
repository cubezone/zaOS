package zaChineseIME
{
	import flash.display.Sprite;
	import qnx.ui.display.Image;
	public class zaTest  extends Sprite
	{
		private var Img_bg:Image = new Image();
		public function zaTest()
		{
			Img_bg.setImage("zaChineseIME/res/bg3.jpg");
			Img_bg.setPosition( 0, 0);
			addChild(Img_bg);
			
		}
	}
}