package com.zhuxy.za_stock;

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
	
	private  String DB_NAME = "za_stock.dbf"; 
	Database db;
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
	
	public Vector select(String billcycle)
	{				  
		Vector vec = new Vector();
		 try
	        {
			 	vec.removeAllElements();
			 	billcycle = billcycle +"%";

			    Statement statement = db.createStatement("SELECT id ,symbol ,cnt,fee " +
			    		"FROM tab_stock where symbol like ?  "); 
	            statement.prepare();
	            statement.bind(1,billcycle);                               
	            Cursor cursor = statement.getCursor();     
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                vec.insertElementAt(new za_stock(
	                		row.getInteger(0), 
	                		row.getString(1),
	                		row.getInteger(2),
	                		row.getInteger(3)
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
	
	public Vector selecttrade(String billcycle)
	{				  
		Vector vec = new Vector();
		 try
	        {
			 	vec.removeAllElements();
			 	billcycle = billcycle +"%";
               // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
			    Statement statement = db.createStatement("SELECT id ,symbol, cnt,fee, dt " +
			    		"FROM tab_stocktrade "); 
	            statement.prepare();
	                                              
	            Cursor cursor = statement.getCursor();     
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                vec.insertElementAt(new za_stocktrade(
	                		row.getInteger(0), 
	                		row.getString(1),
	                		row.getString(2),
	                		row.getString(3),
	                		row.getString(4)	                		
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
	

	
	public void inserttrade(za_stocktrade l_st)
	{	
		 try
	        {
	            // INSERT a row into the Category table for the new category
	            Statement statement = db.createStatement("INSERT INTO tab_stocktrade " +
	            		"VALUES(null, ?,?,?,?,?)");                     
	            statement.prepare();            
	            
	            statement.bind(1, l_st.m_symbol);
	            statement.bind(2, l_st.m_type);
	            statement.bind(3, l_st.m_count);
	            statement.bind(4, l_st.m_fee);
	            statement.bind(5, l_st.m_datetime);
	            	            
	            statement.execute(); 
	            statement.close(); 	            	       
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }	        
	}
	
	
	public void insert(za_stock l_st)
	{	
		 try
	        {
			  Statement statement = db.createStatement("delete from  tab_stock " +
	      		" where symbol = ?");                     
		      statement.prepare();            
		      statement.bind(1,l_st.m_symbol);		      
		      
		      statement.execute(); 
		      statement.close(); 	     
	      
	            // INSERT a row into the Category table for the new category
	           statement = db.createStatement("INSERT INTO tab_stock " +
	            		"VALUES(null, ? ,? ,? )");                     
	            statement.prepare();            
	            statement.bind(1, l_st.m_symbol);
	            statement.bind(2, l_st.m_count);
	            statement.bind(3, l_st.m_fee);	           
	            
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
