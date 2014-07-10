package com.zhuxy.za_rss;


public class za_rssitem
{
		String m_sybmol = null;
		String m_title = null;
		String m_description = null;
		String m_link = "http://www.a.com";
		String m_guid = "";
		String m_category = "";
		String m_pubDate = "";
		String m_formatdesc = null;
		boolean m_read = false;
		
		public za_rssitem()
		{
			
		}
		
		void getdata(String localName, char[] ch, int start, int length) 
		{	
			String l_value = new String(ch,start,length); 
			if (localName.equals("title"))
				m_title= l_value; 
			else if (localName.equals("description"))
				m_description= l_value;
			else if (localName.equals("link"))
				m_link= l_value;
			else if (localName.equals("guid"))
				m_guid= l_value;
			else if (localName.equals("category"))
				m_category= l_value;
			else if (localName.equals("pubDate"))
				m_pubDate= l_value;			
		}
		

		void insertrss()
		{
			try {
				za_db m_db = za_db.getInstanct();
				m_db.open();		     		
				m_read = m_db.insertrss(this);
				m_db.close();
			} catch (Exception e) {
				za_db.errorDialog(e.toString());
				e.printStackTrace();
			}
		}
		
		void updateread()
		{		
			try {
				m_read = true;
				za_db m_db = za_db.getInstanct();
				m_db.open();
				m_db.updateread(this);
				m_db.close();
			} catch (Exception e) {
				za_db.errorDialog(e.toString());
				e.printStackTrace();
			}
		}
		
		
		String formatdesc()
		{
			return formatdesc(999999);
		}
	
		String formatdesc(int len )
		{
			if (m_formatdesc != null)
				return m_formatdesc;
			
			boolean l_tag = false;
			StringBuffer l_out = new StringBuffer();			
			StringBuffer l_br = new StringBuffer();								
				
			int l_len = Math.min(m_description.length(),len);
			
				for (int i = 0 ; i < l_len; i++)
				{
					char l_chr = m_description.charAt(i);
					if (l_chr== '<')
						l_tag = true;

					if (l_tag == false )
						l_out.append(l_chr);
					else
					{
						l_br.append(l_chr);
						if (l_br.toString().toUpperCase().equals("BR"))
						{							
							l_out.append('\r');							
							l_out.append('\n');
							l_out.append(' ');
							l_out.append(' ');	
							l_br.delete(0, l_br.length()-1);
						}
					}		
					if (l_chr== '>')
						l_tag = false;
				}
							
			if (len != 999999 && len < m_description.length() )
				return "\r\n"+l_out.toString()+"\r\nÎÄµµ¼ÓÔØÖÐ...";
			else
			{
				m_formatdesc = "\r\n"+l_out.toString()+"\r\n";
				return m_formatdesc;
			}
		}
}
