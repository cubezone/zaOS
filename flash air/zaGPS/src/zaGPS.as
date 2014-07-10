package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.GeolocationEvent;
	import flash.sensors.Geolocation;
	import flash.text.*;
	
	//	import qnx.system.QNXSystem;
	//	import qnx.system.QNXSystemResource;
	import qnx.ui.text.Label;
	
	public class zaGPS extends Sprite
	{
		private var geoTextField:Label = new Label();
		private var geo:Geolocation; 
		public var logField:TextField;
		
		public function zaGPS()
		{			
			geoTextField.width  = stage.width;
			if (Geolocation.isSupported) 
			{ 				
				geo = new Geolocation(); 
				if (geo.muted) {
					geoTextField.text = 'Geolocation muted';
					
				}
				else
				{					
					geo.addEventListener(GeolocationEvent.UPDATE, updateHandler); 
					geo.setRequestedUpdateInterval(1000);
					geoTextField.text = "Ready.."; 				
				}
				//QNXSystem.system.requestResource(QNXSystemResource.GEOLOCATION);				
			} 
			else 
			{ 
				geoTextField.text = "Geolocation feature \n not supported"; 
			} 
			geoTextField.autoSize = "left";
			addChild(geoTextField);
			
			logField = new TextField();
			logField.defaultTextFormat = new TextFormat("_sans", 25);            
			logField.type = TextFieldType.INPUT;
			logField.x = 10;
			logField.y = 300;
			logField.border = true;
			logField.wordWrap = true;
			logField.multiline = true;
			addChild(logField);     
			
			try
			{
				logField.text = "aa";
				stage.addEventListener("orientationChange", orientationChangeListener);
			}
			catch(e:Error)
			{
				log("Stage orientation not supported.");
			}
			
			
			super();			
		}
		
		public function orientationChangeListener(event:Event):void
		{
			resizeLogField();
			log("beforeOrientation:" + event["beforeOrientation"].toString()
				+ "\nafterOrientation:" + event["afterOrientation"].toString());
		}
		
		public function resizeLogField():void
		{
			logField.width = stage.stageWidth - 20;
			logField.height = stage.stageHeight - 20;
		}
		public function log(obj:Object):void
		{
			var date:Date = new Date();
			var time:String = date.hours.toString() + ":" + date.minutes.toString() + ":" + date.seconds.toString();
			logField.text = time + ": " + obj.toString() +"\n";
		}
		
		
		private function updateHandler(event:GeolocationEvent):void 
		{ 
			geoTextField.text  = "enter event..\n";
			geoTextField.text += event.timestamp.toFixed(6)+ "\n";
			geoTextField.text +=  "latitude: " + event.latitude.toString() + "\n";			
			geoTextField.text +=  "longitude: " + event.longitude.toString() + "\n"; 
			geoTextField.text +=  "altitude: " + event.altitude.toString()  + "\n";
			geoTextField.text +=  "speed: " + event.speed.toString()  + "\n" ;
			geoTextField.text +=  "heading: " + event.heading.toString()  + "\n"; 
			geoTextField.text +=  "horizontal accuracy: " + event.horizontalAccuracy.toString() + "\n";  
			geoTextField.text +=  "vertical accuracy: " + event.verticalAccuracy.toString() +"\n";
			
		}
		
	}	
}