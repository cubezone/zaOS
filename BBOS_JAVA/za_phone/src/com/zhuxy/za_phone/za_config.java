package com.zhuxy.za_phone;

import java.io.InputStream;
import java.io.OutputStream;


import javax.microedition.io.Connector;
import javax.microedition.io.file.FileConnection;


import net.rim.device.api.ui.component.BasicEditField;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.EditField;
import net.rim.device.api.ui.component.LabelField;

import net.rim.device.api.ui.component.SeparatorField;
import net.rim.device.api.ui.container.MainScreen;

public final  class za_config extends MainScreen {
	EditField m_month = new EditField("固定费: ","0",10, BasicEditField.FILTER_INTEGER);			
	EditField m_freemin = new EditField(" 主叫免费分钟数: ","0",10, BasicEditField.FILTER_INTEGER);
	EditField m_rate = new EditField(" 费率(分为单位): ","0",10, BasicEditField.FILTER_INTEGER);
	EditField m_groupfee = new EditField("集团包月费: ","0",10, BasicEditField.FILTER_INTEGER);
	EditField m_freegroupmin = new EditField(" 集团免费分钟数: ","0",10, BasicEditField.FILTER_INTEGER);	
	EditField m_group1 = new EditField(" 集团成员1: ","",20, BasicEditField.NO_COMPLEX_INPUT);
	EditField m_group2 = new EditField(" 集团成员2: ","",20, BasicEditField.NO_COMPLEX_INPUT);
	
	public za_config()
	{            
	    	setTitle("设置");	
	    	add(new LabelField("资费设置"));
	    	add(new SeparatorField());
	    	add(m_month);	    	
	    	add(m_freemin);
	    	add(m_rate); 
	    	add(new SeparatorField());
	    	add(m_groupfee);
	    	add(m_group1); 
	    	add(m_group2); 
	    	init();
	}
	public boolean onSave()
	{
		save();
		return true;
	}
	
	public void save()
	{
		FileConnection fc = null;
		boolean l_new = false;
		// String fn ="SDCard/GPRSPos.txt";
		String fn ="store/home/user/documents/za_bill.cfg.txt";

		try {
			fc = (FileConnection) Connector.open("file:///" + fn,
					Connector.READ_WRITE);
			if (!fc.exists()) {
				fc.create();
				l_new = true;
			}
			OutputStream l_dop = fc.openOutputStream();
			if (l_new)// uef-8 head flag;
			{
				l_dop.write(0xEF);
				l_dop.write(0xBB);
				l_dop.write(0xBF);
			}
			
			String str = "%0"+m_month.getText()
			+"%1"+m_groupfee.getText()
			+"%2"+m_freemin.getText()
			+"%3"+m_rate.getText()
			+"%4"+m_freegroupmin.getText()
			+"%5"+m_group1.getText()
			+"%6"+m_group2.getText()
			+"%7";
			
			l_dop.write(str.getBytes("UTF-8"));
			l_dop.flush();
			l_dop.close();
			fc.close();
		} catch (Exception ioex) {
			Dialog.alert("Error : " + ioex.toString() + fn);
		} finally {
			if (fc != null) {
				try {
					fc.close();
					fc = null;
				} catch (Exception ioex) {
				}
			}
		}
	}
	
	public void init()
	{
		FileConnection fc = null;
		String fn = "store/home/user/documents/za_bill.cfg.txt";
		try {			
			byte[] b = new byte[1000];
			fc = (FileConnection) Connector.open("file:///" + fn,
					Connector.READ_WRITE);
			if (!fc.exists()) {
				return;
			}
			InputStream l_dip = fc.openInputStream();			
			int l_len= l_dip.read(b);
			l_dip.close();
			fc.close();
			String text = new String(b,0,l_len,"UTF-8");
			m_month.setText(text.substring(text.indexOf("%0")+2, text.indexOf("%1")));
			m_groupfee.setText(text.substring(text.indexOf("%1")+2, text.indexOf("%2")));
			m_freemin.setText(text.substring(text.indexOf("%2")+2, text.indexOf("%3")));
			m_rate.setText(text.substring(text.indexOf("%3")+2, text.indexOf("%4")));	
			m_freegroupmin.setText(text.substring(text.indexOf("%4")+2, text.indexOf("%5")));				
			m_group1.setText(text.substring(text.indexOf("%5")+2, text.indexOf("%6")));	
			m_group2.setText(text.substring(text.indexOf("%6")+2, text.indexOf("%7")));
			
		} catch (Exception ioex) {
			Dialog.alert("Error : " + ioex.toString() + fn);
		} finally {
			if (fc != null) {
				try {
					fc.close();
					fc = null;
				} catch (Exception ioex) {
				}
			}
		}		
	}
}
