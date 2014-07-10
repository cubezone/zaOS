package com.zhuxy.za_bill;

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
	
	private  String DB_NAME = "za_trip.dbf"; 
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
	
	
	public void insert(za_bill i_billitem)
	{	
		 try
	        {
			  Statement statement = db.createStatement("delete from  tab_bill " +
		      		" where id = ?");                     
		      statement.prepare();            
		      statement.bind(1,i_billitem.row);		      
		      
		      statement.execute(); 
		      statement.close(); 	            
      
	            statement = db.createStatement("INSERT INTO tab_bill " +
	            		"VALUES(null, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");                     
	            statement.prepare();            
	            statement.bind(1,i_billitem.bill_cycle);
	            statement.bind(2,i_billitem.bill_type);
	            statement.bind(3,i_billitem.pay_type);
	            statement.bind(4,i_billitem.bill_time);
	            statement.bind(5,i_billitem.desc);	            
	            statement.bind(6,i_billitem.icon_name);
	            statement.bind(7,i_billitem.update_time);
	            statement.bind(8,i_billitem.LAC);
	            statement.bind(9,i_billitem.CELL);
	            statement.bind(10,i_billitem.location);
	            statement.bind(11,i_billitem.LAC2);
	            statement.bind(12,i_billitem.CELL2);
	            statement.bind(13,i_billitem.location2);
	            statement.bind(14,i_billitem.remark);
	            statement.bind(15,i_billitem.count);	           
	            statement.bind(16,i_billitem.fee);
	            
	            statement.execute(); 
	            statement.close(); 	            	       
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_db.errorDialog(dbe.toString());
	        }	        
	}

	public Vector selectbill(String billcycle )
	{		Vector vec = new Vector();		  
		 try
	        {
			   
			 	vec.removeAllElements();			 
            // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
			    Statement statement = db.createStatement("SELECT  * " +
			    		"from  tab_bill where  bill_cycle = ? "); 
	            statement.prepare();
	            statement.bind(1, billcycle);                                  
	            Cursor cursor = statement.getCursor();
	            int fee = 0;
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                za_bill l_bill = new za_bill(
	                		row.getInteger(0),
	                		row.getString(1),		                		
	                		row.getString(2), 
	                		row.getString(3),
	                		row.getString(4),
	                		row.getString(5),
	                		row.getString(6),
	                		row.getString(7),
	                		row.getString(8),
	                		row.getString(9),
	                		row.getString(10),
	                		row.getString(11),
	                		row.getString(12),
	                		row.getString(13),
	                		row.getString(14), 
	                		row.getInteger(15), 
	                		row.getInteger(16)
	                		);
	                fee += row.getInteger(16);
	                l_bill.totalfee = fee;
	                vec.insertElementAt(l_bill,0);    	                
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
	
	public void delete(int rowid)
	{	
		 try
	        {	           
	            Statement statement = db.createStatement("delete from tab_bill " +
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
	
	public Vector selectbillitem(int item )
	{		Vector vec = new Vector();		  
		 try
	        {
			   
			 	vec.removeAllElements();			 
            // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
			    Statement statement = db.createStatement("SELECT  * " +
			    		"from  tab_billitem where  parentid = ? "); 
	            statement.prepare();
	            statement.bind(1, item);                                  
	            Cursor cursor = statement.getCursor();     
	            while(cursor.next())
	            {
	                Row row = cursor.getRow(); 
	                vec.addElement(new za_billitem(
	                		row.getInteger(0),
	                		row.getString(1),	
	                		row.getString(2), 
	                		row.getInteger(3) 	
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
