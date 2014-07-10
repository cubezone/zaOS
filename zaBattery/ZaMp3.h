/*
 * ZaMp3.h
 *
 *  Created on: 2012-2-15
 *      Author: zhuxy
 */

#include "zaAll.h"

#ifndef ZAMP3_H_
#define ZAMP3_H_

#define DEFAULT_AUDIO_OUT "audio:default"

class ZaMp3 {
public:
	ZaMp3();

	int count;
	char cwd[PATH_MAX];
	char inputurl[PATH_MAX];
	float volume;
	int rc;
	void stop();
	mmr_connection_t *connection;
	mmr_context_t *ctxt;
	int play(const char * url);
	int playloop(const char * url);
	void mmrerror( mmr_context_t *ctxt, const char *msg );
	void setvolume(float v);
	void mute();
	virtual ~ZaMp3();
};

#endif /* ZAMP3_H_ */
