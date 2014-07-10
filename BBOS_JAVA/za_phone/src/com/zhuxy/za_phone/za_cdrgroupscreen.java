package com.zhuxy.za_phone;

import java.util.Timer;
import java.util.Vector;


import net.rim.device.api.i18n.SimpleDateFormat;
import net.rim.device.api.system.Display;
import net.rim.device.api.system.KeyListener;
import net.rim.device.api.ui.Color;
import net.rim.device.api.ui.Graphics;

import net.rim.device.api.ui.TouchEvent;
import net.rim.device.api.ui.TouchGesture;

import net.rim.device.api.ui.UiApplication;

import net.rim.device.api.ui.component.ListField;
import net.rim.device.api.ui.component.ListFieldCallback;
import net.rim.device.api.ui.component.Menu;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.ui.container.VerticalFieldManager;
import net.rim.device.api.ui.decor.BackgroundFactory;


public class za_cdrgroupscreen  extends MainScreen{
		//PhoneCallLog l_pcall;
		//PhoneLogs l_log = PhoneLogs.getInstance();
		public CRichTextField l_rich = new CRichTextField("");

		Vector m_cdrs= new Vector() ;
		
		int n = 0;
	
		String m_otherpart;

		Timer l_timer = new Timer();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		SimpleDateFormat l_sdf = new SimpleDateFormat("yyyy/MM");
		ListField myList;
		ListCallback myCallback;
		int row =0;
	
		public za_cdrgroupscreen(za_cdr i_cdr) {
			m_otherpart =i_cdr.otherpart;
			l_rich.setBackground(BackgroundFactory.createSolidBackground(Color.LIGHTSTEELBLUE));
			myList = new ListField();
			myCallback = new ListCallback();
				
			initlist();										
			
			myList.setCallback(myCallback);
			myList.setRowHeight(110);		
			add(myList);			
	        
		//	VerticalFieldManager l_status = new VerticalFieldManager();
		//	l_status.add(new SeparatorField());
			
		//	l_status.add(l_rich);
		//	setStatus(l_status);
	 
		}
	
	
		public void initlist()
		{					
			//setTitle("话费月份:" + m_month);		
			myCallback.deleteall();
			myList.setSize(0);
			l_rich.setText("");		
			
			try {
				za_db m_db = za_db.getInstanct();
				m_db.open();
				m_cdrs = m_db.selectgroup(m_otherpart);
				m_db.close();
			} catch (Exception e) {
				za_db.errorDialog(e.toString());
				e.printStackTrace();
			}
					
			for (int m = m_cdrs.size() -1; m >=0 ; m --) 
			{
				za_cdr l_cdr = (za_cdr)m_cdrs.elementAt(m);	
				
							
				if (m == 0)
				  l_rich.setText(l_cdr.descbillall()+l_cdr.descaddup());					
			}
			myList.setSize(m_cdrs.size());		
		}
		
		
		
		public boolean trackwheelClick(int status, int time) {			
		
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
				if (ltg.getTapCount() == 1)
				{			
					UiApplication.getUiApplication().invokeLater(new Runnable() 
						{
				            public void run()
				            {   za_cdr l_cdr = (za_cdr)m_cdrs.elementAt(myList.getSelectedIndex());
				            
				            	//za_bill.this.invalidate();
				                l_rich.setText(l_cdr.descbillall()+l_cdr.descaddup());
				            }
				       }
					);
				}	
			
				int l_way = ltg.getSwipeDirection();

				if (l_way == TouchGesture.SWIPE_EAST)// zoom in
				{
					// navigationMovement(-2,0,0,0);
				}
				if (l_way == TouchGesture.SWIPE_WEST)// zoom in
				{
					// navigationMovement(2,0,0,0);
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

		
		private class ListCallback implements ListFieldCallback {

			public void drawListRow(ListField list, Graphics g, int index, int y,
					int w) {	
				
				za_cdr l_cdr = (za_cdr) m_cdrs.elementAt(index);
				l_cdr.paint(g, index, y, w);			
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