package
{
	import com.riaidea.utils.zip.*;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	public class zaePubFile extends Sprite 
	{
		public var zip:ZipArchive = new ZipArchive();
		public var cnt:XML; 
		public var f_load:Function = null;
		public var f_unZip:Function = null;

		public var m_pagenum:int = 0;
		public var m_filename:String = "";
		public var m_unzipnum:int =0;
		public var m_cssfilename:Array = []; //css 文件列表
		
		private var m_ebook_path:String = ""; //书内容的目录		
		private var m_content_opf:String = ""; //opf 文件名  含目录.
		private var m_toc_ncx:String = "";   //ncx 文件名  含目录.
		public var m_cover_image:String = "";   //image path		
		
		public var m_epubpages:Array=[];    //书章节 文件名  含目录.
		
		public function zaePubFile()
		{
			m_pagenum= -1;
	//		this.addEventListener("onzip",processZip);
			this.addEventListener("zipprocess",onprocessZip);
		}
		public function nextpage():void
		{
			m_pagenum ++ ;
			if ( m_pagenum == m_epubpages.length ) 
				m_pagenum = 0;
		}
		public function gotoPage(n:int):void
		{
			m_pagenum = n ;
		}
		public function prepage():void
		{
			m_pagenum -- ;
			if ( m_pagenum < 0) 
				m_pagenum = m_epubpages.length -1 ;
		}
		
		public function test(file:String):void
		{
			m_filename = file;
			zip = new ZipArchive();
			handleEvents(zip, true);
			zip.addEventListener(ZipEvent.PROGRESS,onzipload);
			zip.load(file);
		}
	
		public function onzipload(e:ZipEvent):void
		{
			f_unZip(e.message.bytesLoaded);
			//this.dispatchEvent(new Event("onzip"));
		}
		
		public function onprocessZip(e:Event):void
		{
			if (f_unZip != null)
				f_unZip(m_unzipnum);
			var a:Timer = new Timer(50,1);
			a.addEventListener(TimerEvent.TIMER_COMPLETE,processZip);
			a.start();
			//this.dispatchEvent(new Event("onzip"));
		}
		
		public function processZip(e:Event):void
		{
			
			if (m_unzipnum == 0)
				m_cssfilename =[];
			
			var f:ZipFile = zip.getFileAt(m_unzipnum);
			
			if (f.isDirectory())
			{
				File.applicationStorageDirectory.resolvePath(f.name).createDirectory();
			}
			else
			{
				var des:File = File.applicationStorageDirectory.resolvePath(f.name);
				
				var streamw:FileStream = new FileStream();
				streamw.open(des,FileMode.WRITE);
				var l_bs :ByteArray = new ByteArray();				
				streamw.writeBytes(f.data);
				streamw.close();	
				if (des.extension !=null && des.extension.toLowerCase() == "css")
				{
					m_cssfilename.push(des.nativePath);
					des.copyTo( File.applicationStorageDirectory.resolvePath(f.name+".bak"),true);																
				}
			}		
			
			if (m_unzipnum < zip.numFiles-1 )
			{
				m_unzipnum++;				
				this.dispatchEvent(new Event("zipprocess"));
			}
			else
			{
				var xmlFile:ZipFile = zip.getFileByName("META-INF/container.xml");
				var xml:XML = new XML(xmlFile.data);
				readNodescontainer(xml);
				
				xmlFile = zip.getFileByName(this.m_content_opf);
				xml = new XML(xmlFile.data);
				this.readNodescontent_opf(xml);
				
				if (m_content_opf.indexOf("/")>0)
					m_ebook_path = m_content_opf.substr(0,m_content_opf.indexOf("/")+1);
				
				this.m_toc_ncx = m_ebook_path + this.m_toc_ncx;
				
				m_epubpages =[];
				xmlFile = zip.getFileByName(this.m_toc_ncx);
				xml = new XML(xmlFile.data);
				this.readNodestoc_ncx(xml);			
				
				if (f_load != null)
					f_load();
				m_unzipnum = 0;
			}
		}
		
		public function modifyCSS(bgcolor:String, fontcolor:String):void
		{
			for (var i:int = 0 ;i < m_cssfilename.length ; i++)
			{
				var src:File = File.applicationStorageDirectory.resolvePath(m_cssfilename[i]+".bak");
				var des:File = File.applicationStorageDirectory.resolvePath(m_cssfilename[i]);
				var streamw:FileStream = new FileStream();
				var streamr:FileStream = new FileStream();
				streamr.open(src,FileMode.READ);
				streamw.open(des,FileMode.WRITE);
				var l_bs :ByteArray = new ByteArray();
				var ss: String = "";
				ss = streamr.readMultiByte(streamr.bytesAvailable,"UTF-8");
				
				ss = ss.toLocaleLowerCase();
				
				var pos:int = ss.indexOf("body");
				var ss_des:String = "";
			
				if (pos > 0)
				{
					ss_des = ss.substr(0,pos);
					ss = ss.substr(pos);
					pos = ss.indexOf("}");
					ss_des = ss_des.concat(ss.substr(0,pos));
					ss_des = ss_des.concat("background-color:"+bgcolor+"; " + 
						"color:"+fontcolor+";");					
					ss_des = ss_des.concat(ss.substr(pos));					
					ss_des = ss_des.concat("body{background-color:"+bgcolor+"; color:"+fontcolor+";}");
				}
				else
					ss_des = ss_des.concat("body{background-color:"+bgcolor+"; color:"+fontcolor+";}");
				
				streamw.writeMultiByte(ss_des,"UTF-8");
				streamr.close();
				streamw.close();
			}
		}
		
		private function processZip_bak():void
		{
			
			//显示zip文件的详细文件信息
			trace(zip.toComplexString());
			
			m_cssfilename =[];
			
			for(var i:int = 0; i < zip.numFiles ; i++)
			{
				
				var f:ZipFile = zip.getFileAt(i);
				if (f_unZip != null)
					f_unZip(i);
				if (f.isDirectory())
				{
					File.applicationStorageDirectory.resolvePath(f.name).createDirectory();
				}
				else
				{
					var des:File = File.applicationStorageDirectory.resolvePath(f.name);
					
					var streamw:FileStream = new FileStream();
					streamw.open(des,FileMode.WRITE);
					var l_bs :ByteArray = new ByteArray();				
					streamw.writeBytes(f.data);
					streamw.close();	
					if (des.extension !=null && des.extension.toLowerCase() == "css")
					{
						m_cssfilename.push(des.nativePath);
						des.copyTo( File.applicationStorageDirectory.resolvePath(f.name+".bak"),true);																
					}
				}					
			}
			
			var xmlFile:ZipFile = zip.getFileByName("META-INF/container.xml");
			var xml:XML = new XML(xmlFile.data);
			readNodescontainer(xml);
			
			xmlFile = zip.getFileByName(this.m_content_opf);
			xml = new XML(xmlFile.data);
			this.readNodescontent_opf(xml);
			
			if (m_content_opf.indexOf("/")>0)
				m_ebook_path = m_content_opf.substr(0,m_content_opf.indexOf("/")+1);
			
			this.m_toc_ncx = m_ebook_path + this.m_toc_ncx;
			
			m_epubpages =[];
			xmlFile = zip.getFileByName(this.m_toc_ncx);
			xml = new XML(xmlFile.data);
			this.readNodestoc_ncx(xml);			
			
			if (f_load != null)
				f_load();
			
			//			var cntfile:ZipFile = zip.getFileByName("content.opf");
			//			cnt = new XML(cntfile.data);
			//			trace(xml);
			//	
			//			//读取zip中的xml文件
			//			var xmlFile:ZipFile = zip.getFileByName("sample.xml");
			//			var xml:XML = new XML(xmlFile.data);
			//			trace(xml);
			//			
			//			//复制zip中的"girl.jpg"为"张曼玉.jpg"
			//			var zmy:ZipFile = zip.getFileByName("girl.jpg");
			//			zip.addFileFromBytes("张曼玉.jpg", zmy.data);
			//			
			//			//异步加载并显示zip中的新生成的图片"张曼玉.jpg"
			//			
			//			zip.getAsyncDisplayObject("张曼玉.jpg", 
			//				function(img:DisplayObject):void 
			//				{ 
			//					addChild(img);
			//					img.x = 10;
			//					img.y = 10;
			//				} );
			//			
			//			//删除zip中的文件"girl.jpg"
			//			zip.removeFileByName("girl.jpg");
			//			
			//异步加载并显示zip中的SWF文件"loading.swf"
			//			zip.getAsyncDisplayObject("loading.swf", 
			//				function(swf:DisplayObject):void 
			//				{ 
			//					addChild(swf);
			//					swf.x = 150;
			//					swf.y = 10;
			//				} );
			
			//根据字符串内容创建一个新的txt文件
			//			var txtContent:String = "这是一个测试文本文件";
			//			zip.addFileFromString("empty_dir/test.txt", txtContent);
			
			//显示修改后的zip文件信息
			trace(zip.toComplexString());
		}
		
		//		private function testSWC():void
		//		{
		//			swc = new ZipArchive();
		//			handleEvents(swc, true);
		//			swc.load("res/puremvc.swc");
		//		}
		
		//		private function processSWC():void
		//		{
		//			//显示swc文件的详细文件信息
		//			trace(swc.toComplexString());
		//			
		//			//读取swc文件中的所有类定义
		//			var catalog:ZipFile = swc.getFileByName("catalog.xml");
		//			var catalogXML:XML = XML(catalog.data);
		//			trace(catalogXML..(catalogXML.namespace())::def);
		//		}
		
		private function readNodescontainer(node:XML):void {
			var l_element:String = "";
			var l_vale:String = "";
			
			for each (var element:XML in node.elements()) 
			{
				l_element = element.localName().toString();
				
				if (l_element == "rootfile")
				{
					l_vale = element.attribute("full-path");	
					m_content_opf = l_vale;
				}
				readNodescontainer(element);				
			}
		}
		
		
			
		private function readNodescontent_opf(node:XML):void {
			var l_element:String = "";
			var l_vale:String = "";			
			for each (var element:XML in node.elements()) 
			{
				l_element = element.localName().toString();				
				if (l_element == "item")
				{
					if ( element.attribute("id") == "ncx"
						|| element.attribute("id") == "ncxtoc")	
						m_toc_ncx = element.attribute("href");
					
					if ( element.attribute("id") == "cover-image")							
						m_cover_image = element.attribute("href") ;
				}
				readNodescontent_opf(element);
			}
		}
		
		private function readNodestoc_ncx(node:XML):void {
			var l_element:String = "";
			var l_vale:String = "";
			
			for each (var element:XML in node.elements()) 
			{
				l_element = element.localName().toString();
				
				if (l_element == "content")
				{
					l_vale = element.attribute("src");	
					m_epubpages.push(m_ebook_path+l_vale);
				}
				readNodestoc_ncx(element);				
			}
		}
			
		private function handleEvents(zip:ZipArchive, add:Boolean):void
		{
			if (add)
			{
				zip.addEventListener(ZipEvent.PROGRESS, onProgress);
				zip.addEventListener(ZipEvent.LOADED, onLoaded);
				zip.addEventListener(ZipEvent.INIT, onInit);
				zip.addEventListener(ZipEvent.ERROR, onError);
			}else
			{
				zip.removeEventListener(ZipEvent.PROGRESS, onProgress);
				zip.removeEventListener(ZipEvent.LOADED, onLoaded);
				zip.removeEventListener(ZipEvent.INIT, onInit);
				zip.removeEventListener(ZipEvent.ERROR, onError);
			}
		}
		
		private function onInit(evt:ZipEvent):void 
		{
			handleEvents(evt.target as ZipArchive, false);			
			switch(evt.target)
			{
				case zip: processZip(null); break;
				//				case swc: processSWC(); break;
			}
		}		
		
		private function onProgress(evt:ZipEvent):void 
		{
			//trace(evt.message.bytesLoaded, evt.message.bytesTotal);
		}
		
		private function onLoaded(evt:ZipEvent):void 
		{
			//trace(evt);
		}
		
		private function onError(evt:ZipEvent):void 
		{
			trace(evt);
		}
	}	
}