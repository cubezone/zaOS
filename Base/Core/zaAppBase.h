/*
 * zaAppBase.h
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */


#ifndef zaAppBase_H_
#define zaAppBase_H_

#include "ZaGL.h"
#include "ZaScreenBase.h"
//#include "ZaScreen.h"
//#include "ZaScreenFlash.h"
//#include "ZaScreenMain.h"
//#include "ZaScreenDir.h"
//#include "ZaScreenRead.h"
//#include "ZaScreenCatalog.h"
//#include "ZaScreenHis.h"
#include "ZaResLib.h"
#include "ZaAppRes.h"

#include "fontconfig/fontconfig.h"

namespace bbcubezone {

class zaAppBase:public ZaObj {
public:
	zaAppBase();

//	static zaAppBase *m_app;
//	static zaAppBase *getInstance()
//	{
//		if (m_app==NULL)
//			m_app = new zaAppBase();
//		return m_app;
//	}
	void onInactive();

	void tweener(int id, float value);
	ZaScreenBase * getScreen(string screen_name);
	void addScreen(string scrname,ZaScreenBase * screen);

	std::map<std::string,ZaScreenBase *> m_v;

	zaGL *m_GL;
	ZaScreenBase *m_active;
	ZaEvent e;

	string m_startscreen;
	bool m_multitouch;

	int m_width;
	int m_height;
	int init();
	int curl(char * url,char * filename);
	void run();
	void dispatchevent(bps_event_t *event );
	inline void getActive();
	virtual ~zaAppBase();
};

} /* namespace bbcubezone */
#endif /* zaAppBase_H_ */
