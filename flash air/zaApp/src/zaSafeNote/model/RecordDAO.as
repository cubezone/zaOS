package zaSafeNote.model
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import zaSafeNote.model.Record;
		
	public class RecordDAO
	{
		private var _sqlConnection:SQLConnection;
		private var m_file:File;
		private var m_msg:String;
		public var m_func_callback:Function = null;
		
		public function get sqlConnection():SQLConnection
		{
			if (_sqlConnection)
				return _sqlConnection;
			openDatabase(File.applicationStorageDirectory.resolvePath("zaSafeNote3.db"));
			return _sqlConnection;
		}

		public function findall(searchKey:String):Array
		{
			 //var sql:String = "SELECT * FROM employee WHERE firstName || ' ' || lastName LIKE '%"+searchKey+"%' ORDER BY lastName, firstName";
			 var sql:String = "";
			 var stmt:SQLStatement = new SQLStatement();	
			 if (searchKey=="")
				 sql = "SELECT * FROM tab_safenote where title <> \"zapassword\" order by updatetime desc ";
			 else
				 sql = "SELECT * FROM tab_safenote where title = \"zapassword\" " +
					 "and username = \"zapassword123\" ";
			 stmt.sqlConnection = sqlConnection;
			 stmt.text = sql;
//			 stmt.parameters[0] = searchKey;
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
		
		public function update(rec:Record):void
		{
			trace(rec.notes);
			var sql:String = 
				"update tab_safenote set title=?,username=?,password=?" +
				",updatetime = ?,notes=?,picture=? " +
				",res1 =? ,res2 =? ,res3 =? ," +
				"res4 =? ,res5 =? ,res6 =? where id = ?";
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;			
			stmt.parameters[0] = rec.title;			
			stmt.parameters[1] = rec.username;
			stmt.parameters[2] = rec.password;
			stmt.parameters[3] = rec.updatetime;
			stmt.parameters[4] = rec.notes;
			stmt.parameters[5] = rec.picture;
			stmt.parameters[6] = rec.res1;
			stmt.parameters[7] = rec.res2;
			stmt.parameters[8] = rec.res3;
			stmt.parameters[9] = rec.res4;
			stmt.parameters[10] = rec.res5;
			stmt.parameters[11] = rec.res6;
			stmt.parameters[12] = rec.id;
			
			stmt.execute();
			rec.loaded = true;
		}	
		
		public function insert(rec:Record):void
		{

			var sql:String = 
				"INSERT INTO tab_safenote select null,?,?,?,?,?,?,?,?,?,?,?,?";
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;			
			stmt.parameters[0] = rec.title;			
			stmt.parameters[1] = rec.username;
			stmt.parameters[2] = rec.password;
			stmt.parameters[3] = rec.updatetime;
			stmt.parameters[4] = rec.notes;			
			stmt.parameters[5] = rec.picture;
			stmt.parameters[6] = rec.res1;
			stmt.parameters[7] = rec.res2;
			stmt.parameters[8] = rec.res3;
			stmt.parameters[9] = rec.res4;
			stmt.parameters[10] = rec.res5;
			stmt.parameters[11] = rec.res6;
			
			
			stmt.execute();
			rec.loaded = true;
		}
		
		public function del(rec:Record):void
		{

			var sql:String = 
				"delete from tab_safenote where id = ?";
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;			
			stmt.parameters[0] = rec.id;			
			stmt.execute();
			rec.loaded = true;
		}
		
		protected function processRow(o:Object):Record
		{
			var rec:Record = new Record();
			rec.id = o.id;
			rec.title = o.title == null ? "" : o.title;							
			rec.username = o.username == null ? "" : o.username;							
			rec.password = o.password == null ? "" : o.password;
			rec.updatetime = o.updatetime == null ? "" : o.updatetime;
			rec.notes = o.notes == null ? "" : o.notes;							
			rec.picture = o.picture == null ? "" : o.picture;							
			rec.res1 = o.res1 == null ? "" : o.res1;	
			rec.res2 = o.res2 == null ? "" : o.res2;
			rec.res3 = o.res3 == null ? "" : o.res3;
			rec.res4 = o.res4 == null ? "" : o.res4;
			rec.res5 = o.res5 == null ? "" : o.res5;
			rec.res6 = o.res6 == null ? "" : o.res6;
			rec.loaded = true;			
			return rec;
		}
		
		public function export(inputmethod:int):void
		{					

			m_file = File.applicationDirectory;
			m_file.addEventListener(Event.SELECT,onfileexpselect);
			m_file.browseForSave("Export saved words to");			
		}
		
		protected function onfileexpselect(e:Event):void
		{
			var fileDes:File = e.target as File;	
			fileDes = File.documentsDirectory.resolvePath(fileDes.name);

			var res:Array = this.findall("");
			var streamw:FileStream = new FileStream();
			streamw.open(fileDes,FileMode.WRITE);
			
			m_msg = "begin export ..."
			if (m_func_callback != null) 
				m_func_callback();
			
			for (var i:int = 0 ;i < res.length ; i ++)
			{
				var a:Record = res[i] as Record;
				streamw.writeMultiByte(a.title + ","+ a.notes + "\n","UTF-8");					
			}
			streamw.close();	
			m_msg = res.length + " words export."
			if (m_func_callback != null) 
				m_func_callback();
		}

		public function openDatabase(file:File):void
		{
			var newDB:Boolean = true;
			if (file.exists)
				newDB = false;
			_sqlConnection = new SQLConnection();
			_sqlConnection.open(file);
			if (newDB)
			{
				createDatabase();
			//	populateDatabase();
			}
		}
		
		protected function createDatabase():void
		{
			var sql:String = 
				"CREATE TABLE IF NOT EXISTS tab_safenote ( "+
				"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"title VARCHAR(150)," +
				"username VARCHAR(150)," +
				"password varchar(150)," +
				"updatetime varchar(200)," +
				"notes varchar(3000)," +
				"picture varchar(100)," +
				"res1 varchar(100)," +
				"res2 varchar(100)," +
				"res3 varchar(100)," +
				"res4 varchar(100)," +
				"res5 varchar(100)," +
				"res6 varchar(100)" +
				")";
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;
			stmt.execute();							
		}		
	}
}