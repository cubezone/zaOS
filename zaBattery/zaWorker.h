/*
 * zaWorker.h
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */
#include "zaAll.h"

#ifndef ZAWORKER_H_
#define ZAWORKER_H_

class zaWorker {
public:
	zaWorker();
	void work();
	int m_x,m_y;
	int m_ox,m_oy;
	int m_dx,m_dy;

	int m_len;
	int m_time;// = clock();
	int m_task;
	void move(int x, int y);
	void init(int x, int y);
	virtual ~zaWorker();
};

#endif /* ZAWORKER_H_ */
