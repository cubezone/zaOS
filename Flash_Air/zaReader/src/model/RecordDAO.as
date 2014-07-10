package model
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import model.Record;
		
	public class RecordDAO
	{
		private var _sqlConnection:SQLConnection;

		public function get sqlConnection():SQLConnection
		{
			if (_sqlConnection)
				return _sqlConnection;
			openDatabase(File.applicationStorageDirectory.resolvePath("zaTextReader1.db"));
			return _sqlConnection;
		}

		public function findall(searchKey:String):Array
		{
			 //var sql:String = "SELECT * FROM employee WHERE firstName || ' ' || lastName LIKE '%"+searchKey+"%' ORDER BY lastName, firstName";
			 var sql:String = "";
			 var stmt:SQLStatement = new SQLStatement();	
			 if (searchKey=="")
				 sql = "SELECT * FROM tab_textreader where title <> \"zapassword\" order by updatetime desc ";
			 else
				 sql = "SELECT * FROM tab_textreader where title = \"zapassword\" " +
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
	
			var sql:String = 
				"update tab_textreader set title=?,username=?,password=?" +
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
			stmt.parameters[6] = rec.dir;
			stmt.parameters[7] = rec.file;
			stmt.parameters[8] = rec.page;
			stmt.parameters[9] = rec.content;
			stmt.parameters[10] = rec.font;
			stmt.parameters[11] = rec.scrollY;
			stmt.parameters[12] = rec.id;
			
			stmt.execute();
			rec.loaded = true;
		}	
		
		public function insert(rec:Record):void
		{
			
			var sql:String = 
				"INSERT INTO tab_textreader select null,?,?,?,?,?,?,?,?,?,?,?,?";
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = sql;			
			stmt.parameters[0] = rec.title;			
			stmt.parameters[1] = rec.username;
			stmt.parameters[2] = rec.password;
			stmt.parameters[3] = rec.updatetime;
			stmt.parameters[4] = rec.notes;			
			stmt.parameters[5] = rec.picture;
			stmt.parameters[6] = rec.dir;
			stmt.parameters[7] = rec.file;
			stmt.parameters[8] = rec.page;
			stmt.parameters[9] = rec.content;
			stmt.parameters[10] = rec.font;
			stmt.parameters[11] = rec.scrollY;
			
			stmt.execute();
			rec.loaded = true;
		}
		
		public function del(rec:Record):void
		{
			
			var sql:String = 
				"delete from tab_textreader where id = ?";
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
			rec.dir = o.res1 == null ? "" : o.res1;	
			rec.file = o.res2 == null ? "" : o.res2;
			rec.page = o.res3 == null ? "" : o.res3;
			rec.content = o.res4 == null ? "" : o.res4;
			rec.font = o.res5 == null ? "" : o.res5;
			rec.scrollY = o.res6 == null ? "" : o.res6;
			rec.loaded = true;			
			return rec;
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
				"CREATE TABLE IF NOT EXISTS tab_textreader ( "+
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