/*
 * ZaMp3.h
 *
 *  Created on: 2012-2-15
 *      Author: zhuxy
 */

#ifndef ZAMP3_H_
#define ZAMP3_H_
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <mm/renderer.h>
#include <bps/bps.h>
#include <bps/audiomixer.h>

#define DEFAULT_AUDIO_OUT "audio:default"

class ZaMp3 {
public:
	ZaMp3();
	void setid(const char * id) ;
	int count;
	char cwd[PATH_MAX];
	char inputurl[PATH_MAX];
	float volume;
	int rc;
	char ctxtname[100] ;
	mmr_context_t *ctxt;
	mmr_connection_t *connection;
	int play(const char * url);
	int playloop(const char * url);
	void mmrerror( mmr_context_t *ctxt, const char *msg );
	void mute();
	int stop();
	virtual ~ZaMp3();
};

#endif /* ZAMP3_H_ */
