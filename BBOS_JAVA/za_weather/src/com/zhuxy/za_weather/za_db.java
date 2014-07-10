package com.zhuxy.za_weather;

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
	
	private  String DB_NAME = "za_weather.dbf"; 
	Database db  ;
	Vector vec = new Vector();
	
	public za_db() throws Exception
	{

		 String dbLocation = "/store/home/user/documents/"; 				
		 URI uri = URI.create(dbLocation + DB_NAME);      
		 db  = DatabaseFactory.openOrCreate(uri, new DatabaseSecurityOptions(false));           
         db.close();
         
         FileConnection fileConnection = (FileConnection)Connector.open("file://" + dbLocation + DB_NAME);            
         if(fileConnection.exists() && fileConnection.fileSize() == 0)
         {                      
             readAndWriteDatabaseFile(fileConnection);           
         }                 
     /*  CodeSigningKey codeSigningKey = CodeSigningKey.get(CodeModuleManager.getModuleHandle( "SQLiteDemo" ), "XYZ");         
         
         try
         {
             DatabaseFactory.encrypt(uri, new DatabaseSecurityOptions(codeSigningKey));
         }
         catch(DatabaseException dbe)
         {
             errorDialog("Encryption failed - " + dbe.toString());         
         }
     */      
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
	
	public Vector select(String billcycle)
	{				  
		 try
	        {
			 	vec.removeAllElements();
			 	billcycle = billcycle +"%";
               // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
			    Statement statement = db.createStatement("SELECT id ,symbol " +
			    		"FROM tab_stock "); 
	            statement.prepare();
	                                              
	            Cursor cursor = statement.getCursor();     
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                vec.insertElementAt(new za_weather(
	                		row.getInteger(0), 
	                		row.getString(1)	                		
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
	
	public void insert(String symbol)
	{	
		 try
	        {
	            // INSERT a row into the Category table for the new category
	            Statement statement = db.createStatement("INSERT INTO tab_stock " +
	            		"VALUES(null, ?)");                     
	            statement.prepare();            
	            statement.bind(1, symbol);
	            
	            statement.execute(); 
	            statement.close(); 	            	       
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }	        
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
