/*
 * CDRBilling.java
 *
 * ? <your company here>, 2003-2008
 * Confidential and proprietary.
 */

package com.rim.samples.device.a_sms;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.LabelField;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.component.SeparatorField;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.system.Characters;
import net.rim.blackberry.api.phone.phonelogs.PhoneLogs;
import net.rim.blackberry.api.phone.phonelogs.CallLog;
import net.rim.device.api.ui.component.Status;

import net.rim.blackberry.api.phone.phonelogs.PhoneCallLog;
import net.rim.device.api.system.IDENInfo;
import net.rim.device.api.system.GPRSInfo;
import net.rim.device.api.system.KeyListener;
import net.rim.blackberry.api.phone.Phone;


import java.io.*;
import java.util.*;
import javax.microedition.io.Connector;
import javax.microedition.io.file.FileConnection;
 import javax.microedition.midlet.*;
 import javax.microedition.io.*;
 import javax.wireless.messaging.*;
 import net.rim.blackberry.api.sms.*;


/**
 * 
 */

final class za_sms extends MainScreen implements MessageListener ,OutboundMessageListener
{
  RichTextField l_rich = new RichTextField("...\r\n\r\n\r\n\r\n\r\n\r\n");
    MessageConnection messconn;
      boolean done;
    private String l_msg=" ";      
      Reader reader;
     String fn ="store/home/user/documents/SMS.txt";
  public  za_sms() 
  {    
      setTitle("¶ÌÐÅ¼àÌý:");
       add(l_rich);         
      // Initial tests setup and execution.
   
         try {
      // Get our receiving port connection.
          messconn = (MessageConnection)
             Connector.open("sms://:0");
             // Register a listener for inbound messages.
           messconn.setMessageListener(this);
             // Start a message-reading thread.
             done = false;
          reader = new Reader();
         new Thread(reader).start();
        } catch (IOException e) {
          l_rich.setText(l_rich.getText()+e.toString());
           }
      }
      public void saveSMS(String str)
  {
       FileConnection fc = null;   
       boolean l_new= false;  
       //String fn ="SDCard/GPRSPos.txt";       
     try 
     {
            fc = (FileConnection)Connector.open("file:///" + fn,Connector.READ_WRITE);  
            if( !fc.exists())
            {
                fc.create();  
                l_new = true;
            }
            OutputStream l_dop =  fc.openOutputStream(99999999);        
            if (l_new)// uef-8 head flag;
            {
            l_dop.write(0xEF);
            l_dop.write(0xBB);
            l_dop.write(0xBF);
            }
            l_dop.write(str.getBytes());       
            l_dop.flush(); 
            l_dop.close();
            fc.close();                
        } 
        catch (Exception ioex) 
        {
            Dialog.alert("Error : "+ioex.toString() + fn);
        } 
        finally 
        {
            if (fc != null) 
            {
                try 
                {
                    fc.close();
                    fc = null;
                } 
                catch (Exception ioex) 
                {
                }
            }             
    }
  }
        public void showmsg(Message mess)
  {
      try{
           if (mess instanceof TextMessage)
                 l_msg="TextMessage"+
                 mess.getAddress()+mess.getTimestamp().toString()+((TextMessage)mess).getPayloadText();
               if (mess instanceof MultipartMessage)
                 l_msg="MultipartMessage"+
                 mess.getAddress()+mess.getTimestamp().toString();
               if (mess instanceof BinaryMessage)
                l_msg="BinaryMessage"+
                mess.getAddress()+mess.getTimestamp().toString() + new String(((BinaryMessage)mess).getPayloadData(),"UTF-8");
                saveSMS(l_msg+"\r\n");  
                  UiApplication.getUiApplication().invokeLater(new Runnable()
                  {
                    public void run()
                    {                        
                       l_rich.setText(l_msg);
                    }
                  });
        }catch (IOException e) {
          l_rich.setText(l_rich.getText()+e.toString());
           }
      }
      
      // Asynchronous callback for inbound message.
      public void notifyIncomingMessage(MessageConnection conn) {
        if (conn == messconn) {
            reader.handleMessage();
          }
      }
            
      public void notifyOutgoingMessage(Message message)
      {
          showmsg(message);
      }
      // Required MIDlet method - release the connection and
      // signal the reader thread to terminate.
      public void pauseApp() {
  done = true;
   try {
      messconn.close();
  } catch (IOException e) {
      l_rich.setText(l_rich.getText()+e.toString());
   }
      }
      // Required MIDlet method - shutdown.
      // @param unconditional forced shutdown flag
      public boolean onClose() {
         done = true;
      try {
           messconn.setMessageListener(null);
           messconn.close();
      } catch (IOException e) {
       l_rich.setText(l_rich.getText()+e.toString());
         }
         return super.onClose();
      }
      // Isolate blocking I/O on a separate thread, so callback
      // can return immediately.
      class Reader implements Runnable {
    private int pendingMessages = 0;

       // The run method performs the actual message reading.
         public void run() {
        while (!done) {
            synchronized(this) {
               if (pendingMessages == 0) {
                        try {
                      wait();
                    } catch (Exception e) {
                            // Handle interruption
                     }
                  }
              pendingMessages--;
                 }
  
            // The benefit of the MessageListener is here.
                 // This thread could via similar triggers be
           // handling other kind of events as well in
            // addition to just receiving the messages.
    
              try {                  
              Message mess = messconn.receive();
                 showmsg(mess);
                 } catch (IOException e) {
               l_rich.setText(l_rich.getText()+e.toString());
               }
          }
  }
 
 public synchronized void handleMessage() {
          pendingMessages++;
              notify();
        }       
       }
  }


