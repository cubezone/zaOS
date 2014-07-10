/*
 * ZaScreenLoader.h
 *
 *  Created on: 2012-11-19
 *      Author: Administrator
 */

#ifndef ZASCREENLOADER_H_
#define ZASCREENLOADER_H_
#include <string>
#include "ZaScreenBase.h"
using namespace std;

namespace bbcubezone
{

class ZaScreenLoader
{
public:
	ZaScreenLoader();
	virtual ZaScreenBase * LoadScreen(string scrname, int w, int h);
	virtual ~ZaScreenLoader();
};

} /* namespace bbcubezone */
#endif /* ZASCREENLOADER_H_ */
