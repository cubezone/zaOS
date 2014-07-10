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
                new MenuItem("关于", 20, 20) {
                 public void run() 
                 {     
                  UiApplication.getUiApplication().pushScreen(new za_about());
                 }} 
          ); 
        
          addMenuItem(
                 new MenuItem("网络信息", 20, 20) {
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
                  new MenuItem("重力计", 20, 20) {
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
    	l_wall.addTitle("内容");
    	l_wall.add("aaaa");
    	l_wall.add("fdsafdsaf");
    	l_wall.add("中文的管理大幅度afk倒萨放空间的萨芬dsl咖啡机dsl发的就是了开发");  
      	l_wall.add("fdsafdsaf");
      	l_wall.set(0,"BBBB");
    	add(l_wall);
     	HorizontalFieldManager l_hr = new HorizontalFieldManager(){
    		 public int getPreferredWidth() { return Display.getWidth();}
    	};
    	ButtonField l_btn = new ButtonField("组模式", ButtonField.CONSUME_CLICK
				| ButtonField.NEVER_DIRTY|ButtonField.FIELD_HCENTER);
			l_hr.add( new ButtonField("组模式", ButtonField.CONSUME_CLICK
					| ButtonField.NEVER_DIRTY|ButtonField.FIELD_HCENTER));		
			l_hr.add( new ButtonField("组模式", ButtonField.CONSUME_CLICK
					| ButtonField.NEVER_DIRTY|ButtonField.FIELD_HCENTER));
			l_hr.add( l_btn);
			l_btn.setMargin(0,0,0,10);
		add(l_hr );
    	za_wall m_wall = new za_wall();
    	m_wall.addTitle("更新历史");
        m_wall.add("2010.");
        m_wall.add("  12/12  V1.6 对话式图形界面");
        m_wall.add("  11/28  V1.5 增加集团优惠");       
        m_wall.add("  10/31  V1.4 增加账期选择");
        m_wall.add("  10/30  V1.2 增加费率设置");
        m_wall.add("  10/24  V1.1 修改界面图标");
        m_wall.add("  10/18  V1.1 增加同步账单显示功能");
        m_wall.add("  10/02  V1.0 清单显示区分主被叫");
        m_wall.add("  09/25  V0.7 增加计费功能");
        m_wall.add("  09/20  V0.5 版本发布");     
        add(m_wall);
	}
	
}
