/*
 * ZaInputText.cpp
 *
 *  Created on: 2012-9-27
 *      Author: Administrator
 */

#include "ZaInputText.h"

namespace bbcubezone
{

ZaInputText::ZaInputText()
{
	// TODO Auto-generated constructor stub

}

/***************************************************************************
 * 将一个字符的Unicode(UCS-2和UCS-4)编码转换成UTF-8编码.
 * 返回值:
 *    返回转换后的字符的UTF8编码所占的字节数, 如果出错则返回 0 .
 *
 * 注意:
 *     1. UTF8没有字节序问题, 但是Unicode有字节序要求;
 *        字节序分为大端(Big Endian)和小端(Little Endian)两种;
 *        在Intel处理器中采用小端法表示, 在此采用小端法表示. (低地址存低位)
 *     2. 请保证 pOutput 缓冲区有最少有 6 字节的空间大小!
 ****************************************************************************/
int enc_unicode_to_utf8_one(unsigned long unic, unsigned char *pOutput,
		int outSize)
{

	if (unic <= 0x0000007F)
	{
		// * U-00000000 - U-0000007F:  0xxxxxxx
		*pOutput = (unic & 0x7F);
		pOutput[1] = 0;
		return 1;
	}
	else if (unic >= 0x00000080 && unic <= 0x000007FF)
	{
		// * U-00000080 - U-000007FF:  110xxxxx 10xxxxxx
		*(pOutput + 1) = (unic & 0x3F) | 0x80;
		*pOutput = ((unic >> 6) & 0x1F) | 0xC0;
		pOutput[2] = 0;
		return 2;
	}
	else if (unic >= 0x00000800 && unic <= 0x0000FFFF)
	{
		// * U-00000800 - U-0000FFFF:  1110xxxx 10xxxxxx 10xxxxxx
		*(pOutput + 2) = (unic & 0x3F) | 0x80;
		*(pOutput + 1) = ((unic >> 6) & 0x3F) | 0x80;
		*pOutput = ((unic >> 12) & 0x0F) | 0xE0;
		pOutput[3] = 0;
		return 3;
	}
	else if (unic >= 0x00010000 && unic <= 0x001FFFFF)
	{
		// * U-00010000 - U-001FFFFF:  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
		*(pOutput + 3) = (unic & 0x3F) | 0x80;
		*(pOutput + 2) = ((unic >> 6) & 0x3F) | 0x80;
		*(pOutput + 1) = ((unic >> 12) & 0x3F) | 0x80;
		*pOutput = ((unic >> 18) & 0x07) | 0xF0;
		pOutput[4] = 0;
		return 4;
	}
	else if (unic >= 0x00200000 && unic <= 0x03FFFFFF)
	{
		// * U-00200000 - U-03FFFFFF:  111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
		*(pOutput + 4) = (unic & 0x3F) | 0x80;
		*(pOutput + 3) = ((unic >> 6) & 0x3F) | 0x80;
		*(pOutput + 2) = ((unic >> 12) & 0x3F) | 0x80;
		*(pOutput + 1) = ((unic >> 18) & 0x3F) | 0x80;
		*pOutput = ((unic >> 24) & 0x03) | 0xF8;
		pOutput[5] = 0;
		return 5;
	}
	else if (unic >= 0x04000000 && unic <= 0x7FFFFFFF)
	{
		// * U-04000000 - U-7FFFFFFF:  1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
		*(pOutput + 5) = (unic & 0x3F) | 0x80;
		*(pOutput + 4) = ((unic >> 6) & 0x3F) | 0x80;
		*(pOutput + 3) = ((unic >> 12) & 0x3F) | 0x80;
		*(pOutput + 2) = ((unic >> 18) & 0x3F) | 0x80;
		*(pOutput + 1) = ((unic >> 24) & 0x3F) | 0x80;
		*pOutput = ((unic >> 30) & 0x01) | 0xFC;
		pOutput[6] = 0;
		return 6;
	}

	return 0;
}

/*****************************************************************************
 * 将一个字符的UTF8编码转换成Unicode(UCS-2和UCS-4)编码.
 *
 * 参数:
 *    pInput      指向输入缓冲区, 以UTF-8编码
 *    Unic        指向输出缓冲区, 其保存的数据即是Unicode编码值,
 *                类型为unsigned long .
 *
 * 返回值:
 *    成功则返回该字符的UTF8编码所占用的字节数; 失败则返回0.
 *
 * 注意:
 *     1. UTF8没有字节序问题, 但是Unicode有字节序要求;
 *        字节序分为大端(Big Endian)和小端(Little Endian)两种;
 *        在Intel处理器中采用小端法表示, 在此采用小端法表示. (低地址存低位)
 ****************************************************************************/
int enc_utf8_to_unicode_one(unsigned char* pInput, unsigned long *Unic)
{

	// b1 表示UTF-8编码的pInput中的高字节, b2 表示次高字节, ...
	char b1, b2, b3, b4, b5, b6;

	*Unic = 0x0; // 把 *Unic 初始化为全零

	int utfbytes = 0;
	unsigned char * p = pInput;
	while (*p)
	{
		if (*p < 0x7F || *p > 0xC0)
			utfbytes++;
	}

	//int utfbytes = enc_get_utf8_size(*pInput);
	unsigned char *pOutput = (unsigned char *) Unic;

	switch (utfbytes)
	{
	case 0:
		*pOutput = *pInput;
		utfbytes += 1;
		break;
	case 2:
		b1 = *pInput;
		b2 = *(pInput + 1);
		if ((b2 & 0xE0) != 0x80)
			return 0;
		*pOutput = (b1 << 6) + (b2 & 0x3F);
		*(pOutput + 1) = (b1 >> 2) & 0x07;
		break;
	case 3:
		b1 = *pInput;
		b2 = *(pInput + 1);
		b3 = *(pInput + 2);
		if (((b2 & 0xC0) != 0x80) || ((b3 & 0xC0) != 0x80))
			return 0;
		*pOutput = (b2 << 6) + (b3 & 0x3F);
		*(pOutput + 1) = (b1 << 4) + ((b2 >> 2) & 0x0F);
		break;
	case 4:
		b1 = *pInput;
		b2 = *(pInput + 1);
		b3 = *(pInput + 2);
		b4 = *(pInput + 3);
		if (((b2 & 0xC0) != 0x80) || ((b3 & 0xC0) != 0x80)
				|| ((b4 & 0xC0) != 0x80))
			return 0;
		*pOutput = (b3 << 6) + (b4 & 0x3F);
		*(pOutput + 1) = (b2 << 4) + ((b3 >> 2) & 0x0F);
		*(pOutput + 2) = ((b1 << 2) & 0x1C) + ((b2 >> 4) & 0x03);
		break;
	case 5:
		b1 = *pInput;
		b2 = *(pInput + 1);
		b3 = *(pInput + 2);
		b4 = *(pInput + 3);
		b5 = *(pInput + 4);
		if (((b2 & 0xC0) != 0x80) || ((b3 & 0xC0) != 0x80)
				|| ((b4 & 0xC0) != 0x80) || ((b5 & 0xC0) != 0x80))
			return 0;
		*pOutput = (b4 << 6) + (b5 & 0x3F);
		*(pOutput + 1) = (b3 << 4) + ((b4 >> 2) & 0x0F);
		*(pOutput + 2) = (b2 << 2) + ((b3 >> 4) & 0x03);
		*(pOutput + 3) = (b1 << 6);
		break;
	case 6:
		b1 = *pInput;
		b2 = *(pInput + 1);
		b3 = *(pInput + 2);
		b4 = *(pInput + 3);
		b5 = *(pInput + 4);
		b6 = *(pInput + 5);
		if (((b2 & 0xC0) != 0x80) || ((b3 & 0xC0) != 0x80)
				|| ((b4 & 0xC0) != 0x80) || ((b5 & 0xC0) != 0x80)
				|| ((b6 & 0xC0) != 0x80))
			return 0;
		*pOutput = (b5 << 6) + (b6 & 0x3F);
		*(pOutput + 1) = (b5 << 4) + ((b6 >> 2) & 0x0F);
		*(pOutput + 2) = (b3 << 2) + ((b4 >> 4) & 0x03);
		*(pOutput + 3) = ((b1 << 6) & 0x40) + (b2 & 0x3F);
		break;
	default:
		return 0;
		break;
	}

	return utfbytes;
}

void ZaInputText::processEvent(ZaEvent * env)
{
	if (env->m_type == ZaEvent::EVENT_DOWN)
	{
		virtualkeyboard_show();
		env->m_event = ZaEvent::EVENT_CLICK;
	}
	else if (env->m_type == ZaEvent::EVENT_KEYBOARD_KEYDOWN)
	{
		fprintf(stderr,"%d \n",env->m_keycode);
		env->m_event = 0;
		if(env->m_keycode == KEYCODE_BACKSPACE)
		{
			if (m_text.length()>0)
			{
				if ((unsigned char) m_text.at(m_text.length()-1) < 0x7F)
					m_text = m_text.substr(0,m_text.length()-1);
				else
				{
					while (m_text.length()>0)
					{
						if ((unsigned char) m_text.at(m_text.length()-1)>0xC0)
						{
							m_text = m_text.substr(0,m_text.length()-1);
							break;
						}
						else
							m_text = m_text.substr(0,m_text.length()-1);

					}
				}
			}
			env->m_event = ZaEvent::EVENT_INPUT_CHAR;
		}
		else if (env->m_keycode == KEYCODE_RETURN)
		{
			env->m_event = ZaEvent::EVENT_INPUT_ENTER;
		}
		else if((env->m_keycode >=UNICODE_BASIC_LATIN_FIRST &&
						env->m_keycode <=UNICODE_BASIC_LATIN_LAST)
				||
				(env->m_keycode >=UNICODE_LATIN_1_SUPPLEMENT_FIRST &&
						env->m_keycode <=UNICODE_LATIN_1_SUPPLEMENT_LAST
				)
				||
				(env->m_keycode >=UNICODE_COMBINING_DIACRITICAL_MARKS_FIRST &&
				 env->m_keycode <=UNICODE_COMBINING_DIACRITICAL_MARKS_LAST)
				||
				( env->m_keycode < 0x9FFF)
				)
		{
			char a[7];
			a[0]=0;
			enc_unicode_to_utf8_one(env->m_keycode,(unsigned char*)a,6);
			m_text.append(a);
			ZaResLib::getInstance()->m_font_en->load_font((char*) (m_text + "_").c_str(), 0);
			env->m_event = ZaEvent::EVENT_INPUT_CHAR;
			fprintf(stderr,"ZaInputText::processEvent \nkkkk");
		}

	}
	ZaObj::processEvent(env);
}

void ZaInputText::drawControl()
{
	int a = m_x, b = m_y;
	getClientXY(a, b);

	ZaResLib::getInstance()->m_font->setcolor(0.6f, 0.6f, 1.0f, 1.0f);

	ZaResLib::getInstance()->m_font->render_text((m_text + "_").c_str(), 0, a, b, "UTF-8",m_width,5);


//	fprintf(stderr,"ZaButton drawControl %p %d %d alpha %f\n",this,a, b ,m_alpha);

}

ZaInputText::~ZaInputText()
{
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
