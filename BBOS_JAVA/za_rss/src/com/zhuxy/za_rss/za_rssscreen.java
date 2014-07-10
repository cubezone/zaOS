package com.zhuxy.za_rss;

import java.util.Timer;
import java.util.Vector;

import net.rim.device.api.i18n.SimpleDateFormat;

import net.rim.device.api.system.Display;
import net.rim.device.api.system.KeyListener;


import net.rim.device.api.ui.DrawStyle;
import net.rim.device.api.ui.Font;
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
import net.rim.device.api.ui.component.SeparatorField;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.ui.container.VerticalFieldManager;



final class za_rssscreen extends MainScreen {

	Vector m_cdrs= new Vector() ;
	String m_book ="";
	Timer l_timer = new Timer();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	SimpleDateFormat l_sdf = new SimpleDateFormat("yyyy/MM");
	ListField myList;
	ListCallback myCallback;
	za_rss m_rss;
	int row =0;
	CRichTextField l_rich = new CRichTextField("");
	
	public za_rssscreen(za_rss l_bc) {
		m_rss = l_bc;
		
		m_cdrs = m_rss.m_rssitem;
		
		myList = new ListField();
		myCallback = new ListCallback();	
		
		initlist();										
		
		myList.setCallback(myCallback);
		myList.setRowHeight(80);		
		add(myList);		
   
		
	}
	
	public void initlist()
	{
		
		myList.setSize(m_cdrs.size());			
	}
	
	public boolean trackwheelClick(int status, int time) {
		  
		  za_rssitem l_cdr = (za_rssitem)m_cdrs.elementAt(myList.getSelectedIndex());

		  za_rssitemscreen l_bookscreen = new za_rssitemscreen(l_cdr);
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
			            {   za_rss l_cdr = (za_rss)m_cdrs.elementAt(myList.getSelectedIndex());
			                l_rich.setText(l_cdr.m_description);
			                
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

		menu.add(new MenuItem("刷新", 20, 20) {
            public void run() 
            {   
	            new myrefresh().start();
        	}});		        
		menu.addSeparator();
	}
	
	
	private class myrefresh extends Thread {
		public void run() 
		{
			synchronized (this) {	
				 UiApplication.getUiApplication().invokeLater(new Runnable()
			        {
			            public void run()
			            {
			            	guiUpdate();
			            } 
			        });
			}
		}
		
		public void guiUpdate() 
		{
        	m_cdrs.removeAllElements();
        	myList.setSize(m_cdrs.size());
        	za_rssscreen.this.invalidate();	
        	try {
				sleep(500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}        	
			m_rss.getStock();
        	m_cdrs = m_rss.m_rssitem;
        	myList.setSize(m_cdrs.size());
        	za_rssscreen.this.invalidate();	
		}
	}
	
	private class ListCallback implements ListFieldCallback {

		public void drawListRow(ListField list, Graphics g, int index, int y,
				int w) {	
			
			if ( m_cdrs.size() ==0) return;
			
			za_rssitem l_cdr = (za_rssitem) m_cdrs.elementAt(index);

			if (l_cdr.m_read)
				g.setColor(0x00AAAAAA);
			g.setFont(Font.getDefault().derive(Font.PLAIN, 10, Ui.UNITS_pt));
			
			StringBuffer l_out = new StringBuffer(Integer.toString(index +1)+". ");
			
			int l_len = g.getFont().getAdvance(Integer.toString(index +1)+". ") +5 ;
			int l_pos  =0;
			for (int n = 0 ; n <l_cdr.m_title.length(); n++ )
			{
			  l_len +=  g.getFont().getAdvance(l_cdr.m_title.charAt(n));			  
			  if (l_len > w)
			  {
				  g.drawText(l_out.toString(), 5, y+4, DrawStyle.ELLIPSIS, w);					  
				  break;
			  }
			  l_out.append(l_cdr.m_title.charAt(n));
			  l_pos = n;
			}
			if (l_pos != l_cdr.m_title.length()-1)
		     g.drawText(l_cdr.m_title.substring(l_pos+1), 5, y+30, DrawStyle.ELLIPSIS, w);
			else
			 g.drawText(l_out.toString(), 5, y+4, DrawStyle.ELLIPSIS, w);	
			
			
				
			g.setFont(Font.getDefault().derive(Font.PLAIN, 8, Ui.UNITS_pt));
			g.setColor(0x00AAAAAA);
			g.drawText(l_cdr.m_pubDate, 5, y+57, 0, w);
			
			g.setColor(0x00888888);
			g.drawLine(0, y+79, w, y+79); 	 	
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