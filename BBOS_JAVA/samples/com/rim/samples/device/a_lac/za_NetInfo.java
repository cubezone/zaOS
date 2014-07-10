/*
 * za_NetInfo.java
 *
 * ? <your company here>, 2003-2008
 * Confidential and proprietary.
 */

package com.rim.samples.device.a_lac;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.EditField;
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
import net.rim.device.api.system.SIMCardInfo;


import java.io.*;
import java.util.*;
import javax.microedition.io.Connector;
import javax.microedition.io.file.FileConnection;

/**
 * 
 */

final class za_NetInfo extends MainScreen
{
  RichTextField l_rich = new RichTextField("按下r，显示网络信息\r\n\r\n\r\n\r\n");
  EditField l_memo = new EditField("位置:","");
  EditField l_date = new EditField("时间:","");
  int n = 0;
  String fn ="store/home/user/documents/GPRSPos.txt";
 refrethpos l_rpos= new refrethpos();   
  public  za_NetInfo() 
  {
     setTitle("GPRS网络信息");     
     addMenuItem( new MenuItem("保存信息",200,100){
           public void run() {
               Status.show("信息追加到"+ fn); 
               savePos("\r\n"+l_date.getText()+"\r\n"+l_memo.getText()+l_rich.getText()+"\r\n");     ;}
          });     
     addMenuItem( new MenuItem("IMSI",200,100){
           public void run() { 
           try {Dialog.alert(GPRSInfo.imeiToString(SIMCardInfo.getIMSI(),false));
           }
           catch(Exception ioex){};}
          });                       
     addMenuItem( new MenuItem("本机号码",200,100){
           public void run() { Dialog.alert(Phone.getDevicePhoneNumber(true));}
          });    
     addMenuItem( new MenuItem("IMEI",200,100){
           public void run() { Dialog.alert(GPRSInfo.imeiToString(GPRSInfo.getIMEI()));}
          });                 
                                                                  
      getMenu(0).addSeparator();                          
      add(l_memo); 
      add(l_date);
      add( new SeparatorField()); 
      add(l_rich);  
     savePos("\r\nPosition Record Started ..\r\n");              
     l_rpos.start();
     
  }
  
  public String getnetinfo()
  {
       Calendar l_c = Calendar.getInstance();       
       l_date.setText(String.valueOf(l_c.get(l_c.YEAR))+"/" 
                      + String.valueOf(l_c.get(l_c.MONTH)+1)+"/"
                      + String.valueOf(l_c.get(l_c.DAY_OF_MONTH))+" "
                      + String.valueOf(l_c.get(l_c.HOUR_OF_DAY))+":"
                      + String.valueOf(l_c.get(l_c.MINUTE ))+":"        
                      + String.valueOf(l_c.get(l_c.SECOND)));   
       String l_out="\r\n";                                                   
        try{
          l_out += "RSSI:"+ Integer.toString( GPRSInfo.getCellInfo().getRSSI())+"\r\n"; 
          l_out += "MCC:"+ Integer.toHexString( GPRSInfo.getCellInfo().getMCC()).toUpperCase()+";  ";
          l_out += "MNC:"+ Integer.toHexString( GPRSInfo.getCellInfo().getMNC()).toUpperCase()+";\r\n";          
          l_out += "LAC:"+ Integer.toString( GPRSInfo.getCellInfo().getLAC())+";  ";
          l_out += "CELLID:"+ Integer.toString( GPRSInfo.getCellInfo().getCellId())+";\r\n";
          l_out += "BSIC:"+ Integer.toString( GPRSInfo.getCellInfo().getBSIC())+";  ";
          l_out += "ARFCN:"+ Integer.toString( GPRSInfo.getCellInfo().getARFCN())+";\r\n";                        
          l_out += "HMCC:"+ Integer.toHexString( GPRSInfo.getHomeMCC()).toUpperCase()+";  ";
          l_out += "HMNC:"+ Integer.toHexString( GPRSInfo.getHomeMNC()).toUpperCase()+";  ";                  
          l_out += "RAC:"+ Integer.toString( GPRSInfo.getCellInfo().getRAC())+";";          
        }
           catch (Exception ioex) 
        {         
          l_out += ioex.toString()+"\r\n" ;
           try{
          l_out += "iDEN信息\r\n";         
          l_out += "网络名称;"+ IDENInfo.getHomeNetworkName()+"\r\n";                            
          l_out += "CellID :"+ Integer.toString(IDENInfo.getCellInfo().getCellId())+"\r\n";
          l_out += "SAID   :"+ Integer.toString( IDENInfo.getCellInfo().getSAId())+"\r\n";
          l_out += "NDC    :"+ Integer.toString( IDENInfo.getCellInfo().getNDC())+"\r\n";           
          l_out += "MCC    :"+ Integer.toString( IDENInfo.getCellInfo().getMCC())+"\r\n";           
          l_out += "HM MCC :"+ Integer.toString( IDENInfo.getHomeMCC())+"\r\n";           
          l_out += "HM MDC :"+ Integer.toString( IDENInfo.getHomeNDC())+"\r\n";           
          l_out += "LLAID  :"+ Integer.toString( IDENInfo.getCellInfo().getLLAId());             
        }
        catch (Exception ioex2) 
        {
           l_out += ioex2.toString()+"\r\n" ;
         };          
       }       
       return l_out; 
  }
        
  public void savePos(String str)
  {
       FileConnection fc = null;     
       //String fn ="SDCard/GPRSPos.txt";       
     try 
     {
            fc = (FileConnection)Connector.open("file:///" + fn,Connector.READ_WRITE);  
            if( !fc.exists())
                fc.create();  
            OutputStream l_dop =  fc.openOutputStream(99999999);        
            l_dop.write(str.getBytes("UTF-8"));       
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
  public boolean onSavePrompt()
  {
      return true;
  }
    public boolean  onClose()
  {
     if( Dialog.ask(Dialog.D_OK_CANCEL,"确实要退出?",Dialog.CANCEL) == Dialog.OK)
     {
      l_rpos.interrupt();
      savePos("\r\nPosition Record Stoped ..\r\n");        
      return super.onClose();
     }
     else
      return false;
  }
  
  public boolean keyChar(char key, int status, int time)
  {
    if (key == Characters.LATIN_SMALL_LETTER_R)
   {     l_rich.setText(getnetinfo()); return true;}
         return super.keyChar(key,status,time); 
  }
  
     private void updateContent(final String text)
    {
        // This will create significant garbage, but avoids threading issues
        // (compared with creating a static Runnable and setting the text).
        UiApplication.getUiApplication().invokeLater(new Runnable() 
        {
            public void run()
            {
                l_rich.setText(text);
            }
        });
    }
    private class refrethpos extends Thread
    {
        private static final int TIMEOUT = 10000; //10秒钟采集一次
        public void run()
        {
            String l_orich1="old unkonwn position0";            
            String l_orich2="old unkonwn position2";
            String l_orich3="old unkonwn position0";
            String l_orich4="old unkonwn position1";
            String l_orich5="old unkonwn position2";
            String l_orich6="old unkonwn position0";
            String l_orich7="old unkonwn position1";
            String l_orich8="old unkonwn position2";
            String l_orich9="old unkonwn position1";
            String l_nrich ="new position";
            int l_mark=0;
            synchronized(this){
            try{
                wait(3000);
            for(;;)
            {            
              l_nrich=getnetinfo();            
              updateContent(l_nrich);
               if(l_nrich.substring(12).equals(l_orich9.substring(12)))
               {
                 l_mark ++;
                 if (l_mark%6==0)
                    savePos("1");
               }
              else  if(l_nrich.substring(12).equals(l_orich8.substring(12)))
              {
                 l_mark ++;
                 if (l_mark%6==0)
                    savePos("2");
               }
              else if(l_nrich.substring(12).equals(l_orich7.substring(12)))
              {
                 l_mark ++;
                 if (l_mark%6==0)
                    savePos("3");
               }
              else  if(l_nrich.substring(12).equals(l_orich6.substring(12)))
               {
                 l_mark ++;
                 if (l_mark%6==0)
                    savePos("4");
               }
              else  if(l_nrich.substring(12).equals(l_orich5.substring(12)))
              {
                 l_mark ++;
                 if (l_mark%6==0)
                    savePos("5");
               }
              else if(l_nrich.substring(12).equals(l_orich4.substring(12)))
              {
                 l_mark ++;
                 if (l_mark%6==0)
                    savePos("6");
               } 
               else if(l_nrich.substring(12).equals(l_orich3.substring(12)))
               {
                 l_mark ++;
                 if (l_mark%6==0)
                    savePos("7");
               }
              else  if(l_nrich.substring(12).equals(l_orich2.substring(12)))
              {
                 l_mark ++;
                 if (l_mark%6==0)
                    savePos("8");
               }
              else if(l_nrich.substring(12).equals(l_orich1.substring(12)))
              {
                 l_mark ++;
                 if (l_mark%6==0)
                    savePos("9");
               }
              else
              {
                l_mark = 0;
                l_orich1=l_orich2;
                l_orich2=l_orich3;
                l_orich3=l_orich4;
                l_orich4=l_orich5;                
                l_orich5=l_orich6;                                
                l_orich6=l_orich7;                                
                l_orich7=l_orich8;                                
                l_orich8=l_orich9;                                                                                
                l_orich9= l_nrich;
                savePos("\r\n"+l_date.getText()+l_memo.getText()+l_nrich.replace('\r',' ').replace('\n',' ')+"\r\n");
              }                           
              wait(TIMEOUT);
            }
            }catch(Exception ioex)
            {
              updateContent("Err"+ ioex.toString()); 
             };}
            }
    }
} 
