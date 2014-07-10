/*
 * ZaObj.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZAOBJ_H_
#define ZAOBJ_H_
#include <stdio.h>
#include <stdlib.h>
#include "ZaEvent.h"

namespace bbcubezone {


class ZaObj {

public:

	ZaObj();
	int m_x;
	int m_y;
	int m_width;
	int m_height;
	int m_id;
	float m_alpha;
	float m_r;
	float m_z;
	float m_percent;
	bool m_visiable;
	bool m_enable;
	bool m_pressed;
	bool m_active;
	bool m_dirty;
	bool m_motion;
	bool m_dragable;

	bool m_postparent;

	inline void setSize(int w, int h)
	{
		m_width = w;
		m_height = h;
	}
	inline void setXY(int x , int y)
	{
		m_x = x;
		m_y = y;
	}
	int setSize(int x, int y , int w, int h);
	int getClientXY(int& x , int& y);
	virtual void processEvent(ZaEvent * env);
	void AddChild(ZaObj * obj);
	void draw();
	virtual void drawControl();
	virtual void tweener(int id, float value);
	void eventtest(ZaEvent * event);
	static void RemoveChild(ZaObj * obj);
	bool inPoint(int x, int y);
	ZaObj * m_parent;
	ZaObj * m_next;
	ZaObj * m_child;
	virtual ~ZaObj();
};

} /* namespace bbcubezone */
#endif /* ZAOBJ_H_ */
