package com.zhuxy.za_store;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Calendar;

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
import net.rim.device.api.system.CodeModuleManager;
import net.rim.device.api.system.CodeSigningKey;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.container.MainScreen;

public class za_sqllit extends MainScreen {
	
	private static String DB_NAME = "za_sqllit.db"; 
	Database db  ;
	RichTextField l_rich = new RichTextField("按下r，显示网络信息\r\n\r\n\r\n\r\n");  
	
	public za_sqllit() throws Exception
	  {
		 add(l_rich);
		
		 String dbLocation = "/store/home/user/documents/"; 
				
		 URI uri = URI.create(dbLocation + DB_NAME);     
         
         // Open or create a plain text database.  This will create the
         // directory and file defined by the URI (if they do not already exist).
         db  = DatabaseFactory.openOrCreate(uri, new DatabaseSecurityOptions(false));  
         
         // Close the database in case it is blank and we need to write to the file
         db.close();
         
         // Open a connection to the database file        
         FileConnection fileConnection = (FileConnection)Connector.open("file://" + dbLocation + DB_NAME);    
         
         // If the file is blank, copy the pre-defined database from this
         // module to the SDCard.
         if(fileConnection.exists() && fileConnection.fileSize() == 0)
         {                      
             readAndWriteDatabaseFile(fileConnection);           
         }         
         
         // Retrieve the code signing key for the XYZ key file
         CodeSigningKey codeSigningKey = CodeSigningKey.get(CodeModuleManager.getModuleHandle( "SQLiteDemo" ), "XYZ");
         
         try
         {
             // Encrypt and protect the database.  If the database is already
             // encrypted, the method will exit gracefully. 
             DatabaseFactory.encrypt(uri, new DatabaseSecurityOptions(codeSigningKey));
         }
         catch(DatabaseException dbe)
         {
             errorDialog("Encryption failed - " + dbe.toString());         
         }
         
         // Open the database            
         db = DatabaseFactory.open(uri);
		
         insert();
	  }
	
	void closeDB()
    {        
        try
        {            
           db.close();
        }
        catch(DatabaseException dbe)
        {
            za_sqllit.errorDialog(dbe.toString());
        }
    }  
	
	public boolean onClose()
	{
		closeDB();
		return super.onClose();
	}
	
	public void insert()
	{
		String name= Calendar.getInstance().getTime().toString();
		 try
	        {
	            // INSERT a row into the Category table for the new category
	            Statement statement = db.createStatement("INSERT INTO Category VALUES(null, ?)");                     
	            statement.prepare();            
	            statement.bind(1, name);
	            statement.execute(); 
	            statement.close(); 
	            
	            // Query the database for the auto-generated ID of the category just added
	            // and create a new Category object.
	            statement = db.createStatement("SELECT category_id , category_name FROM Category  "); 
	            statement.prepare();
	            //statement.bind(1, name);                                  
	            Cursor cursor = statement.getCursor();     
	            l_rich.setText("");
	            while(cursor.next())
	            {
	                Row row = cursor.getRow();
	                int id = row.getInteger(0);
	                String str = row.getString(1);
	                //errorDialog(Integer.toString(id));     
	                l_rich.setText(l_rich.getText()+"\r\n"+
	                		Integer.toString(id)+":"+str);
	            }                 
	            cursor.close();
	            statement.close();
	        }
	        catch(DatabaseException dbe)
	        {
	        	za_sqllit.errorDialog(dbe.toString());
	        }    
	        catch(DataTypeException dte)
	        {
	        	za_sqllit.errorDialog(dte.toString());
	        }
	        
	}
		  
	 public void readAndWriteDatabaseFile(FileConnection fileConnection) throws IOException
	    {        
	        OutputStream outputStream = null;
	        InputStream inputStream = null;       
	                       
	        // Open an input stream to the pre-defined encrypted database bundled
	        // within this module.
	        inputStream = getClass().getResourceAsStream("/" + DB_NAME); 
	        
	        // Open an output stream to the newly created file
	        outputStream = (OutputStream)fileConnection.openOutputStream();                                       
	        
	        // Read data from the input stream and write the data to the
	        // output stream.            
	        byte[] data = new byte[256];
	        int length = 0;
	        while (-1 != (length = inputStream.read(data)))
	        {
	            outputStream.write(data, 0, length);                
	        }     
	        
	        // Close the connections
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
