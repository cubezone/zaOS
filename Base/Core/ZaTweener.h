/*
 * ZaTweener.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZATWEENER_H_
#define ZATWEENER_H_
#include  <list>
#include "ZaObj.h"
#include <unistd.h>

namespace bbcubezone {


typedef struct  {
// 1 x, 2, y , 3 ,w ,4 h, 5 alpha;
ZaObj * obj;
int type;
float o;
float n;
int begin_seg;
int segs;
int current;
}str_tween ;

class ZaTweener {
public:
	static const int X= 1;
	static const int Y= 2;
	static const int WIDTH= 3;
	static const int HEIGHT= 4;
	static const int ALPHA= 5;
	static const int ROTATION= 6;
	static const int ZOOM = 7;
	static const int PERCENT = 8;
	static const int YMOVE = 9;
	static const int LOADSCREEN = 10;
	static const int FUNCTION = 11;
	ZaTweener();
	static ZaTweener * m_tweener;
	static ZaTweener * getInstance();
	void push(ZaObj* obj,int type, float o, float n, int begin_seg,int segs);
	void pop(ZaObj * obj);
	void run(int& x, int& y, int& w,int& h);
	bool empty();
	std::list<str_tween *> m_v;
	int m_x,m_y,m_w,m_h;
	std::string m_param;
	std::string m_param2;
	virtual ~ZaTweener();
};

} /* namespace bbcubezone */
#endif /* ZATWEENER_H_ */
