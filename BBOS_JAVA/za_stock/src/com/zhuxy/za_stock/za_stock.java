package com.zhuxy.za_stock;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.microedition.io.Connector;
import javax.microedition.io.HttpConnection;

import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.xml.jaxp.XMLParser;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;


final public class za_stock {
	int row = 0;
	String m_symbol = "N/A";
	String m_company = "N/A";
	String m_last = "N/A";
	String m_high = "N/A";
	String m_low = "N/A";
	String m_volume = "N/A";
	String m_open = "N/A";
	String m_y_close = "N/A";
	String m_perc_change = "N/A";
	String m_current_date_utc = "N/A";
	String m_current_time_utc = "N/A";
	String m_chart_url = "N/A";
	String m_log;
	String m_location;
	int m_count=0;
	int m_fee=0;
	int m_advance=0;
	int m_today_advance=0;
	
	public za_stock(int id ,String symbol , int count ,int fee)
	{
		row = id ;
		m_symbol = symbol;
		m_count = count;
		m_fee = fee;		
	}
	
	void caladvance()
	{
		try {
			float  last = Float.valueOf(m_last).floatValue()*100;
			float  y_close = Float.valueOf(m_y_close).floatValue()*100;
			m_today_advance =(int)(last * m_count - y_close * m_count);
			
			m_advance = (int)(last * m_count - m_fee * m_count);
		} catch (Exception e) {
			m_today_advance = 0;
			m_advance = 0;
		}
	}
	
	String getsymbol()
	{
		int l_pos = m_symbol.indexOf(':');
		if (l_pos > 0)
			return m_symbol.substring(l_pos + 1);
		else
			return m_symbol;
	}
	
	String formatfee(int i_fee)
	{
		StringBuffer ls_allfee = new StringBuffer(200);
		if (i_fee < 0)
		{
			i_fee = -i_fee;
			ls_allfee.append("-");
		}
		ls_allfee.append(i_fee / 100).append(".");
		if ((i_fee % 100) < 10)
			ls_allfee.append("0");		
		ls_allfee.append(i_fee % 100);		
		return  ls_allfee.toString();
	}
	
	void  getStock(){
		if (m_symbol.indexOf(':')>0)
			getStockB();
		else
			getStockA();
	}
	
	void getStockA()
	{
	    HttpConnection c = null;
		OutputStream os = null;
		InputStream is = null;
		String m_url = "http://www.google.com/ig/api?hl=zh_en&stock=";
		m_url += m_symbol;
		try {
			c = (HttpConnection)Connector.open(m_url); 
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
				caladvance();             
             
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
	
	void  getStockB(){
		    HttpConnection c = null;
			OutputStream os = null;
			InputStream is = null;
			String m_url = "http://finance.google.com/finance/info?client=ig&q=";
			m_url += m_symbol;
			try {
				c = (HttpConnection)Connector.open(m_url); 
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

		             int len = (int)c.getLength();
		             
		             if (len > 0) {
		                 int actual = 0;
		                 int bytesread = 0 ;
		                 byte[] data = new byte[len];
		                 while ((bytesread != len) && (actual != -1)) {
		                    actual = is.read(data, bytesread, len - bytesread);
		                    bytesread += actual;
		                 }
		                 m_location = "位置信息："+new String(data,"utf-8");	
		             } else {		                 
		                 int ret;
		                 byte[] data = new byte[1000];
		                  ret = is.read(data);
		                  if (ret > 0) 
		                	  m_location = "位置信息："+new String(data,"utf-8");
		                  else
		                	  m_location = "位置信息：无数据返回。";
		             }		
		        try {
					int tag = m_location.indexOf("lt\" : \"");
					String l_str = m_location.substring(tag+7);
					m_current_time_utc = l_str.substring(0,l_str.indexOf("\""));
					
					tag = m_location.indexOf("l\" : \"");
					l_str = m_location.substring(tag+6);
					m_last = l_str.substring(0,l_str.indexOf("\""));
					
					int l_d = m_last.indexOf(',');
					if (l_d>0)
					m_last = m_last.substring(0,l_d)+m_last.substring(l_d+1);
					
					tag = m_location.indexOf("cp\" : \"");
					l_str = m_location.substring(tag+7);
					m_perc_change = l_str.substring(0,l_str.indexOf("\""));
					
					tag = m_location.indexOf("c\" : \"");
					l_str = m_location.substring(tag+6);
					String l_add = l_str.substring(0,l_str.indexOf("\""));
					
					m_y_close = String.valueOf(Float.parseFloat(m_last) - Float.parseFloat(l_add));
					
				} catch (Exception e) {
					za_db.errorDialog(e.toString());
				}         
		        
				 caladvance();             
	             
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

	class mydh extends DefaultHandler
	{			 
		public void startElement(String uri, String localName, String qName, Attributes attributes) 
		{			
				String l_value = "N/A";
						
				if (attributes.getLength()>0)
					l_value = attributes.getValue(0);
				
				if (localName.equals("symbol"))
				m_symbol= l_value; 
				else if (localName.equals("company"))
				m_company= l_value;
				else if (localName.equals("last"))
				m_last= l_value;
				else if (localName.equals("high"))
				m_high= l_value;
				else if (localName.equals("low"))
				m_low= l_value;
				else if (localName.equals("volume"))
				m_volume= l_value;
				else if (localName.equals("open"))
				m_open= l_value;
				else if (localName.equals("y_close"))
				m_y_close= l_value;
				else if (localName.equals("perc_change"))
				m_perc_change= l_value;						
				else if (localName.equals("current_date_utc"))
				m_current_date_utc= l_value;
				else if (localName.equals("current_time_utc"))
				m_current_time_utc= l_value;
				else if (localName.equals("chart_url"))
				m_chart_url= l_value;
	 
		}
		
		public void characters(char[] ch, int start, int length) 
		{
			//m_cdrs.addElement(new String(ch,start,length));
		}
		
		public void endElement(String uri, String localName, String qName) 
		{
			
		}
		public void startDocument()
		{

		}
		public void endDocument()
		{

		}
	}
	

	/*create table tab_stock
	 (id integer primary key,
	  symbol varchar);
	  
	  insert into tab_stock select null,"600036";
	  insert into tab_stock select null,"601098";
	  insert into tab_stock select null,"600050";
	  insert into tab_stock select null,"600005";
	  insert into tab_stock select null,"600811";

	
//	    m_cdrs.addElement(new za_stock("600036"));
//		m_cdrs.addElement(new za_stock("601098"));
//		m_cdrs.addElement(new za_stock("600050"));
//		m_cdrs.addElement(new za_stock("600005"));
//		m_cdrs.addElement(new za_stock("000002"));
//		m_cdrs.addElement(new za_stock("600811"));
//		m_cdrs.addElement(new za_stock("600104"));
//		m_cdrs.addElement(new za_stock("Asia"));		
	
	 */
}