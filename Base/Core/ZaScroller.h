/*
 * ZaScroller.h
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#ifndef ZaScroller_H_
#define ZaScroller_H_

#include "ZaObj.h"
#include <string>
#include <vector>
#include "ZaTweener.h"
#include "ZaButton.h"
#include "ZaResLib.h"

using namespace std;
namespace bbcubezone {

class ZaScroller: public bbcubezone::ZaObj {
public:
	ZaScroller();
	void drawControl();
	void calChildHeight();
	void tweener(int id, float value);
	void AddChild(ZaObj * obj);
	void processEvent(ZaEvent * env);
	int setSize(int x, int y , int w, int h);

	int m_style; //0:noral 1:radius;
	int m_childheight;
	std::vector<ZaObj *> m_v;
	int m_top;

	virtual ~ZaScroller();
};

} /* namespace bbcubezone */
#endif /* ZaScroller_H_ */
