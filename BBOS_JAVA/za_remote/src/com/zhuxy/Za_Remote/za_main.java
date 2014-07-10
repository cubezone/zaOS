package com.zhuxy.Za_Remote;

import java.util.Vector;

import net.rim.device.api.bluetooth.BluetoothSerialPort;
import net.rim.device.api.bluetooth.BluetoothSerialPortInfo;
import net.rim.device.api.ui.Color;
import net.rim.device.api.ui.Graphics;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.TransitionContext;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.UiEngineInstance;
import net.rim.device.api.ui.component.LabelField;
import net.rim.device.api.ui.component.BitmapField;
import net.rim.device.api.ui.component.ListField;
import net.rim.device.api.ui.component.ListFieldCallback;
import net.rim.device.api.system.Bitmap;
import net.rim.device.api.system.Display;
import net.rim.device.api.ui.container.MainScreen;

public final class za_main extends MainScreen
{
    
    private BluetoothSerialPortInfo[] _portInfo;   
    ListField myList;
    ListCallback myCallback ;
    Vector m_cdrs = new Vector();
    
    public za_main()
    {
        //setTitle("Media Control");
//        add( new LabelField(""));
//        add( new LabelField(""));        
//        add(new BitmapField( Bitmap.getBitmapResource("pad.png"),FIELD_HCENTER));
        int numDevices = 0;
        
    	myList = new ListField();
		myCallback = new ListCallback();	
													
		myList.setCallback(myCallback);
		myList.setRowHeight(50);	
		
		
		
        if (BluetoothSerialPort.isSupported())
        {
            _portInfo = BluetoothSerialPort.getSerialPortInfo();
            numDevices = _portInfo.length;
        
            for (int count = numDevices - 1; count >= 0; --count)
            {
            	m_cdrs.addElement( _portInfo[count]);            
            }            
        }
        else
        {
            add(new LabelField("Bluetooth is not supported on this BlackBerry or simulator."));
        }
        
        myList.setSize(m_cdrs.size());
		add(myList);
        
    }
    
    ////////////////////////////////////////////////////////////
    //                  Menu Items                            //
    ////////////////////////////////////////////////////////////
    private MenuItem _listenItem = new MenuItem("Listen for connections", 30, 30)
    {
        public void run() 
        {
            UiApplication.getUiApplication().pushScreen(new za_remote(null));
            close(); //close the current screen            
        }
    };
    
    ////////////////////////////////////////////////////////////
    //                  Custom Item                           //
    ////////////////////////////////////////////////////////////
    private final class DeviceMenuItem extends MenuItem {
        private BluetoothSerialPortInfo _info;
        
        DeviceMenuItem(String text, BluetoothSerialPortInfo info) {
            super(text, 20, 20);
            _info = info;
        }
        
        public void run() {
            UiApplication.getUiApplication().pushScreen(new za_remote(_info));
            close(); //close the current screen            
        }
    };
    
    
	public boolean trackwheelClick(int status, int time) {
		   BluetoothSerialPortInfo l_stock= (BluetoothSerialPortInfo) m_cdrs.elementAt(myList.getSelectedIndex());
		   za_remote l_wz = new za_remote(l_stock);
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
	
    private class ListCallback implements ListFieldCallback {

		public void drawListRow(ListField list, Graphics g, int index, int y,
				int w) {	
			
			if (m_cdrs.size()==0) return ;
			
			BluetoothSerialPortInfo l_stock = (BluetoothSerialPortInfo)m_cdrs.elementAt(index);
					
			g.drawText("Á¬½Ó £º" + l_stock.getDeviceName(), 20, y+14, 0, w);	
			
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