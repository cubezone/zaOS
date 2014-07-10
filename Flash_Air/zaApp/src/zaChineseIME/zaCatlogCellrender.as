package  zaChineseIME
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import qnx.ui.display.Image;
	import qnx.ui.listClasses.ICellRenderer;
	import qnx.ui.skins.SkinStates;
	import qnx.ui.skins.UISkin;
	import qnx.ui.text.Label;
	
	public class zaCatlogCellrender extends UISkin implements ICellRenderer
	{
		protected var _beer:Object;
		private var _row:int;
		private var _column:int;
		private var _section:int;
		private var _index:int;    
		
		private var _yOffset:int = 45;
		private var _xOffset:int = 35;
		
		/**
		 * Skins
		 **/
		protected var _upSkin:Sprite;
		protected var _selectedSkin:Sprite;
		protected var _downSkin:Sprite;
		protected var _disabledSkin:Sprite;
		
		/**
		 * Cell Renderer content
		 **/
		// I use a background sprite because I want to
		// make sure it's the lowest layer. Then I can just
		// modify the lowest layer without overwriting the text.
		protected var _background:Sprite;
		protected var _title:Label;
		protected var _updatetime:Label;
		protected var _password:Label;
		
		protected var _image:Image;
		
		protected var _cond:Label=new Label();
		protected var _temp:Label=new Label();
		protected var _wind:Label=new Label();
		protected var _hime:Label=new Label();
		protected var _icon:Image=new Image();
		
		
		
		
		/**
		 * TextFormats
		 **/
		protected var _titleFormat:TextFormat;
		protected var _breweryFormat:TextFormat;
		protected var _beerTypeFormat:TextFormat;
		protected var _ratingTextFormat:TextFormat;
		protected var _avgRatingFormat:TextFormat;
		
		protected var  tempATF:TextFormat;
		protected var  condATF:TextFormat;
		protected var  windTF:TextFormat;
		
		protected var  tempTF:TextFormat;
		protected var 　condTF:TextFormat;
		
		
		public function zaCatlogCellrender()
		{
			super();
			
			var ly:int = 180;
			var lx:int = 55;
		
			/**
			 * CellRenderer Content
			 **/
			_image = new Image();
			_image.x = lx;
			_image.y = 80;
			_image.filters = [new DropShadowFilter(3,45,0x000000,.5,4,4,.5)];
			
			_titleFormat = new TextFormat();
			_titleFormat.color = 0xFFFFAA;
			_titleFormat.size = 30;
			_titleFormat.bold = false;
			_titleFormat.font = "";
			
			_title = new Label();
			_title.x = 12;
			_title.y = 5;
			
			_title.autoSize = "left";
			_title.format = _titleFormat;
			
						
			_titleFormat.size = 30;			
			_titleFormat.color = 0xCCFFEE;
			
			_updatetime = new Label();
			_updatetime.alpha = 0.6;
			_updatetime.x = 180;
			_updatetime.y = 45;
			_updatetime.autoSize = "left";
			_updatetime.format = _titleFormat;
			
			_titleFormat.color = 0xCCFFCC;
			
			_password = new Label();
			_password.x = 180;
			_password.y = 10;
			_password.autoSize = TextFieldAutoSize.NONE;
			_password.format = _titleFormat;
						
			_title.width = 10;	
			_password.width = width-50;
			_updatetime.width = width-100;
			
			_background = new Sprite();
		}		
		
		
		/**
		 * Getters/Setters
		 **/
		
		public function get data():Object
		{
			return _beer;
		}
		
		public function errhand(evt:Event):void 
		{
		}	
		public function set data(data:Object):void
		{				
			_beer = data;
			if (_beer.match)					
				_titleFormat.color = 0xFFFF99;					
			else
				_titleFormat.color = 0x66FF99;			
			_title.format  = _titleFormat;
			
			_title.text = data.cn;	
			
			_title.width = _title.textWidth;
			if (_title.textWidth >200)
				_title.x = 0;
			else 				
				_title.x = (width - _title.width)/2;	
//			_updatetime.text = data.updatetime;						
//			_password.text = data.password;				
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		public function get row():int
		{
			return _row;
		}
		
		public function set row(value:int):void
		{
			_row = value;
		}
		
		public function get column():int
		{
			return _column;
		}
		
		public function set column(value:int):void
		{
			_column = value;
		}
		
		public function get section():int
		{
			return _section;
		}
		
		public function set section(section:int):void
		{
			_section = section;
		}
		
		public function get isHeader():Boolean
		{
			return false;
		}
		
		/**
		 * Overriden Functions
		 */
		
		override protected function initializeStates():void
		{
			// Set up the skin states
			_upSkin = new Sprite();    
			setSkinState(SkinStates.UP,_upSkin);
			
			_downSkin = new Sprite();    
			setSkinState(SkinStates.DOWN,_downSkin);
			setSkinState(SkinStates.DOWN_SELECTED,_downSkin);
			setSkinState(SkinStates.SELECTED,_downSkin);
			
			showSkin(_upSkin);
		}
		
		override protected function setState(state:String):void
		{
			super.setState(state);
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width,height,90/180*Math.PI);
			var matrix2:Matrix = new Matrix();
			matrix2.createGradientBox(width,height,180/180*Math.PI);
			
			// Check to see what state is being set and then draw
			// the graphics on the background Sprite accordingly.
			//if(state == SkinStates.UP)
			{                  

				_background.graphics.clear();
				
				_background.graphics.beginFill(0x002040,0);
				_background.graphics.drawRect(0,0,width,height);
				_background.graphics.endFill();
			
				_background.graphics.beginGradientFill(GradientType.LINEAR,
					[0x444444,0x999999,0x444444],[1,1,1],[0,127,255],matrix2);
						
				_background.graphics.drawRoundRect(5,height - 2,width-10,1,10,10);
				_background.graphics.endFill();
			}
			if(state == SkinStates.DOWN ||
				state == SkinStates.DOWN_SELECTED ||
				state == SkinStates.SELECTED)
			{                     
//				_titleFormat = new TextFormat();
//				_titleFormat.color = 0xFFFF00;
//				_titleFormat.size = 24;
//				_titleFormat.bold = true;
//				_title.format  = _titleFormat;
				
				/*_background.graphics.clear();
				_background.graphics.beginFill(0x444444);
				_background.graphics.drawRect(0,0,width,height);
				_background.graphics.endFill();
				*/
				
				_background.graphics.beginGradientFill(GradientType.LINEAR,
					[0x444444,0x6666FF,0x444444],[1,1,1],[0,127,255],matrix);
							
				//_background.graphics.lineStyle(1,0x666666);
				_background.graphics.drawRoundRect(0,0,width,height-5,10,10);
				_background.graphics.endFill();
			}              
		}
		
		override protected function onAdded():void
		{
			super.onAdded();
			addChild(_background);			
			addChild(_title);
		//	addChild(_updatetime);
		//	addChild(_password);	
		}		

		
		override protected function onRemoved():void
		{
			super.onRemoved();
			removeChild(_background);			
			removeChild(_title);
			//removeChild(_updatetime);
			//removeChild(_password);
		}
	}
}