package com.zhuxy.za_phone;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.microedition.io.Connector;
import javax.microedition.io.HttpConnection;
import javax.wireless.messaging.MessageConnection;
import javax.wireless.messaging.TextMessage;

import net.rim.blackberry.api.invoke.Invoke;
import net.rim.blackberry.api.invoke.MessageArguments;
import net.rim.blackberry.api.invoke.PhoneArguments;
import net.rim.device.api.ui.Field;
import net.rim.device.api.ui.FieldChangeListener;
import net.rim.device.api.ui.TransitionContext;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.UiEngineInstance;
import net.rim.device.api.ui.component.ButtonField;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.container.HorizontalFieldManager;
import net.rim.device.api.ui.container.MainScreen;

public class za_cdrscreen extends MainScreen implements FieldChangeListener {

	za_cdr  m_cdr;
	za_cdrgroupscreen l_cdrgroupscreen ;
	
	   TransitionContext transitionContextPush = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
	  	  
       TransitionContext transitionContextPop = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
   
       
	
	ButtonField btf_a = new ButtonField("通话", ButtonField.CONSUME_CLICK
			| ButtonField.NEVER_DIRTY);	
	ButtonField btf_b = new ButtonField("短信", ButtonField.CONSUME_CLICK
			| ButtonField.NEVER_DIRTY|ButtonField.FIELD_RIGHT);
	ButtonField btf_c = new ButtonField("组模式", ButtonField.CONSUME_CLICK
			| ButtonField.NEVER_DIRTY);
	ButtonField btf_d = new ButtonField("位置", ButtonField.CONSUME_CLICK
			| ButtonField.NEVER_DIRTY);
	
	za_wall l_wall;
	za_wall l_wallb;
	
	public za_cdrscreen(za_cdr cdr) {
		m_cdr = cdr;
		
		l_wall = new za_wall();
		l_wall.addTitle("基本信息");
		l_wall.add("号码: " + m_cdr.otherpart);
		l_wall.add("类型: " + m_cdr.cdr_type + " 子类型: " + m_cdr.cdr_subtype);
		l_wall.add("时间: " + m_cdr.dt);
		l_wall.add("费用: " + m_cdr.fee + " 时长: " + m_cdr.duration);		
		l_wall.add("小区: " + m_cdr.lac + " 基站: " + m_cdr.cell);
		l_wall.add("内容: " + m_cdr.content);
		l_wall.add("位置: " + m_cdr.location);
	    add(l_wall);					
		
		HorizontalFieldManager l_hr = new HorizontalFieldManager(HorizontalFieldManager.USE_ALL_WIDTH|
				HorizontalFieldManager.FIELD_HCENTER);
			btf_a.setMargin(0,0,0,20);
			l_hr.add(btf_a);		
			l_hr.add(btf_b);
			l_hr.add(btf_c);
			l_hr.add(btf_d);	
		add(l_hr );
		
		l_wallb = new za_wall();
		l_wallb.addTitle("费用信息");
				
		l_wallb.add("通话次数:"+Integer.toString(m_cdr.row));
		l_wallb.add("固定费:"+ m_cdr.formatfee(m_cdr.monthfee+m_cdr.groupfee));
		l_wallb.add("通信费:"+ m_cdr.formatfee(m_cdr.allfee));		
		 
		l_wallb.add( "集团通话次数:"+Integer.toString(m_cdr.m_groupmin_n) + "  "+
			"集团分钟数:"+Integer.toString(m_cdr.m_groupmin));
		l_wallb.add("主叫通话次数:"+Integer.toString(m_cdr.out_n) + "  "+
			"主叫分钟数:"+Integer.toString(m_cdr.out_time));
		l_wallb.add("被叫通话次数:"+Integer.toString(m_cdr.in_n)+ "  "+
			"被叫分钟数:"+Integer.toString(m_cdr.in_time));
		l_wallb.add("客服通话次数:"+Integer.toString(m_cdr.kf_n) + "  "+
			"客服分钟数:"+Integer.toString(m_cdr.kf_time));	
	    add(l_wallb);				

		btf_a.setChangeListener(this);
		btf_b.setChangeListener(this);
		btf_c.setChangeListener(this);
		btf_d.setChangeListener(this);
		
		transitionContextPush.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
	    transitionContextPush.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_LEFT);
	    transitionContextPop.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
	    transitionContextPop.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_RIGHT);
	    transitionContextPop.setIntAttribute(TransitionContext.ATTR_KIND, TransitionContext.KIND_OUT);
	}

	
	public boolean trackwheelClick(int status, int time) {
		 
	
	
		return true;
	}
	
	// FieldChangeListener listener = new FieldChangeListener() {
	public void fieldChanged(Field field, int context) 
	{
		
		ButtonField buttonField = (ButtonField) field;
		if (buttonField == btf_a) 
		{
			if (Dialog.ask(Dialog.D_OK_CANCEL, "呼叫  " + m_cdr.otherpart) == Dialog.D_OK)
				Invoke.invokeApplication(Invoke.APP_TYPE_PHONE,
						new PhoneArguments(PhoneArguments.ARG_CALL,
								m_cdr.otherpart));
		}
		if (buttonField == btf_b) {
				MessageConnection conn = null;
				TextMessage text = null;
				try {									
					conn = (MessageConnection) Connector.open("sms://");
					conn.close();
					text = (TextMessage) conn
							.newMessage(MessageConnection.TEXT_MESSAGE);
					text.setPayloadText("");
					text.setAddress("sms://" + m_cdr.otherpart);
				} catch (IOException e) {
					Dialog.alert("Exception: " + e);
				}
				Invoke.invokeApplication(Invoke.APP_TYPE_MESSAGES,
						new MessageArguments(text));		
		}
		if (buttonField == btf_c) 
		{
			  if (m_cdr.isOut())
			  {
				  l_cdrgroupscreen = new za_cdrgroupscreen(m_cdr);			
			  Ui.getUiEngineInstance().		  
			  setTransition(this, l_cdrgroupscreen, UiEngineInstance.TRIGGER_PUSH, transitionContextPush);		  
			  Ui.getUiEngineInstance().		  
			  setTransition(l_cdrgroupscreen, this, UiEngineInstance.TRIGGER_POP, transitionContextPop);	
			  UiApplication.getUiApplication().pushScreen(l_cdrgroupscreen); 
			  }
			  else
			  {
				l_cdrgroupscreen = new za_cdrgroupscreen(m_cdr);
		  Ui.getUiEngineInstance().		  
			  setTransition(this, l_cdrgroupscreen, UiEngineInstance.TRIGGER_PUSH, transitionContextPush);		  
			  Ui.getUiEngineInstance().		  
			  setTransition(l_cdrgroupscreen, this, UiEngineInstance.TRIGGER_POP, transitionContextPop);	
			  UiApplication.getUiApplication().pushScreen(l_cdrgroupscreen); 
			  }
		}
		if (buttonField == btf_d)
		{
				HttpConnection c = null;
				OutputStream os = null;
				InputStream is = null;
				String msg = m_cdr.location;
				String LAC = "53505";
				String CELL = "823";
				LAC = m_cdr.lac;
				CELL = m_cdr.cell;      
				msg = "{" +
					  "\"version\": \"1.1.0\"," +
					  "\"host\": \"www.google.com\"," +
					  "\"home_mobile_country_code\": 460," +
					  "\"home_mobile_network_code\": 1," +
					  "\"address_language\": \"zh_CN\"," +
					  "\"radio_type\": \"wcdma\"," +
					  "\"request_address\": true ," +
					  "\"cell_towers\":[" +
					  "{" +
					  "\"cell_id\": "+CELL+ "," +
					  "\"location_area_code\": "+LAC+"," +
					  "\"age\": 0," +
					  "\"timing_advance\": 5555" +
					  "}" +
					  "]" +
					  "}";
				String url= "http://www.google.com/loc/json";
				try {
					c = (HttpConnection)Connector.open(url); 
					c.setRequestMethod(HttpConnection.POST); 
					c.setRequestProperty("User-Agent", "Profile/MIDP-2.0 Configuration/CLDC-1.0");
					c.setRequestProperty("Content-Language", "UTF-8");
					
					os = c.openOutputStream();
					msg.concat("\n");
					os.write(msg.getBytes());
					os.flush();
	
					int rc = c.getResponseCode();
					if (rc != HttpConnection.HTTP_OK) {
		                 throw new IOException("HTTP response code: " + rc);
		             }
 
					 is = c.openInputStream();

					 l_wall.set(6,c.getType());
		             int len = (int)c.getLength();
		             
		             if (len > 0) {
		                 int actual = 0;
		                 int bytesread = 0 ;
		                 byte[] data = new byte[len];
		                 while ((bytesread != len) && (actual != -1)) {
		                    actual = is.read(data, bytesread, len - bytesread);
		                    bytesread += actual;
		                 }
		                 l_wall.set(6,"位置信息："+new String(data,"utf-8"));	
		             } else {		                 
		                 int ret;
		                 byte[] data = new byte[1000];
		                  ret = is.read(data);
		                  if (ret > 0) 
		                	  l_wall.set(6,"位置信息："+new String(data,"utf-8"));
		                  else
		                	  l_wall.set(6,"位置信息：无数据返回。");
		             }		      
		             UiApplication.getUiApplication().relayout();
				} catch (ClassCastException e) {
					 za_db.errorDialog(e.toString());
				} catch (IOException e) {
					za_db.errorDialog(e.toString());
				} finally {
						try {
							if (is != null)is.close();
							if (c != null) c.close();
							if (os != null) os.close();
						} catch (IOException e) {
							za_db.errorDialog(e.toString());
						}
				}

		}
	}
}
