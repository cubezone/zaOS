/*
 * zaPicList.h
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */


#include "zaAll.h"

#ifndef ZAPICLIST_H_
#define ZAPICLIST_H_

class zaPicList : public zaObj {
public:
	zaPicList();
	void addPic();
	zaWorker *m_worker;
	virtual ~zaPicList();
};

#endif /* ZAPICLIST_H_ */
