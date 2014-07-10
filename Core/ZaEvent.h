/*
 * ZaEvent.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZAEVENT_H_
#define ZAEVENT_H_

namespace bbcubezone {

class ZaObj;



class ZaEvent {
public:
	ZaEvent();
	int m_x;//touch pos x;
	int m_y;//touch pos y;
	int m_id;//touch id;
static const int EVENT_DOWN = 100;
static const int EVENT_MOVE = 101;
static const int EVENT_UP = 102;
static const int EVENT_CLICK = 103;
static const int EVENT_SLIDER_CHANGED = 104;
static const int EVENT_LIST_SELECT = 105;
static const int EVENT_LIST_SELECT_FILE = 106;
static const int EVENT_CLICK_URL = 107;

static const int EVENT_SWIPE_LEFT = 206;
static const int EVENT_SWIPE_RIGHT = 207;


static const int EVENT_KEYBOARD_KEYDOWN = 7;
static const int EVENT_INPUT_CHAR  = 300;
static const int EVENT_INPUT_ENTER = 301;

static const int EVENT_RT_END=160;

	int m_type;
	int m_event;
	int m_index;//list select index;
	int m_d_x;
	int m_d_y;
	int m_d_h;
	int m_d_w;
	unsigned int m_keycode;
	ZaObj * m_obj;
	virtual ~ZaEvent();
};

} /* namespace bbcubezone */
#endif /* ZAEVENT_H_ */

