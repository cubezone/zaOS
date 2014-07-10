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
    	m_wall.addTitle("关于");
    	           
        m_wall.add("za_bill");
        m_wall.add("ver:V2.0");
        m_wall.add("dev:cubezone");
        m_wall.add("mail:daemon@wo.com.cn");
        add(m_wall);
    	m_wall = new za_wall();
    	m_wall.addTitle("更新历史");
        m_wall.add("2010.");
        m_wall.add("  12/12  V1.6 对话式图形界面");
        m_wall.add("  11/28  V1.5 增加集团优惠");       
        m_wall.add("  10/31  V1.4 增加账期选择");
        m_wall.add("  10/30  V1.2 增加费率设置");
        m_wall.add("  10/24  V1.1 修改界面图标");
        m_wall.add("  10/18  V1.1 增加同步账单显示功能");
        m_wall.add("  10/02  V1.0 清单显示区分主被叫");
        m_wall.add("  09/25  V0.7 增加计费功能");
        m_wall.add("  09/20  V0.5 版本发布");       
        add(m_wall);
    }  
}