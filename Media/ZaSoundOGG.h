/*
 * ZaSoundOGG.h
 *
 *  Created on: 2012-11-4
 *      Author: Administrator
 */

#ifndef ZASOUNDOGG_H_
#define ZASOUNDOGG_H_
#include <vorbis/vorbisfile.h>
#include <AL/al.h>
#include <AL/alc.h>
#include <AL/alut.h>
#include <unistd.h>

namespace bbcubezone
{

class ZaSoundOGG
{
public:
	ZaSoundOGG();
	void run(char * ogg);
	int playogg(const char * file);
	virtual ~ZaSoundOGG();
};

} /* namespace bbcubezone */
#endif /* ZASOUNDOGG_H_ */
