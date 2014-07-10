package com.zhuxy.za_rss;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Vector;

import javax.microedition.io.Connector;
import javax.microedition.io.file.FileConnection;

import net.rim.device.api.database.Cursor;
import net.rim.device.api.database.DataTypeException;
import net.rim.device.api.database.Database;
import net.rim.device.api.database.DatabaseException;
import net.rim.device.api.database.DatabaseFactory;
import net.rim.device.api.database.DatabaseSecurityOptions;
import net.rim.device.api.database.Row;
import net.rim.device.api.database.Statement;
import net.rim.device.api.io.URI;

import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.Dialog;


public class za_db {
	
	private  String DB_NAME = "za_rss.dbf"; 
	Database db  ;
	String dbLocation = "/store/home/user/documents/";
	URI uri = URI.create(dbLocation + DB_NAME);
	static za_db m_db = null;
	
	static za_db getInstanct()throws Exception
	{
		if (m_db == null)
			m_db = new za_db();
		return m_db;		
	}
	
	
	public za_db() throws Exception {

		db = DatabaseFactory.openOrCreate(uri, new DatabaseSecurityOptions(
				false));
		db.close();

		FileConnection fileConnection = (FileConnection) Connector
				.open("file://" + dbLocation + DB_NAME);
		if (fileConnection.exists() && fileConnection.fileSize() == 0) {
			readAndWriteDatabaseFile(fileConnection);
		}
		/*
		 * CodeSigningKey codeSigningKey =
		 * CodeSigningKey.get(CodeModuleManager.getModuleHandle( "SQLiteDemo" ),
		 * "XYZ");
		 * 
		 * try { DatabaseFactory.encrypt(uri, new
		 * DatabaseSecurityOptions(codeSigningKey)); } catch(DatabaseException
		 * dbe) { errorDialog("Encryption failed - " + dbe.toString()); }
		 */

	}

	void open() throws Exception {
		db = DatabaseFactory.open(uri);
	}

	void close()
    {        
        try
        {            
           db.close();
        }
        catch(DatabaseException dbe)
        {
            za_db.errorDialog(dbe.toString());
        }
    }  
	
	public Vector selectrss(String billcycle)
	{	
		Vector vec = new Vector();			  
		 try
	        {
			 	vec.removeAllElements();
			 	billcycle = billcycle +"%";
               // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
			    Statement statement = db.createStatement("SELECT id ,symbol ,title " +
			    		"FROM tab_stock "); 
	            statement.prepare();
	                                              
	            Cursor cursor = statement.getCursor();     
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                vec.insertElementAt(new za_rss(
	                		row.getInteger(0), 
	                		row.getString(1),
	                		row.getString(2)
	                		),0);    	                
	            }                 
	            cursor.close();
	            statement.close();	            	            
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }    
	        catch(DataTypeException dte)
	        {
	        	za_db.errorDialog(dte.toString());
	        }
	        	    
	        return  vec;
	}
	
	public Vector selectrssitem(String symbol)
	{			
			Vector vec = new Vector();			  		 
	        try
	        {	        		        		
				    Statement statement = db.createStatement("SELECT symbol ,uid ,title ," +
				    		" content ,datetime , readtag FROM tab_rsslog " +
				    		"where symbol = ? "); 
		            statement.prepare();
		            statement.bind(1, symbol);                                  
		            Cursor cursor = statement.getCursor();     
		            while(cursor.next())
		            {
		                Row row = cursor.getRow(); 
		                za_rssitem l_rssitem = new za_rssitem();
		                l_rssitem.m_sybmol = row.getString(0); 
		                l_rssitem.m_guid = row.getString(1);
		                l_rssitem.m_title = row.getString(2);
		                l_rssitem.m_description = row.getString(3);
		                l_rssitem.m_pubDate = row.getString(4);
		                if (row.getString(5).equals("Y"))
		                	l_rssitem.m_read = true;
		                vec.insertElementAt(l_rssitem,0);    	                
		            }                 
		                                                		           
		            cursor.close();
		            statement.close();	     	        	
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }    
	        catch(DataTypeException dte)
	        {
	        	za_db.errorDialog(dte.toString());
	        }
	        
	        return  vec;
	}
	
	public void insert(za_rss l_rss)
	{	
		 try
	        {
			  Statement statement = db.createStatement("delete from  tab_stock " +
		      		" where symbol = ?");                     
		      statement.prepare();            
		      statement.bind(1,l_rss.m_symbol);		      
		      
		      statement.execute(); 
		      statement.close(); 	            
      
	            statement = db.createStatement("INSERT INTO tab_stock " +
	            		"VALUES(null, ?,?)");                     
	            statement.prepare();            
	            statement.bind(1,l_rss.m_symbol);
	            statement.bind(2,l_rss.m_title);
	            
	            statement.execute(); 
	            statement.close(); 	            	       
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }	        
	}
	
	public void deleterss()
	{	
		 try
	        {	           
	            Statement statement = db.createStatement("delete from tab_rsslog " +
	            		" " );                     
	            statement.prepare();            	            
	            statement.execute(); 
	            statement.close(); 	            	       
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }	            
	        
	}
	
	public void deleterss(za_rss l_rss)
	{	
		 try
	        {	           
	            Statement statement = db.createStatement("delete from tab_rsslog " +
	            		" where symbol = ? ");                     
	            statement.prepare();            
	            statement.bind(1,l_rss.m_symbol);
	            statement.execute(); 
	            statement.close(); 	            	       
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }	            
	        
	}
	
	public void updateread(za_rssitem l_rs)
	{	
		try
	        {
			    Statement statement = db.createStatement("update tab_rsslog " +
			    		"set readtag = 'Y' where  uid = ? "); 
		        statement.prepare();
		        statement.bind(1, l_rs.m_guid);                              
			    statement.execute();
	            statement.close();	          
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }	        
	        
	}
	
	public boolean insertrss(za_rssitem l_rs)
	{	
		boolean l_exists = false;
		boolean l_read = false;
		 try
	        {
			    Statement statement = db.createStatement("SELECT readtag " +
	    		"FROM tab_rsslog where uid = ? "); 
		        statement.prepare();
		        statement.bind(1, l_rs.m_guid);                              
		        Cursor cursor = statement.getCursor();     
		        while(cursor.next())
		        {
		        	l_exists = true;
		        	Row row = cursor.getRow(); 		        
		            if (row.getString(0).equals("Y") )
		            		l_read = true;
		        }
	            cursor.close();
	            statement.close();
	            if (!l_exists)
	            { 
		            statement = db.createStatement("INSERT INTO tab_rsslog " +
		            		"VALUES(?,?,?,?,?,'N')");                     
		            statement.prepare();   
		            statement.bind(1, l_rs.m_sybmol);
		            statement.bind(2, l_rs.m_guid);
		            statement.bind(3, l_rs.m_title);
		            statement.bind(4, l_rs.m_description);
		            statement.bind(5, l_rs.m_pubDate);	            
		            
		            statement.execute(); 
		            statement.close(); 	            
	            }
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }	      
	        catch(DataTypeException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }	
	        return l_read;
	}
	
	public void delete(int rowid)
	{	
		 try
	        {	           
	            Statement statement = db.createStatement("delete from tab_stock " +
	            		"where id = ?");                     
	            statement.prepare();            
	            statement.bind(1, rowid);

	            statement.execute(); 
	            statement.close(); 	            	       
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }	        
	}
		  
	 public void readAndWriteDatabaseFile(FileConnection fileConnection) throws IOException
	    {        
	        OutputStream outputStream = null;
	        InputStream inputStream = null;       
	                       
	        inputStream = getClass().getResourceAsStream("/" + DB_NAME); 
	        
	        outputStream = (OutputStream)fileConnection.openOutputStream();                                       
	               
	        byte[] data = new byte[256];
	        int length = 0;
	        while (-1 != (length = inputStream.read(data)))
	        {
	            outputStream.write(data, 0, length);                
	        }     
	        
	        if(fileConnection != null)
	        {
	            fileConnection.close();
	        }
	        if(outputStream != null)
	        {
	            outputStream.close();
	        } 
	        if(inputStream != null)
	        {
	            inputStream.close();
	        }            
	    }
	 
	   public static void errorDialog(final String message)
	    {
	        UiApplication.getUiApplication().invokeLater(new Runnable()
	        {
	            public void run()
	            {
	                Dialog.alert(message);
	            } 
	        });
	    }

}
