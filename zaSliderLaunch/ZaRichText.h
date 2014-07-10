/*
 * ZaRichText.h
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#ifndef ZARICHTEXT_H_
#define ZARICHTEXT_H_
#include "ZaObj.h"
#include "ZAImage.h"
#include "ZAButton.h"
#include "ZaResLib.h"
#include "ZaTweener.h"
#include "zaFileText.h"
#include "clipboard/clipboard.h"
#include <vector>

namespace bbcubezone {

class ZaRichText:public ZaObj{

typedef struct
{
		unsigned int charcode;
		int pos;
		int x ;
		int y;
		int w;
		int h;
		char * img_path;
		int action;
} str_char;

public:
	ZaRichText();
	void drawControl();
	ZAImage m_image;
	ZaButton m_select_a;
	ZaButton m_select_b;
	ZAImage m_link;
	ZAImage m_a;
	ZAImage m_b;
	ZAImage m_bg;
	zaFont *m_font;
	char m_filename[255];
	zaFileText m_txt;
	bool m_opened;
	bool m_changing;
	bool m_drawImg;
	int m_layout_org;
	void init();
	void getSelectText(string & txt);
	void closefile();
	void openfile(const char *p);
	void changefile(const char *p);
	void processEvent(ZaEvent * env);
	void settext(char *c);
	int nextpage();
	int prepage();
	void changefont(int size);
	void setpos(float percent);
	void getpos(float & percent);
	void changetheme(int index);
	void tweener(int id, float value);

	int m_theme;

	virtual ~ZaRichText();
private:
	void layout(int dirct);
	void layouttxt(int dirct);
	void layouthtml(int dirct);
	void onLoading();
	std::vector<str_char *> m_v;
	std::vector<str_char *> m_v_copy;

};

} /* namespace bbcubezone */
#endif /* ZARICHTEXT_H_ */
