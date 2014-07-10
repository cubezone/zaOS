package com.zhuxy.za_phone;

import net.rim.device.api.system.Bitmap;
import net.rim.device.api.util.MultiMap;

final public class za_icon {

	private static za_icon  m_instance = null;

	static MultiMap m_icons = new MultiMap();
	za_icon()
	{
		m_icons.add("in.png", Bitmap.getBitmapResource("in.png"));
		m_icons.add("out.png", Bitmap.getBitmapResource("out.png"));
		m_icons.add("sms_in.png", Bitmap.getBitmapResource("sms_in.png"));
		m_icons.add("sms_out.png", Bitmap.getBitmapResource("sms_out.png"));
		m_icons.add("user.png", Bitmap.getBitmapResource("user.png"));
		m_icons.add("web.png", Bitmap.getBitmapResource("web.png"));
	}
	
	static public za_icon getInstance()
	{
		if (m_instance==null)
			m_instance = new za_icon();
		return m_instance;
	}
	
	public Bitmap getIcon(String i_icon)
	{
		return (Bitmap)m_icons.elements(i_icon).nextElement();
	}

}
