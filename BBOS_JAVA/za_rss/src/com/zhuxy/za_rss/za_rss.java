package com.zhuxy.za_rss;

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


final public class za_rss {
	int row = 0;
	
	String m_symbol ="http://";
	Vector m_items = new Vector();
	
	String m_title = "N/A";
	String m_link = "N/A";
	String m_description = "N/A";
	String m_image_title = "N/A";
	String m_image_width = "N/A";
	String m_image_height = "N/A";
	String m_image_url = "N/A";
	String m_lastBuildDate = "N/A";
	String m_copyright = "N/A";
	String m_log ="";
	public Vector m_rssitem = new Vector();
	public za_rssitem l_rssitem = null; 
	
	public za_rss()
	{
		
	}
	
	public za_rss(int id ,String symbol,String title)
	{
		row = id ;
		m_symbol = symbol;
		m_title = title;
	}
	
	void  getStock(){
	    HttpConnection c = null;
		OutputStream os = null;
		InputStream is = null;			
		m_lastBuildDate = "N/A";
		try {
			c = (HttpConnection)Connector.open(m_symbol); 
			c.setRequestProperty("Content-Language", "UTF-8");
			int rc = c.getResponseCode();
			if (rc != HttpConnection.HTTP_OK) {
                 throw new IOException("HTTP response code: " + rc);
             }
			 is = c.openInputStream();
			 m_log="aaa";
			  XMLParser r = new XMLParser();
		       	try {
		       		//InputSource l_ns = new InputSource(getClass().getResourceAsStream("/stocksNews.txt" ));
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
	
//	void getStock() {
//		m_log = "aaa";
//		XMLParser r = new XMLParser();
//		try {
//			InputSource l_ns = new InputSource(getClass().getResourceAsStream(
//					"/stocksNews.txt"));
//			l_ns.setEncoding("UFT-8");
//			r.parse(l_ns, new mydh());
//		} catch (SAXException e) {
//			m_log = "Bbb";
//			e.printStackTrace();
//		} catch (IOException e) {
//			m_log = "ccc";
//			e.printStackTrace();
//		}
//	}

	
	
	
	class mydh extends DefaultHandler
	{			 
		public void startElement(String uri, String localName, String qName, Attributes attributes) 
		{			
			pushitem(localName);		
			if (localName.equals("item"))
				l_rssitem = new za_rssitem();
		}
		
		public void characters(char[] ch, int start, int length) 
		{
			 if (getitem().equals("channel"))
			     getdate(ch, start, length) ;			
			 if (getitem().equals("item"))
				 l_rssitem.getdata((String) m_items.elementAt(m_items.size()-1),ch, start, length) ;
		}
		
		public void endElement(String uri, String localName, String qName) 
		{			
			popitem();
			if (localName.equals("item"))
			{
				m_rssitem.addElement(l_rssitem);
				l_rssitem.m_sybmol = m_symbol;
				
				if (l_rssitem.m_guid == null)
					l_rssitem.m_guid = l_rssitem.m_link;
				
				l_rssitem.insertrss();
			}
		}
		public void startDocument()
		{
			m_rssitem.removeAllElements();
		}
		public void endDocument()
		{

		}
	}
	
	String getitem()
	{		
		if (m_items.size() >=2)
		return (String)m_items.elementAt(m_items.size() -2);
		else
		return "N/A";
	}
	
	void pushitem(String localName)
	{
		m_items.addElement(localName);	
	}
	
	void popitem()
	{
		m_items.removeElementAt(m_items.size()-1);
	}
	
	void getdate(char[] ch, int start, int length)
	{
		String localName = (String) m_items.elementAt(m_items.size()-1);
		String l_value = new String(ch,start,length); 
		if (localName.equals("title"))
			m_title= l_value; 
		else if (localName.equals("link"))
			m_link= l_value;
		else if (localName.equals("description"))
			m_description= l_value;
		else if (localName.equals("lastBuildDate"))
			m_lastBuildDate= l_value;
		else if (localName.equals("copyright"))
			m_copyright= l_value;
	}	
	
	String totalString()
	{
		int l_all= 0;
		int l_unread = 0;
		for (int n =0;n < m_rssitem.size(); n++)
		{
			za_rssitem l_ty;
			l_ty = (za_rssitem)m_rssitem.elementAt(n);
			if (!l_ty.m_read)
				l_unread ++;
			l_all ++;					
		}
		return Integer.toString(l_unread)+ "/"+ Integer.toString(l_all);
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
	
	
create table tab_rsslog 
(
symbol varchar,
uid varchar,
title varchar,
content varchar,
datetime varchar
)
	 */

