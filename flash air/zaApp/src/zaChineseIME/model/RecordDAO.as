package zaChineseIME.model
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.net.Responder;
	import flash.utils.ByteArray;
	
	import zaChineseIME.model.Record;
	
	public class RecordDAO
	{
		private var _sqlConnection:SQLConnection;
		private var osearch:String="";
		private var m_file:File;
		private var m_inputmethod:int = 0;
		private var m_where:String = "";
		public var m_func_callback:Function = null;
		public var m_msg:String = "";		
		public function get sqlConnection():SQLConnection
		{
			if (_sqlConnection)
				return _sqlConnection;
			openDatabase(File.applicationStorageDirectory.resolvePath("zaChineseIME200.db"));
			return _sqlConnection;
		}
		
		public function getver():String
		{	
			var sql:String = "select ver from tab_version";
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;
			stmt.execute();
			var result:Array = stmt.getResult().data;
			if (result)
			{
				return result[0].ver;
			}
			else
			{
				sql = "insert into tab_version select \"0\",\"-\",0,\"\"";				
				stmt = new SQLStatement();
				stmt.sqlConnection = sqlConnection;
				stmt.text = sql;
				stmt.execute();
			}				
			return "0";
		}
		
		public function setver(v :String):void
		{	
			var sql:String = "update tab_version set ver = \""+ v+ "\"";
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;
			stmt.execute();
		}
		
		public function addver():int
		{	
			var sql:String = "update tab_version set cnt = cnt+1";
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;
			stmt.execute();
			
			sql = "select cnt from tab_version";
			stmt = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;
			stmt.execute();
			var result:Array = stmt.getResult().data;
			if (result)
			{
				return result[0].cnt;
			}
			return 0;
		}
		
		public function findall(mtype:int ,type:int ,searchKey:String):Array
		{	
			var sql:String = "";
			
			osearch= searchKey;
			var stmt:SQLStatement = new SQLStatement();
			
			var aa:int= 0;
			searchKey = searchKey.toLocaleLowerCase();
			
			if (type==0)// pinyin simpl
			{	
				sql = "SELECT cn,pinyin,cnt,pinyin remark FROM tab_dict where  ";
				
				for (aa = 0 ;aa < searchKey.length ; aa++)
				{
					if (aa != 0)
						sql = sql.concat (" and ");
					sql = sql.concat(" rm"+(aa+1) + " = ? ") ;					
				}
				if (mtype==0 && searchKey.length !=6)
					sql = sql.concat(" and rm"+(aa+1) + " = \"\"") ;
				
				sql = sql.concat( " "+ m_where + " order by cnt desc ");
			}
				
			else if (type==5)// 繁体拼音
			{				 
				if (mtype==0)					 
					sql = "SELECT cn,pinyin,cnt,pinyin remark FROM tab_dict_fanti_pinyin where pinyin = ? order by cnt desc ";
				else
				{
					searchKey += "%";
					sql = "SELECT cn,pinyin,cnt,pinyin remark FROM tab_dict_fanti_pinyin where pinyin like ? order by cnt desc ";
				}
			}	 
			else if (type==1)// cj fanti
			{
				searchKey += "%";
				sql = "SELECT cn,pinyin,cnt  FROM tab_dict_cj5 where pinyin like ? order by pinyin ,cnt desc ";				 
			}
			if (type==2)// english
				return null;
			
			if (type==3)// russian
				return null;
			
			if (type==4)// russian
				return null;
			
			
			if(searchKey.length == 2)
			{
				sql = sql.concat(" limit 200 ");
			}
			
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;
			if (type==0)
			{
				for (aa = 0 ;aa < searchKey.length ; aa++)
				{
					stmt.parameters[aa] = searchKey.charAt(aa);		
					
				}	
			}
			else
				stmt.parameters[0] = searchKey;
			stmt.execute();
			var result:Array = stmt.getResult().data;
			if (result)
			{
				var list:Array =[];
				for (var i:int=0; i<result.length; i++)
				{
					list.push(processRow(result[i]));	
				}
				return list;
			} 
			else
			{
				return null;
			}
		}
		
		public function findlengend(type:int ,searchKey:String):Array
		{
			
			//		if (searchKey.length ==1) return null;
			
			var sql:String = "";
			var aa:int= 0;
			osearch= searchKey;
			var stmt:SQLStatement = new SQLStatement();	
			
			searchKey = searchKey.toLocaleLowerCase();
			
			if (type==0)// pinyin simpl
			{	
				sql = "SELECT substr(cn,2,10) cn,cn o_cn,pinyin FROM tab_dict_cz where  cn1 = ? order by cnt desc";				
			}
			if (type==5)// pinyin simpl
			{	
				sql = "SELECT substr(cn,2,10) cn,cn o_cn,pinyin FROM tab_dict_fanti_cz where  cn1 = ? order by cnt desc";				
			}
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;
			stmt.parameters[0] =  searchKey ;
			stmt.execute();
			var result:Array = stmt.getResult().data;
			if (result)
			{
				var list:Array =[];
				for (var i:int = 0; i<result.length; i++)
				{
					list.push(processRow(result[i]));	
				}
				return list;
			} 
			else
			{
				return null;
			}
		}
		
		public function findcizu(type:int ,pyv:PinYinVector):Array
		{
			
			var searchKey:String = pyv.getmutilcharfull();
			if (type == 0 || type == 5)
				if (pyv.m_py_decode_list.length <=1) return null;
			
			var sql:String = "";
			var aa:int= 0;
			osearch= searchKey;
			var stmt:SQLStatement = new SQLStatement();	
			
			searchKey = searchKey.toLocaleLowerCase();
			
			if (type==0)// pinyin simpl
			{	
				sql = "SELECT cn,cnt,pinyin,remark FROM tab_dict_cz where ";
				if (searchKey.length<6)
					for ( aa = 0;aa < pyv.m_py_decode_list.length ; aa++)
					{
						if (aa != 0)
							sql = sql.concat (" and ");
						sql = sql.concat(" py"+(aa+2) + " = ? ") ;					
					}
				
				if (searchKey.length>0 && searchKey.length<6)
					sql = sql.concat (" or ");
				
				for (aa = 0 ;aa < searchKey.length ; aa++)
				{
					if (aa != 0)
						sql = sql.concat (" and ");
					sql = sql.concat(" rm"+(aa+2) + " = ? ") ;					
				}
				
				sql = sql.concat( " "+ m_where + " order by cnt desc ");
			}
				
			else if (type==1)// cangj
				sql = "SELECT cn,pinyin FROM tab_dict_cj5_cz where pinyin like ?  or remark3 = ? and   remart2 like ?  order by cnt desc";
				
			else if (type==2)// english
			{				
				sql = "SELECT cn,pinyin FROM tab_dict_en where pinyin like ? order by pinyin ,cnt desc ";
			}
			else if (type==3)// russian
			{				
				sql = "SELECT cn,pinyin FROM tab_dict_rs where pinyin like ? order by pinyin ,cnt desc ";
			}			
			else if (type==4)// korean
			{				
				sql = "SELECT cn,pinyin,remark FROM tab_dict_kr where pinyin like ? order by pinyin ,cnt desc ";
			}
				
			else if (type==5)// fantif
			{				
				
				sql = "SELECT cn,cnt,pinyin,remark FROM tab_dict_fanti_cz where  ";
				if (searchKey.length<6)
					for ( aa = 0;aa < pyv.m_py_decode_list.length  ; aa++)
					{
						if (aa != 0)
							sql = sql.concat (" and ");
						sql = sql.concat(" py"+(aa+2) + " = ? ") ;						
					}
				
				if (searchKey.length>0 && searchKey.length<6)
					sql = sql.concat (" or ");
				
				for (aa = 0 ;aa < searchKey.length ; aa++)
				{
					if (aa != 0)
						sql = sql.concat (" and ");
					sql = sql.concat(" rm"+(aa+2) + " = ? ") ;					
				}
				
				sql = sql.concat( " "+ m_where + " order by cnt desc ");
			}
			//			if (type==1)// cj fanti 
			//				sql = "SELECT cn,pinyin FROM tab_dict_cj5 where pinyin like ? order by cnt desc ";
			//			
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;
			
			if (type==0 || type==5)
			{
				var bb:int= 0 ;
				
				if (searchKey.length<6)
				{
					for (aa = 0 ;aa < pyv.m_py_decode_list.length ; aa++)
					{						
						var kk:String= pyv.m_py_decode_list[aa].py.substr(0,1);
						stmt.parameters[aa] = kk.toLocaleLowerCase();	
						bb = aa;
					}
					bb++;
				}
				
				for (aa = 0 ;aa < searchKey.length ; aa++)
				{
					stmt.parameters[bb+aa] = searchKey.charAt(aa);					
				}			
			}
			else if (type==1)
			{
				stmt.parameters[0] = searchKey+"%";
				stmt.parameters[1] = searchKey.substr(0,2);				
				stmt.parameters[2] = searchKey+"%";			
			}
			else
			{
				searchKey = searchKey.toLocaleLowerCase() +"%";
				stmt.parameters[0] = searchKey;
			}
			
			stmt.execute();
			var result:Array = stmt.getResult().data;
			if (result)
			{
				var list:Array =[];
				for (var i:int = 0; i<result.length; i++)
				{
					list.push(processRow(result[i]));	
				}
				return list;
			} 
			else
			{
				return null;
			}
		}
		
		public function update1(i:int,rec:Record):void
		{
			var sql:String;
			if ( i == 0)
				sql = "update tab_dict set cnt = cnt + 6000 where cn = ? ";
			if ( i == 1)
				sql ="update tab_dict_cj5 set cnt = cnt + 6000 where cn = ? ";
			if ( i == 2)
				sql ="update tab_dict_en set cnt = cnt + 6000 where cn = ? ";			
			if ( i == 3)
				sql ="update tab_dict_rs set cnt = cnt + 6000 where cn = ? ";
			if ( i == 4)
				sql ="update tab_dict_kr set cnt = cnt + 6000 where cn = ? ";
			if ( i == 5)
				sql ="update tab_dict_fanti_pinyin set cnt = cnt + 6000 where cn = ? ";
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;			
			stmt.parameters[0] = rec.cn;	
			stmt.execute();
			rec.loaded = true;
		}	
		
		public function update2(i:int,rec:Record):int
		{
			var sql:String ;
			var add:String = "10";
			if (rec.priority < 70000)
				add= "70000 - cnt ";
			
			if ( i == 0)
				sql = "update tab_dict_cz set cnt = cnt + " + add +" where cn = ?";
			if ( i == 1)
				sql = "update tab_dict_cj5_cz set cnt = cnt + " + add +" where cn = ?";
			if ( i == 2)
				sql = "update tab_dict_en set cnt = cnt + " + add +" where cn = ?";			
			if ( i == 3)
				sql = "update tab_dict_rs set cnt = cnt + " + add +" where cn = ?";
			if ( i == 4)
				sql = "update tab_dict_kr set cnt = cnt + " + add +" where cn = ?";
			if ( i == 5)
				sql = "update tab_dict_fanti_cz set cnt = cnt + " + add +" where cn = ?";
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;			
			rec.loaded = true;
			stmt.parameters[0] = rec.cn;
			if ( rec.o_cn != "" && rec.o_cn != null )
				stmt.parameters[0] = rec.o_cn;			
			
			stmt.execute();								
			var rw:int =  stmt.getResult().rowsAffected;
			return  rw;
		}
		
		
		public function save(i:int,rec:Record):void
		{
			var sql:String;
			var bb:int = 0;
			var aa:int= 0;
			var stmt:SQLStatement ;
			if (i == 0)
			{
				sql="delete from tab_dict_cz where cn = ?";
				stmt = new SQLStatement();
				stmt.sqlConnection = sqlConnection;
				stmt.text = sql;			
				
				stmt.parameters[0] = rec.cn;
				
				stmt.execute();
				
				sql = "insert into tab_dict_cz select ? , ? , 61000,?  ";
				bb = 0;
				for ( aa = 0; aa< rec.pinyin_full.length; aa++)
				{
					if (bb >5) break;
					if ( aa ==0 || (aa>1 && rec.pinyin_full.charAt(aa-1) ==" "))
					{
						sql = sql.concat(",\""+ rec.pinyin_full.charAt(aa) +"\"");
						bb ++
					}
				}
				if (bb < 5)
				{
					for ( ; bb < 5 ; bb++)
						sql = sql.concat(",\"\" ");
				}
				
				bb = 0;
				for ( aa = 0; aa< rec.pinyin_full.length ; aa++)
				{
					if ( rec.pinyin_full.charAt(aa) != " ")
					{
						sql = sql.concat(",\""+ rec.pinyin_full.charAt(aa) +"\"");
						bb ++;
					}
				}
				
				if (bb < 14)
				{
					for ( ; bb < 14 ; bb++)
						sql = sql.concat(",\"\" ");
				}
				sql = sql.concat(",\"" + rec.cn.substr(0,1)+"\" ");
			}
			if (i == 1)
				sql = "insert into tab_dict_cj5_cz select ? , ? , 61000,\"user\",\"\",\"\"";				
			if (i == 2)
				sql = "insert into tab_dict_en select ? , ? , 61000,\"user\",\"\"";
			if (i == 3)
				sql = "insert into tab_dict_rs select ? , ? , 61000,\"user\",\"\"";
			if (i == 4)
				sql = "insert into tab_dict_kr select ? , ? , 61000,\"user\",\"\"";
			if (i == 5)
			{
				sql="delete from tab_dict_fanti_cz where cn = ?";
				stmt = new SQLStatement();
				stmt.sqlConnection = sqlConnection;
				stmt.text = sql;			
				
				stmt.parameters[0] = rec.cn;
				
				stmt.execute();
				
				sql = "insert into tab_dict_fanti_cz select ? , ? ,61000,? ";
				bb = 0;
				for ( aa = 0; aa< rec.pinyin_full.length ; aa++)
				{
					if (bb >5) break;
					if ( aa ==0 || (aa>1 && rec.pinyin_full.charAt(aa-1) ==" "))
					{
						sql = sql.concat(",\""+ rec.pinyin_full.charAt(aa) +"\"");
						bb ++
					}
				}
				if (bb < 5)
				{
					for ( ; bb < 5 ; bb++)
						sql = sql.concat(",\"\" ");
				}
				
				bb = 0;
				for ( aa = 0; aa< rec.pinyin_full.length ; aa++)
				{
					if ( rec.pinyin_full.charAt(aa) != " ")
					{
						sql = sql.concat(",\""+ rec.pinyin_full.charAt(aa) +"\"");
						bb ++;
					}
				}
				
				if (bb < 14)
				{
					for ( ; bb < 14 ; bb++)
						sql = sql.concat(",\"\" ");
				}
				sql = sql.concat(",\"" + rec.cn.substr(0,1)+"\" ");
			}
			stmt = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;			
			
			stmt.parameters[0] = rec.cn;
			stmt.parameters[1] = rec.pinyin;	
			if (i == 0 || i == 5)
				stmt.parameters[2] = rec.pinyin_full;
			stmt.execute();
			rec.loaded = true;
		}
		
		
		protected function processRow(o:Object):Record
		{
			var rec:Record = new Record();
			rec.id = o.id;
			rec.cn = o.cn == null ? "" : o.cn;			
			
			rec.priority = o.cnt == null ? 0 : o.cnt;
			var a:String = rec.priority.toString();
			for (var n:int =0 ; n < 6-a.length; n ++)
				a = "0"+a;
			rec.priorityS = a;
			
			rec.o_cn = rec.cn;
			rec.o_cn = o.o_cn == null ? "" : o.o_cn;
			
			rec.pinyin = o.pinyin == null ? "" : o.pinyin;
			rec.pinyin_full = o.remark == null ? "" : o.remark;						
			
			rec.match = false;
			if (osearch.toLowerCase() == rec.pinyin.toLowerCase())
				rec.match = true;
			rec.loaded = true;			
			return rec;
		}
		
		public function openDatabase(file:File):void
		{
			var newDB:Boolean = true;
			if (file.exists)
				newDB = false;
			else
				copydb(file);
			_sqlConnection = new SQLConnection();
			_sqlConnection.open(file);			
		}
		
		protected function copydb(fileDes:File):void
		{
			var fileSrc:File = File.applicationDirectory.resolvePath("zaChineseIME/res/zaChineseIME.db"); 
			var stream:FileStream = new FileStream();
			stream.open(fileSrc, FileMode.READ);
			
			var streamw:FileStream = new FileStream();
			streamw.open(fileDes,FileMode.WRITE);
			var l_bs :ByteArray = new ByteArray();
			stream.readBytes(l_bs);
			streamw.writeBytes(l_bs);
			stream.close();
			streamw.close();		
		}
		
		public function export(inputmethod:int):void
		{					
			m_inputmethod = inputmethod;
			m_file = File.applicationDirectory;
			m_file.addEventListener(Event.SELECT,onfileexpselect);
			m_file.browseForSave("Export saved words to");			
		}
		
		protected function onfileexpselect(e:Event):void
		{
			var fileDes:File = e.target as File;	
			fileDes = File.documentsDirectory.resolvePath(fileDes.name);
			m_where = " remark = \"user\" ";
			var res:Array = this.findcizu(m_inputmethod,new PinYinVector());
			var streamw:FileStream = new FileStream();
			streamw.open(fileDes,FileMode.WRITE);
			
			m_msg = "begin export ..."
			if (m_func_callback != null) 
				m_func_callback();
			
			for (var i:int = 0 ;i < res.length ; i ++)
			{
				var a:Record = res[i] as Record;
				streamw.writeMultiByte(a.cn + ","+ a.pinyin + "\n","UTF-8");					
			}
			m_where = "";
			streamw.close();	
			m_msg = res.length + " words export."
			if (m_func_callback != null) 
				m_func_callback();
		}
		
		public function importIn(inputmethod:int):void
		{				
			m_inputmethod = inputmethod;
			m_file = File.applicationDirectory;
			m_file.addEventListener(Event.SELECT,onfileimpselect);
			m_file.browseForOpen("Import new words from");	
		}
		
		protected function onfileimpselect(e:Event):void
		{		
			var fileDes:File = e.target as File;
			var streamr:FileStream = new FileStream();
			streamr.open(fileDes,FileMode.READ);
			var r:String ="";
			var l_line:String = "";
			r = streamr.readMultiByte(streamr.bytesAvailable,"UTF-8").concat("\n");
			fileDes.extension
			m_msg = "begin import ..."
			if (m_func_callback != null) 
				m_func_callback();
			
			var n:int = 0;
			n= r.indexOf("\n");
			var o:Record = new Record();
			var num:int  = 0;
			while(n>0)
			{
				l_line = r.substr(0,n);
				if (l_line.replace(" ","").length ==0)
				{
					r = r.substr(n+1);
					continue;
				}
				num ++;
				o.cn = l_line.substr(0,l_line.indexOf(","));
				o.pinyin = l_line.substr(l_line.indexOf(",")+1);
				this.save(m_inputmethod,o);
				r = r.substr(n+1);
				n= r.indexOf("\n");
			}			
			streamr.close();	
			m_msg = num + " words import."
			if (m_func_callback != null) 
				m_func_callback();
		}		
	}
	
}