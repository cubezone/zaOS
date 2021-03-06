/*
 * CDRBilling.java
 *
 * ? <your company here>, 2003-2008
 * Confidential and proprietary.
 */

package com.rim.samples.device.a_calllog;
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

/**
 * 
 */

final class za_CDRBilling extends MainScreen
{
  PhoneCallLog l_pcall;
  PhoneLogs l_log =  PhoneLogs.getInstance();
  RichTextField l_rich = new RichTextField("按下ALT，同时移动轨迹球来显示明细");
  CallLog l_call;
  int n = 0;
  int out_time=0;
  int in_time=0;
  int out_n=0;
  int in_n=0;
  String l_month;
   FileConnection fc = null;
  Timer l_timer = new Timer();
  public  za_CDRBilling(String month) 
  {
      l_month = month;
      for (int m = 0; m < l_log.numberOfCalls(PhoneLogs.FOLDER_NORMAL_CALLS) ; m++)
      {
           
           l_call = l_log.callAt(m,PhoneLogs.FOLDER_NORMAL_CALLS);  
           if (l_call.getDate().toString().indexOf(l_month) < 0 )
             continue;
         
           l_pcall = (PhoneCallLog)l_call; 
           
           if (l_pcall.getParticipant().getNumber().equals("10010"))
             continue;
                      
            if( l_pcall.getType() == PhoneCallLog.TYPE_PLACED_CALL)  
            {
                out_n ++;
                out_time += (l_call.getDuration()+59)/60;
            }
            else
            {
                in_n ++;
                in_time += (l_call.getDuration()+59)/60;
             } 
             n = m;
      }
      setTitle("通话记录:"+l_month);
      add(new LabelField("主叫次数:"+Integer.toString(out_n) + " 分钟数:"+Integer.toString(out_time)));
      add(new LabelField("被叫次数:"+Integer.toString(in_n) + " 分钟数:"+Integer.toString(in_time)));
      

     addMenuItem( new MenuItem("本机号码",200,100){
           public void run() { Status.show(Phone.getDevicePhoneNumber(true));}
          });    
                     
      addMenuItem( new MenuItem("通话记录数",200,100){
           public void run() { Dialog.alert("总数:" +Integer.toString( PhoneLogs.getInstance().numberOfCalls(PhoneLogs.FOLDER_NORMAL_CALLS)));}
          });    
                                                     
      addMenuItem( new MenuItem("保存到文件",200,100){
           public void run() {            
           Status.show("正在保存通话记录...",5000);
            UiApplication.getUiApplication().invokeLater( new Runnable()
            {               
            public void run()
            {
            String fn ="store/home/user/documents/CallLog_"+l_month+".txt";
            //String fn ="SDCard/sCallLog.txt";
        try 
        {
             fc = (FileConnection)Connector.open("file:///" + fn,Connector.READ_WRITE);  
             if( !fc.exists())
                fc.create();  
             String l_out="" ;  
       
       for (int m = 0; m <  l_log.numberOfCalls(PhoneLogs.FOLDER_NORMAL_CALLS) ; m++)
      {                        
           l_call = l_log.callAt(m,PhoneLogs.FOLDER_NORMAL_CALLS);  
           if (l_call.getDate().toString().indexOf(l_month) < 0 )
             continue;
           if (l_call instanceof PhoneCallLog)
           {
            l_pcall = (PhoneCallLog)l_call ; 
           l_out  +=  Integer.toString(m)+"\t"+"number:\t"+l_pcall.getParticipant().getNumber()+"\t";
           if( l_pcall.getType() == PhoneCallLog.TYPE_PLACED_CALL)             
           l_out  += "\ttype:\t"+"outgoing"+"\t";
           if( l_pcall.getType() == PhoneCallLog.TYPE_RECEIVED_CALL)           
           l_out  += "\ttype:\t"+"incoming"+"\t";                      
           l_out  += "\tstatus:\t"+Integer.toString(l_call.getStatus())+"\t";
           l_out  += "\tdate:\t"+l_call.getDate().toString() +"\t";
           l_out  += "\tduration:\t"+Integer.toString(l_call.getDuration()) +"\r\n";     
           }                 
      }           
      DataOutputStream l_dop =  fc.openDataOutputStream();
     l_dop.write(l_out.getBytes());  
     l_dop.flush(); 
     l_dop.close();
      fc.close();
          Dialog.alert("文件已经保存"+ fn);           
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
    }});
           }
          });     
      getMenu(0).addSeparator();    
      add( new SeparatorField());                            
      add(l_rich);         
  }
   
  protected boolean navigationMovement(int dx, int dy, int status,int time)
  {
        boolean ret;   
         String l_out="" ;    
              
       if (!((KeyListener.STATUS_ALT & status)==KeyListener.STATUS_ALT ))
        return super.navigationMovement(dx, dy, status, time);
                    
        if (dy > 0)// zoom in 
            if ( n + dy < l_log.numberOfCalls(PhoneLogs.FOLDER_NORMAL_CALLS ))
              n = n + dy ;
        if (dy < 0 ) // zoom out
            if(n +dy >= 0) 
              n = n +dy;         
       
           l_call = l_log.callAt(n,PhoneLogs.FOLDER_NORMAL_CALLS);  
           l_pcall = (PhoneCallLog)l_call;
           
           l_out  +=  Integer.toString(n)+"\n"+"number: "+l_pcall.getParticipant().getNumber()+"\n";
           if( l_pcall.getType() == PhoneCallLog.TYPE_PLACED_CALL)             
           l_out  += "type: "+"主叫"+"\n";
           if( l_pcall.getType() == PhoneCallLog.TYPE_RECEIVED_CALL)           
           l_out  += "type: "+"被叫"+"\n";
                      
           l_out  += "status: "+Integer.toString(l_call.getStatus())+"\n";
           l_out  += "date: "+l_call.getDate().toString() +"\n";
           l_out  += "duration: "+Integer.toString(l_call.getDuration()) +"\n";
              
           l_rich.setText(l_out);     
           return true;            
    }      
} 



