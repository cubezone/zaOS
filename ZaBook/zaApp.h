/*
 * zaApp.h
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */


#ifndef ZAAPP_H_
#define ZAAPP_H_


#include "ZaAppBase.h"
#include "dirent.h"
#include <curl/curl.h>
#include <curl/easy.h>

//#include <sys/mman.h>

namespace bbcubezone {

class zaApp:public bbcubezone::zaAppBase {
public:
	zaApp();
	int init();
	virtual ~zaApp();
};

} /* namespace bbcubezone */
#endif /* ZAAPP_H_ */
