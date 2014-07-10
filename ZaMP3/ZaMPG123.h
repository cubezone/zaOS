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
#include <string>
#include <pthread.h>
#include "libmpg123\mpg123.h"

#define NUM_BUFFERS 4

using namespace std;
namespace bbcubezone
{

class ZaMPG123
{
public:
	ZaMPG123();
	mpg123_handle *mpg123 ;

	pthread_t m_thread;
	ALuint uiSource;
	mpg123_handle *m_mpg123;

	bool m_exit;
	int init();
	int setvolume(float v);
	string m_filename;
	int run(char * fn);
	virtual ~ZaMPG123();
};

} /* namespace bbcubezone */
#endif /* ZAMPG123_H_ */
