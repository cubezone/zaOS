package com.zhuxy.za_bill;

import java.util.Vector;

import net.rim.device.api.system.Bitmap;
import net.rim.device.api.system.Display;

import net.rim.device.api.ui.Graphics;
import net.rim.device.api.ui.TransitionContext;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiEngineInstance;

import net.rim.device.api.ui.UiApplication;

import net.rim.device.api.ui.component.ListField;
import net.rim.device.api.ui.component.ListFieldCallback;
import net.rim.device.api.ui.container.MainScreen;

public class za_billitemoption  extends MainScreen {
	
	Vector listElements = new Vector();
	ListField myList;
	ListCallback myCallback;
	
	public za_billitemoption(za_billitem i_bi)
	{
		myList = new ListField();
		myCallback = new ListCallback();	
		myList.setCallback(myCallback);	
		myList.setRowHeight(60);	
		if (i_bi ==null) i_bi = new za_billitem(0,"","",0);
			
		try {
			za_db m_db = za_db.getInstanct();
			m_db.open();
			listElements = m_db.selectbillitem(i_bi.id);
			m_db.close();
		} catch (Exception e) {
			za_db.errorDialog(e.toString());
		}
		myList.setSize(listElements.size());	
		add(myList);
	}

	public boolean trackwheelClick(int status,int time){
		int index = myList.getSelectedIndex();
		if (index > -1)
		{
			za_billitem s = (za_billitem)myList.getCallback().get(myList, index);
			  TransitionContext transitionContextPush = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
	          transitionContextPush.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
	          transitionContextPush.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_LEFT);

	          TransitionContext transitionContextPop = new TransitionContext(TransitionContext.TRANSITION_SLIDE);
	          transitionContextPop.setIntAttribute(TransitionContext.ATTR_DURATION, 200);
	          transitionContextPop.setIntAttribute(TransitionContext.ATTR_DIRECTION, TransitionContext.DIRECTION_RIGHT);
	          transitionContextPop.setIntAttribute(TransitionContext.ATTR_KIND, TransitionContext.KIND_OUT);
 
			if(s.isdir())
			{
				za_billitemoption l_add = new za_billitemoption(s);
				Ui.getUiEngineInstance().		  
				  setTransition(this, l_add, UiEngineInstance.TRIGGER_PUSH, transitionContextPush);		  
				  Ui.getUiEngineInstance().		  
				  setTransition(l_add, this, UiEngineInstance.TRIGGER_POP, transitionContextPop);	
				  UiApplication.getUiApplication().pushScreen(l_add); 
			}
			else
			{
				za_billitemscreen l_add = new za_billitemscreen(s);
				Ui.getUiEngineInstance().		  
				  setTransition(this, l_add, UiEngineInstance.TRIGGER_PUSH, transitionContextPush);		  
				  Ui.getUiEngineInstance().		  
				  setTransition(l_add, this, UiEngineInstance.TRIGGER_POP, transitionContextPop);	
				UiApplication.getUiApplication().pushScreen(l_add);
			}
				
			return true;
		}
		else
			return false;
	}
	
	private class ListCallback implements ListFieldCallback {

		
		public void drawListRow(ListField list, Graphics g, int index, int y,
				int w) {
		
			za_billitem l_bill = (za_billitem) listElements.elementAt(index);
			
			//feetype			
			g.drawText(l_bill.billitem, 120, y+18,0, w); 
		    	
			try {
				g.drawBitmap(10,y+6,64,60,Bitmap.getBitmapResource(l_bill.iconname),0,0);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		    
			if (myList.getSelectedIndex() != index)
				g.setGlobalAlpha(100);
			
			g.setColor(0x00888888);
			g.drawLine(0, y + 59, w, y + 59);
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
	}
}
