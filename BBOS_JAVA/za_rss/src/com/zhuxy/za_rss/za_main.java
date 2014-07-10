package com.zhuxy.za_rss;

import java.util.Timer;
import java.util.Vector;


import net.rim.device.api.i18n.SimpleDateFormat;

import net.rim.device.api.system.Bitmap;
import net.rim.device.api.system.Display;
import net.rim.device.api.system.KeyListener;
import net.rim.device.api.ui.Color;

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
import net.rim.device.api.ui.container.MainScreen;


final class za_main extends MainScreen {

	Vector m_cdrs= new Vector() ;
	String m_book ="";
	Timer l_timer = new Timer();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	SimpleDateFormat l_sdf = new SimpleDateFormat("yyyy/MM");
	ListField myList;
	ListCallback myCallback;
	int row =0;
//	CRichTextField l_rich = new CRichTextField("");
	za_rss m_stock = null;
	
	public za_main() {
		
		myList = new ListField();
		myCallback = new ListCallback();	
													
		myList.setCallback(myCallback);
		myList.setRowHeight(50);	
		
		try {
			za_db m_db = za_db.getInstanct();
			m_db.open();
			m_cdrs = m_db.selectrss("");
			m_db.close();
		} catch (Exception e) {
			za_db.errorDialog(e.toString());
		}
		myList.setSize(m_cdrs.size());
		add(myList);					
		
		new Cinitfromdb().start();
		
	}
	
	private class Cinitfromdb extends Thread {
		public void run() 
		{
			synchronized (this) {
				try {
					za_db m_db = za_db.getInstanct();
					m_db.open();
					for (int n = 0; n < m_cdrs.size(); n++) {
						za_rss l_rss = (za_rss) m_cdrs.elementAt(n);	
						l_rss.m_lastBuildDate = "更新中...";
						za_main.this.invalidate();
						l_rss.m_rssitem = m_db.selectrssitem(l_rss.m_symbol);
						
						l_rss.m_lastBuildDate = "离线模式.";
						za_main.this.invalidate();
					}
					m_db.close();
				} catch (Exception e) {
					za_db.errorDialog(e.toString());
					e.printStackTrace();
				}
			}
		}
	}	
	
	private class Cinitfromweb extends Thread {
		public void run() 
		{
			synchronized (this) {
				try {
					wait(500);            	
					for (int n = 0; n < m_cdrs.size(); n++)
					{
						za_rss  l_sto = (za_rss) m_cdrs.elementAt(n);						
						l_sto.m_lastBuildDate =  "更新中...";		
						za_main.this.invalidate();
						l_sto.getStock();	
						za_main.this.invalidate();
					};
				} catch (InterruptedException e) {
					za_db.errorDialog(e.toString());							
				}
			}
		}
	}
	  
	public boolean trackwheelClick(int status, int time) {
		  za_rss l_stock= (za_rss) m_cdrs.elementAt(myList.getSelectedIndex());
		  za_rssscreen l_wz = new za_rssscreen(l_stock);
		  TransitionContext transitionContextPush = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
          transitionContextPush.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
          transitionContextPush.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_LEFT);

          TransitionContext transitionContextPop = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
          transitionContextPop.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
          transitionContextPop.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_RIGHT);
          transitionContextPop.setIntAttribute(TransitionContext.ATTR_KIND, TransitionContext.KIND_OUT);

		  Ui.getUiEngineInstance().		  
		  setTransition(this, l_wz, UiEngineInstance.TRIGGER_PUSH, transitionContextPush);		  
		  Ui.getUiEngineInstance().		  
		  setTransition(l_wz, this, UiEngineInstance.TRIGGER_POP, transitionContextPop);	
		  UiApplication.getUiApplication().pushScreen(l_wz); 
	
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
			            {  
			            	
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
	
	protected void makeMenu(Menu menu, int instance) {			
		menu.add(new MenuItem("退出", 20, 20) {
	            public void run() 
	            {     	
	        		if (Dialog.ask(Dialog.D_OK_CANCEL, "确实要退出?", Dialog.CANCEL) == Dialog.OK) 
	        		{	        			
	        			try {
						
						} catch (Exception e) {
							
						}finally{
						  System.exit(0);
						}
	        		}
	        	}});


		menu.add(new MenuItem("刷新", 20, 20) {
            public void run() 
            {                	
            	Cinitfromweb l_get = new Cinitfromweb();            	
        		l_get.start();	
        	}});			
		
		menu.addSeparator();
		menu.add(new MenuItem("添加栏目", 20, 20){
			public void run() 
			{
				UiApplication.getUiApplication().pushScreen(new za_rssconfig(new za_rss()));
			}			
		});
		
		menu.add(new MenuItem("编辑栏目", 20, 20) {
            public void run() 
            {     
            	int pos = myList.getSelectedIndex();
    			za_rss l_cdr = (za_rss)m_cdrs.elementAt(pos);    
            	UiApplication.getUiApplication().pushScreen(new za_rssconfig(l_cdr));
            }});

		menu.add(new MenuItem("删除栏目", 20, 20) {
            public void run() 
            {     
    			int pos = myList.getSelectedIndex();
    			za_rss l_cdr = (za_rss)m_cdrs.elementAt(pos);      
            	if (Dialog.ask(Dialog.D_OK_CANCEL, "确实要删除 "+l_cdr.m_title+" ?", Dialog.CANCEL) == Dialog.OK) 
        		{	  
        		try {
        			za_db m_db = za_db.getInstanct();
        			m_db.open();
        			m_db.delete(l_cdr.row);
        			m_db.deleterss(l_cdr);
        			m_cdrs.removeElementAt(pos);
        			myList.setSize(m_cdrs.size());
        			m_db.close();
        		} catch (Exception e) {
        			za_db.errorDialog(e.toString());
        			e.printStackTrace();
        		}
        		}
            }});
		
		menu.addSeparator();
		menu.add(new MenuItem("删除本栏目新闻", 20, 20) {
            public void run() 
            {     
            	int pos = myList.getSelectedIndex();
    			za_rss l_cdr = (za_rss)m_cdrs.elementAt(pos);      
            	if (Dialog.ask(Dialog.D_OK_CANCEL, "确实要删除 "+l_cdr.m_title+ " 新闻? ", Dialog.CANCEL) == Dialog.OK) 
            		
        		{	  
        		try {
        			za_db m_db = za_db.getInstanct();
        			m_db.open();
        			m_db.deleterss(l_cdr);
        			m_db.close();
        		} catch (Exception e) {
        			za_db.errorDialog(e.toString());
        			e.printStackTrace();
        		}
        		}
            }});
		
	
		
		menu.add(new MenuItem("删除所有新闻", 20, 20) {
            public void run() 
            {     
            	if (Dialog.ask(Dialog.D_OK_CANCEL, "确实要删除所有新闻?", Dialog.CANCEL) == Dialog.OK) 
        		{	  
        		try {
        			za_db m_db = za_db.getInstanct();
        			m_db.open();
        			m_db.deleterss();
        			m_db.close();
        		} catch (Exception e) {
        			za_db.errorDialog(e.toString());
        			e.printStackTrace();
        		}
        		}
            }});
	}
		
	public boolean onClose() {
		UiApplication.getUiApplication().requestBackground();
		return false;
	}
	
	private class ListCallback implements ListFieldCallback {

		public void drawListRow(ListField list, Graphics g, int index, int y,
				int w) {	
			
			za_rss l_stock = (za_rss) m_cdrs.elementAt(index);
					
			g.drawText( l_stock.m_title, 20, y+4, 0, w);	
			if (!l_stock.totalString().substring(0,1).equals("0"))
			{
				g.setColor(0x008888FF);
				g.fillRect(280 -2, y +4 - 2, 
					g.getFont().getAdvance(l_stock.totalString())+4,
					g.getFont().getHeight()+4);
				g.setColor(Color.WHITE);
			}
			g.drawText(l_stock.totalString(),280, y+4, 0, w);
			g.setColor(0x00AAAAAA);
			g.drawText( l_stock.m_lastBuildDate , 20, y+27, 0, w);	
			
			g.drawBitmap(340, y+20,80,200, Bitmap.getBitmapResource("next.png"), 0, 0);
			
			g.setColor(0x00888888); 
			g.drawLine(0, y+49, w, y+49); 	 	
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