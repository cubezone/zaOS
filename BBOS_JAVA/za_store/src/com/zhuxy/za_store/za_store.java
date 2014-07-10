package com.zhuxy.za_store;

import java.util.Calendar;
import java.util.Vector;

import net.rim.blackberry.api.phone.Phone;

import net.rim.device.api.system.GPRSInfo;
import net.rim.device.api.system.PersistentObject;
import net.rim.device.api.system.PersistentStore;
import net.rim.device.api.system.SIMCardInfo;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.EditField;

import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.component.SeparatorField;
import net.rim.device.api.ui.component.Status;
import net.rim.device.api.ui.container.MainScreen;

final class za_store extends MainScreen
{
  private PersistentObject m_store; 
  //com.zhuxy.za_store   0xc1de079c3b1a7824L
  static final long PERSISTENT_STORE_ID = 0xc1de079c3b1a7827L;
  Vector m_cnt = new Vector();  
	  
  RichTextField l_rich = new RichTextField("按下r，显示网络信息\r\n\r\n\r\n\r\n");  
  EditField l_memo = new EditField("位置:","");
  EditField l_date = new EditField("时间:","");
  int n = 0;
  
  public  za_store() 
  {
	  m_store = PersistentStore.getPersistentObject(PERSISTENT_STORE_ID);                       
	
      // Synchronize on the PersistentObject so that no other object can
      // acquire the lock before we finish our commit operation.     
      synchronized(m_store)
      {         
          // If the PersistentObject is empty, initialize it
          if(m_store.getContents() == null)
          {        	  
        	  m_cnt.addElement("aaa");
        	  m_cnt.addElement("BBB");
        	  m_cnt.addElement("CCC");
        	  m_cnt.addElement("DDD");
        	  m_cnt.addElement("EEE");
        	  m_store.setContents(m_cnt);             	  
        	  m_store.commit();              
          }            
      }  
      
     setTitle("Store信息");     
     
     addMenuItem( new MenuItem("add time",200,100){
         public void run() {
        	 m_cnt.insertElementAt(Calendar.getInstance().getTime().toString(), 0);
        	 m_store.commit(); 
        	 }
        });     
   
     addMenuItem( new MenuItem("保存信息",200,100){
         public void run() {
             Status.show("信息已经保存"); 
             savePos("\r\n"+l_date.getText()+"\r\n"+l_memo.getText()+l_rich.getText()+"\r\n");     ;}
        });     
   
     addMenuItem( new MenuItem("保存信息",200,100){
           public void run() {
               Status.show("信息已经保存"); 
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
    //l_rpos.start();     
  }
  
  void savePos(String ls)
  {	      
      m_store = PersistentStore.getPersistentObject(PERSISTENT_STORE_ID); 
      
      m_cnt = (Vector)m_store.getContents();
      if (m_cnt.size()>0)
      {
    	  String l_msg = (String)m_cnt.elementAt(0);
    	  l_rich.setText(l_msg);	
      }
  }
}