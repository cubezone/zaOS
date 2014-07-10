/*
 * zaApp.h
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */


#ifndef ZAAPP_H_
#define ZAAPP_H_

#include "ZaScreenBase.h"
#include "ZaScreen.h"
#include "ZaScreenFlash.h"
#include "ZaScreenMain.h"
#include "ZaScreenDir.h"
#include "ZaScreenRead.h"
#include "ZaScreenCatalog.h"
#include "ZaScreenHis.h"
#include "ZaScreenWindMill.h"
#include "ZaScreenDict.h"
#include "ZaScreenStart.h"
#include "ZaScreenDesktop.h"

#include "zaFileEpub.h"
#include <curl/curl.h>
#include <curl/easy.h>
#include "ZaDict.h"
//#include <sys/mman.h>


namespace bbcubezone {

class zaApp:public ZaObj {
public:
	zaApp();

	static zaApp *m_app;
	static zaApp *getInstance()
	{
		if (m_app==NULL)
			m_app = new zaApp();
		return m_app;
	}
	void onInactive();


	void tweener(int id, float value);
	ZaScreen * getScreen(string screen_name);
	void addScreen(string scrname,ZaScreen * screen);

	std::map<std::string,ZaScreen *> m_v;

	zaGL *m_GL;
	ZaScreenBase *m_active;
	ZaScreenBase *m_next;
	ZaEvent e;
	int m_width;
	int m_height;
	int init();
	int curl(char * url,char * filename);
	void run();
	void dispatchevent(bps_event_t *event );
	inline void getActive();
	virtual ~zaApp();
};

} /* namespace bbcubezone */
#endif /* ZAAPP_H_ */
