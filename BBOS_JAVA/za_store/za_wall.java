

import java.util.Vector;

import net.rim.device.api.system.Bitmap;
import net.rim.device.api.system.Display;
import net.rim.device.api.ui.DrawStyle;
import net.rim.device.api.ui.Field;
import net.rim.device.api.ui.Graphics;

public class za_wall extends Field  implements DrawStyle
{
	   static Bitmap l_bmp = Bitmap.getBitmapResource("back.png");
	   Vector m_vec = new Vector();
	   String m_title = "";
	   
		protected void layout(int width, int height) {			
			setExtent(Display.getWidth(),l_bmp.getHeight());
		}

		protected void paint(Graphics g) {
			//g.drawImage(dest, image, frameIndex, left, top);
			int x =  (Display.getWidth() - l_bmp.getWidth()) /2 ;
			g.drawBitmap(x, 0, l_bmp.getWidth(), l_bmp.getHeight(), l_bmp, 0, 0);
			
			g.drawText(m_title,Display.getWidth()/2 - g.getFont().getAdvance(m_title)/2, 12);
			x = 30 ;
			int y = 62 ;
			int addup = 35;
			for (int n=0 ; n < m_vec.size(); n ++)
			{
				g.drawText((String) m_vec.elementAt(n), x, y);
				y += addup;				
			}										
		}		
		
		protected void add(String i_cnt) {
			m_vec.addElement(i_cnt);
		}	
		
		protected void addTitle(String i_cnt) {
			m_title = i_cnt;
		}	
	}