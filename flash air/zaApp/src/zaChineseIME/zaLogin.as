package
{
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import model.*; 
	
	import org.osmf.net.StreamingURLResource;
	
	import qnx.ui.buttons.Button;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.buttons.RadioButton;
	import qnx.ui.data.DataProvider;
	import qnx.ui.display.Image;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	import qnx.ui.listClasses.ScrollDirection;
	import qnx.ui.listClasses.ScrollPane;
	import qnx.ui.skins.slider.VolumeFillSkin;
	import qnx.ui.text.Label;
	
	
	[SWF(height="600", width="1024", 
     frameRate="30", backgroundColor="#444444")]
	
	public class zaLogin extends Sprite
	{
		private var m_p1:Image = new Image();
		private var m_p2:Image = new Image();
		private var m_p3:Image = new Image();
		private var m_p4:Image = new Image();
		private var m_p5:Image = new Image();
		private var m_p6:Image = new Image();
		
		
		private var m_btn_0:LabelButton = new LabelButton();
		private var m_btn_1:LabelButton = new LabelButton();
		private var m_btn_2:LabelButton = new LabelButton();
		private var m_btn_3:LabelButton = new LabelButton();
		private var m_btn_4:LabelButton = new LabelButton();
		private var m_btn_5:LabelButton = new LabelButton();
		private var m_btn_6:LabelButton = new LabelButton();
		private var m_btn_7:LabelButton = new LabelButton();
		private var m_btn_8:LabelButton = new LabelButton();
		private var m_btn_9:LabelButton = new LabelButton();
		private var m_btn_back:LabelButton = new LabelButton();
		private var m_btn_u:LabelButton = new LabelButton();
		
		private var m_sql:RecordDAO = new RecordDAO();
		
		private var til:Label = new Label();
		private var m_pass:String = "112233";
		private var newTaskPane :Sprite = new Sprite();
		private var m_parray :Array = [];
		private var m_tf:TextFormat ;
		private var m_input:String="";
		private var m_input2:String="";
		
		private var m_passlist:Array = [];
		private var m_updatemode:int = 0;
		
		public function zaLogin()
		{			
			initUI();
			
			m_passlist = m_sql.findall(0,"zapassword");
			if (m_passlist == null)
			{
				m_updatemode = 2;
				til.text = "Set password";			
				til.x = (1024 - til.textWidth)/2;
			}			  
			else			
			  m_pass = m_passlist[0].password;			
			super();			
		}
		
		public function initUI():void
		{
			m_tf = til.format;
			m_tf.size = 20;
			m_tf.color = 0xEEEE00;
			til.format = m_tf;
			til.alpha = 0.8;
			til.text ="";
			til.width = 1000;
			til.y = 210;			
			
			addChild(til);
			
			m_p1.setImage("res/p1.png");
			m_p2.setImage("res/p1.png");
			m_p3.setImage("res/p1.png");
			m_p4.setImage("res/p1.png");
			m_p5.setImage("res/p1.png");
			m_p6.setImage("res/p1.png");
			m_parray.push(m_p1);
			m_parray.push(m_p2);
			m_parray.push(m_p3);
			m_parray.push(m_p4);
			m_parray.push(m_p5);
			m_parray.push(m_p6);
			
			var l_x:int = 0;
			var l_y:int = 0;
			l_x = 160;
			l_y = 100;
			
			m_p1.x = l_x; l_x += 120;
			m_p2.x = l_x; l_x += 120;
			m_p3.x = l_x; l_x += 120;
			m_p4.x = l_x; l_x += 120;
			m_p5.x = l_x; l_x += 120;
			m_p6.x = l_x; l_x += 120;
			
			m_p1.y = l_y;
			m_p2.y = l_y;
			m_p3.y = l_y;
			m_p4.y = l_y;
			m_p5.y = l_y;
			m_p6.y = l_y;
			
			addChild(this.m_p1);
			addChild(this.m_p2);
			addChild(this.m_p3);
			addChild(this.m_p4);
			addChild(this.m_p5);
			addChild(this.m_p6);
			
			m_btn_0.label = "0";
			m_btn_1.label = "1";
			m_btn_2.label = "2";
			m_btn_3.label = "3";
			m_btn_4.label = "4";
			m_btn_5.label = "5";
			m_btn_6.label = "6";
			m_btn_7.label = "7";
			m_btn_8.label = "8";
			m_btn_9.label = "9";
			m_btn_u.label = "R";
			m_btn_back.label = "<";
			
			l_x = 320;
			l_y = 250;
			m_btn_1.x = l_x;
			m_btn_1.y = l_y;
			m_btn_1.width = 120;
			m_btn_1.height = 80;
			l_x += 130;
			
			m_btn_2.x = l_x;
			m_btn_2.y = l_y;
			m_btn_2.width = 120;
			m_btn_2.height = 80;
			l_x += 130;
			
			m_btn_3.x = l_x;
			m_btn_3.y = l_y;
			m_btn_3.width = 120;
			m_btn_3.height = 80;
			
			l_x = 320;
			
			l_y += 80;
			m_btn_4.x = l_x;
			m_btn_4.y = l_y;
			m_btn_4.width = 120;
			m_btn_4.height = 80;
			l_x += 130;
			
			m_btn_5.x = l_x;
			m_btn_5.y = l_y;
			m_btn_5.width = 120;
			m_btn_5.height = 80;
			l_x += 130;
			
			m_btn_6.x = l_x;
			m_btn_6.y = l_y;
			m_btn_6.width = 120;
			m_btn_6.height = 80;
			
			l_x = 320;			
			l_y += 80;
			m_btn_7.x = l_x;
			m_btn_7.y = l_y;
			m_btn_7.width = 120;
			m_btn_7.height = 80;
			l_x += 130;
			
			m_btn_8.x = l_x;
			m_btn_8.y = l_y;			
			m_btn_8.width = 120;
			m_btn_8.height = 80;
			l_x += 130;
			
			m_btn_9.x = l_x;
			m_btn_9.y = l_y;
			m_btn_9.width = 120;
			m_btn_9.height = 80;
			
			
			l_x = 320;	
			l_y += 80;	
			
			m_btn_u.x = l_x;
			m_btn_u.y = l_y;
			m_btn_u.width = 120;
			m_btn_u.height = 80;
			
			l_x += 130;
			
			m_btn_0.x = l_x;
			m_btn_0.y = l_y;
			m_btn_0.width = 120;
			m_btn_0.height = 80;
			
			
			l_x += 130;
			
			m_btn_back.x = l_x;
			m_btn_back.y = l_y;
			m_btn_back.width = 120;
			m_btn_back.height = 80;
			
			
			addChild(m_btn_0);
			addChild(m_btn_1);
			addChild(m_btn_2);
			addChild(m_btn_3);
			addChild(m_btn_4);
			addChild(m_btn_5);
			addChild(m_btn_6);
			addChild(m_btn_7);
			addChild(m_btn_8);
			addChild(m_btn_9);
			addChild(m_btn_u);
			addChild(m_btn_back);
			
			m_btn_0.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_1.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_2.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_3.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_4.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_5.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_6.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_7.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_8.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_9.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_u.addEventListener(MouseEvent.CLICK,on_click);
			m_btn_back.addEventListener(MouseEvent.CLICK,on_click);
			
		}

		private function clearinput():void
		{
			m_p1.setImage("res/p1.png");
			m_p2.setImage("res/p1.png");
			m_p3.setImage("res/p1.png");
			m_p4.setImage("res/p1.png");
			m_p5.setImage("res/p1.png");
			m_p6.setImage("res/p1.png");
		}
		
		private function on_click(e:MouseEvent):void
		{
			var l_btn:LabelButton = e.target as LabelButton;
			
			if (l_btn == m_btn_u)
			{
				m_updatemode = 1 ;// update password.
				clearinput();
				m_input = "";
				m_input2 = "";
				til.text = "Type old password";		
				til.x = (1024 - til.textWidth)/2;
				return;
			}
			
			if (m_updatemode == 0 || m_updatemode == 1 )// login
			{
				if (l_btn != m_btn_back && l_btn != m_btn_u )			
				{				
					if (m_input.length ==6 ) return;
					
					m_input = m_input.concat(l_btn.label);		
					
					if (m_input.length == 6)
					{
						if (m_input == m_pass)
						{							
							if (m_updatemode==0)
								zaChineseIME(this.parent).change();
							else
							{
								m_updatemode = 2;
								til.text = "Type new password";		
								til.x = (1024 - til.textWidth)/2;
								m_input ="";
								clearinput();
							}
						}	
						else
							if (m_input.length >0)
								m_parray[m_input.length-1].setImage("res/p2.png");
					}
					else
						if (m_input.length >0)
							m_parray[m_input.length-1].setImage("res/p2.png");
				}
				if (l_btn == m_btn_back)
				{
					m_input = m_input.substr(0,m_input.length-1);
					if (m_input.length >=0)
					m_parray[m_input.length].setImage("res/p1.png");				
				}		
			}
			
			else if (m_updatemode == 2 || m_updatemode == 3 )				
			{
				if (l_btn != m_btn_back && l_btn != m_btn_u )			
				{				
					if (m_updatemode == 2 )//type new pass
					{											
						m_input = m_input.concat(l_btn.label);												
						if (m_input.length == 6) 
						{
							m_updatemode = 3;
							m_input2 = "";
							clearinput();
							til.text = "Retype new password";			
							til.x = (1024 - til.textWidth)/2;
							
						} else  if (m_input.length >0)
								m_parray[m_input.length-1].setImage("res/p2.png");
					}
					else if (m_updatemode ==3)// retype new password
					{						
						m_input2 = m_input2.concat(l_btn.label);							
						if (m_input2.length == 6) 
						{
							if (m_input== m_input2)
							{
								til.text = "Password changed";
								til.x = (1024 - til.textWidth)/2;
								
								zaChineseIME(this.parent).change();
								//savepass;
								var l_r:Record
								if (m_passlist==null)
								{
									l_r= new Record();								
//									l_r.title = "zapassword";
//									l_r.username = "zapassword123";
//									l_r.password = m_input;		
									m_sql.insert(l_r);
								}
								else
								{
									l_r = m_passlist[0];
								//	l_r.password = m_input;		
									m_sql.update(l_r);	
								}								
							}
							else
							{
							  til.text = "Input mismatch, Type new password";
							  til.x = (1024 - til.textWidth)/2;
							  
							  m_input = "";
							  m_input2 = "";
							  clearinput();
							  m_updatemode = 2;
							}
						}
						else if (m_input2.length >0)
							m_parray[m_input2.length-1].setImage("res/p2.png");
					}											
				}
				
				if (l_btn == m_btn_back)
				{
					if (m_updatemode ==2 )//type new pass
					{	
						m_input = m_input.substr(0,m_input.length -1);
						m_parray[m_input.length].setImage("res/p1.png");	
					}
					else
					{
						m_input2 = m_input2.substr(0,m_input2.length -1);
						m_parray[m_input2.length].setImage("res/p1.png");	
					}
				}				
			}		
		}
	
	}
}
