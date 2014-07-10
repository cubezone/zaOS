
package
{
	import baidu.map.basetype.LngLat;
	import baidu.map.basetype.Size;
	import baidu.map.config.MarkerLayout;
	import baidu.map.core.Map;
	import baidu.map.event.GeometryEvent;
	import baidu.map.layer.Layer;
	import baidu.map.layer.RasterLayer;
	import baidu.map.overlay.InfoWindow;
	import baidu.map.overlay.Label;
	import baidu.map.overlay.Marker;
	import baidu.map.overlay.geometry.Circle;
	import baidu.map.overlay.geometry.Polygon;
	import baidu.map.overlay.geometry.Polyline;
	import baidu.map.symbol.CircleSymbol;
	import baidu.map.symbol.PolylineSymbol;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import util.LabelButton;
	import baidu.map.symbol.PolygonSymbol;
	
	/*
	* Demo：添加各种覆盖物以及修改覆盖物样式等属性的例子。
	* 本例展示了Flash API提供的覆盖物的使用方法。
	*/ 
	public class zaMapc extends Sprite
	{
		private var label:Label;
		private var marker:Marker;
		private var info:InfoWindow;
		private var circle:Circle;
		private var polyline:Polyline;
		private var polygon:Polygon;
		
		public function zaMapc()
		{
			super();
			
			// 舞台设置 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// 创建一个大小为600*400的Map对象
			var map:Map = new Map(new Size(600, 400));
			addChild(map);
			// 初始化Map的中心点和显示级别
			map.centerAndZoom(new LngLat(116.404, 39.915), 12);
			// 添加底图
			var layer:Layer = new RasterLayer("BaiduMap", map);
			map.addLayer(layer);
			
			// 创建文本覆盖物
			var createTextBtn:LabelButton = new LabelButton("添加文本覆盖物");
			addChild(createTextBtn);
			createTextBtn.x = 10;
			createTextBtn.y = 405;
			createTextBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(label){
					return;
				}
				label = new Label("测试文本", new TextFormat("宋体", 14, 0xff0000));
				label.position = new LngLat(116.404, 39.915);
				map.addOverlay(label);
			});
			
			// 改变文本覆盖物偏移值
			var changeTextOffsetBtn:LabelButton = new LabelButton("改变文本覆盖物偏移值");
			addChild(changeTextOffsetBtn);
			changeTextOffsetBtn.x = 120;
			changeTextOffsetBtn.y = 405;
			changeTextOffsetBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!label){
					return;
				}
				label.offset = new Size(50, 50);
			});
			
			// 改变文本覆盖物坐标
			var changeTextPositionBtn:LabelButton = new LabelButton("改变文本覆盖物坐标");
			addChild(changeTextPositionBtn);
			changeTextPositionBtn.x = 270;
			changeTextPositionBtn.y = 405;
			changeTextPositionBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!label){
					return;
				}
				label.offset = new Size(0, 0);
				label.position = new LngLat(116.45, 39.95);
			});
			
			// 设置文本覆盖物文本样式
			var changeTextStyleBtn:LabelButton = new LabelButton("改变文本覆盖物样式");
			addChild(changeTextStyleBtn);
			changeTextStyleBtn.x = 420;
			changeTextStyleBtn.y = 405;
			changeTextStyleBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!label){
					return;
				}
				var labelBg:Sprite = new Sprite();
				labelBg.graphics.beginFill(0x0000ff, 0.8);
				labelBg.graphics.drawRect(0, 0, 100, 100);
				labelBg.graphics.endFill();
				
				label.background = labelBg;
				label.contentStyle = new TextFormat("微软雅黑", 16, 0xff00ff, true);
			});
			
			// 创建Marker覆盖物
			var createMarkerBtn:LabelButton = new LabelButton("添加Marker覆盖物");
			addChild(createMarkerBtn);
			createMarkerBtn.x = 10;
			createMarkerBtn.y = 440;
			createMarkerBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(marker){
					return;
				}
				marker = new Marker();
				marker.position = new LngLat(116.404, 39.915);
				marker.enableDragging = false;
				map.addOverlay(marker);
			});
			
			// 改变Marker覆盖物偏移值
			var changeMarkerOffsetBtn:LabelButton = new LabelButton("改变Marker覆盖物偏移值");
			addChild(changeMarkerOffsetBtn);
			changeMarkerOffsetBtn.x = 120;
			changeMarkerOffsetBtn.y = 440;
			changeMarkerOffsetBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!marker){
					return;
				}
				marker.offset = new Size(50, 50);
			});
			
			// 改变Marker覆盖物坐标
			var changeMarkerPositionBtn:LabelButton = new LabelButton("改变Marker覆盖物坐标");
			addChild(changeMarkerPositionBtn);
			changeMarkerPositionBtn.x = 270;
			changeMarkerPositionBtn.y = 440;
			changeMarkerPositionBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!marker){
					return;
				}
				marker.offset = new Size(0, 0);
				marker.position = new LngLat(116.45, 39.95);
			});
			
			// 改变Marker覆盖物的文本样式
			var changeMarkerStyleBtn:LabelButton = new LabelButton("改变Marker覆盖物样式");
			addChild(changeMarkerStyleBtn);
			changeMarkerStyleBtn.x = 420;
			changeMarkerStyleBtn.y = 440;
			changeMarkerStyleBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!marker){
					return;
				}
				
				var markerBg:Sprite = new Sprite();
				markerBg.graphics.beginFill(0xff0000, 0.8);
				markerBg.graphics.drawRect(0, 0, 100, 100);
				markerBg.graphics.endFill();
				marker.background = markerBg;
				
				var newicon:Sprite = new Sprite();
				newicon.graphics.beginFill(0xf000ff, 1);
				newicon.graphics.moveTo(0, 10);
				newicon.graphics.lineTo(10, 0);
				newicon.graphics.lineTo(20, 10);
				newicon.graphics.lineTo(30, 0);
				newicon.graphics.lineTo(40, 10);
				newicon.graphics.lineTo(20, 30);
				newicon.graphics.lineTo(0, 10);
				marker.icon = newicon;
				
				marker.content = "测试Marker文本";
				marker.contentStyle = new TextFormat("微软雅黑", 12, 0x0000ff, true);
			});
			
			// 改变Marker覆盖物的布局方式 
			var changeMarkerLayoutBtn:LabelButton = new LabelButton("改变Marker覆盖物布局");
			addChild(changeMarkerLayoutBtn);
			changeMarkerLayoutBtn.x = 560;
			changeMarkerLayoutBtn.y = 440;
			changeMarkerLayoutBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!marker){
					return;
				}
				marker.layout = MarkerLayout.RIGHT; 
			});
			
			// 设置Marker覆盖物可拖拽
			var changeMarkerDragBtn:LabelButton = new LabelButton("设置Marker可拖拽");
			addChild(changeMarkerDragBtn);
			changeMarkerDragBtn.x = 700;
			changeMarkerDragBtn.y = 440;
			changeMarkerDragBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!marker){
					return;
				}
				marker.enableDragging = true;
			});
			
			// 弹出InfoWindow
			var createInfoWindowBtn:LabelButton = new LabelButton("打开InfoWindow");
			addChild(createInfoWindowBtn);
			createInfoWindowBtn.x = 10;
			createInfoWindowBtn.y = 475;
			createInfoWindowBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!info){
					info = new InfoWindow("InfoWindow的文本内容", new TextFormat("宋体", 14, 0xf0f000), "标题", new TextFormat("黑体", 12, 0x00000, true));
				}
				map.openInfoWindow(info);
			});
			
			// 改变InfoWindow内容
			var changeInfoWindowBtn:LabelButton = new LabelButton("改变InfoWindow样式");
			addChild(changeInfoWindowBtn);
			changeInfoWindowBtn.x = 110;
			changeInfoWindowBtn.y = 475;
			changeInfoWindowBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!info){
					return;
				}
				info.title = "改变标题";
				info.content = "改变InfoWindow文本内容";
				info.titleStyle = new TextFormat("宋体", 12, 0xff0000);
				info.contentStyle = new TextFormat("宋体", 14, 0x000000, null, true);
				
				var infoBg:Sprite = new Sprite();
				infoBg.graphics.beginFill(0xffff00, 0.8);
				infoBg.graphics.drawRoundRect(0, 0, 100, 100, 8, 8);
				infoBg.graphics.endFill();
				info.background = infoBg;
			});
			
			// 设置InfoWindow可以通过点击地图关掉
			var setInfoWindowBtn:LabelButton = new LabelButton("设置InfoWindow可以通过点击地图关掉");
			addChild(setInfoWindowBtn);
			setInfoWindowBtn.x = 240;
			setInfoWindowBtn.y = 475;
			setInfoWindowBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!info){
					return;
				}
				info.enableCloseOnClick = true;
			});
			
			// 关闭InfoWindow
			var closeInfoWindowBtn:LabelButton = new LabelButton("关闭InfoWindow");
			addChild(closeInfoWindowBtn);
			closeInfoWindowBtn.x = 470;
			closeInfoWindowBtn.y = 475;
			closeInfoWindowBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!info){
					return;
				}
				map.closeInfoWindow();
			});
			
			// 添加圆形几何覆盖物
			var createCircleBtn:LabelButton = new LabelButton("添加圆形几何覆盖物");
			addChild(createCircleBtn);
			createCircleBtn.x = 10;
			createCircleBtn.y = 510;
			createCircleBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(circle){
					return;
				}
				
				circle = new Circle(new LngLat(116.404, 39.915), 7000);
				circle.addEventListener(GeometryEvent.DATA_UPDATE, onCircleDataUpdate);
				map.addOverlay(circle);
			});
			
			// 改变圆形几何覆盖物坐标
			var changeCirclePositionBtn:LabelButton = new LabelButton("改变圆形几何覆盖物坐标");
			addChild(changeCirclePositionBtn);
			changeCirclePositionBtn.x = 140;
			changeCirclePositionBtn.y = 510;
			changeCirclePositionBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!circle){
					return;
				}
				circle.position = new LngLat(116.39, 39.85);
			});
			
			// 改变圆形几何覆盖物半径
			var changeCircleRadiusBtn:LabelButton = new LabelButton("改变圆形几何覆盖物半径");
			addChild(changeCircleRadiusBtn);
			changeCircleRadiusBtn.x = 290;
			changeCircleRadiusBtn.y = 510;
			changeCircleRadiusBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!circle){
					return;
				}
				circle.radius = 10000;
			});
			
			// 改变圆形几何覆盖物的样式
			var changeCircleSymbolBtn:LabelButton = new LabelButton("改变圆形几何覆盖物样式");
			addChild(changeCircleSymbolBtn);
			changeCircleSymbolBtn.x = 440;
			changeCircleSymbolBtn.y = 510;
			changeCircleSymbolBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!circle){
					return;
				}
				circle.symbol = new CircleSymbol(0xff0000, 0.6, 6, 0x0000ff, 0.8);
			});
			
			// 添加折线几何覆盖物
			var createPolylineBtn:LabelButton = new LabelButton("添加折线几何覆盖物");
			addChild(createPolylineBtn);
			createPolylineBtn.x = 10;
			createPolylineBtn.y = 545;
			createPolylineBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(polyline){
					return;
				}
				var coords:Vector.<LngLat> = new Vector.<LngLat>();
				coords.push(new LngLat(116.36, 39.860));
				coords.push(new LngLat(116.405, 39.920));
				
				polyline = new Polyline(coords);
				polyline.addEventListener(GeometryEvent.DATA_UPDATE, onPolylineDataUpdate);
				map.addOverlay(polyline);
			});
			
			// 改变折线几何覆盖物坐标串
			var changePolylineCoordsBtn:LabelButton = new LabelButton("改变折线几何覆盖物坐标串");
			addChild(changePolylineCoordsBtn);
			changePolylineCoordsBtn.x = 140;
			changePolylineCoordsBtn.y = 545;
			changePolylineCoordsBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!polyline){
					return;
				}
				var coords:Vector.<LngLat> = new Vector.<LngLat>();
				coords.push(new LngLat(116.41, 39.860));
				coords.push(new LngLat(116.385, 39.9));
				
				polyline.coords = coords;
			});
			
			// 改变折线几何覆盖物的样式
			var changePolylineSymbolBtn:LabelButton = new LabelButton("改变折线几何覆盖物的样式");
			addChild(changePolylineSymbolBtn);
			changePolylineSymbolBtn.x = 310;
			changePolylineSymbolBtn.y = 545;
			changePolylineSymbolBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!polyline){
					return;
				}
				polyline.symbol = new PolylineSymbol(0x00ff00, 1, 6);
			});
			
			// 添加多边形几何覆盖物
			var createPolygonBtn:LabelButton = new LabelButton("添加多边形几何覆盖物");
			addChild(createPolygonBtn);
			createPolygonBtn.x = 10;
			createPolygonBtn.y = 580;
			createPolygonBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(polygon){
					return;
				}
				var coords:Vector.<LngLat> = new Vector.<LngLat>();
				coords.push(new LngLat(116.36, 39.860));
				coords.push(new LngLat(116.405, 39.920));
				coords.push(new LngLat(116.355, 39.89));
				
				polygon = new Polygon(coords);
				polygon.addEventListener(GeometryEvent.DATA_UPDATE, onPolygonDataUpdate);
				map.addOverlay(polygon);
			});
			
			// 改变多边形几何覆盖物坐标串
			var changePolygonCoordsBtn:LabelButton = new LabelButton("改变多边形几何覆盖物坐标串");
			addChild(changePolygonCoordsBtn);
			changePolygonCoordsBtn.x = 150;
			changePolygonCoordsBtn.y = 580;
			changePolygonCoordsBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!polygon){
					return;
				}
				var coords:Vector.<LngLat> = new Vector.<LngLat>();
				coords.push(new LngLat(116.36, 39.860));
				coords.push(new LngLat(116.405, 39.920));
				coords.push(new LngLat(116.355, 39.89));
				coords.push(new LngLat(116.34, 39.89));
				
				polygon.coords = coords;
			});
			
			// 改变多边形几何覆盖物的样式
			var changePolygonSymbolBtn:LabelButton = new LabelButton("改变多边形几何覆盖物的样式");
			addChild(changePolygonSymbolBtn);
			changePolygonSymbolBtn.x = 330;
			changePolygonSymbolBtn.y = 580;
			changePolygonSymbolBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
				if(!polygon){
					return;
				}
				
				polygon.symbol = new PolygonSymbol(0x00ff00, 1, 6, 0xffff00, 0.4);
			});
		}
		
		/*
		* 当Circle的半径或者中心点改变的时候，会派发GeometryEvent.DATA_UPDATE事件，此时需要主动的去重绘。 
		*/ 
		private function onCircleDataUpdate(evt:GeometryEvent):void{
			circle.draw();
		}
		
		/*
		* 当Polyline的坐标串改变的时候，会派发GeometryEvent.DATA_UPDATE事件，此时需要主动的去重绘。 
		*/ 
		private function onPolylineDataUpdate(evt:GeometryEvent):void{
			polyline.draw();
		}
		
		/*
		* 当Polygon的坐标串改变的时候，会派发GeometryEvent.DATA_UPDATE事件，此时需要主动的去重绘。 
		*/ 
		private function onPolygonDataUpdate(evt:GeometryEvent):void{
			polygon.draw();
		}
	}
}