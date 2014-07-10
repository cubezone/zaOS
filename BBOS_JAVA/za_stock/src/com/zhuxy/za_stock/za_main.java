package com.zhuxy.za_stock;

import java.util.Timer;
import java.util.Vector;

import net.rim.device.api.system.Bitmap;
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
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.EditField;
import net.rim.device.api.ui.component.ListField;
import net.rim.device.api.ui.component.ListFieldCallback;
import net.rim.device.api.ui.component.Menu;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.container.MainScreen;


final class za_main extends MainScreen {

	Vector m_cdrs= new Vector() ;
	String m_book ="";

	ListField myList;
	ListCallback myCallback;
	int row =0;
	CRichTextField l_rich = new CRichTextField("");
	za_stock m_stock = null;
	
	
	public za_main() {
		
		myList = new ListField();
		myCallback = new ListCallback();	
													
		myList.setCallback(myCallback);
		myList.setRowHeight(50);	
		try {
			za_db m_db = za_db.getInstanct();
			m_db.open();
			m_cdrs = m_db.select("%");
			m_db.close();
		} catch (Exception e) {
			za_db.errorDialog(e.toString());
			e.printStackTrace();
		}
		
		myList.setSize(m_cdrs.size());			
		add(myList);	
		
	}
	
	private class Cthd extends Thread {
		public void run() 
		{
			synchronized (this) { 
				try {
					wait(500);
					l_rich.setText("开始更新数据");
					for (int n = 0; n < m_cdrs.size(); n++)
					{
						za_stock  l_sto = (za_stock) m_cdrs.elementAt(n);
						l_sto.m_last = "更新中...";
						l_sto.m_perc_change = "";
						za_main.this.invalidate();
						l_sto.getStock();			
						za_main.this.invalidate();
					};
					l_rich.setText("");
				} catch (InterruptedException e) {
					l_rich.setText("更新数据出现异常");							
				}
			}
		}
	}
	  
	public boolean trackwheelClick(int status, int time) {
		  za_stock l_stock= (za_stock) m_cdrs.elementAt(myList.getSelectedIndex());
		  TransitionContext transitionContextPush = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
          transitionContextPush.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
          transitionContextPush.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_LEFT);

          TransitionContext transitionContextPop = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
          transitionContextPop.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
          transitionContextPop.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_RIGHT);
          transitionContextPop.setIntAttribute(TransitionContext.ATTR_KIND, TransitionContext.KIND_OUT);
		
		za_stockscreen l_wz = new za_stockscreen(l_stock);
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
				
			}
			if (l_way == TouchGesture.SWIPE_WEST)// zoom in
			{
				myCallback.changeshow();
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
							
						}finally{
						  System.exit(0);
						}
	        		}
	        	}});
		menu.add(new MenuItem("刷新", 20, 20) {
            public void run() 
            {     	
            	Cthd l_get = new Cthd();
        		l_get.start();	
        	}});
			        
		menu.addSeparator();
		
		menu.add(new MenuItem("新增", 20, 20) {
		            public void run() 
		            {    			
		        		UiApplication.getUiApplication().pushScreen(new za_stockconfig(new za_stock(0,"",0,0)));	
		        	}
		});
			

		menu.add(new MenuItem("修改", 20, 20) {
		            public void run() 
		            {
		            	int pos = myList.getSelectedIndex();
		        		za_stock l_cdr = (za_stock)m_cdrs.elementAt(pos);        			
		        		UiApplication.getUiApplication().pushScreen(new za_stockconfig(l_cdr));	
		        	}
		});
		

		
		menu.add(new MenuItem("删除", 20, 20) {
            public void run() 
            {     
            	if (Dialog.ask(Dialog.D_OK_CANCEL, "确实要删除?", Dialog.CANCEL) == Dialog.OK) 
        		{	  
        		try {
        			za_db m_db = za_db.getInstanct();
        			m_db.open();
        			int pos = myList.getSelectedIndex();
        			za_stock l_cdr = (za_stock)m_cdrs.elementAt(pos);        			
        			m_db.delete(l_cdr.row);
        			m_cdrs.removeElementAt(pos);
        			myList.setSize(m_cdrs.size());
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
		int m_show = 0;
		public void drawListRow(ListField list, Graphics g, int index, int y,
				int w) {	
			
			if (m_cdrs.size()==0) return;
			
			za_stock l_stock = (za_stock) m_cdrs.elementAt(index);
			
			if (m_show % 3 == 0)
			{
				
				g.drawText( l_stock.getsymbol() , 20, y+15, 0, w);	
				g.drawText("现价",103,y+15,0,w);
										
				if (l_stock.m_perc_change.indexOf("-")>=0)
				{
					g.setColor(0x0000FF00);
			//		g.drawBitmap(145, y+5,120,80, Bitmap.getBitmapResource("green.png"), 0, 0);
			//		g.drawBitmap(265, y+5,120,80, Bitmap.getBitmapResource("green.png"), 0, 0);				
				}
				else
				{
					g.setColor(0x00FF0000);
			//		g.drawBitmap(145, y+5,120,80, Bitmap.getBitmapResource("red.png"), 0, 0);				
			//		g.drawBitmap(265, y+5,120,80, Bitmap.getBitmapResource("red.png"), 0, 0);
				}
				
				g.setFont(Font.getDefault().derive(Font.BOLD));				
				g.drawText( l_stock.m_last,  145, y+15, DrawStyle.RIGHT, 100);							
				g.drawText( l_stock.m_perc_change+"%", 260, y+15, DrawStyle.RIGHT, 90);			 	
				
			}
			if (m_show % 3 == 1)
			{
				g.drawText( l_stock.getsymbol()  , 20, y+15, 0, w);	
				g.drawText("收益",103,y+15,0,w);
				
				if (l_stock.m_advance<0)
					g.setColor(0x0000FF00);
				else
					g.setColor(0x00FF0000);
				
				g.drawText(l_stock.formatfee(l_stock.m_advance),  145, y+15, DrawStyle.RIGHT, 100);																				
				if (l_stock.m_today_advance<0)
					g.setColor(0x0000FF00);
				else
					g.setColor(0x00FF0000);
				g.drawText(l_stock.formatfee(l_stock.m_today_advance),260, y+15, DrawStyle.RIGHT, 90);			 	
				
			}
			if (m_show % 3 == 2)
			{
				g.drawText( l_stock.getsymbol()  , 20, y+15, 0, w);			
				g.drawText("仓位",103,y+15,0,w);			

				g.drawText( String.valueOf(l_stock.m_count),  145, y+15, DrawStyle.RIGHT, 100);																			
				g.drawText( l_stock.formatfee(l_stock.m_fee), 260, y+15, DrawStyle.RIGHT, 90);			 				
			}			
			g.setColor(0x00BBBBBB);
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

		public void changeshow()
		{
			m_show++;

				
			za_main.this.invalidate();
		}
	}
}