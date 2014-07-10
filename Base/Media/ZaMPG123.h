/*
 * ZaMPG123.h
 *
 *  Created on: 2012-11-8
 *      Author: Administrator
 */

#ifndef ZAMPG123_H_
#define ZAMPG123_H_
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "AL\al.h"
#include "AL\alc.h"
#include <bps\event.h>
#include "libmpg123\mpg123.h"

#define NUM_BUFFERS 8

namespace bbcubezone
{

class ZaMPG123
{
public:
	ZaMPG123();
	mpg123_handle *mpg123 ;
	int init();
	int run();
	virtual ~ZaMPG123();
};

} /* namespace bbcubezone */
#endif /* ZAMPG123_H_ */
