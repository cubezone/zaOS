package
{
	import baidu.map.basetype.LngLat;
	import baidu.map.basetype.Size;
	import baidu.map.control.base.*;
	import baidu.map.core.Map;
	import baidu.map.layer.Layer;
	import baidu.map.layer.RasterLayer;
	import baidu.map.overlay.InfoWindow;
	import baidu.map.overlay.geometry.*;
	import baidu.map.symbol.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.system.Capabilities;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class zaMap extends Sprite
	{
		public var map:Map = new Map(new Size(1024, 600));
		public var info:InfoWindow = new InfoWindow("InfoWindow的文本内容", new TextFormat("宋体", 14, 0xf0f000), "标题", new TextFormat("黑体", 12, 0x00000, true));
		public var m_x:Number=1;
		public var m_y:Number =1;
		public function zaMap()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
		
			addChild(map);
					// 初始化Map的中心点和显示级别28.			
			//map.centerAndZoom(new LngLat(116.404, 39.915), 12);			
			//map.centerAndZoom(new LngLat(106.404, 37), 5);
			//map.centerAndZoom(new LngLat(118.8, 32.03), 13);
			map.centerAndZoom(new LngLat(-122,47), 5);
						// 添加底图30.			
			var layer:Layer = new RasterLayer("BaiduMap", map);			
			map.addLayer(layer);
			
			var nav:Navigator = new Navigator(map);
			map.addControl(nav);
			// 添加Overview			
			var overview:Overview = new Overview(map);
			map.addControl(overview);
			// 添加Scaler			
			var scaler:Scaler = new Scaler(map);
			map.addControl(scaler);
			// 添加Ruler			
			var ruler:Ruler = new Ruler(map);
			map.addControl(ruler);
			
			var maptype:MapType = new MapType(map);
			map.addControl(maptype);
//			// 创建圆形覆盖物
//			var circle:Circle = new Circle(new LngLat(116.404, 39.915), 100);
//			// 设置圆形覆盖物的样式
//			circle.symbol = new CircleSymbol(0xff00ff, 0.8, 2, 0x00ffff, 0.8);
//			map.addOverlay(circle);
//			map.openInfoWindow(info);
			init_multifstouch();
		}
		
		public function init_multifstouch():void
		{
			
			if (Capabilities.os.indexOf("PlayBook") > -1)
			{			
				
				Multitouch.inputMode = MultitouchInputMode.GESTURE;
				map.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoom);
			} 
		}
		
		public function onZoom(event:TransformGestureEvent):void
		{
				info.title = map.zoom +"\n="+ event.scaleX +"\n=" + event.scaleY;
				if (event.phase==flash.events.GesturePhase.UPDATE)
				{
					m_x *= event.scaleX;
				}
				if (event.phase==flash.events.GesturePhase.END)
				{
					if (m_x > 1)
						map.zoomIn(m_x,m_x);
					if (m_x < 1)
						map.zoomOut(m_x,m_x);
					
					m_x = 1;
				}
				
		}
	}
}