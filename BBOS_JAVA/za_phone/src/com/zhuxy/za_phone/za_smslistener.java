package com.zhuxy.za_phone;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
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
import net.rim.device.api.system.GPRSInfo;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.Dialog;

public class za_smslistener implements MessageListener,OutboundMessageListener
{
	boolean  done = false;
	MessageConnection m_conn;
	Reader reader;
	za_cdr m_cdr;
	za_main m_main = null;	
	public void start()
	{	    
		try {
			m_conn = (MessageConnection) Connector.open("sms://:0");
			m_conn.setMessageListener(this);
			done = false;
			reader = new Reader();
			new Thread(reader).start();
		} catch (IOException e) {
			za_db.errorDialog(e.toString());
		}
	}
		
	public void stop() throws Exception
	{	    
		done = true;		
		m_conn.setMessageListener(null);
		m_conn.close();
					
	}
	
	public void notifyIncomingMessage(MessageConnection conn) {
		if (conn == m_conn) {
			reader.handleMessage();
		}
	}
	
	public void notifyOutgoingMessage(Message message) {
			savesms(message,1);
			m_main.addcdr(m_cdr);
	}
	
	public void saveCDR() {
		try {
			za_db m_db = za_db.getInstanct();
			m_db.open();
			m_db.insert(m_cdr);
			m_db.close();						
		} catch (Exception e) {
			za_db.errorDialog(e.toString());
		}	
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
			l_cdr.cdr_type = "SMS";
			l_cdr.otherpart  =l_address;
			l_cdr.dt = sdf.format(l_dt);
			String l_msg = "";   
			String l_subtype = "TEXT"; 
			if (message instanceof TextMessage)
			{				
				l_msg = ((TextMessage) message).getPayloadText();
			}else if (message instanceof MultipartMessage)
			{
				l_subtype = "MMS";
				l_msg = ((MultipartMessage) message).getSubject();
			}else if (message instanceof BinaryMessage)							
			{	 
				l_subtype = "BIN";
				byte[] tt = ((BinaryMessage) message).getPayloadData();
				for (int i = 0 ; i < tt.length; i ++)
					if (tt[i]< 32 && tt[i] >=0 )
						 tt[i]=32;
				ByteArrayOutputStream l_o = new ByteArrayOutputStream();
				l_o.write(tt, 15, tt.length - 15);
				tt = l_o.toByteArray();
		
				l_msg = "http://" + new String(tt, "UTF-8");// "Content: http://"
			}
			l_cdr.cdr_subtype = l_subtype;			
			l_cdr.content = l_msg;
			l_cdr.in_out = i_in_out;
			l_cdr.mcc = Integer.toHexString(GPRSInfo.getCellInfo().getMCC())
				.toUpperCase();
			l_cdr.mnc = Integer.toHexString(GPRSInfo.getCellInfo().getMNC())
				.toUpperCase();
			l_cdr.lac = Integer.toString(GPRSInfo.getCellInfo().getLAC());
			l_cdr.cell = Integer.toString(GPRSInfo.getCellInfo().getCellId());
			if (i_in_out == 1) //修正发短信  没有时间
			{
				l_cdr.dt = sdf.format(Calendar.getInstance().getTime());
			}
			l_cdr.duration = 0;
			
			m_cdr = l_cdr;
			saveCDR();
			m_main.addcdr(m_cdr);

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
					savesms(message,0);
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
