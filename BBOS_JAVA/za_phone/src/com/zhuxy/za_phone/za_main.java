package com.zhuxy.za_phone;

/*
 * CDRBilling.java
 *
 * ? <your company here>, 2003-2008
 * Confidential and proprietary.
 */

import net.rim.device.api.ui.Color;
import net.rim.device.api.ui.Graphics;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.TouchEvent;
import net.rim.device.api.ui.TouchGesture;
import net.rim.device.api.ui.TransitionContext;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.UiEngineInstance;
import net.rim.device.api.ui.component.ListField;
import net.rim.device.api.ui.component.ListFieldCallback;
import net.rim.device.api.ui.component.Menu;
import net.rim.device.api.ui.component.RichTextField;

import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.ui.container.VerticalFieldManager;
import net.rim.blackberry.api.phone.phonelogs.CallLog;
import net.rim.device.api.ui.decor.BackgroundFactory;
import net.rim.device.api.ui.picker.DateTimePicker;

import net.rim.device.api.system.Display;
import net.rim.device.api.system.KeyListener;
import net.rim.device.api.i18n.DateFormat;
import net.rim.device.api.i18n.SimpleDateFormat;


import java.io.*;
import java.util.*;

import javax.microedition.io.Connector;
import javax.microedition.io.file.FileConnection;

/**
 * 
 */
final public class za_main extends MainScreen {
	//PhoneCallLog l_pcall;
	//PhoneLogs l_log = PhoneLogs.getInstance();
	public CRichTextField l_rich = new CRichTextField("");
	CallLog l_call;
	Vector m_cdrs= new Vector() ;
	Vector m_groups = new Vector();	
	
	int n = 0;
	int out_time = 0;
	int in_time = 0;
	int kf_time = 0;
	int out_n = 0;
	int in_n = 0;
	int kf_n = 0;
	int allfee =0;
	int m_monthfee = 0;
	int m_freegroupmin =0;
	int m_groupmin =0;
	int m_groupmin_n=0;
	int m_groupfee = 0;
	int m_freemin = 0;
	int sms_n = 0;
	int m_rate = 0;
	int m_showtype = 0;
	String m_month;
	FileConnection fc = null;
	Timer l_timer = new Timer();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	SimpleDateFormat l_sdf = new SimpleDateFormat("yyyy/MM");
	ListField myList;
	ListCallback myCallback;
	int row =0;
	za_phonelistener  m_phonelistener;
	za_smslistener m_smslistener;
	
	za_cdrscreen l_cdrscreen;
	
    TransitionContext transitionContextPush = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
    
    TransitionContext transitionContextPop = new TransitionContext(TransitionContext.TRANSITION_SLIDE);

	
	public za_main(String i_month) {
		
		l_rich.setBackground(BackgroundFactory.createSolidBackground(Color.LIGHTSTEELBLUE));
		myList = new ListField();
		myCallback = new ListCallback();
		
		initlist(i_month);			
		initrate();			
		rate();
		
		m_phonelistener = new za_phonelistener();
		m_phonelistener.m_main = this;
		m_phonelistener.start();
		
		myList.setCallback(myCallback);
		myList.setRowHeight(110);		
		add(myList);	
		
		m_smslistener = new za_smslistener();
		m_smslistener.m_main = this;
		m_smslistener.start();
		
		transitionContextPush.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
        transitionContextPush.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_LEFT);
        transitionContextPop.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
        transitionContextPop.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_RIGHT);
        transitionContextPop.setIntAttribute(TransitionContext.ATTR_KIND, TransitionContext.KIND_OUT);
		
	}
	 
	void addcdr(za_cdr l_cdr)
	{	
    	ratecdr(l_cdr);
		m_cdrs.insertElementAt(l_cdr,0);
	 	  
    	synchronized (UiApplication.getEventLock())
     	{	 	            			
			za_main.this.myList.setSize(m_cdrs.size());
			za_main.this.invalidate();    
     	}	      
//		UiApplication.getUiApplication().invokeLater(new Runnable() 
//		{	
//	            public void run()
//	            { 	  
//	            	synchronized (UiApplication.getEventLock())
//	             	{	 	            			
//	        			za_main.this.myList.setSize(m_cdrs.size());
//	        			za_main.this.invalidate();    
//	             	}	            		 	              	 
//	            }
//	       }
//		);
	}
	
	public void initrate()
	{
		FileConnection fc = null;
		String fn = "store/home/user/documents/za_bill.cfg.txt";
		try {			
			byte[] b = new byte[1000];
			fc = (FileConnection) Connector.open("file:///" + fn,
					Connector.READ_WRITE);
			if (!fc.exists()) {
				return;
			}
			InputStream l_dip = fc.openInputStream();			
			int l_len= l_dip.read(b);
			l_dip.close();
			fc.close();
			String text = new String(b,0,l_len,"UTF-8");
			m_monthfee = Integer.parseInt(text.substring(text.indexOf("%0")+2, text.indexOf("%1")));
			m_groupfee = Integer.parseInt(text.substring(text.indexOf("%1")+2, text.indexOf("%2")));
			m_freemin = Integer.parseInt(text.substring(text.indexOf("%2")+2, text.indexOf("%3")));
			m_rate = Integer.parseInt(text.substring(text.indexOf("%3")+2, text.indexOf("%4")));	
			m_freegroupmin = Integer.parseInt(text.substring(text.indexOf("%4")+2, text.indexOf("%5")));
			m_groups.addElement(text.substring(text.indexOf("%5")+2, text.indexOf("%6")));
			m_groups.addElement(text.substring(text.indexOf("%6")+2, text.indexOf("%7")));
			
		} catch (Exception ioex) {
			Dialog.alert("Error : " + ioex.toString() + fn);
		} finally {
			if (fc != null) {
				try {
					fc.close();
					fc = null;
				} catch (Exception ioex) {
				}
			}
		}		
	}
	
	public void ratecdr(za_cdr l_cdr)
	{
		int fee = 0;
		if (l_cdr.isSMS()) //短信
		{
			if (l_cdr.iskefu()) //10010 
			{	
			
			}
			else
			{					
				if (l_cdr.isOut())
				{
					fee= 10;
					allfee += 10;
					sms_n ++;
				}
			}
		}
		else //语音 
		{	
			int l_dur = (l_cdr.duration + 59) / 60;			
			if (l_cdr.iskefu())
			{			    
				kf_n ++;
				kf_time += l_dur ;
				l_dur = 0;
			}
			else 
			{			   			    
				if (l_cdr.isOut()) 
				{
					if (m_groups.indexOf(l_cdr.otherpart)!=-1 )
					{
						m_groupmin += l_dur;
						m_groupmin_n ++;						
						l_dur = 0;
					}
					else
					{
						out_n++;
						if(out_time > m_freemin)
						{										
							allfee += l_dur * m_rate;
							out_time += l_dur ;	
						}else
						{						
							if (out_time + l_dur > m_freemin)
							{
								allfee += (out_time + l_dur - m_freemin)* m_rate;		
								out_time += l_dur ;	
								l_dur = out_time  - m_freemin;
							}
							else
							{
								out_time += l_dur ;	
								allfee += 0* m_rate;
								l_dur = 0;
							}
																			 
						}
					}
				} else {					
					in_n++; 
					in_time += l_dur;
					l_dur = 0;
				}
			}
			fee = l_dur * m_rate;
		}

		l_cdr.kf_n = kf_n;
		l_cdr.kf_time = kf_time;
		l_cdr.in_n = in_n;
		l_cdr.in_time = in_time;
		l_cdr.out_n = out_n;
		l_cdr.out_time = out_time;
		l_cdr.m_groupmin_n = m_groupmin_n;
		l_cdr.m_groupmin = m_groupmin;
		l_cdr.fee = fee;
		l_cdr.allfee = allfee;
		l_cdr.monthfee = m_monthfee;
		l_cdr.groupfee = m_groupfee;
	}
	
	public void initlist(String i_month)
	{
		m_month = i_month;		
		myCallback.deleteall();
		myList.setSize(0);
		l_rich.setText("");				
		try {
			za_db m_db = za_db.getInstanct();
			m_db.open();
			m_cdrs = m_db.select(m_month);
			m_db.close();
		} catch (Exception e) {
			za_db.errorDialog(e.toString());
			e.printStackTrace();
		}				
	}
	
	public void rate()
	{
		m_groupmin=0;
		m_groupmin_n=0;
		out_time = 0;
		in_time = 0;
		kf_time = 0;
		out_n = 0;
		in_n = 0;
		kf_n = 0;
		allfee = 0;
		sms_n = 0;
		
		for (int m = m_cdrs.size() -1; m >=0 ; m --) 
		{
			za_cdr l_cdr = (za_cdr)m_cdrs.elementAt(m);	
			
			ratecdr(l_cdr);
						
			if (m == 0)
			  l_rich.setText(l_cdr.descbillall()+l_cdr.descaddup());					
		}
		myList.setSize(m_cdrs.size());		
	}
	
	
	public boolean trackwheelClick(int status, int time) {
		  za_cdr l_cdr = (za_cdr)m_cdrs.elementAt(myList.getSelectedIndex());	
		  		  
		  if (l_cdr.isOut())
		  {
		   l_cdrscreen = new za_cdrscreen(l_cdr);
			  Ui.getUiEngineInstance().		  
		  setTransition(this, l_cdrscreen, UiEngineInstance.TRIGGER_PUSH, transitionContextPush);		  
		  Ui.getUiEngineInstance().		  
		  setTransition(l_cdrscreen, this, UiEngineInstance.TRIGGER_POP, transitionContextPop);	
		  UiApplication.getUiApplication().pushScreen(l_cdrscreen); 
		  }
		  else
		  {
			l_cdrscreen = new za_cdrscreen(l_cdr);
			  Ui.getUiEngineInstance().		  
		  setTransition(this, l_cdrscreen, UiEngineInstance.TRIGGER_PUSH, transitionContextPush);		  
		  Ui.getUiEngineInstance().		  
		  setTransition(l_cdrscreen, this, UiEngineInstance.TRIGGER_POP, transitionContextPop);	
		  UiApplication.getUiApplication().pushScreen(l_cdrscreen); 
		  }
	
		return true;
	}

	protected boolean touchEvent(TouchEvent message) {
		int event = message.getEvent();
		switch (event) {
		case TouchEvent.CLICK:
			// don't do anything - it will call navigationClick
			break;
		case TouchEvent.UNCLICK:
			// don't do anything - it will call navigationUnclick
			break;
		case TouchEvent.DOWN:
			// process DOWN here
			break;
		case TouchEvent.UP:
			// process UP here

			break;
		case TouchEvent.MOVE:
			// sample processing - make your own if needed

			int size = message.getMovePointsSize();
			int[] x_points = new int[size];
			int[] y_points = new int[size];
			int[] time_points = new int[size];
			message.getMovePoints(1, x_points, y_points, time_points);
			// process that MOVE here!
			break;
		case TouchEvent.CANCEL:
			// something happened in the middle of your touch
			break;
		case TouchEvent.GESTURE:
			TouchGesture ltg = message.getGesture();
			
			if (ltg.getEvent() == TouchGesture.DOUBLE_TAP)
			{			
			
			}	
		
			int l_way = ltg.getSwipeDirection();

			if (l_way == TouchGesture.SWIPE_EAST)// zoom in
			{
				UiApplication.getUiApplication().invokeLater(new Runnable() 
				{
		            public void run()
		            {   
		            	 za_cdr l_cdr = (za_cdr)m_cdrs.elementAt(myList.getSelectedIndex());
		            	 m_showtype = (m_showtype + 1)%3;
		            	 invalidate();
		                 l_rich.setText(l_cdr.descbillall()+l_cdr.descaddup());
		            }
				}
				);
			}
			if (l_way == TouchGesture.SWIPE_WEST)// zoom in
			{
				UiApplication.getUiApplication().invokeLater(new Runnable() 
				{
		            public void run()
		            {   
		            	 za_cdr l_cdr = (za_cdr)m_cdrs.elementAt(myList.getSelectedIndex());
		            	 m_showtype --;
		            	 if (m_showtype == -1)
		            		 m_showtype = 2;
		            	 invalidate();
		                 l_rich.setText(l_cdr.descbillall()+l_cdr.descaddup());
		            }
				}
				);
			}
			if (l_way == TouchGesture.SWIPE_SOUTH)// zoom in
			{
				navigationMovement(0, 1, KeyListener.STATUS_ALT, 0);
			}
			if (l_way == TouchGesture.SWIPE_NORTH)// zoom in
			{
				navigationMovement(0, -1, KeyListener.STATUS_ALT, 0);
			}
			if (l_way == (TouchGesture.SWIPE_EAST | TouchGesture.SWIPE_NORTH)) {
			}
			if (l_way == (TouchGesture.SWIPE_WEST | TouchGesture.SWIPE_SOUTH)) {
			}
			break;
		}
		return super.touchEvent(message);
	}
	
	public class CRichTextField extends  RichTextField
	{ 
		boolean m_textflag = true;
		String m_msg = "";
		
		public CRichTextField (String msg)
		{
			super(msg);
		}

		public void setText(String msg)
		{
			m_msg = msg;			
			if (m_msg.indexOf("集团") >=0)
			{
				if (m_textflag)				
					super.setText(msg.substring(0,m_msg.indexOf("集团")));
				else
					super.setText(msg.substring(m_msg.indexOf("集团")));
			}
			else
				super.setText(m_msg);				
		}
		
		protected boolean touchEvent(TouchEvent message) {
			int event = message.getEvent();
			switch (event) {
			case TouchEvent.GESTURE:
				TouchGesture ltg = message.getGesture();
				if (ltg.getTapCount() == 1)// tap once
				{
					m_textflag = ! m_textflag;
					invalidate();
				}
				break;
			}
			return super.touchEvent(message);
		}
	}
	protected void makeMenu(Menu menu, int instance) {
		menu.add(new MenuItem("关于", 20, 20) {
	           public void run() 
	           {     
	                  UiApplication.getUiApplication().pushScreen(new za_about());
	           }});
		menu.add(new MenuItem("退出", 20, 20) {
            public void run() 
            {     	
        		if (Dialog.ask(Dialog.D_OK_CANCEL, "确实要退出?", Dialog.CANCEL) == Dialog.OK) 
        		{	        			
        			try {
						m_phonelistener.stop();
						m_smslistener.stop();
					} catch (Exception e) {
						za_db.errorDialog(e.toString());
					}finally{
					  System.exit(0);
					}
        		}
        	}});        
		menu.addSeparator();

		menu.add(new MenuItem("设置资费", 20, 20) {
	            public void run() 
	            {     
	             UiApplication.getUiApplication().pushScreen(new za_config());
	            }});
		menu.add(new MenuItem("删除", 20, 20) {
	            public void run()  
	            {     
	        		try {
	        			za_db m_db = za_db.getInstanct();
	        			m_db.open();
	        			int pos = myList.getSelectedIndex();
	        			za_cdr l_cdr = (za_cdr)m_cdrs.elementAt(pos);        			
	        			m_db.delete(l_cdr.row);
	        			m_cdrs.removeElementAt(pos);
	        			myList.setSize(m_cdrs.size());
	        			m_db.close();
	        		} catch (Exception e) {
	        			za_db.errorDialog(e.toString());
	        			e.printStackTrace();
	        		}
	            }});
		menu.add(new MenuItem("选择月份", 20, 20) {
				public void run() 
				{
					DateTimePicker datePicker = DateTimePicker.createInstance( Calendar.getInstance(), "yyyyMM", null);		        
			        if (datePicker.doModal(DateFormat.MONTH_FIELD))        
			        	initlist(l_sdf.format(datePicker.getDateTime().getTime()));
				}
			});			
		menu.addSeparator();
	}
	
	public boolean onClose() {
		UiApplication.getUiApplication().requestBackground();
		return false;
	}
	
	private class ListCallback implements ListFieldCallback {

		public void drawListRow(ListField list, Graphics g, int index, int y,
				int w) {	
			
			za_cdr l_cdr = (za_cdr) m_cdrs.elementAt(index);
			if (m_showtype ==0)
				l_cdr.paint(g, index, y, w);
			else if (m_showtype ==1)
				l_cdr.paintbill(g, index, y, w);	
			else if (m_showtype ==2)
				l_cdr.paintaddup(g, index, y, w);		
		}

		public Object get(ListField list, int index) {
			return m_cdrs.elementAt(index);
		}

		public int indexOfList(ListField list, String p, int s) {
			return m_cdrs.indexOf(p, s);
		}

		public int getPreferredWidth(ListField list) {
			return Display.getWidth();
		}
		
		public void deleteall() {
			m_cdrs.removeAllElements();
		}
	}
}

