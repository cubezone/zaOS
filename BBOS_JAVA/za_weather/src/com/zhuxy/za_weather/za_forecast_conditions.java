package com.zhuxy.za_weather;

public class za_forecast_conditions {
	String m_day_of_week = "N/A";
	String m_low = "N/A";
	String m_high = "N/A";
	String m_icon  = "N/A";
	String m_condition = "N/A";	
	String info()
	{
		return "����:" + m_day_of_week +
		       " ����:" + m_condition + 
		       "\r\n�¶�:" + m_low +"~" + m_high;
	}
	String icon()
	{
		int l_pos = m_icon.indexOf("weather/");
		if (l_pos >0)
		return m_icon.substring(l_pos + 8);
		else
		return " ";
	}
}