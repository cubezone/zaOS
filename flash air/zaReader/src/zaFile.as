package
{
	import com.riaidea.utils.zip.*;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import qnx.notificationManager.Indication;
	
	public class zaFile
	{
		private var m_f:File = null;
		private var m_position:uint = 0;
		private var m_startpage:uint = 0;
		private var m_size:uint = 0;
		private var m_block:int = 3000;
		private var m_buf:Array = [];
		public var m_auto:Boolean = true;
		public var m_page:int=0;
		private var m_fileCharset:String = File.systemCharset;
		private var stream:FileStream = new FileStream();
		public function zaFile()
		{
			
		}
		
		public function assignfile(f:File):void
		{
			stream.close();
			if (f != null)
				m_f = f;	
			m_page = 0;
			m_size = m_f.size;
			m_startpage = 0;
			m_position = 0;
			m_buf =[];
			
			if (m_auto)
				m_fileCharset = autofileCharset();
			stream = new FileStream();
			stream.open(m_f, FileMode.READ);				
		}
				
		public function page():int
		{
			return m_page + 1;
		}
		
		public function pathname():String
		{
			return m_f.nativePath.replace(m_f.name,"");
		}
		
		public function fname():String
		{
			return m_f.name;
		}
		
		public function totalpage():int
		{
			return Math.ceil(1.0* m_size /m_block);
		}
		
		public function setfileCharset(c:String):void
		{
			m_fileCharset = c;	
		}
		public function getfileCharset():String
		{
			return m_fileCharset;
		}
		
		public function autofileCharset():String
		{
			var bytes:ByteArray = new ByteArray;
			if (m_f.size >=2)
			{
				stream = new FileStream();
				stream.open(m_f, FileMode.READ);	
				stream.readBytes(bytes,0,2);
				stream.close();
				// 1. unicode 文档 开头 16进制码为 FF FE ,对应 十进制 数 为 255，254
				if (bytes[0]==255 && bytes[1]==254){
					return "unicode";
				}
				// 2.unicode big endian 开头 16进制 为 FE FF，对应十进制数 为 254，255
				if (bytes[0]==254 && bytes[1]==255){
					return "UTF-16BE";
				}
				// 3.utf-8 开头 16进制 为 EF BB ，对应 十进制 数 为 239，187
				if (bytes[0]==239 && bytes[1]==187){
					return "utf-8";
				}
				
				if (bytes[0]>=0xC0 && bytes[1] < 0xC0 ){
					return "utf-8";
				}
				
				if (bytes[0] <0x80 && bytes[1] < 0x80 ){
					return "utf-8";
				}
			} 
			// 默认采用系统编码 读取
			return  "cn-gb";			
			return  File.systemCharset;			
		}
		
		public function setstartpage(i:int):int
		{
			i--;
			m_startpage = i;
			m_position = i*m_block;
			if (m_position > m_f.size)
				return -1;
			stream.position = m_position;		
			m_page = i;
			return m_position;
		}
		
		public function nextpage():String
		{
			//GB2312 0xB0 - 0xF7 0xA0 - 0xFE   
			//GBK 0x81 - 0xFE 0x40 - 0xFE 
			var n :int = 0;
			var cnt:String = "";
			if (m_page - m_startpage + 1 < m_buf.length)
			{	
				m_page ++;
				cnt = m_buf[m_page - m_startpage];
				return cnt;
			}
			
			if ( m_position < m_f.size)
			{
				n = maxread();
//				if ((m_fileCharset=="cn-gb")
//					|| (m_fileCharset=="utf-8"))
//				{
					var ba:ByteArray = new ByteArray();
					stream.readBytes(ba,0,n);
					m_position += n;
					ba.position = n;
					while (half != 0x0A && m_position < m_f.size)
					{
						var half:uint = stream.readUnsignedByte();
						m_position ++;
						n++;
						ba.writeByte(half);
					}					
					ba.position = 0;
					cnt = ba.readMultiByte(ba.bytesAvailable,m_fileCharset);
//				}
//				else
//				{
//					cnt = stream.readMultiByte(n,m_fileCharset);
//					m_position += n;
//				}
					if(cnt.length == 0)
						cnt = cnt + "\nThe charset mismatch in this txt file.\n\n" +
							"Try to choose another charset to open it, if full of this text can't be read \n\n" +
							"Try to resave it in unicode via document app, such as microsoft notepad, if some page of this text can't be read";  
					
					m_buf.push(cnt);
					m_page++;
					return cnt;
			}
			else
				return m_buf[m_buf.length-1];
		}
		
		public function nextpage_org():String
		{
			//GB2312 0xB0 - 0xF7 0xA0 - 0xFE   
			//GBK 0x81 - 0xFE 0x40 - 0xFE 
			var n :int = 0;
			var cnt:String = "";
			if (m_page - m_startpage + 1 < m_buf.length)
			{	
				m_page ++;
				cnt = m_buf[m_page - m_startpage];
				return cnt;
			}
		
			if ( m_position < m_f.size)
			{
				n = maxread();
				if (m_fileCharset=="cn-gb")
				{
						var ba:ByteArray = new ByteArray();
						stream.readBytes(ba,0,n);
						m_position += n;
						var halfflag:Boolean =false;
						var bug:Boolean=false;
						
						for(var c:int =0; c < ba.length; c++)
						{
							if(ba[c] == 0x0D)
							   ba[c]= 0x20;
							
							
							if(bug)
							{
								bug = false;
								ba[c]= 0x5E;	
							}
							
							if (halfflag)
							{
								if (ba[c] <= 0xA0) 
								{
									ba[c] = 0x5E;
									ba[c-1] = 0x5E;
								}		
								halfflag = false;						
							}
							else
							{
								if (ba[c] >= 0x80)
								{
									halfflag = true;
									
									if (ba[c] <= 0xA0 || ba[c] >= 0xFD)
									{
										bug = true;
										ba[c] = 0x5E;
									}
								}
							}
						}			
						
						if (halfflag)
						{
							var half:uint = stream.readUnsignedByte();
							m_position ++;
							ba[n]= half;							
						}
						
						cnt = ba.readMultiByte(ba.bytesAvailable,m_fileCharset);
				   }
				 else if(m_fileCharset=="utf-8")
				 {
					 var ba:ByteArray = new ByteArray();
					 stream.readBytes(ba,0,n);
					 m_position += n;
					 var nn:int;
					 var bac:int;					 
					 for (nn = 1; nn < 7;nn ++)
					 {
						 var l:int = ba[ba.length-nn];
						 if (l >= 0xC0)
						 {							
							if (l >=0xC0) bac = 2;
							if (l >=0xE0) bac = 3;
							if (l >=0xF0) bac = 4;
							if (l >=0xF8) bac = 5;
							if (l >=0xFC) bac = 6;
							break;
						 }
						 else if ( l < 0x80)
						 {
							bac =0;
							break;
						 }
					 }

					 for ( var i:int=0;i < bac-nn ; i++)
					 {
						 var half:uint = stream.readUnsignedByte();
						 m_position ++;
						 ba[n]= half;						 
						 n++;
					 }
											 
					 cnt = ba.readMultiByte(ba.bytesAvailable,m_fileCharset);
				 }				
				else
				{
				    cnt = stream.readMultiByte(n,m_fileCharset);
					m_position += n;
				}
							
				if(cnt.length == 0)
					cnt = cnt + "\nThe charset mismatch in this txt file.\n\n" +
						"Try to choose another charset to open it, if full of this text can't be read \n\n" +
						"Try to resave it in unicode via document app, such as microsoft notepad, if some page of this text can't be read";  
				
				m_buf.push(cnt);
				m_page++;
				return cnt;
			}
			else
				return m_buf[m_buf.length-1];
			
		}
		
		public function nextpageall():String
		{
			var n :int = 0;
			var cnt:String = "";
			cnt = stream.readMultiByte(stream.bytesAvailable,m_fileCharset);
			return cnt;	
		}
		
		public function prepage():String
		{
			if (m_page > m_startpage) 
			{
				m_page --;
				return m_buf[m_page - m_startpage]; 
			}			
			else if (m_page>0)
			{
				m_buf =[]
				setstartpage(m_page);
				nextpage();
				m_page --;
				return m_buf[0];
			}
			else
				return m_buf[0];
		}
		
		public function gotopage(i:int):String
		{
			m_page = i;
			m_buf =[]
			setstartpage(m_page);
			nextpage();
			m_page --;
			return m_buf[0];
		}
		
		public function maxread():uint
		{
			if (m_size - m_position >= m_block)
				return m_block;
			else
				return m_size - m_position;
		}
	}
}