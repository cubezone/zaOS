package com.zhuxy.za_book;

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
	
	private  String DB_NAME = "za_book.dbf"; 
	Database db  ;
	
	String dbLocation = "/store/home/user/documents/";
	URI uri = URI.create(dbLocation + DB_NAME);
	static za_db m_db = null;

	static za_db getInstanct() throws Exception {
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
	
	public Vector selectbookstore(int storeid )
	{		Vector vec = new Vector();		  
		 try
	        {
			 
			 	vec.removeAllElements();			 
            // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
			    Statement statement = db.createStatement("SELECT id, bookid,pseq ,content ," +
			    		"seq FROM tab_book where  pseq = ?"); 
	            statement.prepare();
	            statement.bind(1, storeid);                                  
	            Cursor cursor = statement.getCursor();     
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                vec.addElement(new za_bookcontent(
	                		row.getInteger(0),
	                		row.getInteger(1), 
	                		row.getInteger(2),
	                		row.getString(3),
	                		row.getInteger(4)         		
	                		));    	                
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
	
	public Vector selectbook(int bookid )
	{		Vector vec = new Vector();		  
		 try
	        {
			   
			 	vec.removeAllElements();			 
            // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
			    Statement statement = db.createStatement("SELECT id, bookid,pseq ,content ," +
			    		"seq FROM tab_book where  bookid = ? and pseq = 1"); 
	            statement.prepare();
	            statement.bind(1, bookid);                                  
	            Cursor cursor = statement.getCursor();     
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                vec.addElement(new za_bookcontent(
	                		row.getInteger(0),
	                		row.getInteger(1), 
	                		row.getInteger(2),
	                		row.getString(3),
	                		row.getInteger(4)         		
	                		));    	                
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
	
	public Vector selectcontent(int bookid , int pseq, int pseqe )
	{		Vector vec = new Vector();		  
		 try
	        {
			   
			 	vec.removeAllElements();			 
               // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
			    Statement statement = db.createStatement("SELECT id, bookid,pseq ,content ," +
			    		"seq FROM tab_book where  bookid = ? and seq > ? and seq < ?"); 
	            statement.prepare();
	            statement.bind(1, bookid);                                  
	            statement.bind(2, pseq);
	            statement.bind(3, pseqe);
	            Cursor cursor = statement.getCursor();     
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                vec.addElement(new za_bookcontent(
	                		row.getInteger(0),
	                		row.getInteger(1), 
	                		row.getInteger(2),
	                		row.getString(3),
	                		row.getInteger(4)         		
	                		));    	                
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
