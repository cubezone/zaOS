package com.zhuxy.za_phone;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import net.rim.blackberry.api.phone.AbstractPhoneListener;
import net.rim.blackberry.api.phone.Phone;
import net.rim.blackberry.api.phone.PhoneCall;
import net.rim.device.api.i18n.SimpleDateFormat;
import net.rim.device.api.system.ControlledAccessException;
import net.rim.device.api.system.GPRSInfo;
import net.rim.device.api.ui.UiApplication;

public final class za_phonelistener extends AbstractPhoneListener {
	boolean m_calling = false;
	String m_starttime;
	String m_phoneNumber;
	String m_inout;
	long m_talktime;
	za_cdr m_cdr = null;
	za_main m_main = null;
	za_phonelistener() {

	}

	public void callConnected(int callId) {
		begincall(callId);
	}

	public void callAnswered(int callId) {
		begincall(callId);
	}

	public void callEndedByUser(int callId) {
		endcall(callId);
	}

	public void callDisconnected(int callId) {
		endcall(callId);
	}

	public void begincall(int callId) {
		m_cdr = new za_cdr();
		m_calling = true;		
		PhoneCall phoneCall = Phone.getCall(callId);
		m_cdr.otherpart = phoneCall.getPhoneNumber();
		if (phoneCall.isOutgoing())
			m_cdr.in_out = 1;
		else
			m_cdr.in_out = 0;
		m_cdr.cdr_type = "Call";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		m_cdr.dt = sdf.format(Calendar.getInstance().getTime());
		m_talktime = new Date().getTime();
	}

	public void endcall(int callId) {
		if (m_calling) {
			m_talktime = (new Date().getTime() - m_talktime + 200) / 1000;
			m_cdr.duration = (int) m_talktime;
			m_calling = false;
			
			Timer l_timer = new Timer();
			l_timer.schedule(new TimerTask(){
				 public void run(){
					 m_cdr.mcc = Integer.toHexString(GPRSInfo.getCellInfo().getMCC())
									.toUpperCase();
					 m_cdr.mnc = Integer.toHexString(GPRSInfo.getCellInfo().getMNC())
									.toUpperCase();
					 m_cdr.lac = Integer.toString(GPRSInfo.getCellInfo().getLAC());
					 m_cdr.cell = Integer.toString(GPRSInfo.getCellInfo().getCellId());
					 saveCDR();
					 m_main.addcdr(m_cdr);
				 }
				 }, 1000);			
		}
	}

	public void start() {
		try {
			Phone.addPhoneListener(this);
		} catch (final ControlledAccessException e) {
			za_db
					.errorDialog("Access to Phone API restricted by system administrator: "
							+ e.toString());
			System.exit(1);
		}
	}

	public void stop() {
		Phone.removePhoneListener(this);
	}

	public void saveCDR() {
		try {
			za_db m_db = za_db.getInstanct();
			m_db.open();
			m_db.insert(m_cdr);
			m_db.close();			
		} catch (Exception e) {
			za_db.errorDialog(e.toString());
			e.printStackTrace();
		}
		//za_db.ratecdr(m_cdr);
	}
}
