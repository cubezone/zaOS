/*
 * ZaDict.h
 *
 *  Created on: 2012-10-22
 *      Author: Administrator
 */

#ifndef ZADICT_H_
#define ZADICT_H_
#include <vector>
#include <string>
#include "dictziplib.h"
#include "net/netbyte.h"
#include "Exception.h"
namespace bbcubezone {

 struct worditem_t {
	std::string word;
	unsigned int offset;
	unsigned int size;
	bool operator < (const worditem_t & rhs) const
	{
		return (rhs.word < this->word);
	};
	bool operator > (const worditem_t & rhs) const
	{
		return (rhs.word > this->word);
	};
	bool operator == (const worditem_t & rhs) const
	{
		return (rhs.word == this->word);
	};
} ;

 int stardict_strncmp(const char *s1, const char *s2 ,int n);
 int stardict_strcmp(const char *s1, const char *s2);

class ZaDict {
public:
	ZaDict();

	typedef std::vector< worditem_t> worditem_vect_t;
	worditem_vect_t m_v_idx;
	dictData m_dict;
	int m_index;

	void openDict(std::string & f);
	int queryWord(const std::string & w,std::string& o);
	void closeDict();

	virtual ~ZaDict();
};
}

#endif /* ZADICT_H_ */
