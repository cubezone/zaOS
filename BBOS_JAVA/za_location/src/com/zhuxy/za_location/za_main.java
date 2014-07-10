/*
 * AppScreen.java
 *
 * Copyright 1998-2008 Research In Motion Ltd.
 * 
 * Note: For the sake of simplicity, this sample application may not leverage
 * resource bundles and resource strings.  However, it is STRONGLY recommended
 * that application developers make use of the localization features available
 * within the BlackBerry development platform to ensure a seamless application
 * experience across a variety of languages and geographies.  For more information
 * on localizing your application, please refer to the BlackBerry Java Development
 * Environment Development Guide associated with this release.
 */

package com.zhuxy.za_location;

import java.io.IOException;

import javax.microedition.io.Connector;
import javax.microedition.io.InputConnection;
import javax.wireless.messaging.MessageConnection;

import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.ButtonField;
import net.rim.device.api.ui.component.LabelField;
import net.rim.device.api.ui.component.BitmapField;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.io.DatagramConnectionBase;
import net.rim.device.api.io.DatagramStatusListener;
import net.rim.device.api.system.Bitmap;
import net.rim.device.api.system.Device;
import net.rim.device.api.ui.container.HorizontalFieldManager;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.system.Display;



final class za_main extends MainScreen implements DatagramStatusListener
{	za_wall l_wall ;

    DatagramConnectionBase m_conn;
    public za_main()
    {
    	RichTextField l_rich = new RichTextField();
    	add (l_rich);
    	
    	try {
			m_conn = (DatagramConnectionBase) Connector.open("http://:0");
			m_conn.setDatagramStatusListener(this);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
        Bitmap l_bmp = new Bitmap(Display.getWidth(), Display.getHeight());
        Display.screenshot(l_bmp);
        addMenuItem(
                new MenuItem("����", 20, 20) {
                 public void run() 
                 {     
                  UiApplication.getUiApplication().pushScreen(new za_about());
                 }} 
          ); 
        
          addMenuItem(
                 new MenuItem("������Ϣ", 20, 20) {
                  public void run() 
                  {     
                   UiApplication.getUiApplication().pushScreen(new za_NetInfo());
                  }} 
           );          
          
          addMenuItem(
                  new MenuItem("settext a ", 20, 20) {
                   public void run() 
                   {     
                	    l_wall.set(3, "aaaaaaaaaaaaaa  aaaaa aaaaaaaa aaaaa aaaaaaaa)"); 
                	    UiApplication.getUiApplication().relayout();
                	    
                	    }} 
            );  
          addMenuItem(
                  new MenuItem("power off", 20, 20) {
                   public void run() 
                   {     
                	
                	   Device.requestPowerOff(true);
                	    }} 
            ); 
          addMenuItem(
                  new MenuItem("back", 20, 20) {
                   public void run() 
                   {     
                	   UiApplication.getUiApplication().requestBackground();
                	                   	    
                	    }} 
            );  
          
          addMenuItem(
                  new MenuItem("������", 20, 20) {
                   public void run() 
                   {     
                	int directions = net.rim.device.api.system.Display.DIRECTION_PORTRAIT;
                	net.rim.device.api.ui.Ui.getUiEngineInstance().setAcceptableDirections(directions);                	   
                    UiApplication.getUiApplication().pushScreen(new za_Accl());
                   }}
            );                      
     
    }
	public void updateDatagramStatus(int dgId, int code, Object context) {
		
		
	}
	
	void init()
	{
//    	//setTitle("Media Control");
//    	add( new LabelField(""));
//    	add( new LabelField(""));        
//    	add(new BitmapField( Bitmap.getBitmapResource("pad.png"),FIELD_HCENTER));
    	l_wall = new za_wall();
    	l_wall.addTitle("����");
    	l_wall.add("aaaa");
    	l_wall.add("fdsafdsaf");
    	l_wall.add("���ĵĹ�������afk�����ſռ������dsl���Ȼ�dsl���ľ����˿���");  
      	l_wall.add("fdsafdsaf");
      	l_wall.set(0,"BBBB");
    	add(l_wall);
     	HorizontalFieldManager l_hr = new HorizontalFieldManager(){
    		 public int getPreferredWidth() { return Display.getWidth();}
    	};
    	ButtonField l_btn = new ButtonField("��ģʽ", ButtonField.CONSUME_CLICK
				| ButtonField.NEVER_DIRTY|ButtonField.FIELD_HCENTER);
			l_hr.add( new ButtonField("��ģʽ", ButtonField.CONSUME_CLICK
					| ButtonField.NEVER_DIRTY|ButtonField.FIELD_HCENTER));		
			l_hr.add( new ButtonField("��ģʽ", ButtonField.CONSUME_CLICK
					| ButtonField.NEVER_DIRTY|ButtonField.FIELD_HCENTER));
			l_hr.add( l_btn);
			l_btn.setMargin(0,0,0,10);
		add(l_hr );
    	za_wall m_wall = new za_wall();
    	m_wall.addTitle("������ʷ");
        m_wall.add("2010.");
        m_wall.add("  12/12  V1.6 �Ի�ʽͼ�ν���");
        m_wall.add("  11/28  V1.5 ���Ӽ����Ż�");       
        m_wall.add("  10/31  V1.4 ��������ѡ��");
        m_wall.add("  10/30  V1.2 ���ӷ�������");
        m_wall.add("  10/24  V1.1 �޸Ľ���ͼ��");
        m_wall.add("  10/18  V1.1 ����ͬ���˵���ʾ����");
        m_wall.add("  10/02  V1.0 �嵥��ʾ����������");
        m_wall.add("  09/25  V0.7 ���ӼƷѹ���");
        m_wall.add("  09/20  V0.5 �汾����");     
        add(m_wall);
	}
	
}
