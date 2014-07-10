/*
 * ZaList.h
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#ifndef ZALIST_H_
#define ZALIST_H_

#include "ZaObj.h"
#include <string>
#include <vector>
#include "ZaTweener.h"
#include "ZaButton.h"
#include "ZaResLib.h"
#include "ZaTextArea.h"

using namespace std;
namespace bbcubezone {

class ZaList: public bbcubezone::ZaObj {
public:
	ZaList();
	void drawControl();
	void processEvent(ZaEvent * env);
	int setSize(int x, int y , int w, int h);
	void tweener(int id, float value);
	void addlistitem(string item);
	virtual void removeItem(int id){};
	int m_style; //0:noral 1:radius;
	int m_index;
	int m_index_temp;
	//ÿ�а���ַ���
	int m_rowseg;
	//�ڲ���� = m_rowseg * m_rowcount.
	std::vector<string> m_v;
	//�������ʼλ��.
	int m_top;
	//�и�
	int m_rowheight;
	//����
	zaFont * m_font;
	ZaButton * m_delete;
	virtual ~ZaList();
};

} /* namespace bbcubezone */
#endif /* ZALIST_H_ */
