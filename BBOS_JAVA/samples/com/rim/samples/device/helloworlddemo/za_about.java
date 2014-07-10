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
import net.rim.blackberry.api.invoke.*;
import net.rim.blackberry.api.homescreen.HomeScreen;
import javax.microedition.media.control.*;
import javax.microedition.media.*;
import javax.microedition.media.Manager.*;
import java.io.IOException;
import java.io.InputStream;
import javax.microedition.io.Connector;
import javax.microedition.io.file.FileConnection;



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
    
    ;
    FileConnection fc = null;
    
    public za_about(UiApplication app)
    {            
        m_ColorSet = new za_ColorSet(app);    
        String ls_about;
        String fn ="SDCard/aaa.png";
        m_app = app;
        String ls_step=null;
        setTitle(title);                  
        add(new BitmapField( Bitmap.getBitmapResource("helloworld_jde.png"),FIELD_HCENTER));
        add(new BitmapField(Bitmap.createBitmapFromPNG(l_png.getBytes(),0,bys.length),Field.FOCUSABLE ));
        try 
        {
             fc = (FileConnection)Connector.open("file:///" + fn);
             int len = (int)fc.fileSize();
             //fc = (FileConnection)Connector.open("file:///" );
             ls_step = "aaaa";
             byte[] l_data  = new byte[len];
             fc.openInputStream().read(l_data,0,len);         
             ls_step = "bbb";
             add(new BitmapField(Bitmap.createBitmapFromPNG(l_data,0,l_data.length),Field.FOCUSABLE ));
             ls_step = "ccc";
        } 
        catch (Exception ioex) 
        {
            add(new LabelField ("Error : "+ls_step+ioex.toString() + fn));
        } 
        finally 
        {
            if (fc != null) 
            {
                try 
                {
                    fc.close();
                    fc = null;
                } 
                catch (Exception ioex) 
                {
                }
            }      
        }
        //add(new SeparatorField(SeparatorField.LINE_HORIZONTAL));  
        ls_about =  "�汾:V1.6\n";
        ls_about += "����:daemon@wo.com.cn \n";
        ls_about += "\n";                                            
        ls_about += "ʹ��˵��:\n";
        ls_about += "1.�켣���ƶ���ͼ\n";
        ls_about += "2.+ - ���Ŵ���С��ͼ\n";   
        ls_about += "\n";
        ls_about += "������ʷ:\n";
        ls_about += "2010/07/11  V1.5 �Ż�������ʾ�㷨 \n";
        ls_about += "2010/07/09  V1.1 ����������ͼ \n";
        ls_about += "2010/07/07  V1.0 �����Ϻ���ͼ \n";
        ls_about += "2010/07/06  V1.0 ���ӱ�����ͼ \n";
        ls_about += "2010/07/06  V1.0 ���ӹ��ݵ�ͼ\n";
        ls_about += "2010/07/06  V1.0 �����Ͼ���ͼ\n";
        ls_about += "2010/07/01  V1.0 �汾����\n";     
     
        add(new RichTextField(ls_about)); 
    }  
   
   protected void makeMenu(Menu menu, int instance)
    {   
        menu.add(new MenuItem("��ɫ��" , 100, 10){
            public void run(){
               m_app.pushScreen(m_ColorSet);
            }}
        );          
        menu.add(new MenuItem("���� 10010" , 100, 10){
            public void run(){
             Invoke.invokeApplication(Invoke.APP_TYPE_PHONE,new 
              PhoneArguments(PhoneArguments.ARG_CALL,"10010"));
             }
            }
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
