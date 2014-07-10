
package 
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
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
		protected var _filename:Label;
		protected var _filesize:Label;
		protected var _dirflag:Label;
		
		protected var _image:Image;
		protected var _icon:Image=new Image();
		
		protected var _cond:Label=new Label();
		protected var _temp:Label=new Label();
		protected var _wind:Label=new Label();
		protected var _hime:Label=new Label();

		
		
		
		
		/**
		 * TextFormats
		 **/
		protected var _filenameFormat:TextFormat;
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
			_image.x = 535;
			_image.y = 15;
			_image.filters = [new DropShadowFilter(3,45,0x000000,.5,4,4,.5)];
			_image.setImage("res/tag.png");
			
			_icon = new Image();
			_icon.x = 10;
			_icon.y = 15;
			_icon.filters = [new DropShadowFilter(3,45,0x000000,.5,4,4,.5)];
			
			
			_filenameFormat = new TextFormat();
			_filenameFormat.color = 0xFFFFFF;
			_filenameFormat.size = 20;
			_filenameFormat.bold = false;
			
			_filename = new Label();
			_filename.x = 60;
			_filename.y = 10;
			_filename.width = 490;
			_filename.format = _filenameFormat;
			
			_filenameFormat.size = 18;
			
			_filenameFormat.color = 0xFFFFFF;
			_filesize = new Label();
			_filesize.alpha = 0.6;
			_filesize.x = 480;
			_filesize.y = 35;
			_filesize.autoSize = "left";
			_filesize.format = _filenameFormat;
			
			_filenameFormat.color = 0xFFFFFF;
			
			_dirflag = new Label();
			_dirflag.x = 60;
			_dirflag.y = 35;
			_dirflag.height = 60;
			_dirflag.autoSize = TextFieldAutoSize.NONE;
			_dirflag.format = _filenameFormat;
			
			_filesize.width = width-70;
			
			_image.visible = false;
			
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
			var f:File = data as File;
		
			_filename.text = f.name;	
			if (f.isDirectory)
			{
				_dirflag.text = "D";
				_filenameFormat = _filename.format;
				_filenameFormat.color = 0xAAFFAA;
				_filename.format = _filenameFormat;
				_icon.setImage("res/a.png");
				_filesize.text ="";
			}
			
			else
			{
				
				if (f.extension == null ||
				 f.extension.toLowerCase() != "txt" &&
				 f.extension.toLowerCase() != "epub")
				{					
					_dirflag.text = "U";
					_filenameFormat = _filename.format;
					_filenameFormat.color = 0xAAAAAA;
					_filename.format = _filenameFormat;
					_icon.setImage("res/b.png");
					_icon.alpha = 0.5;
				}
				else
				{
					_dirflag.text = "R";
					_filenameFormat = _filename.format;
					_filenameFormat.color = 0xFFFFFF;
					_filename.format = _filenameFormat;	
					_icon.setImage("res/c.png");
				}
			_filesize.text =  Math.ceil((f.size/1024)).toString() +"K";			
			}							
							
			_background.graphics.clear();				
			if (this.index % 2 == 0)
			{
				_background.graphics.beginFill(0x003366,1);
				_background.graphics.drawRect(0,0,width,height);				
				_background.graphics.endFill();
			}
			
			var matrix2:Matrix = new Matrix();
			matrix2.createGradientBox(width,height,180/180*Math.PI);
			_background.graphics.beginGradientFill(GradientType.LINEAR,
				[0xFFFFFF,0x80BCCE,0x005B8E],[1,1,1],[0,127,255],matrix2);
			_background.graphics.drawRoundRect(5,0,width-10,1,10,10);
			_background.graphics.endFill();
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
			_image.visible = false;
			// Check to see what state is being set and then draw
			// the graphics on the background Sprite accordingly.
			//if(state == SkinStates.UP)
			{                  
				;
//				_filenameFormat = new TextFormat();
//				_filenameFormat.color = 0xAAAAAA;
//				_filenameFormat.size = 24;
//				_filenameFormat.bold = true;
//				_filename.format  = _filenameFormat;				
				
				_background.graphics.clear();				
				if (this.index % 2 == 0)
				{
				_background.graphics.beginFill(0x003366,1);
				_background.graphics.drawRect(0,0,width,height);				
				_background.graphics.endFill();
				}
				else
				{
					_background.graphics.beginFill(0x003366,0);
					_background.graphics.drawRect(0,0,width,height);				
					_background.graphics.endFill();
				}
				
				_background.graphics.beginGradientFill(GradientType.LINEAR,
					[0xFFFFFF,0x80BCCE,0x005B8E],[1,1,1],[0,127,255],matrix2);
				_background.graphics.drawRoundRect(5,0,width-10,1,10,10);
				_background.graphics.endFill();
			}
			if(state == SkinStates.DOWN ||
				state == SkinStates.DOWN_SELECTED ||
				state == SkinStates.SELECTED)
			{                     
				_image.visible = true;
//				_filenameFormat = new TextFormat();
//				_filenameFormat.color = 0xFFFF00;
//				_filenameFormat.size = 24;
//				_filenameFormat.bold = true;
//				_filename.format  = _filenameFormat;
				
				/*_background.graphics.clear();
				_background.graphics.beginFill(0x444444);
				_background.graphics.drawRect(0,0,width,height);
				_background.graphics.endFill();
				*/
//				
//				_background.graphics.beginGradientFill(GradientType.LINEAR,
//					[0x005B8E,0x3360BA,0x6666FF],[1,1,1],[0,190,255],matrix);
//							
//				//_background.graphics.lineStyle(1,0x666666);
//				_background.graphics.drawRoundRect(5,5,width-10,height-10,10,10);
//				_background.graphics.endFill();
			}              
		}
		
		override protected function onAdded():void
		{
			super.onAdded();
			addChild(_background);			
			addChild(_filename);
			addChild(_filesize);
			addChild(_dirflag);	
			addChild(_image);
			addChild(_icon);
		}		

		
		override protected function onRemoved():void
		{
			super.onRemoved();
			removeChild(_background);			
			removeChild(_filename);
			removeChild(_filesize);
			removeChild(_dirflag);
			removeChild(_image);
			removeChild(_icon);
		}
	}
}