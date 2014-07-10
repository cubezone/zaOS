package zaChineseIME.model
{
	public class PinYinVector
	{		
		public var m_vector:Array= new Array();
		public var m_vectorbase:Array= new Array(); 
		
		private var m_py:String="";
		private var m_py_decode:String="";
		public var m_py_decode_list:Array=new Array();
		private var m_py_action_list:Array = new Array();
		private var m_current_match:int;
		private var m_input_method:int=0;
		
		
		public function querysinglechar():String
		{
			if (m_current_match<m_py_decode_list.length)
			return m_py_decode_list[m_current_match].py;
			else 
			return "-";
		}
				
		public function querymutilchar():String
		{
			var ls:String = "";
			if (m_input_method ==0 ||m_input_method ==5)
			{				
				if (m_current_match>0)
					return m_py_decode_list[m_current_match-1].zw;
				else
				{
					for (var n:int = m_current_match ;n < m_py_decode_list.length ; n++)
						ls += m_py_decode_list[n].py.substr(0,1);
					return ls;
				}
			}
			else
			{
				ls = m_py_decode_list[0].py;
				return ls.toLocaleLowerCase() ;
			}												
		}
		
		public function getmutilchar():String
		{
			var ls:String = "";
			for (var n:int = 0 ;n < m_py_decode_list.length ; n++)
				ls += m_py_decode_list[n].py_full.substr(0,1);
			return ls.toLocaleLowerCase();
		}
		
		public function getinputmutilchar():String
		{
			var ls:String = "";
			for (var n:int = 0 ;n < m_py_decode_list.length ; n++)
				ls += m_py_decode_list[n].py.substr(0,1);
			return ls.toLocaleLowerCase();
		}
		
		public function getmutilchar_full():String
		{
			var ls:String = "";
			for (var n:int = 0 ;n < m_py_decode_list.length ; n++)
			{   
				if (n==0)
					ls = m_py_decode_list[n].py_full;
				else
					ls += " "+m_py_decode_list[n].py_full;
			}
			return ls.toLocaleLowerCase();
		}
		
		public function getmutilcharfull():String
		{
			var ls:String = "";
			for (var n:int = 0 ;n < m_py_decode_list.length ; n++)
			{   
				if (n==0)
					ls = m_py_decode_list[n].py;
				else
					ls += m_py_decode_list[n].py;
			}
			return ls.toLocaleLowerCase();
		}
		
		public function hasit(ss:String):Boolean
		{
			if (m_vector.indexOf(ss)>=0)
				return true
			else
				return false;
		}
		
		public function basehasit(ss:String):Boolean
		{
			if (m_vectorbase.indexOf(ss)>=0)
				return true
			else
				return false;
		}
		
		
		public function newword():Boolean
		{
			if (m_py_decode_list.length < 2) return false;
			for (var n:int = 0; n < this.m_py_action_list.length ; n++)
			{
				if ( m_py_action_list[n].action_type == "match")
					return true;
			}	
			return false;
		}
		
		public function reset(im:int):void
		{
			this.m_input_method = im;
			this.m_current_match = 0;
			this.m_py_action_list = [];
			this.m_py_decode_list = [];
		}
		
		public function addchar(py:String):void
		{		
			var a:pyAction = new pyAction();
			a.action_type = "char";
			a.action_Content = py;
			a.action_Content_len = py.length;
			m_py_action_list.push(a);
			var o:pychar;
			if (m_py_decode_list.length==0)
			{
				o = new pychar();
				o.py = py;
				m_py_decode_list.push(o);
				return;
			}
			if (m_input_method == 0 || m_input_method == 5)
			{	
				var p:pychar=m_py_decode_list[m_py_decode_list.length-1];
				var l_s:String=p.py ;					
				if (hasit(l_s.concat(py).toLocaleLowerCase()))
				{				
					p.py += py;				
				}
				else					
				{
					o = new pychar();
					o.py = py;
					m_py_decode_list.push(o);
				}			
			}
			else
				m_py_decode_list[m_py_decode_list.length-1].py += py;
		}
		
		public function match(zw:String,py_full:String):void
		{
			if (m_input_method == 0 || m_input_method == 5)
			{
				var a:pyAction = new pyAction();
				a.action_type = "match";
				a.action_Content = zw;
				a.action_Content_len = zw.length;
				m_py_action_list.push(a);
				for (var n:int = 0 ; n < zw.length ;n ++)
				{
					if (m_py_decode_list.length <=m_current_match)
					{
						var o:pychar = new pychar();
						o.py = py_full;
						m_py_decode_list.push(o);
					}
					var p:pychar = this.m_py_decode_list[this.m_current_match];
					p.zw = zw.charAt(n);
					p.py_full = py_full;
					m_current_match ++;
				}
			}
			else
			{
				m_py_decode_list[0].zw = zw;
				m_py_decode_list[0].py = zw;
				m_py_decode_list[0].py_full = py_full;
				m_current_match =1;	
			}
		}
		
		public function undo():void
		{
			if(m_py_action_list.length==0)
				return;				
			var a:pyAction = m_py_action_list[m_py_action_list.length-1];
			if (a.action_type == "match")
				dismatch(a)
			if (a.action_type == "char")				
				dischar(a);
			m_py_action_list.pop();
		}
		
		public function dismatch(a:pyAction):void
		{
			m_current_match -= a.action_Content_len;		
		}
		
		public function dischar(a:pyAction):void
		{
				var p:pychar = m_py_decode_list[m_py_decode_list.length-1];
			p.py = p.py.substr(0,p.py.length-1);
			if (p.py =="")
				m_py_decode_list.pop();		
		}
		
		public function matchover():Boolean
		{
			return this.m_current_match > 0 && 
			this.m_current_match == this.m_py_decode_list.length;
		}
		
		public function getdecode():String
		{
			var ls:String= "";
			for (var n:int = 0 ; n < m_py_decode_list.length; n++)
			{
				if (n < m_current_match)
					ls = ls.concat(this.m_py_decode_list[n].zw)
				else
				{
					if(n < m_py_decode_list.length -1)
						ls = ls.concat(this.m_py_decode_list[n].py +" ")
					else
						ls = ls.concat(this.m_py_decode_list[n].py );
				}
			}
			return ls;
		}		
		
		public function decode(py:String):String
		{
			m_py = py;
			var l_s:String="";
			var l_n:int = 0;
			var l_char:String="";
			m_py_decode_list = [];
			m_py_decode = "";
			m_current_match = 0;
			for (var a:int = 0 ; a< m_py.length ; a++)
			{
				l_char = m_py.charAt(a);				
				if (!hasit(l_s.concat(l_char)))
				{
					var o:pychar = new pychar();
					o.py = l_s;
					m_py_decode_list.push(o);
					m_py_decode = m_py_decode.concat(l_s+" ");
					l_s = l_char;
				}
				else					
					l_s = l_s.concat(m_py.charAt(a));
			}			
			o = new pychar();
			o.py = l_s;
			m_py_decode_list.push(o);
			
			m_py_decode= m_py_decode.concat(l_s);
			return m_py_decode;
		}
		
		public  function PinYinVectorBase():void 
		{
			m_vectorbase.push("a");
			m_vectorbase.push("ai");
			m_vectorbase.push("an");
			m_vectorbase.push("ang");
			m_vectorbase.push("ao");
			m_vectorbase.push("ba");
			m_vectorbase.push("bai");
			m_vectorbase.push("ban");
			m_vectorbase.push("bang");
			m_vectorbase.push("bao");
			m_vectorbase.push("bei");
			m_vectorbase.push("ben");
			m_vectorbase.push("beng");
			m_vectorbase.push("bi");
			m_vectorbase.push("bian");
			m_vectorbase.push("biao");
			m_vectorbase.push("bie");
			m_vectorbase.push("bin");
			m_vectorbase.push("bing");
			m_vectorbase.push("bo");
			m_vectorbase.push("bu");
			m_vectorbase.push("ca");
			m_vectorbase.push("cai");
			m_vectorbase.push("can");
			m_vectorbase.push("cang");
			m_vectorbase.push("cao");
			m_vectorbase.push("ce");
			m_vectorbase.push("cen");
			m_vectorbase.push("ceng");
			m_vectorbase.push("cha");
			m_vectorbase.push("chai");
			m_vectorbase.push("chan");
			m_vectorbase.push("chang");
			m_vectorbase.push("chao");
			m_vectorbase.push("che");
			m_vectorbase.push("chen");
			m_vectorbase.push("cheng");
			m_vectorbase.push("chi");
			m_vectorbase.push("chong");
			m_vectorbase.push("chou");
			m_vectorbase.push("chu");
			m_vectorbase.push("chuai");
			m_vectorbase.push("chuan");
			m_vectorbase.push("chuang");
			m_vectorbase.push("chui");
			m_vectorbase.push("chun");
			m_vectorbase.push("chuo");
			m_vectorbase.push("ci");
			m_vectorbase.push("co");
			m_vectorbase.push("cong");
			m_vectorbase.push("cou");
			m_vectorbase.push("cu");
			m_vectorbase.push("cuan");
			m_vectorbase.push("cui");
			m_vectorbase.push("cun");
			m_vectorbase.push("cuo");
			m_vectorbase.push("da");
			m_vectorbase.push("dai");
			m_vectorbase.push("dan");
			m_vectorbase.push("dang");
			m_vectorbase.push("dao");
			m_vectorbase.push("de");
			m_vectorbase.push("deng");
			m_vectorbase.push("di");
			m_vectorbase.push("dia");
			m_vectorbase.push("dian");
			m_vectorbase.push("diao");
			m_vectorbase.push("die");
			m_vectorbase.push("ding");
			m_vectorbase.push("diu");
			m_vectorbase.push("dong");
			m_vectorbase.push("dou");
			m_vectorbase.push("du");
			m_vectorbase.push("duan");
			m_vectorbase.push("dui");
			m_vectorbase.push("dun");
			m_vectorbase.push("duo");
			m_vectorbase.push("e");
			m_vectorbase.push("ei");
			m_vectorbase.push("en");
			m_vectorbase.push("er");
			m_vectorbase.push("fa");
			m_vectorbase.push("fan");
			m_vectorbase.push("fang");
			m_vectorbase.push("fei");
			m_vectorbase.push("fen");
			m_vectorbase.push("feng");
			m_vectorbase.push("fo");
			m_vectorbase.push("fou");
			m_vectorbase.push("fu");
			m_vectorbase.push("ga");
			m_vectorbase.push("gai");
			m_vectorbase.push("gan");
			m_vectorbase.push("gang");
			m_vectorbase.push("gao");
			m_vectorbase.push("ge");
			m_vectorbase.push("gei");
			m_vectorbase.push("gen");
			m_vectorbase.push("geng");
			m_vectorbase.push("gong");
			m_vectorbase.push("gou");
			m_vectorbase.push("gu");
			m_vectorbase.push("gua");
			m_vectorbase.push("guai");
			m_vectorbase.push("guan");
			m_vectorbase.push("guang");
			m_vectorbase.push("gui");
			m_vectorbase.push("gun");
			m_vectorbase.push("guo");
			m_vectorbase.push("ha");
			m_vectorbase.push("hai");
			m_vectorbase.push("han");
			m_vectorbase.push("hang");
			m_vectorbase.push("hao");
			m_vectorbase.push("he");
			m_vectorbase.push("hei");
			m_vectorbase.push("hen");
			m_vectorbase.push("heng");
			m_vectorbase.push("hong");
			m_vectorbase.push("hou");
			m_vectorbase.push("hu");
			m_vectorbase.push("hua");
			m_vectorbase.push("huai");
			m_vectorbase.push("huan");
			m_vectorbase.push("huang");
			m_vectorbase.push("hui");
			m_vectorbase.push("hun");
			m_vectorbase.push("huo");
			m_vectorbase.push("ji");
			m_vectorbase.push("jia");
			m_vectorbase.push("jian");
			m_vectorbase.push("jiang");
			m_vectorbase.push("jiao");
			m_vectorbase.push("jie");
			m_vectorbase.push("jin");
			m_vectorbase.push("jing");
			m_vectorbase.push("jiong");
			m_vectorbase.push("jiu");
			m_vectorbase.push("ju");
			m_vectorbase.push("juan");
			m_vectorbase.push("jue");
			m_vectorbase.push("jun");
			m_vectorbase.push("ka");
			m_vectorbase.push("kai");
			m_vectorbase.push("kan");
			m_vectorbase.push("kang");
			m_vectorbase.push("kao");
			m_vectorbase.push("ke");
			m_vectorbase.push("ken");
			m_vectorbase.push("keng");
			m_vectorbase.push("kong");
			m_vectorbase.push("kou");
			m_vectorbase.push("ku");
			m_vectorbase.push("kua");
			m_vectorbase.push("kuai");
			m_vectorbase.push("kuan");
			m_vectorbase.push("kuang");
			m_vectorbase.push("kui");
			m_vectorbase.push("kun");
			m_vectorbase.push("kuo");
			m_vectorbase.push("la");
			m_vectorbase.push("lai");
			m_vectorbase.push("lan");
			m_vectorbase.push("lang");
			m_vectorbase.push("lao");
			m_vectorbase.push("le");
			m_vectorbase.push("lei");
			m_vectorbase.push("leng");
			m_vectorbase.push("li");
			m_vectorbase.push("lia");
			m_vectorbase.push("lian");
			m_vectorbase.push("liang");
			m_vectorbase.push("liao");
			m_vectorbase.push("lie");
			m_vectorbase.push("lin");
			m_vectorbase.push("ling");
			m_vectorbase.push("liu");
			m_vectorbase.push("lo");
			m_vectorbase.push("long");
			m_vectorbase.push("lou");
			m_vectorbase.push("lu");
			m_vectorbase.push("luan");
			m_vectorbase.push("lue");
			m_vectorbase.push("lun");
			m_vectorbase.push("luo");
			m_vectorbase.push("lv");
			m_vectorbase.push("m");
			m_vectorbase.push("ma");
			m_vectorbase.push("mai");
			m_vectorbase.push("man");
			m_vectorbase.push("mang");
			m_vectorbase.push("mao");
			m_vectorbase.push("me");
			m_vectorbase.push("mei");
			m_vectorbase.push("men");
			m_vectorbase.push("meng");
			m_vectorbase.push("mi");
			m_vectorbase.push("mian");
			m_vectorbase.push("miao");
			m_vectorbase.push("mie");
			m_vectorbase.push("min");
			m_vectorbase.push("ming");
			m_vectorbase.push("miu");
			m_vectorbase.push("mo");
			m_vectorbase.push("mou");
			m_vectorbase.push("mu");
			m_vectorbase.push("na");
			m_vectorbase.push("nai");
			m_vectorbase.push("nan");
			m_vectorbase.push("nang");
			m_vectorbase.push("nao");
			m_vectorbase.push("ne");
			m_vectorbase.push("nei");
			m_vectorbase.push("nen");
			m_vectorbase.push("neng");
			m_vectorbase.push("ni");
			m_vectorbase.push("nian");
			m_vectorbase.push("niang");
			m_vectorbase.push("niao");
			m_vectorbase.push("nie");
			m_vectorbase.push("nin");
			m_vectorbase.push("ning");
			m_vectorbase.push("niu");
			m_vectorbase.push("nong");
			m_vectorbase.push("nou");
			m_vectorbase.push("nu");
			m_vectorbase.push("nuan");
			m_vectorbase.push("nue");
			m_vectorbase.push("nuo");
			m_vectorbase.push("nv");
			m_vectorbase.push("o");
			m_vectorbase.push("ou");
			m_vectorbase.push("pa");
			m_vectorbase.push("pai");
			m_vectorbase.push("pan");
			m_vectorbase.push("pang");
			m_vectorbase.push("pao");
			m_vectorbase.push("pe");
			m_vectorbase.push("pei");
			m_vectorbase.push("pen");
			m_vectorbase.push("peng");
			m_vectorbase.push("pi");
			m_vectorbase.push("pian");
			m_vectorbase.push("piao");
			m_vectorbase.push("pie");
			m_vectorbase.push("pin");
			m_vectorbase.push("ping");
			m_vectorbase.push("po");
			m_vectorbase.push("pou");
			m_vectorbase.push("pu");
			m_vectorbase.push("puo");
			m_vectorbase.push("qi");
			m_vectorbase.push("qia");
			m_vectorbase.push("qian");
			m_vectorbase.push("qiang");
			m_vectorbase.push("qiao");
			m_vectorbase.push("qie");
			m_vectorbase.push("qin");
			m_vectorbase.push("qing");
			m_vectorbase.push("qiong");
			m_vectorbase.push("qiu");
			m_vectorbase.push("qu");
			m_vectorbase.push("quan");
			m_vectorbase.push("que");
			m_vectorbase.push("qun");
			m_vectorbase.push("ran");
			m_vectorbase.push("rang");
			m_vectorbase.push("rao");
			m_vectorbase.push("re");
			m_vectorbase.push("ren");
			m_vectorbase.push("reng");
			m_vectorbase.push("ri");
			m_vectorbase.push("rong");
			m_vectorbase.push("rou");
			m_vectorbase.push("ru");
			m_vectorbase.push("ruan");
			m_vectorbase.push("rui");
			m_vectorbase.push("run");
			m_vectorbase.push("ruo");
			m_vectorbase.push("sa");
			m_vectorbase.push("sai");
			m_vectorbase.push("san");
			m_vectorbase.push("sang");
			m_vectorbase.push("sao");
			m_vectorbase.push("se");  
			m_vectorbase.push("sen");
			m_vectorbase.push("seng");
			m_vectorbase.push("sh");
			m_vectorbase.push("sha");
			m_vectorbase.push("shai");
			m_vectorbase.push("shan");
			m_vectorbase.push("shang");
			m_vectorbase.push("shao");
			m_vectorbase.push("she");
			m_vectorbase.push("shen");
			m_vectorbase.push("sheng");
			m_vectorbase.push("shi");
			m_vectorbase.push("shou");
			m_vectorbase.push("shu");
			m_vectorbase.push("shua");
			m_vectorbase.push("shuai");
			m_vectorbase.push("shuan");
			m_vectorbase.push("shuang");
			m_vectorbase.push("shui");
			m_vectorbase.push("shun");
			m_vectorbase.push("shuo");
			m_vectorbase.push("si");
			m_vectorbase.push("song");
			m_vectorbase.push("sou");
			m_vectorbase.push("su");
			m_vectorbase.push("suan");
			m_vectorbase.push("sui");
			m_vectorbase.push("sun");
			m_vectorbase.push("suo");
			m_vectorbase.push("ta");
			m_vectorbase.push("tai");
			m_vectorbase.push("tan");
			m_vectorbase.push("tang");
			m_vectorbase.push("tao");
			m_vectorbase.push("te");
			m_vectorbase.push("teng");
			m_vectorbase.push("ti");
			m_vectorbase.push("tian");
			m_vectorbase.push("tiao");
			m_vectorbase.push("tie");
			m_vectorbase.push("ting");
			m_vectorbase.push("tong");
			m_vectorbase.push("tou");
			m_vectorbase.push("tu");
			m_vectorbase.push("tuan");
			m_vectorbase.push("tui");
			m_vectorbase.push("tun");
			m_vectorbase.push("tuo");
			m_vectorbase.push("wa");
			m_vectorbase.push("wai");
			m_vectorbase.push("wan");
			m_vectorbase.push("wang");
			m_vectorbase.push("wei");
			m_vectorbase.push("wen");
			m_vectorbase.push("weng");
			m_vectorbase.push("wo");
			m_vectorbase.push("wu");
			m_vectorbase.push("xi");
			m_vectorbase.push("xia");
			m_vectorbase.push("xian");
			m_vectorbase.push("xiang");
			m_vectorbase.push("xiao");
			m_vectorbase.push("xie");
			m_vectorbase.push("xin");
			m_vectorbase.push("xing");
			m_vectorbase.push("xiong");
			m_vectorbase.push("xiu");
			m_vectorbase.push("xu");
			m_vectorbase.push("xuan");
			m_vectorbase.push("xue");
			m_vectorbase.push("xun");
			m_vectorbase.push("ya");
			m_vectorbase.push("yan");
			m_vectorbase.push("yang");
			m_vectorbase.push("yao");
			m_vectorbase.push("ye");
			m_vectorbase.push("yi");
			m_vectorbase.push("yin");
			m_vectorbase.push("ying");
			m_vectorbase.push("yo");
			m_vectorbase.push("yong");
			m_vectorbase.push("you");
			m_vectorbase.push("yu");
			m_vectorbase.push("yuan");
			m_vectorbase.push("yue");
			m_vectorbase.push("yun");
			m_vectorbase.push("za");
			m_vectorbase.push("zai");
			m_vectorbase.push("zan");
			m_vectorbase.push("zang");
			m_vectorbase.push("zao");
			m_vectorbase.push("ze");
			m_vectorbase.push("zei");
			m_vectorbase.push("zen");
			m_vectorbase.push("zeng");
			m_vectorbase.push("zha");
			m_vectorbase.push("zhai");
			m_vectorbase.push("zhan");
			m_vectorbase.push("zhang");
			m_vectorbase.push("zhao");
			m_vectorbase.push("zhe");
			m_vectorbase.push("zhen");
			m_vectorbase.push("zheng");
			m_vectorbase.push("zhi");
			m_vectorbase.push("zhong");
			m_vectorbase.push("zhou");
			m_vectorbase.push("zhu");
			m_vectorbase.push("zhua");
			m_vectorbase.push("zhuai");
			m_vectorbase.push("zhuan");
			m_vectorbase.push("zhuang");
			m_vectorbase.push("zhui");
			m_vectorbase.push("zhun");
			m_vectorbase.push("zhuo");
			m_vectorbase.push("zi");
			m_vectorbase.push("zong");
			m_vectorbase.push("zou");
			m_vectorbase.push("zu");
			m_vectorbase.push("zuan");
			m_vectorbase.push("zui");
			m_vectorbase.push("zun");
			m_vectorbase.push("zuo");
		}
		
		public  function PinYinVector()
		{
m_vector.push("a");
m_vector.push("ai");
m_vector.push("an");
m_vector.push("ang");
m_vector.push("ao");
m_vector.push("ba");
m_vector.push("bai");
m_vector.push("ban");
m_vector.push("bang");
m_vector.push("bao");
m_vector.push("be");//
m_vector.push("bei");
m_vector.push("ben");
m_vector.push("beng");
m_vector.push("bi");
m_vector.push("bia");//
m_vector.push("bian");
m_vector.push("biao");
m_vector.push("bie");
m_vector.push("bin");
m_vector.push("bing");
m_vector.push("bo");
m_vector.push("bu");
m_vector.push("ca");
m_vector.push("cai");
m_vector.push("can");
m_vector.push("cang");
m_vector.push("cao");
m_vector.push("ce");
m_vector.push("cen");
m_vector.push("ceng");
m_vector.push("ch");//
m_vector.push("cha");
m_vector.push("chai");
m_vector.push("chan");
m_vector.push("chang");
m_vector.push("chao");
m_vector.push("che");
m_vector.push("chen");
m_vector.push("cheng");
m_vector.push("chi");
m_vector.push("cho");//
m_vector.push("chon");//
m_vector.push("chong");
m_vector.push("chou");
m_vector.push("chu");
m_vector.push("chua");//
m_vector.push("chuai");
m_vector.push("chuan");
m_vector.push("chuang");
m_vector.push("chui");
m_vector.push("chun");
m_vector.push("chuo");
m_vector.push("ci");
m_vector.push("co");
m_vector.push("con");//
m_vector.push("cong");
m_vector.push("cou");
m_vector.push("cu");
m_vector.push("cua");//
m_vector.push("cuan");
m_vector.push("cui");
m_vector.push("cun");
m_vector.push("cuo");
m_vector.push("da");
m_vector.push("dai");
m_vector.push("dan");
m_vector.push("dang");
m_vector.push("dao");
m_vector.push("de");
m_vector.push("den");//
m_vector.push("deng");
m_vector.push("di");
m_vector.push("dia");
m_vector.push("dian");
m_vector.push("diao");
m_vector.push("die");
m_vector.push("din");//
m_vector.push("ding");
m_vector.push("diu");
m_vector.push("do");//
m_vector.push("don");//
m_vector.push("dong");
m_vector.push("dou");
m_vector.push("du");
m_vector.push("dua");//
m_vector.push("duan");
m_vector.push("dui");
m_vector.push("dun");
m_vector.push("duo");
m_vector.push("e");
m_vector.push("ei");
m_vector.push("en");
m_vector.push("er");
m_vector.push("fa");
m_vector.push("fan");
m_vector.push("fang");
m_vector.push("fe");//
m_vector.push("fei");
m_vector.push("fen");
m_vector.push("feng");
m_vector.push("fo");
m_vector.push("fou");
m_vector.push("fu");
m_vector.push("ga");
m_vector.push("gai");
m_vector.push("gan");
m_vector.push("gang");
m_vector.push("gao");
m_vector.push("ge");
m_vector.push("gei");
m_vector.push("gen");
m_vector.push("geng");
m_vector.push("go");//
m_vector.push("gon");//
m_vector.push("gong");
m_vector.push("gou");
m_vector.push("gu");
m_vector.push("gua");
m_vector.push("guai");
m_vector.push("guan");
m_vector.push("guang");
m_vector.push("gui");
m_vector.push("gun");
m_vector.push("guo");
m_vector.push("ha");
m_vector.push("hai");
m_vector.push("han");
m_vector.push("hang");
m_vector.push("hao");
m_vector.push("he");
m_vector.push("hei");
m_vector.push("hen");
m_vector.push("heng");
m_vector.push("ho");//
m_vector.push("hon");//
m_vector.push("hong");
m_vector.push("hou");
m_vector.push("hu");
m_vector.push("hua");
m_vector.push("huai");
m_vector.push("huan");
m_vector.push("huang");
m_vector.push("hui");
m_vector.push("hun");
m_vector.push("huo");
m_vector.push("ji");
m_vector.push("jia");
m_vector.push("jian");
m_vector.push("jiang");
m_vector.push("jiao");
m_vector.push("jie");
m_vector.push("jin");
m_vector.push("jing");
m_vector.push("jio");//
m_vector.push("jion");//
m_vector.push("jiong");
m_vector.push("jiu");
m_vector.push("ju");
m_vector.push("jua");//
m_vector.push("juan");
m_vector.push("jue");
m_vector.push("jun");
m_vector.push("ka");
m_vector.push("kai");
m_vector.push("kan");
m_vector.push("kang");
m_vector.push("kao");
m_vector.push("ke");
m_vector.push("ken");
m_vector.push("keng");
m_vector.push("ko");//
m_vector.push("kon");//
m_vector.push("kong");
m_vector.push("kou");
m_vector.push("ku");
m_vector.push("kua");
m_vector.push("kuai");
m_vector.push("kuan");
m_vector.push("kuang");
m_vector.push("kui");
m_vector.push("kun");
m_vector.push("kuo");
m_vector.push("la");
m_vector.push("lai");
m_vector.push("lan");
m_vector.push("lang");
m_vector.push("lao");
m_vector.push("le");
m_vector.push("lei");
m_vector.push("len");//
m_vector.push("leng");
m_vector.push("li");
m_vector.push("lia");
m_vector.push("lian");
m_vector.push("liang");
m_vector.push("liao");
m_vector.push("lie");
m_vector.push("lin");
m_vector.push("ling");
m_vector.push("liu");
m_vector.push("lo");
m_vector.push("lon");//
m_vector.push("long");
m_vector.push("lou");
m_vector.push("lu");
m_vector.push("lua");//
m_vector.push("luan");
m_vector.push("lue");
m_vector.push("lun");
m_vector.push("luo");
m_vector.push("lv");
m_vector.push("m");
m_vector.push("ma");
m_vector.push("mai");
m_vector.push("man");
m_vector.push("mang");
m_vector.push("mao");
m_vector.push("me");
m_vector.push("mei");
m_vector.push("men");
m_vector.push("meng");
m_vector.push("mi");
m_vector.push("mia");//
m_vector.push("mian");
m_vector.push("miao");
m_vector.push("mie");
m_vector.push("min");
m_vector.push("ming");
m_vector.push("miu");
m_vector.push("mo");
m_vector.push("mou");
m_vector.push("mu");
m_vector.push("na");
m_vector.push("nai");
m_vector.push("nan");
m_vector.push("nang");
m_vector.push("nao");
m_vector.push("ne");
m_vector.push("nei");
m_vector.push("nen");
m_vector.push("neng");
m_vector.push("ni");
m_vector.push("nia");//
m_vector.push("nian");
m_vector.push("niang");
m_vector.push("niao");
m_vector.push("nie");
m_vector.push("nin");
m_vector.push("ning");
m_vector.push("niu");
m_vector.push("no");//
m_vector.push("non");//
m_vector.push("nong");
m_vector.push("nou");
m_vector.push("nu");
m_vector.push("nua");//
m_vector.push("nuan");
m_vector.push("nue");
m_vector.push("nuo");
m_vector.push("nv");
m_vector.push("o");
m_vector.push("ou");
m_vector.push("pa");
m_vector.push("pai");
m_vector.push("pan");
m_vector.push("pang");
m_vector.push("pao");
m_vector.push("pe");
m_vector.push("pei");
m_vector.push("pen");
m_vector.push("peng");
m_vector.push("pi");
m_vector.push("pia");//
m_vector.push("pian");
m_vector.push("piao");
m_vector.push("pie");
m_vector.push("pin");
m_vector.push("ping");
m_vector.push("po");
m_vector.push("pou");
m_vector.push("pu");
m_vector.push("puo");
m_vector.push("qi");
m_vector.push("qia");
m_vector.push("qian");
m_vector.push("qiang");
m_vector.push("qiao");
m_vector.push("qie");
m_vector.push("qin");
m_vector.push("qing");
m_vector.push("qio");//
m_vector.push("qion");//
m_vector.push("qiong");
m_vector.push("qiu");
m_vector.push("qu");
m_vector.push("qua");//
m_vector.push("quan");
m_vector.push("que");
m_vector.push("qun");
m_vector.push("ra");//
m_vector.push("ran");
m_vector.push("rang");
m_vector.push("rao");
m_vector.push("re");
m_vector.push("ren");
m_vector.push("reng");
m_vector.push("ri");
m_vector.push("ro");//
m_vector.push("ron");//
m_vector.push("rong");
m_vector.push("rou");
m_vector.push("ru");
m_vector.push("rua");//
m_vector.push("ruan");
m_vector.push("rui");
m_vector.push("run");
m_vector.push("ruo");
m_vector.push("sa");
m_vector.push("sai");
m_vector.push("san");
m_vector.push("sang");
m_vector.push("sao");
m_vector.push("se");  
m_vector.push("sen");
m_vector.push("seng");
m_vector.push("sh");
m_vector.push("sha");
m_vector.push("shai");
m_vector.push("shan");
m_vector.push("shang");
m_vector.push("shao");
m_vector.push("she");
m_vector.push("shen");
m_vector.push("sheng");
m_vector.push("shi");
m_vector.push("sho");//
m_vector.push("shou");
m_vector.push("shu");
m_vector.push("shua");
m_vector.push("shuai");
m_vector.push("shuan");
m_vector.push("shuang");
m_vector.push("shui");
m_vector.push("shun");
m_vector.push("shuo");
m_vector.push("si");
m_vector.push("so");//
m_vector.push("son");//
m_vector.push("song");
m_vector.push("sou");
m_vector.push("su");
m_vector.push("sua");//
m_vector.push("suan");
m_vector.push("sui");
m_vector.push("sun");
m_vector.push("suo");
m_vector.push("ta");
m_vector.push("tai");
m_vector.push("tan");
m_vector.push("tang");
m_vector.push("tao");
m_vector.push("te");
m_vector.push("ten");//
m_vector.push("teng");
m_vector.push("ti");
m_vector.push("tia");//
m_vector.push("tian");
m_vector.push("tiao");
m_vector.push("tie");
m_vector.push("tin");//
m_vector.push("ting");
m_vector.push("to");//
m_vector.push("ton");//
m_vector.push("tong");
m_vector.push("tou");
m_vector.push("tu");
m_vector.push("tua");//
m_vector.push("tuan");
m_vector.push("tui");
m_vector.push("tun");
m_vector.push("tuo");
m_vector.push("wa");
m_vector.push("wai");
m_vector.push("wan");
m_vector.push("wang");
m_vector.push("we");//
m_vector.push("wei");
m_vector.push("wen");
m_vector.push("weng");
m_vector.push("wo");
m_vector.push("wu");
m_vector.push("xi");
m_vector.push("xia");
m_vector.push("xian");
m_vector.push("xiang");
m_vector.push("xiao");
m_vector.push("xie");
m_vector.push("xin");
m_vector.push("xing");
m_vector.push("xio");//
m_vector.push("xion");//
m_vector.push("xiong");
m_vector.push("xiu");
m_vector.push("xu");
m_vector.push("xua");//
m_vector.push("xuan");
m_vector.push("xue");
m_vector.push("xun");
m_vector.push("ya");
m_vector.push("yan");
m_vector.push("yang");
m_vector.push("yao");
m_vector.push("ye");
m_vector.push("yi");
m_vector.push("yin");
m_vector.push("ying");
m_vector.push("yo");
m_vector.push("yon");//
m_vector.push("yong");
m_vector.push("you");
m_vector.push("yu");
m_vector.push("yua");//
m_vector.push("yuan");
m_vector.push("yue");
m_vector.push("yun");
m_vector.push("za");
m_vector.push("zai");
m_vector.push("zan");
m_vector.push("zang");
m_vector.push("zao");
m_vector.push("ze");
m_vector.push("zei");
m_vector.push("zen");
m_vector.push("zeng");
m_vector.push("zh");//
m_vector.push("zha");
m_vector.push("zhai");
m_vector.push("zhan");
m_vector.push("zhang");
m_vector.push("zhao");
m_vector.push("zhe");
m_vector.push("zhen");
m_vector.push("zheng");
m_vector.push("zhi");
m_vector.push("zho");//
m_vector.push("zhon");//
m_vector.push("zhong");
m_vector.push("zhou");
m_vector.push("zhu");
m_vector.push("zhua");
m_vector.push("zhuai");
m_vector.push("zhuan");
m_vector.push("zhuang");
m_vector.push("zhui");
m_vector.push("zhun");
m_vector.push("zhuo");
m_vector.push("zi");
m_vector.push("zo");//
m_vector.push("zon");//
m_vector.push("zong");
m_vector.push("zou");
m_vector.push("zu");
m_vector.push("zua");//
m_vector.push("zuan");
m_vector.push("zui");
m_vector.push("zun");
m_vector.push("zuo");
PinYinVectorBase();
		}
	}
}