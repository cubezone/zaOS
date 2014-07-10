package com.zhuxy.a_sms;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;

import javax.microedition.io.Connector;
import javax.wireless.messaging.BinaryMessage;
import javax.wireless.messaging.Message;
import javax.wireless.messaging.MessageConnection;
import javax.wireless.messaging.MessageListener;
import javax.wireless.messaging.MultipartMessage;
import javax.wireless.messaging.TextMessage;

import net.rim.blackberry.api.sms.OutboundMessageListener;
import net.rim.device.api.i18n.SimpleDateFormat;
import net.rim.device.api.ui.component.Dialog;

public class za_smslistener implements MessageListener,OutboundMessageListener
{
	boolean  done = false;
	MessageConnection m_conn;
	Reader reader;
		
	public void start()
	{	    
		try {
			m_conn = (MessageConnection) Connector.open("sms://:0");
			m_conn.setMessageListener(this);
			done = false;
			reader = new Reader();
			new Thread(reader).start();
		} catch (IOException e) {
			Dialog.alert(e.toString());
		}
	}
	
	public void stop()
	{	    
		done = true;
		try {
			m_conn.setMessageListener(null);
		} catch (IOException e) {
			Dialog.alert(e.toString());
		}	
		try {
			m_conn.close();
		} catch (IOException e) {
			Dialog.alert(e.toString());
		}			
	}
	
	public void notifyIncomingMessage(MessageConnection conn) {
		if (conn == m_conn) {
			reader.handleMessage();
		}
	}
	
	public void notifyOutgoingMessage(Message message) {
			savesms(message,0);
	}
	
	
	void savesms(Message message ,int i_in_out)
	{
		try {
			za_cdr l_cdr = new za_cdr(); 
			Date l_dt = message.getTimestamp();
			l_dt.setTime(l_dt.getTime() - 8 * 3600 * 1000);
			String l_address = message.getAddress();
			l_address = l_address.substring(l_address.indexOf("//")+2);			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			l_cdr.otherpart  =l_address;
			l_cdr.dt = sdf.format(l_dt);
			String l_msg = "";
			String l_subtype = "text";
			if (message instanceof TextMessage)
			{				
				l_msg = ((TextMessage) message).getPayloadText();
			}	
			else if (message instanceof MultipartMessage)
			{
				l_subtype = "MMS";
				l_msg = ((MultipartMessage) message).getSubject();
			}else if (message instanceof BinaryMessage)							
			{	
				l_subtype = "BIN";
				byte[] tt = ((BinaryMessage) message).getPayloadData();
				ByteArrayOutputStream l_o = new ByteArrayOutputStream();
				l_o.write(tt, 15, tt.length - 15);
				l_msg = "http://" + new String(l_o.toByteArray(), "UTF-8") + "%5";// "Content: http://"
			}
			l_cdr.sub_type = l_subtype;
			l_cdr.content = l_msg;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
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

				try {
					Message message = m_conn.receive();			
					savesms(message,1);
				} catch (IOException e) {
					Dialog.alert(e.toString());
				}
			}
		}

		public synchronized void handleMessage() {
			pendingMessages++;
			notify();
		}
	}
}
