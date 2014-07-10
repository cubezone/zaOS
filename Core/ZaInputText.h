/*
 * ZaInputText.h
 *
 *  Created on: 2012-9-27
 *      Author: Administrator
 */

#ifndef ZaInputText_H_
#define ZaInputText_H_
#include <string>
#include "ZaObj.h"
#include "ZaResLib.h"
#include "ZaLabel.h"
#include <bps/virtualkeyboard.h>
#include <sys/keycodes.h>

namespace bbcubezone {

class ZaInputText: public bbcubezone::ZaLabel {
public:
	ZaInputText();
	void processEvent(ZaEvent * env);
	void drawControl();
	std::string m_text;
	virtual ~ZaInputText();
};

} /* namespace bbcubezone */
#endif /* ZaInputText_H_ */
