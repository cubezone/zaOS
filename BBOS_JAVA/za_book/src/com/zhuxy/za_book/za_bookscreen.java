package com.zhuxy.za_book;

import java.util.Vector;

import net.rim.device.api.ui.Font;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.container.MainScreen;

public class za_bookscreen  extends MainScreen{
	Vector m_cdrs = new Vector();
	RichTextField l_rich = new RichTextField("");
   public za_bookscreen(za_bookcontent l_bc,int seqe)
   {	   
	   setTitle(l_bc.m_content);
	   String l_str="";
		try {
			za_db m_db = za_db.getInstanct();
			m_db.open();
			m_cdrs = m_db.selectcontent(l_bc.m_bookid,l_bc.m_seq ,seqe);
			m_db.close();
		} catch (Exception e) {
			za_db.errorDialog(e.toString());
			e.printStackTrace();
		}
		for (int n = 0 ; n < m_cdrs.size() ; n++)
			l_str += ((za_bookcontent) m_cdrs.elementAt(n)).m_content + "\r\n\r\n";		
		l_rich.setText(l_str);
		l_rich.setFont(Font.getDefault().derive(Font.PLAIN, 9, Ui.UNITS_pt));
		add(l_rich);
   }
}
