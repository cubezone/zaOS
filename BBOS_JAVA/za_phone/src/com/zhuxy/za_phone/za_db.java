package com.zhuxy.za_phone;

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
	
	private  String DB_NAME = "za_bill.dbf"; 
	Database db  ;
	
	static za_db m_db = null;
	 String dbLocation = "/store/home/user/documents/"; 				
	 URI uri = URI.create(dbLocation + DB_NAME); 
	 
	static za_db getInstanct()throws Exception
	{
		if (m_db == null)
			m_db = new za_db();
		return m_db;		
	}
	
	public za_db() throws Exception
	{
     
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
        
	}
	
	
	void open() throws Exception
	{
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
		Vector vec = new Vector();
		 try
	        {
			 	billcycle = billcycle +"%";
               // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
			    Statement statement = db.createStatement("SELECT id,otherpart , " +
			    		" dt,duration ,in_out, location ,cdr_type,cdr_subtype," +
			    		"mcc,mnc,lac,cell,content " +
			    		"FROM tab_cdr where dt like ? "); 
	            statement.prepare();
	            statement.bind(1, billcycle);                                  
	            Cursor cursor = statement.getCursor();     
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                vec.insertElementAt(new za_cdr(
	                		row.getInteger(0),
	                		row.getString(1),
	                		row.getString(2),
	                		row.getInteger(3),
	                		row.getInteger(4),
	                		row.getString(5),
	                		row.getString(6),
	                		row.getString(7),
	                		row.getString(8),
	                		row.getString(9),
	                		row.getString(10),
	                		row.getString(11),
	                		row.getString(12)
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
	
	public Vector selectgroup(String otherpart)
	{			
		Vector vec = new Vector();
		 try
	        {
			
               // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
			    Statement statement = db.createStatement("SELECT id,otherpart , " +
			    		" dt,duration ,in_out, location ,cdr_type,cdr_subtype," +
			    		"mcc,mnc,lac,cell,content " +
			    		"FROM tab_cdr where otherpart = ? "); 
	            statement.prepare();
	            statement.bind(1, otherpart);                                  
	            Cursor cursor = statement.getCursor();     
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                vec.insertElementAt(new za_cdr(
	                		row.getInteger(0),
	                		row.getString(1),
	                		row.getString(2),
	                		row.getInteger(3),
	                		row.getInteger(4),
	                		row.getString(5),
	                		row.getString(6),
	                		row.getString(7),
	                		row.getString(8),
	                		row.getString(9),
	                		row.getString(10),
	                		row.getString(11),
	                		row.getString(12)
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
	
	public void insert(za_cdr cdr)
	{	
		 try
	        {
	            // INSERT a row into the Category table for the new category
	            Statement statement = db.createStatement("INSERT INTO tab_cdr " +
	            		"VALUES(null,?,?,?,?,?,?,?,?,?,?,?,?)");                     
	            statement.prepare();            
	            statement.bind(1, cdr.otherpart);
	            statement.bind(2, cdr.dt);
	            statement.bind(3, cdr.duration);
	            statement.bind(4, cdr.in_out);
	            statement.bind(5, cdr.location);
	            statement.bind(6, cdr.cdr_type);
	            statement.bind(7, cdr.cdr_subtype);	           
	            statement.bind(8, cdr.mcc);
	            statement.bind(9, cdr.mnc);
	            statement.bind(10, cdr.lac);
	            statement.bind(11, cdr.cell);
	            statement.bind(12, cdr.content);
	            
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
	            Statement statement = db.createStatement("delete from tab_cdr " +
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
	   
/*	   public static void ratecdr(final za_cdr l_cdr)
	    {
	        UiApplication.getUiApplication().invokeLater(new Runnable()
	        {
	            public void run()
	            {
	            	((za_app)UiApplication.getUiApplication()).ratecdr(l_cdr);
	            } 
	        });
	    }
*/
}
