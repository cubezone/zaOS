package com.zhuxy.za_weather;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Vector;

import javax.microedition.io.Connector;
import javax.microedition.io.HttpConnection;

import net.rim.device.api.xml.jaxp.XMLParser;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;


public class za_weather
{
	int row = 0;
	String m_city = "N/A";
	String m_postal_code = "N/A";
	String m_forecast_date= "N/A";
	String m_current_date_time= "N/A";
	String m_unit_system= "N/A";
	String m_condition= "N/A";
	String m_temp_f= "N/A";
	String m_temp_c= "N/A";
	String m_humidity= "N/A";
	String m_icon= "N/A";
	String m_wind_condition= "N/A";
	boolean m_current=true;
	Vector m_forecast = new Vector();
	String m_log;
	public za_weather(int id ,String city)
	{
			row = id ;
			m_city = city;			
	}
	
	String info()
	{
		return "城市: " + m_city + "\r\n" +
			   "更新时间: " + m_current_date_time ;					   
	}
	String infocur()
	{
		return "天气: " + m_condition +"\r\n" + 
			   "温度: " + m_temp_c +"\r\n" + 
			   "湿度: " + m_humidity +"\r\n" +
			   "风向: " + m_wind_condition +"\r\n" +
			   "日期: " + m_forecast_date ;					   
	}
	String icon()
	{
		int l_pos = m_icon.indexOf("weather/");
		if (l_pos >0)
		return m_icon.substring(l_pos + 8);
		else
		return "";
	}
	
	void    getweather(){
		
		    HttpConnection c = null;
			OutputStream os = null;
			InputStream is = null;
			String url = "http://www.google.com/ig/api?hl=zh-en&weather=";  			
			url += m_city ;
			try {
				c = (HttpConnection)Connector.open(url); 
				/*c.setRequestMethod(HttpConnection.GET); 
				c.setRequestProperty("User-Agent", "Profile/MIDP-2.0 Configuration/CLDC-1.0");
				c.setRequestProperty("Content-Language", "UTF-8");			
				os = c.openOutputStream();
				os.flush();
				*/
				c.setRequestProperty("Content-Language", "UTF-8");
				int rc = c.getResponseCode();
				if (rc != HttpConnection.HTTP_OK) {
	                 throw new IOException("HTTP response code: " + rc);
	             }
				 is = c.openInputStream();
				 m_log="aaa";
				  XMLParser r = new XMLParser();
			       	try {
			       		//InputSource l_ns = new InputSource(getClass().getResourceAsStream("/test.xml" ));
			       		InputSource l_ns = new InputSource(is);
			       		l_ns.setEncoding("UFT-8");
						r.parse(l_ns,new mydh());
					} catch (SAXException e) {
						m_log ="Bbb";
						e.printStackTrace();
					} catch (IOException e) {
						m_log= "ccc";
						e.printStackTrace();
					}
             		             
	             
			} catch (ClassCastException e) {
				m_log="dddd";
			} catch (IOException e) {
				m_log="eee";
			} finally {
					try {
						if (is != null)is.close();
						if (c != null) c.close();
						if (os != null) os.close();
					} catch (IOException e) {
						m_log="fff";
					}
			}		   
	   }
	   
		final class mydh extends DefaultHandler
		{
			za_forecast_conditions l_fc = null;
			
			public void startElement(String uri, String localName, String qName, Attributes attributes) 
			{				
				String l_value ="";
				if (attributes.getLength()>0)
					l_value = attributes.getValue(0);
				else
					l_value = "no date";
				
				if (localName.equals("forecast_conditions"))
				{
					l_fc = new za_forecast_conditions();
					m_current = false;
				}
				
				if (m_current)
				{
					if (localName.equals("city"))
					m_city= l_value;
					else if (localName.equals("postal_code"))
					m_postal_code= l_value;
					else if (localName.equals("forecast_date"))
					m_forecast_date= l_value;
					else if (localName.equals("current_date_time"))
					m_current_date_time= l_value;
					else if (localName.equals("unit_system"))
					m_unit_system= l_value;
					else if (localName.equals("condition"))
					m_condition= l_value;
					else if (localName.equals("temp_f"))
					m_temp_f= l_value;
					else if (localName.equals("temp_c"))
					m_temp_c= l_value;
					else if (localName.equals("humidity"))
					m_humidity= l_value;
					else if (localName.equals("icon"))
					m_icon= l_value;
					else if (localName.equals("wind_condition"))
					m_wind_condition= l_value;
				}
				else
				{
					if (localName.equals("day_of_week"))
					l_fc.m_day_of_week= l_value;
					else if (localName.equals("high"))
					l_fc.m_high= Integer.toString((Integer.parseInt(l_value) -32 )*5/9);					
					else if (localName.equals("low"))
					l_fc.m_low = Integer.toString((Integer.parseInt(l_value) -32 )*5/9);
					else if (localName.equals("icon"))
					l_fc.m_icon= l_value;
					else if (localName.equals("condition"))
					l_fc.m_condition= l_value;
				}				
			}
			
			public void characters(char[] ch, int start, int length) 
			{
				//m_cdrs.addElement(new String(ch,start,length));
			}
			
			public void endElement(String uri, String localName, String qName) 
			{
				if (localName.equals("forecast_conditions"))
				   m_forecast.addElement(l_fc);
			}
			public void startDocument()
			{

			}
			public void endDocument()
			{

			}
		}
		
		
//	m_cdrs.addElement("beijing");
//	m_cdrs.addElement("guangzhou");
//	m_cdrs.addElement("shanghai");
//	m_cdrs.addElement("nanjing");
//	m_cdrs.addElement("suzhou");
//	m_cdrs.addElement("zhuhai");
//	m_cdrs.addElement("xiamen");
//	m_cdrs.addElement("qingdao");
//	m_cdrs.addElement("dalian");
}
