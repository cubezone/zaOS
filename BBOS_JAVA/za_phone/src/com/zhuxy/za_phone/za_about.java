package com.zhuxy.za_phone;
import net.rim.device.api.ui.component.LabelField;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.container.MainScreen;

public final  class za_about extends MainScreen
{
    
     
    public za_about()
    {        
    	za_wall m_wall;
    	m_wall = new za_wall();
    	m_wall.addTitle("����");
    	           
        m_wall.add("za_bill");
        m_wall.add("ver:V2.0");
        m_wall.add("dev:cubezone");
        m_wall.add("mail:daemon@wo.com.cn");
        add(m_wall);
    	m_wall = new za_wall();
    	m_wall.addTitle("������ʷ");
        m_wall.add("2010.");
        m_wall.add("  12/12  V1.6 �Ի�ʽͼ�ν���");
        m_wall.add("  11/28  V1.5 ���Ӽ����Ż�");       
        m_wall.add("  10/31  V1.4 ��������ѡ��");
        m_wall.add("  10/30  V1.2 ���ӷ�������");
        m_wall.add("  10/24  V1.1 �޸Ľ���ͼ��");
        m_wall.add("  10/18  V1.1 ����ͬ���˵���ʾ����");
        m_wall.add("  10/02  V1.0 �嵥��ʾ����������");
        m_wall.add("  09/25  V0.7 ���ӼƷѹ���");
        m_wall.add("  09/20  V0.5 �汾����");       
        add(m_wall);
    }  
}