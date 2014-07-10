

import java.util.Date;
import java.util.Vector;

import net.rim.device.api.i18n.SimpleDateFormat;

final public class za_billing {

	public Vector m_cdrs = new Vector();
	za_cdr l_cdr;

	public class za_cdr {
		String m_billingmonth;
		String m_phonenumber;
		String m_calltype;
		String m_callstatus;
		Date m_calldate;
		int m_duration;
		int m_fee;

		int m_n = 0;
		int m_out_time = 0;
		int m_in_time = 0;
		int m_kf_time = 0;
		int m_out_n = 0;
		int m_in_n = 0;
		int m_kf_n = 0;
		int m_allfee = 0;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

		String getFormatCalldate() {
			return sdf.format(m_calldate);
		}

		String getFormatDuration() {
			String l_dur;
			l_dur = String.valueOf(m_duration / 60) + "'";
			if (m_duration % 60 < 10)
				l_dur += "0";
			l_dur += String.valueOf(m_duration % 60);
			return l_dur;
		}

		String getFormatFee() {
			StringBuffer ls_ret = new StringBuffer(200);
			ls_ret.append(m_fee / 100).append(".");
			if (m_fee % 100 < 10)
				ls_ret.append("0");
			ls_ret.append(m_fee % 100);
			return ls_ret.toString();
		}

		String getFormatAllFee() {
			StringBuffer ls_ret = new StringBuffer(200);
			ls_ret.append(m_allfee / 100).append(".");
			if (m_allfee % 100 < 10)
				ls_ret.append("0");
			ls_ret.append(m_allfee % 100);
			return ls_ret.toString();
		}

		boolean freenumber() {
			return m_phonenumber.equals("10010");
		}

		boolean outgoing() {
			return m_calltype.equals("1");
		}

		String toShowString() {
			return "总费用:" + getFormatFee() + "\r\n" + "主叫次数:"
					+ String.valueOf(m_out_n) + " " + "主叫分钟:"
					+ String.valueOf(m_out_time) + "\r\n" + "被叫次数:"
					+ String.valueOf(m_in_n) + " " + "被叫分钟数:"
					+ String.valueOf(m_in_time) + "\r\n" + "客服次数:"
					+ String.valueOf(m_kf_n) + " " + "客服分钟数:"
					+ String.valueOf(m_kf_time) + "";
		}

		String toSaveString() {
			String l_out = Integer.toString(m_n) + "\t" + "number:\t"
					+ m_phonenumber + "\t";
			if (m_calltype.equals("0"))
				l_out += "\ttype:\t" + "outgoing" + "\t";
			else
				l_out += "\ttype:\t" + "incoming" + "\t";
			l_out += "\tstatus:\t" + m_callstatus + "\t";
			l_out += "\tdate:\t" + getFormatCalldate() + "\t";
			l_out += "\tduration:\t" + Integer.toString(m_duration) + "\r\n";
			l_out += "\tbillcycle:\t"
					+ Integer.toString((m_duration + 59) / 60) + "\r\n";
			return l_out;
		}
	}

	int billing() {
		int num = m_cdrs.size();
		int kf_n = 0;
		int kf_time = 0;
		int in_n = 0;
		int in_time = 0;
		int out_n = 0;
		int out_time = 0;
		int fee = 0;
		int allfee = 0;

		for (int n = 0; n < num; n++) {
			l_cdr = (za_cdr) m_cdrs.elementAt(n);
			int l_dur = (l_cdr.m_duration + 59) / 60;

			if (l_cdr.freenumber()) {
				kf_n++;
				l_cdr.m_kf_n = kf_n;
				kf_time += l_dur;
				l_cdr.m_kf_time = kf_time;
				l_dur = 0;
			} else {
				if (l_cdr.outgoing()) {
					out_n++;
					l_cdr.m_out_n = out_n;
					out_time += l_dur;
					l_cdr.m_out_time = out_time;
				} else {
					in_n++;
					l_cdr.m_in_n = in_n;
					in_time += l_dur;
					l_cdr.m_in_time = in_time;
					l_dur = 0;
				}
			}
			l_cdr.m_fee = l_dur * 15;
			allfee += l_dur * 15;
			l_cdr.m_allfee = allfee;
		}
		return 0;
	}

	void insertCdr(String billingmonth, String phonenumber, String calltype,
			String callstatus, Date calldate, int duration) {
		l_cdr = new za_cdr();
		l_cdr.m_billingmonth = billingmonth;
		l_cdr.m_calldate = calldate;
		l_cdr.m_callstatus = callstatus;
		l_cdr.m_calltype = calltype;
		l_cdr.m_duration = duration;
		m_cdrs.insertElementAt(l_cdr, 0);
	}
}
