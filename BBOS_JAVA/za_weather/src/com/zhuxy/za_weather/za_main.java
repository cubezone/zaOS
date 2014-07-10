package com.zhuxy.za_weather;

import java.util.Timer;
import java.util.Vector;

import net.rim.device.api.i18n.SimpleDateFormat;
import net.rim.device.api.system.Bitmap;
import net.rim.device.api.system.Display;
import net.rim.device.api.system.KeyListener;
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
	Timer l_timer = new Timer();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	SimpleDateFormat l_sdf = new SimpleDateFormat("yyyy/MM");
	ListField myList;
	ListCallback myCallback;
	int row =0;
	CRichTextField l_rich = new CRichTextField("");
	
	public za_main() {
		
		myList = new ListField();
		myCallback = new ListCallback();			
		myList.setCallback(myCallback);
		myList.setRowHeight(60);
		
		m_book = "";					
		try {
			za_db m_db = new za_db();
			m_cdrs = m_db.select("");
			m_db.close();
		} catch (Exception e) {
			za_db.errorDialog(e.toString());
			e.printStackTrace();
		}
		myList.setSize(m_cdrs.size());									
				
		add(myList);		
   		
		Cthd l_get = new Cthd();
		l_get.start();		
	}
	
	private class Cthd extends Thread {
		public void run() 
		{
			synchronized (this) {
				try {
					wait(200);					
					for (int n = 0; n < m_cdrs.size(); n++)
					{
						za_weather  l_sto = (za_weather) m_cdrs.elementAt(n);
						l_sto.m_condition = "更新中...";
						za_main.this.invalidate();
						l_sto.getweather();		
						za_main.this.invalidate();					
					};			
				} catch (InterruptedException e) {
					l_rich.setText("更新数据出现异常");							
				}
			}
		}		
	}
	
	public boolean trackwheelClick(int status, int time) {
		  za_weather l_str= (za_weather) m_cdrs.elementAt(myList.getSelectedIndex());
		  za_weatherscreen l_wz = new za_weatherscreen(l_str);
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
	
	protected class CRichTextField extends  RichTextField
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
	        
		menu.addSeparator();
			menu.add(new MenuItem("添加", 20, 20) {
		            public void run() 
		            {     		            	
		            	    Dialog l_dg = new Dialog(Dialog.D_OK_CANCEL,"添加城市",0,
		            	    		Bitmap.getPredefinedBitmap(Bitmap.INFORMATION),0);
		            	    EditField l_ef =new EditField("", null, 20,EditField.FILTER_DEFAULT);
		            	    l_dg.add(l_ef); 
		        		if (l_dg.doModal() == Dialog.OK) 
		        		{	
		        				try {
		        					za_db m_db = new za_db();		        					
		        					m_db.insert(l_ef.getText()); 
		        					m_db.close();
		        					Dialog.inform("数据已经添加，程序将退出.\r\n 请重新运行程序！");
		        					System.exit(0);
		        				} catch (Exception e) {
		        					za_db.errorDialog(e.toString());
		        				}													
						}
		        	}
		     });
			menu.add(new MenuItem("刷新", 20, 20) {
	            public void run() 
	            {     	
	            	Cthd l_get = new Cthd();
	        		l_get.start();	
	        	}});
		
		menu.addSeparator();
		menu.add(new MenuItem("删除", 20, 20) {
            public void run() 
            {     
            	if (Dialog.ask(Dialog.D_OK_CANCEL, "确实要删除?", Dialog.CANCEL) == Dialog.OK) 
        		{	  
        		try {
        			za_db m_db = new za_db();
        			int pos = myList.getSelectedIndex();
        			za_weather l_cdr = (za_weather)m_cdrs.elementAt(pos);        			
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
	
	protected class ListCallback implements ListFieldCallback {

		public void drawListRow(ListField list, Graphics g, int index, int y,
				int w) {
			za_weather l_cdr = (za_weather) m_cdrs.elementAt(index);
			
			try {
				g.drawBitmap(0 + 12, y + 10 , 60, 60, Bitmap.getBitmapResource(l_cdr.icon()), 0, 0);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace(); 
			}
			g.drawText( l_cdr.m_city, 70, y + 6, 0, w);	
			g.setGlobalAlpha(100);
			g.drawText( "温度:", 70, y+35, 0, w);	
			g.drawText( "天气:",160, y+35, 0, w);		
			g.setGlobalAlpha(255);
			g.setFont(Font.getDefault().derive(Font.BOLD));
			g.drawText(l_cdr.m_temp_c, 70+40, y+35, 0, w);	
			g.setFont(Font.getDefault().derive(Font.PLAIN));
			g.drawText(l_cdr.m_condition ,160+40, y+35, 0, w);	
			g.setColor(0x00888888);
			g.drawLine(0, y+59, w, y+59); 	 	
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