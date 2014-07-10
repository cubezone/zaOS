package com.zhuxy.za_book;


import java.util.Timer;
import java.util.Vector;

import net.rim.device.api.i18n.SimpleDateFormat;

import net.rim.device.api.system.Display;
import net.rim.device.api.system.KeyListener;

import net.rim.device.api.ui.Graphics;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.TouchEvent;
import net.rim.device.api.ui.TouchGesture;
import net.rim.device.api.ui.TransitionContext;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.UiEngineInstance;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.ListField;
import net.rim.device.api.ui.component.ListFieldCallback;
import net.rim.device.api.ui.component.Menu;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.component.SeparatorField;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.ui.container.VerticalFieldManager;



final class za_bookstore extends MainScreen {

	Vector m_cdrs= new Vector() ;
	String m_book ="";
	Timer l_timer = new Timer();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	SimpleDateFormat l_sdf = new SimpleDateFormat("yyyy/MM");
	ListField myList;
	ListCallback myCallback;
	za_bookcontent m_bc;
	int row =0;
	CRichTextField l_rich = new CRichTextField("");
	
	public za_bookstore(za_bookcontent l_bc) {
		m_bc = l_bc;
		myList = new ListField();
		myCallback = new ListCallback();	
		
		initlist();										
		
		myList.setCallback(myCallback);
		myList.setRowHeight(40);		
		add(myList);		
   
		VerticalFieldManager l_status = new VerticalFieldManager();
		l_status.add(new SeparatorField());
		setStatus(l_status);
		
	}
	
	public void initlist()
	{
		m_book = "";		
		
		try {
			za_db m_db = za_db.getInstanct();
			m_db.open();
			m_cdrs = m_db.selectbook(m_bc.m_bookid);
			m_db.close();
		} catch (Exception e) {
			za_db.errorDialog(e.toString());
			e.printStackTrace();
		}
		String ls_title ="";
		if (m_cdrs.size()>0)		
		{
			ls_title= ((za_bookcontent)m_cdrs.elementAt(0)).m_content;
			m_cdrs.removeElementAt(0);			
		}
		setTitle(ls_title);
		
		myList.setSize(m_cdrs.size());			
	}
	
	public boolean trackwheelClick(int status, int time) {
		  int eseq =9999999;
		  za_bookcontent l_cdr = (za_bookcontent)m_cdrs.elementAt(myList.getSelectedIndex());
		  if ((myList.getSelectedIndex()+1) < m_cdrs.size())
		  {
		   za_bookcontent l_cdr2 = (za_bookcontent)m_cdrs.elementAt(myList.getSelectedIndex()+1);
		   eseq = l_cdr2.m_seq;
		  }	  
		  za_bookscreen l_bookscreen = new za_bookscreen(l_cdr,eseq);
		  TransitionContext transitionContextPush = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
          transitionContextPush.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
          transitionContextPush.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_LEFT);

          TransitionContext transitionContextPop = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
          transitionContextPop.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
          transitionContextPop.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_RIGHT);
          transitionContextPop.setIntAttribute(TransitionContext.ATTR_KIND, TransitionContext.KIND_OUT);

		  Ui.getUiEngineInstance().		  
		  setTransition(this, l_bookscreen, UiEngineInstance.TRIGGER_PUSH, transitionContextPush);		  
		  Ui.getUiEngineInstance().		  
		  setTransition(l_bookscreen, this, UiEngineInstance.TRIGGER_POP, transitionContextPop);	
		  UiApplication.getUiApplication().pushScreen(l_bookscreen); 
	
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
			            {   za_bookcontent l_cdr = (za_bookcontent)m_cdrs.elementAt(myList.getSelectedIndex());
			                l_rich.setText(l_cdr.m_content);
			                
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
	
	private class CRichTextField extends  RichTextField
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
		menu.add(new MenuItem("退出", 20, 20) {
	            public void run() 
	            {     	
	        		if (Dialog.ask(Dialog.D_OK_CANCEL, "确实要退出?", Dialog.CANCEL) == Dialog.OK) 
	        		{	        			
	        			try {
						
						} catch (Exception e) {
							za_db.errorDialog(e.toString());
						}finally{
						  System.exit(0);
						}
	        		}
	        	}});
	        
		menu.addSeparator();
	}
	
	private class ListCallback implements ListFieldCallback {

		public void drawListRow(ListField list, Graphics g, int index, int y,
				int w) {	
			
			za_bookcontent l_cdr = (za_bookcontent) m_cdrs.elementAt(index);
			
			g.drawText(Integer.toString(index +1)+". "+l_cdr.m_content, 10, y+10, 0, w);			
			
			g.drawLine(0, y+39, w, y+39); 	 	
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
		
	}
}