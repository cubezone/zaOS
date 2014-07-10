/*
 * zaObj.h
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaAll.h"

#ifndef ZAOBJ_H_
#define ZAOBJ_H_

class zaObj {
public:
	zaObj();
	int m_x,m_y;
	int m_ox,m_oy;
	int m_d;
	int m_ll;
	bool m_dirty;
	float m_alpha;
	bool m_event;
	void render();
	void porcess(zaWorker * wk);
	virtual ~zaObj();
	void move();
	std::vector<ZAImage> m_v ;

};

#endif /* ZAOBJ_H_ */
