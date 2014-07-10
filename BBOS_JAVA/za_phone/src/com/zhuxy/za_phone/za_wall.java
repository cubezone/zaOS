package com.zhuxy.za_phone;

import java.util.Vector;

import net.rim.device.api.system.Bitmap;
import net.rim.device.api.system.Display;
import net.rim.device.api.ui.Color;
import net.rim.device.api.ui.DrawStyle;
import net.rim.device.api.ui.Field;
import net.rim.device.api.ui.Font;
import net.rim.device.api.ui.Graphics;

final public class za_wall extends Field  implements DrawStyle
{
	   
	   Vector m_vec = new Vector();
	   String m_title = "N/A";
	   
	   int m_height = 100;
	   int m_width = 100;
	   int addup = 35;
	   boolean m_dirty=true;
	   static Bitmap l_bmp = Bitmap.getBitmapResource("g_corner.png");
		protected void layout(int width, int height) {		
			if (m_dirty)
			{	
				m_dirty = false;
				calheight();				
			}
			setExtent(Display.getWidth(),m_height);			
		}

		protected void paint(Graphics g) {
	
			int x =  (Display.getWidth() - m_width) /2 ;
			int y = 10 ; 
			g.setColor(0x00EBFDD2);
			g.fillRect(x, y, m_width, 35+1);
			
			g.setColor(0x00B0D167);
			g.drawLine(x, y, x+m_width-1, y);
			g.drawLine(x, y, x, y+35);
			g.drawLine(x+m_width-1, y, x+m_width-1, y+35);
			g.drawBitmap(x,y,7,7,l_bmp , 0, 0);
			g.drawBitmap(x+m_width-7,y,7,7,l_bmp , 7, 0);
			y += addup;
			g.drawLine(x, y, x+m_width-1, y);
			g.setColor(Color.BLACK);			
			g.drawText(m_title, x, 17,DrawStyle.HCENTER|DrawStyle.HALIGN_MASK ,m_width);
					
			y += 5;
			
			for (int n=0 ; n < m_vec.size(); n ++)
			{								
				String l_str ="";
				int len = 0;
				String l_cnt = (String) m_vec.elementAt(n);		
				int f = 0;
				for (int i = 0 ; i < l_cnt.length(); i++)
				{					
					len += Font.getDefault().getAdvance(l_cnt.charAt(i));
					if (len > m_width -25 || l_cnt.charAt(i) == '\r' )
					{
						g.setColor(0x00E5EEFF);
						g.fillRect(x, y, m_width, 35+1);
						g.setColor(0x004A7EBB);
						if (f ==0)							
						{
							f = 1;
							g.drawLine(x, y, x+m_width-1, y);
						}
						g.drawLine(x, y, x, y+35);						
						g.drawLine(x+m_width-1, y, x+m_width-1, y+35);
						g.setColor(Color.BLACK);
						g.drawText(l_str, x+10, y+10);		
						y += addup;	
						len = 0;
						l_str = ""+l_cnt.charAt(i);
					}
					else
						l_str += l_cnt.charAt(i);
				}
						
				g.setColor(0x00E5EEFF);				
				g.fillRect(x, y, m_width, 35+1);
				g.setColor(0x004A7EBB);
				if (f == 0)
					g.drawLine(x, y, x+m_width-1, y);
				g.drawLine(x, y, x, y+35);
				g.drawLine(x+m_width-1, y, x+m_width-1, y+35);
				g.setColor(Color.BLACK);								
				g.drawText(l_str, x+10, y+10,DrawStyle.LEFT,300);				
				y += addup;				
			}	
			g.setColor(0x004A7EBB);
			g.drawLine(x, y, x+m_width-1, y);
		}		
		
		protected void add(String i_cnt) {
			m_vec.addElement(i_cnt);				
			m_dirty=true; 
		}	
		
		protected void set(int ind, String i_cnt) {
			if (ind < m_vec.size())
			{
				m_vec.removeElementAt(ind);
				m_vec.insertElementAt(i_cnt, ind);				
				m_dirty=true;				
			}
		}
		
		protected void calheight()
		{			
			m_height  = 45;
			for (int n=0 ; n < m_vec.size(); n ++)
			{			
				String l_str ="";
				int len = 0;
				String l_cnt = (String) m_vec.elementAt(n);				
				for (int i = 0 ; i < l_cnt.length(); i++)
				{
					len += Font.getDefault().getAdvance(l_cnt.charAt(i));
					if (len > m_width -25)
					{
						m_height += addup;						
						len = 0;
						l_str = ""+l_cnt.charAt(i);
					}
					else
						l_str += l_cnt.charAt(i);
				}					
				m_height += addup;				
			}					
			m_height += 10;
		}
		
		protected void addTitle(String i_cnt) {
			m_title = i_cnt;
			m_height = 35;
			m_width =  Display.getWidth()-30;
			m_height += 5;
		}	
}