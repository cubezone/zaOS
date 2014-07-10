package com.zhuxy.a_sms;

import net.rim.device.api.i18n.DateFormat;
import net.rim.device.api.i18n.SimpleDateFormat;
import net.rim.device.api.system.Bitmap;
import net.rim.device.api.system.ControlledAccessException;
import net.rim.device.api.system.Display;
import net.rim.device.api.system.GPRSInfo;
import net.rim.device.api.ui.Color;
import net.rim.device.api.ui.Font;
import net.rim.device.api.ui.Graphics;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.TouchEvent;
import net.rim.device.api.ui.TouchGesture;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.ListField;
import net.rim.device.api.ui.component.ListFieldCallback;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.SeparatorField;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.ui.container.VerticalFieldManager;
import net.rim.device.api.ui.decor.BackgroundFactory;
import net.rim.device.api.ui.picker.DateTimePicker;

import java.io.*;
import java.util.Calendar;
import java.util.Date;
import java.util.Vector;

import javax.microedition.io.Connector;
import javax.microedition.io.file.FileConnection;

import javax.wireless.messaging.*;

import net.rim.blackberry.api.invoke.Invoke;
import net.rim.blackberry.api.invoke.PhoneArguments;
import net.rim.blackberry.api.phone.AbstractPhoneListener;
import net.rim.blackberry.api.phone.Phone;
import net.rim.blackberry.api.phone.PhoneCall;
import net.rim.blackberry.api.sms.*;

/**
 * 
 */
final  class Za_sms extends MainScreen implements MessageListener,
		OutboundMessageListener {
    RichTextField l_rich = new RichTextField("");
	MessageConnection messconn;
	boolean done;
	private String l_msg = " ";
	Reader reader;
	static long m_talktime;
	static String m_month = "201011";
	static ListField myList;
	static ListCallback myCallback;
	static int row = 0;
	ConcretePhoneListener m_pl= new ConcretePhoneListener();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

	public Za_sms(String i_month) {
		m_month = i_month;
		setTitle("短信:");
		l_rich.setBackground(BackgroundFactory.createSolidBackground(Color.LIGHTBLUE));
		myList = new ListField();
		myCallback = new ListCallback();		
		initlist(i_month);
		
		myList.setCallback(myCallback);
		myList.setRowHeight(60);
		add(myList);
		VerticalFieldManager l_status = new VerticalFieldManager();
		l_status.add(new SeparatorField());
		l_status.add(l_rich);
		setStatus(l_status);
		
// Initial tests setup and execution.
//		  try 
//          {
//              Phone.addPhoneListener( m_pl );
//          }
//          catch ( final ControlledAccessException e ) 
//          {
//              UiApplication.getUiApplication().invokeLater(new Runnable()
//              {
//                  public void run()
//                  {
//                      Dialog.alert("Access to Phone API restricted by system administrator: " + e.toString());
//                  } 
//              });
//
//              System.exit( 1 );
//          }
          
		try {
			// Get our receiving port connection.
			messconn = (MessageConnection) Connector.open("sms://:0");
			// Register a listener for inbound messages.
			messconn.setMessageListener(this);
			// Start a message-reading thread.
			done = false;
			reader = new Reader();
			new Thread(reader).start();
		} catch (IOException e) {
			l_rich.setText(l_rich.getText() + e.toString());
		}
		
/*		addMenuItem(new MenuItem("手工增加", 200, 100) {
			public void run() {
				l_msg = "%0"+Integer.toString(++row) + 
				"%1" + "TextMessage" + 
				"%2" + "10010" + 
				"%3" + "2010/10/10 10:10:10" +
				"%4" + "手工增加"	 +
				"%5"+ "接受"+
				"%6";
				
				saveSMS(l_msg);
				
				UiApplication.getUiApplication().invokeLater(new Runnable() {
					public void run() {
						l_rich.setText(l_msg);
						myCallback.add(l_msg, 0);
						myList.setSize(row);
					}
				});
			}
		});
*/
		addMenuItem(new MenuItem("选择月份", 200, 100) {
			public void run() {
				SimpleDateFormat l_sdf = new SimpleDateFormat("yyyyMM");
				DateTimePicker datePicker = DateTimePicker.createInstance( Calendar.getInstance(), "yyyyMM", null);		        
		        if (datePicker.doModal(DateFormat.MONTH_FIELD))        
		        	initlist(l_sdf.format(datePicker.getDateTime().getTime()));
			}
		});
		
		addMenuItem(new MenuItem("强制退出", 200, 100) {
			public void run() {
				 System.exit(0);
			}
		});
		addMenuItem(new MenuItem("刷新", 200, 100) {
			public void run() {
				initlist(m_month);
			}
		});
	}

	public void initlist(String i_month)
	{
		myCallback.deleteall();
		row=0;
		m_month = i_month;
		FileConnection fc = null;
		String fn = "store/home/user/documents/CDR" + m_month
				+ ".txt";
		try {			
			byte[] b = new byte[100000];
			fc = (FileConnection) Connector.open("file:///" + fn,
					Connector.READ_WRITE);
			if (!fc.exists()) {
				return;
			}
			InputStream l_dip = fc.openInputStream();			
			int l_len= l_dip.read(b);
			l_dip.close();
			fc.close();
			String l_str = new String(b,0,l_len,"UTF-8");
			String l_token = "";
			int l_pos=l_str.indexOf("%6");
			while ( l_pos >= 0)
			{
				l_token = l_str.substring(0,l_pos+2);
				row ++;
				myCallback.add(l_token,0);
				l_str = l_str.substring(l_pos+2);
				l_pos = l_str.indexOf("%6");
			}
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
		myList.setSize(row);	
	}
	
	public static void saveSMS(String str) {
		FileConnection fc = null;
		boolean l_new = false;
		// String fn ="SDCard/GPRSPos.txt";

		String fn = "store/home/user/documents/CDR" + m_month
				+ ".txt";

		try {					
			fc = (FileConnection) Connector.open("file:///" + fn,
					Connector.READ_WRITE);
			if (!fc.exists()) {
				fc.create();
				l_new = true;
			}
			OutputStream l_dop = fc.openOutputStream(99999999);
			if (l_new)// uef-8 head flag;
			{
				l_dop.write(0xEF);
				l_dop.write(0xBB);
				l_dop.write(0xBF);
			}
			l_dop.write(str.getBytes("UTF-8"));
			l_dop.flush();
			l_dop.close();
			fc.close();
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

	public void showmsg(Message mess, int type) {
		
		try {	
			Date l_dt = mess.getTimestamp();
			l_dt.setTime(l_dt.getTime() - 8 * 3600 * 1000);
			String l_address = mess.getAddress();
			l_address = l_address.substring(l_address.indexOf("//")+2);
			l_msg = "unknown message type.";
			if (mess instanceof TextMessage)
				l_msg = "%0" + Integer.toString(++row) + "%1TextMssage" // text
						+ "%2" + l_address// from
						+ "%3" + sdf.format(l_dt) // date
						+ "%4" + ((TextMessage) mess).getPayloadText()// content
						+ "%5";
			else if (mess instanceof MultipartMessage)
				l_msg = "%0" + Integer.toString(++row) + "%1MultipartMessage" // MultipartMessage
						+ "%2" + l_address// from
						+ "%3" + sdf.format(l_dt)// date
						+ "%4" + ((MultipartMessage) mess).getSubject()// content
						+ "%5";
			else if (mess instanceof BinaryMessage) {
				
				byte[] tt = ((BinaryMessage) mess).getPayloadData();
				ByteArrayOutputStream l_o = new ByteArrayOutputStream();

				l_o.write(tt, 15, tt.length - 15);
				l_msg = "%0" + Integer.toString(++row) + "%1BinaryMessage" // text
						+ "%2" + l_address // from
						+ "%3" + sdf.format(l_dt) // date
						+ "%4http://" + new String(l_o.toByteArray(), "UTF-8") + "%5";// "Content: http://"				
			}						
		} catch (IOException e) {
			l_msg = e.toString();
		}
	
		if(type==0)
			l_msg += "接收%6";
		else
			l_msg += "发送%6";
		
		saveSMS(l_msg);

		UiApplication.getUiApplication().invokeLater(new Runnable()
			{
				public void run() {
					l_rich.setText(l_msg);
					myCallback.add(l_msg, 0);
					myList.setSize(row);
				}
			}
		);
	}

	public boolean trackwheelClick(int status, int time) {
		int index = myList.getSelectedIndex();
		String s = (String) myList.getCallback().get(myList, index);
		if (index == 99) {
			// UiApplication.getUiApplication().pushScreen(l_add);
		} else
			if (Dialog.ask(Dialog.D_OK_CANCEL,"呼叫  "+s.substring(s.indexOf("%2")+2,
					s.indexOf("%3"))) == Dialog.D_OK)
				 Invoke.invokeApplication(Invoke.APP_TYPE_PHONE,
						 new  PhoneArguments(PhoneArguments.ARG_CALL,
								 s.substring(s.indexOf("%2")+ 2, s.indexOf("%3"))));			
		return true;
	}
	
	protected boolean touchEvent(TouchEvent message) {
		int event = message.getEvent();
		switch (event) {
		case TouchEvent.GESTURE:
			TouchGesture ltg = message.getGesture();
			if (ltg.getTapCount() == 1) {
				UiApplication.getUiApplication().invokeLater(new Runnable() {
					public void run() {
						String text = (String) myCallback.get(myList, myList
								.getSelectedIndex());
						l_rich.setText(
								 "记录数:"+text.substring(text.indexOf("%0")+2, text.indexOf("%1")) +"\r\n"+						
								 "内容:"+text.substring(text.indexOf("%4")+2, text.indexOf("%5"))  								 
								);
					}
				});
			}
			break;
		}

		return super.touchEvent(message);
	}

	// Asynchronous callback for inbound message.
	public void notifyIncomingMessage(MessageConnection conn) {
		if (conn == messconn) {
			reader.handleMessage();
		}
	}

	public void notifyOutgoingMessage(Message message) {
		showmsg(message,1);
	}

	// Required MIDlet method - release the connection and
	// signal the reader thread to terminate.
	/*
	 * public void pauseApp() {
	 * 
	 * try { messconn.close(); } catch (IOException e) {
	 * l_rich.setText(l_rich.getText() + e.toString()); } }
	 */
	// Required MIDlet method - shutdown.
	// @param unconditional forced shutdown flag

	public boolean onClose() {
		boolean ret = true;		
		if (Dialog.ask(Dialog.D_OK_CANCEL, "确实要退出?", Dialog.CANCEL) == Dialog.OK) 
		{
//			Phone.removePhoneListener(m_pl );
			done = true;
			try {
				messconn.setMessageListener(null);
			} catch (IOException e) {
					l_rich.setText(l_rich.getText() + e.toString());
			}	
			try {
				messconn.close();
			} catch (IOException e) {
				l_rich.setText(l_rich.getText() + e.toString());
			}				
		}
		else
		   ret = false;		

		if (ret == true)
			return super.onClose();
		else
			return false;

	}

	// Isolate blocking I/O on a separate thread, so callback
	// can return immediately.
	class Reader implements Runnable {
		private int pendingMessages = 0;

		// The run method performs the actual message reading.
		public void run() {
			while (!done) {
				synchronized (this) {
					if (pendingMessages == 0) {
						try {
							wait();
						} catch (Exception e) {
							// Handle interruption
						}
					}
					pendingMessages--;
				}

				// The benefit of the MessageListener is here.
				// This thread could via similar triggers be
				// handling other kind of events as well in
				// addition to just receiving the messages.

				try {
					Message mess = messconn.receive();
					showmsg(mess,0);
				} catch (IOException e) {
					l_rich.setText(l_rich.getText() + e.toString());
				}
			}
		}

		public synchronized void handleMessage() {
			pendingMessages++;
			notify();
		}
	}
	
	  /**
     * Phone listener object.  Listens for the callConnected, callDisconnected, 
     * callHeld, and callResumed events and calculates talk time for each unique
     * phone number.
     */
    private static final class ConcretePhoneListener extends AbstractPhoneListener
    {        
        /**
         * Default constructor
         */ 
    	static boolean l_calling = false;
    	static String m_starttime;
    	static String m_phoneNumber;
    	static String m_inout;
    	
    	ConcretePhoneListener()
        {
            // Not implemented
        }       
        
        /**
         * Called when a phone call is connected.  Finds the record with the call's phone
         * number (or creates a new one if one doesn't exist), starts the "talk time" 
         * timer, and saves the record list.
         * 
         * @param callId The ID of the call that connected.
         */
        public void callConnected( int callId ) 
        {
        	begincall(callId);
        }
        public void callAnswered( int callId ) 
        {
        	begincall(callId);            
        }
                
        public void callEndedByUser( int callId ) 
        {
        	endcall(callId);
        } 
        
        public void callDisconnected( int callId ) 
        {
        	endcall(callId);            
        }
        
        public void begincall(int callId)
        {
        	l_calling = true;
            PhoneCall phoneCall = Phone.getCall( callId );
            m_phoneNumber = phoneCall.getPhoneNumber();
            if (phoneCall.isOutgoing())
            	m_inout = "发送";
            else
            	m_inout = "接收";
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); 
            m_starttime = sdf.format(Calendar.getInstance().getTime());
            m_talktime= new Date().getTime();                	
        }
               
        public void endcall(int callId)
        {
        	if (l_calling)
        	{
        	m_talktime = (new Date().getTime() - m_talktime+200)/1000;
            String l_msg = "%0"+Integer.toString(++row) + 
			"%1" + "phone" + 
			"%2" + m_phoneNumber +" "+ String.valueOf(m_talktime)+
			"%3" + m_starttime +
			"%4" + "通话地:"	 +		 
	        "MCC:"+ Integer.toHexString( GPRSInfo.getCellInfo().getMCC()).toUpperCase()+" "+
	        "MNC:"+ Integer.toHexString( GPRSInfo.getCellInfo().getMNC()).toUpperCase()+" "+          
	        "LAC:"+ Integer.toString( GPRSInfo.getCellInfo().getLAC())+" "+
	        "CELLID:"+ Integer.toString( GPRSInfo.getCellInfo().getCellId())+
			"%5"+ m_inout+
			"%6";
			
			saveSMS(l_msg);
			l_calling = false;
        	}
        }         
    }
    
    void setListSize()
    {
    	myList.setSize(myCallback.size());
    }
    
	private static class ListCallback implements ListFieldCallback {

		private static Vector listElements = new Vector();

		public void drawListRow(ListField list, Graphics g, int index, int y,
				int w) {

			String text = (String) listElements.elementAt(index);

			// phone number
			g.drawText(text.substring(text.indexOf("%2") + 2, text
					.indexOf("%3")), 70, y, 0, w);

			String ls_icon = "sms";
			if (text.substring(text.indexOf("%1") + 2, text
					.indexOf("%2")).equals("phone"))
			ls_icon = "phone";	
				
			if (text.substring(text.indexOf("%5") + 2, text
					.indexOf("%6")).equals("接收"))
			g.drawBitmap(0+3,y+3,60,60,Bitmap.getBitmapResource(ls_icon+"_in.png"),0, 0);
			else
			g.drawBitmap(0+3,y+3,60,60,Bitmap.getBitmapResource(ls_icon+"_out.png"),0, 0);	
			
			if (myList.getSelectedIndex() != index)
				g.setGlobalAlpha(100);
			
			if (myList.getSelectedIndex() == index)
				g.setColor(0x00FFFFFF);
			else
				g.setColor(0x00000000);
			g.setFont(Font.getDefault().derive(Font.PLAIN, 7, Ui.UNITS_pt));
			
			String l_content = text.substring(text.indexOf("%4") + 2, text
					.indexOf("%5"));
			
			if (l_content.indexOf("[")>0)
				g.drawText(l_content.substring(l_content.indexOf("[")), 70, y + 22, 0, w);
			else
				g.drawText(l_content, 70, y + 22, 0, w);
			
			g.drawText(text.substring(text.indexOf("%0") + 2, text
					.indexOf("%1")), 70, y + 39, 0, w);
			// date time			
			g.drawText(text.substring(text.indexOf("%3") + 2, text
					.indexOf("%4")), 110, y + 39, 0, w);
			g.setFont(Font.getDefault().derive(Font.PLAIN, 9, Ui.UNITS_pt));

			// line
			g.setColor(0x00888888);
			g.drawLine(0, y + 59, w, y + 59);
			g.setColor(0x00000000);
		}

		public Object get(ListField list, int index) {
			return listElements.elementAt(index);
		}

		public int indexOfList(ListField list, String p, int s) {
			// return listElements.getSelectedIndex();
			return listElements.indexOf(p, s);
			// return list.indexOfList(p,s);
		}

		public int getPreferredWidth(ListField list) {
			return Display.getWidth();
		}

		public void add(String toInsert, int index) {
			listElements.insertElementAt(toInsert, index);
		}

		public void deleteall() {
			listElements.removeAllElements();
		}
		
		public int size() {
			return listElements.size();
		}
	}
}