package com.zhuxy.za_bill;

import java.util.Calendar;
import java.util.Date;

import net.rim.device.api.i18n.SimpleDateFormat;
import net.rim.device.api.system.Display;
import net.rim.device.api.system.GPRSInfo;
import net.rim.device.api.ui.Field;
import net.rim.device.api.ui.FieldChangeListener;
import net.rim.device.api.ui.Font;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.container.HorizontalFieldManager;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.ui.component.*;

public final class za_billitemscreen extends MainScreen {
	boolean m_fromto = true;
	boolean m_everyday = false;

	ObjectChoiceField lf_billperiod; // 一次,周期
	EditField ef_fee;
	DateField df_delltime ; 
	DateField df_endtime;
	EditField ef_from;
	EditField ef_to;
	NullField nf_tag;
	EditField ef_pos;
	EditField ef_desc;
	NullField nf_tag2;
	EditField ef_remark1;
	RichTextField ef_remark2;
	EditField ef_billtype;
	String m_iconname;
	String period_choices[] = { "一次", "每天" };
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	za_bill m_bill  ;

	public za_billitemscreen( za_bill i_bill) {
		m_bill = i_bill;		
		lf_billperiod = new ObjectChoiceField("周期类型:", period_choices, 0) {
			protected void fieldChangeNotify(int context) {
				if (m_everyday == true) {
					delete(df_endtime);
					m_everyday = false;
				}
				if (getSelectedIndex() == 1)// 按天
				{
					insert(df_endtime, nf_tag2.getIndex());
					m_everyday = true;
				}
			}
		};
		m_iconname  = i_bill.icon_name;
		df_delltime = new DateField("开销时间:", System.currentTimeMillis(),
				DateField.DATE_TIME);
		df_endtime = new DateField("结束时间:", System.currentTimeMillis(),
				DateField.DATE_TIME);
		ef_billtype = new EditField("费用类型:", null, 40,
				EditField.FILTER_DEFAULT);
		ef_fee = new EditField("金额:", String.valueOf(i_bill.fee), 20,
				EditField.FILTER_REAL_NUMERIC);
		ef_fee.setFont(Font.getDefault().derive(Font.PLAIN, 12, Ui.UNITS_pt));
		ef_from = new EditField("始发地:", 
			        "LAC:"+ Integer.toString( GPRSInfo.getCellInfo().getLAC())+" "+
			        "CELLID:"+ Integer.toString( GPRSInfo.getCellInfo().getCellId())
			        , 50, EditField.FILTER_DEFAULT 
				| EditField.FIELD_TRAILING);
		ef_to = new EditField("目的地:", null, 50,
				EditField.FILTER_DEFAULT);
		ef_pos = new EditField("位置:", 
			   "LAC:"+ Integer.toString( GPRSInfo.getCellInfo().getLAC())+" "+
		        "CELLID:"+ Integer.toString( GPRSInfo.getCellInfo().getCellId()),
		        50,
				EditField.FILTER_DEFAULT);		
		ef_desc = new EditField("描述:", i_bill.desc, Integer.MAX_VALUE,
				EditField.FILTER_DEFAULT);
		ef_remark1 = new EditField("备注1:", null, Integer.MAX_VALUE,
				EditField.FILTER_DEFAULT);
		ef_remark2 = new RichTextField(""); 	

		add(ef_fee);
		ef_billtype.setText(i_bill.bill_type);
		add(ef_billtype);
		ef_desc.setText(i_bill.desc);
		add(ef_desc); 
		add(new SeparatorField());
	
		
		add(ef_from);
		add(ef_to);
		add(ef_pos);
		nf_tag = new NullField();	
		add(nf_tag);
		
		add(new SeparatorField());

		add(df_delltime);
		nf_tag2 = new NullField();		
		add(nf_tag2);
		
		insert(lf_billperiod,df_delltime.getIndex());
		
		add(new SeparatorField());
		add(ef_remark1);
		add(new LabelField("备注2:"));
		add(ef_remark2);
	}
	
	public za_billitemscreen( za_billitem i_bill) {
		m_bill = new za_bill();
		lf_billperiod = new ObjectChoiceField("周期类型:", period_choices, 0) {
			protected void fieldChangeNotify(int context) {
				if (m_everyday == true) {
					delete(df_endtime);
					m_everyday = false;
				}
				if (getSelectedIndex() == 1)// 按天
				{
					insert(df_endtime, nf_tag2.getIndex());
					m_everyday = true;
				}
			}
		};
		m_iconname = i_bill.iconname;
		df_delltime = new DateField("开销时间:", System.currentTimeMillis(),
				DateField.DATE_TIME);
		df_endtime = new DateField("结束时间:", System.currentTimeMillis(),
				DateField.DATE_TIME);
		ef_billtype = new EditField("费用类型:", null, 40,
				EditField.FILTER_DEFAULT);
		ef_fee = new EditField("金额:", "0", 20,
				EditField.FILTER_REAL_NUMERIC);
		ef_fee.setFont(Font.getDefault().derive(Font.PLAIN, 12, Ui.UNITS_pt));
		
		ef_from = new EditField("始发地:", 
			        "LAC:"+ Integer.toString( GPRSInfo.getCellInfo().getLAC())+" "+
			        "CELLID:"+ Integer.toString( GPRSInfo.getCellInfo().getCellId())
			        , 50, EditField.FILTER_DEFAULT 
				| EditField.FIELD_TRAILING);
		ef_to = new EditField("目的地:", null, 50,
				EditField.FILTER_DEFAULT);
		
		ef_pos = new EditField("位置:", 
				"LAC:"+ Integer.toString( GPRSInfo.getCellInfo().getLAC())+" "+
		        "CELLID:"+ Integer.toString( GPRSInfo.getCellInfo().getCellId()),
		        50,
				EditField.FILTER_DEFAULT);		
		ef_desc = new EditField("描述:", null, Integer.MAX_VALUE,
				EditField.FILTER_DEFAULT);
		ef_remark1 = new EditField("备注1:", null, Integer.MAX_VALUE,
				EditField.FILTER_DEFAULT);
		ef_remark2 = new RichTextField(""); 	

		
		add(ef_fee);
		
		ef_billtype.setText(i_bill.billitem);		
		add(ef_billtype);		
		add(ef_desc); 
		add(new SeparatorField());	
		
		add(ef_from);
		add(ef_to);
		add(ef_pos);
		nf_tag = new NullField();	
		add(nf_tag);
		
		add(new SeparatorField());

		add(df_delltime);
		nf_tag2 = new NullField();		
		add(nf_tag2);
		
		insert(lf_billperiod,df_delltime.getIndex());
		
		add(new SeparatorField());
		add(ef_remark1);
		add(new LabelField("备注2:"));
		add(ef_remark2);
	}
	
	public boolean onSavePrompt() {
		boolean l_ret = super.onSavePrompt();
		if (l_ret == true) {
			
			m_bill.fee = Integer.parseInt(ef_fee.getText());
			m_bill.desc= ef_desc.getText();

			SimpleDateFormat l_sdf = new SimpleDateFormat("yyyyMM");
			m_bill.bill_cycle = l_sdf.format(Calendar.getInstance().getTime());
			m_bill.icon_name = m_iconname;
			m_bill.bill_type = ef_billtype.getText();
			m_bill.LAC = ef_from.getText();
			m_bill.CELL = ef_to.getText();
			m_bill.location = ef_pos.getText();

			// period_choices[lf_billperiod.getSelectedIndex()];
			Date l_dt = new Date();
			l_dt.setTime(df_delltime.getDate());
			m_bill.bill_time = sdf.format(l_dt);
			
			l_dt.setTime(df_endtime.getDate());			

			m_bill.desc =ef_desc.getText();		
			
			try {
				za_db m_db = za_db.getInstanct();
				m_db.open();

				m_db.insert(m_bill);
				m_db.close();
			} catch (Exception e) {
				za_db.errorDialog(e.toString());
			}
		}
		return l_ret;
	}

	public void close() {
		super.close();
	}

	class JustifiedEditField extends HorizontalFieldManager implements
			FieldChangeListener {

		LabelField lf; 
		EditField ef;
		int dw = Display.getWidth();
		int rightMargin = 0;

		public JustifiedEditField(String label, String value, int maxChars,
				long style) {
			super(USE_ALL_WIDTH);
			ef = new EditField(null, value, maxChars, style) {
				protected void onDisplay() {
					update(0);
				}

				protected void update(int d) {
					super.update(d);
					int efw = getFont().getAdvance(super.getText());
					setPosition(dw - efw - rightMargin, 0);
				}
			};
			ef.setChangeListener(this);
			lf = new LabelField(label);
			add(lf);
			add(ef);
		}

		public String getText() {
			return ef.getText();
		}

	/*	public void setRightMargin(int m) {
			rightMargin = m;
		}

		public int getRightMargin() {
			return rightMargin;
		}
	*/
		public void fieldChanged(Field field, int context) {
			invalidate();
		} 

	}	
	protected void makeMenu(Menu menu, int instance) {
		super.makeMenu(menu, instance);
		
		menu.add(new MenuItem("option", 100, 10) {
			public void run() {
				za_billitemoption l_add = new za_billitemoption(null);
				UiApplication.getUiApplication().pushScreen(l_add);
			}
		});
	}
}