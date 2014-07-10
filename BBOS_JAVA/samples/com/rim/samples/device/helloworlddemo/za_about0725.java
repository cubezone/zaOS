/*
 * za_ColorSet.java
 *
 * ? <your company here>, 2003-2008
 * Confidential and proprietary.
 */
package com.rim.samples.device.helloworlddemo;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.system.*;
import net.rim.blackberry.api.homescreen.HomeScreen;
import javax.microedition.media.control.*;
import javax.microedition.media.*;
import javax.microedition.media.Manager.*;
import java.io.IOException;

public final  class za_about extends MainScreen
{
     UiApplication m_app;
     LabelField title = new LabelField("About ChinaMetro" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH);   
    za_ColorSet m_ColorSet;
    char bys[]={0x89,0x50,0x4E,0x47,0x0D,0x0A,0x1A,0x0A,0x00,0x00,0x00,0x0D,0x49,0x48,0x44,0x52,
0x00,0x00,0x00,0x29,0x00,0x00,0x00,0x19,0x08,0x03,0x00,0x00,0x00,0x9B,0xC4,0xF7,
0x69,0x00,0x00,0x00,0x06,0x50,0x4C,0x54,0x45,0x00,0xFF,0x00,0x00,0x00,0xFF,0x42,
0x01,0x91,0xCE,0x00,0x00,0x00,0x01,0x74,0x52,0x4E,0x53,0x00,0x40,0xE6,0xD8,0x66,
0x00,0x00,0x00,0x16,0x49,0x44,0x41,0x54,0x78,0xDA,0x63,0x60,0x24,0x16,0x30,0x8C,
0xAA,0x1C,0x55,0x39,0xAA,0x72,0xC4,0xA8,0x04,0x00,0x3A,0x9F,0x04,0x02,0x04,0x65,
0xE1,0x1D,0x00,0x00,0x00,0x00,0x49,0x45,0x4E,0x44,0xAE,0x42,0x60,0x82};
    String l_png = new String(bys); 
    public za_about(UiApplication app)
    {            
        m_ColorSet = new za_ColorSet(app);    
        String ls_about;
        m_app = app;
        setTitle(title);                  
        add(new BitmapField( Bitmap.getBitmapResource("helloworld_jde.png"),FIELD_HCENTER));
        add(new BitmapField(Bitmap.createBitmapFromPNG(l_png.getBytes(),0,bys.length),Field.FOCUSABLE ));
        //add(new SeparatorField(SeparatorField.LINE_HORIZONTAL));  
        ls_about =  "版本:V1.6\n";
        ls_about += "作者:daemon@wo.com.cn \n";
        ls_about += "\n";                                            
        ls_about += "使用说明:\n";
        ls_about += "1.轨迹球移动地图\n";
        ls_about += "2.+ - 键放大缩小地图\n";   
        ls_about += "\n";
        ls_about += "更新历史:\n";
        ls_about += "2010/07/11  V1.5 优化增量显示算法 \n";
        ls_about += "2010/07/09  V1.1 增加沈阳地图 \n";
        ls_about += "2010/07/07  V1.0 增加上海地图 \n";
        ls_about += "2010/07/06  V1.0 增加北京地图 \n";
        ls_about += "2010/07/06  V1.0 增加广州地图\n";
        ls_about += "2010/07/06  V1.0 增加南京地图\n";
        ls_about += "2010/07/01  V1.0 版本发布\n";     
     
        add(new RichTextField(ls_about)); 
    }  
   
   protected void makeMenu(Menu menu, int instance)
    {   
       menu.add(new MenuItem("调色板" , 100, 10){
            public void run(){
               m_app.pushScreen(m_ColorSet);
            }}
        );          
    }
    public boolean onSavePrompt()
    {
        return true;
    }      

    public void close()
    {

       super.close();
    }   
}
