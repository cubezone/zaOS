package com.zhuxy.za_bill;

import java.util.Calendar;
import java.util.Vector;

import net.rim.device.api.i18n.DateFormat;
import net.rim.device.api.i18n.SimpleDateFormat;
import net.rim.device.api.system.Bitmap;
import net.rim.device.api.system.Display;

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
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.picker.DateTimePicker;

public final class za_main extends MainScreen {

	ListField myList;
	ListCallback myCallback;
	Vector listElements = new Vector();
	int row = 0;
	RichTextField l_rich = new RichTextField("");
	String m_month;
	int m_showtype = 0;
	public za_main(){
		myList = new ListField();
		myCallback = new ListCallback();	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		initlist(sdf.format(Calendar.getInstance().getTime()));
		myList.setCallback(myCallback);	
		myList.setRowHeight(60);	
		add(myList);
	}	
	
	public void initlist(String i_month)
	{
		myCallback.deleteall();
		row=0;
		myList.setSize(row);
		m_month = i_month; 
		try {
			za_db m_db = za_db.getInstanct();
			m_db.open();
			listElements = m_db.selectbill(m_month);
			m_db.close();
		} catch (Exception e) {
			za_db.errorDialog(e.toString());
		}
		myList.setSize(listElements.size());	
	}

	protected boolean touchEvent(TouchEvent message) {
		int event = message.getEvent();
		switch (event) {
		case TouchEvent.GESTURE:
			TouchGesture ltg = message.getGesture();

			int l_way = ltg.getSwipeDirection();

			if (l_way == TouchGesture.SWIPE_EAST)// zoom in
			{
				UiApplication.getUiApplication().invokeLater(new Runnable() 
				{
		            public void run()
		            {   
		            	 m_showtype = (m_showtype + 1)%2;
		            	 invalidate();		              
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
		            	 m_showtype --;
		            	 if (m_showtype == -1)
		            		 m_showtype = 1;
		            	 invalidate();
		            }
				}
				);
			}
		
			break;
		}
		return super.touchEvent(message);
	}
	
	
	public boolean trackwheelClick(int status,int time){
		int index = myList.getSelectedIndex();
		if (index > -1)
		{
			  TransitionContext transitionContextPush = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
	          transitionContextPush.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
	          transitionContextPush.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_LEFT);

	          TransitionContext transitionContextPop = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
	          transitionContextPop.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
	          transitionContextPop.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_RIGHT);
	          transitionContextPop.setIntAttribute(TransitionContext.ATTR_KIND, TransitionContext.KIND_OUT);
 
	          
			  za_bill s = (za_bill)myList.getCallback().get(myList, index);
				za_billitemscreen l_add = new za_billitemscreen(s);
				Ui.getUiEngineInstance().		  
				  setTransition(this, l_add, UiEngineInstance.TRIGGER_PUSH, transitionContextPush);		  
				  Ui.getUiEngineInstance().		  
				  setTransition(l_add, this, UiEngineInstance.TRIGGER_POP, transitionContextPop);	
		
				UiApplication.getUiApplication().pushScreen(l_add);
			return true;
		}
		else
			return false;
	}

	public void close() {
		super.close();
	}

	private class ListCallback implements ListFieldCallback {

		public void drawListRow(ListField list, Graphics g, int index, int y,
				int w) {
			try {
				za_bill l_bill = (za_bill) listElements.elementAt(index);
				g.setFont( Font.getDefault().derive(Font.PLAIN, 9, Ui.UNITS_pt));
				//fee
				if (m_showtype==0)
				{
					g.drawText(l_bill.bill_type, 90, y+5, 0, w); 
				
					g.drawText(String.valueOf(l_bill.fee), 250, y+5,  DrawStyle.RIGHT, 90);
				}
				else
				{
					g.drawText(l_bill.desc, 90, y+5, 0, w);
					g.drawText(String.valueOf(l_bill.totalfee), 250, y+5,  DrawStyle.RIGHT, 90);
				}
				
				g.drawBitmap(0+15,y+6,64,60,Bitmap.getBitmapResource(l_bill.geticon()),0,0);
				
				if (myList.getSelectedIndex() != index)
					g.setGlobalAlpha(100);
				
				if (myList.getSelectedIndex() == index)
					   g.setColor(0x00FFFFFF);
					else
					   g.setColor(0x00000000);
				
				//g.drawText(l_bill.LAC, 80, y + 22, 0, w); 
				//g.drawText(l_bill.CELL, 80, y + 39, 0, w); 
				g.setFont( Font.getDefault().derive(Font.PLAIN, 7, Ui.UNITS_pt));	
				g.drawText(l_bill.bill_time, 90, y + 39, 0, w); 
				g.setGlobalAlpha(255);
				// line			
				g.setColor(0x00888888);
				g.drawLine(0, y + 59, w, y + 59);
				g.setColor(0x00000000);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		public Object get(ListField list, int index) {
			return listElements.elementAt(index);
		}
 
		public int indexOfList(ListField list, String p, int s) {
			// return listElements.getSelectedIndex();
			return listElements.indexOf(p, s);
			//return list.indexOfList(p,s);
		}

		public int getPreferredWidth(ListField list) {
			return Display.getWidth();
		}
		
		public void deleteall() {
			listElements.removeAllElements();
		}
	}
	protected void makeMenu(Menu menu, int instance) {
		
		
		menu.add(new MenuItem("增加", 100, 10) {
			public void run() {
				za_billitemoption l_add = new za_billitemoption(null);
				UiApplication.getUiApplication().pushScreen(l_add);
			}
		});
		
		menu.add(new MenuItem("复制", 100, 10) {
			public void run() {
				try {
					za_db m_db = za_db.getInstanct();
					m_db.open();
		   			int pos = myList.getSelectedIndex();
        			za_bill l_cdr = (za_bill)listElements.elementAt(pos); 
        			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        			l_cdr.bill_time = sdf.format(Calendar.getInstance().getTime());   
        			l_cdr.row = 0;
        			l_cdr.update_time = l_cdr.bill_time ;        			
					m_db.insert(l_cdr);
					m_db.close();
					listElements.insertElementAt(l_cdr,0);
					myList.setSize(listElements.size());
				} catch (Exception e) {
					za_db.errorDialog(e.toString());
				}
			
			}
		});
				
		menu.addSeparator();
        
		menu.add(new MenuItem("选择月份", 200, 100) {
			public void run() {
				SimpleDateFormat l_sdf = new SimpleDateFormat("yyyyMM");
				DateTimePicker datePicker = DateTimePicker.createInstance( Calendar.getInstance(), "yyyyMM", null);
		        if (datePicker.doModal(DateFormat.MONTH_FIELD))        
		        	initlist(l_sdf.format(datePicker.getDateTime().getTime()));
			}
		});
		menu.add(new MenuItem("删除", 120, 20) {
            public void run() 
            {     
        		try {
        			za_db m_db = za_db.getInstanct();
        			m_db.open();
        			int pos = myList.getSelectedIndex();
        			za_bill l_cdr = (za_bill)listElements.elementAt(pos);        			
        			m_db.delete(l_cdr.row);
        			listElements.removeElementAt(pos);
        			myList.setSize(listElements.size());
        			m_db.close();
        		} catch (Exception e) {
        			za_db.errorDialog(e.toString());
        			e.printStackTrace();
        		}
            }});
		//super.makeMenu(menu, instance);	
	}
}
