/*
 * ZaMp3.cpp
 *
 *  Created on: 2012-2-15
 *      Author: zhuxy
 */

#include "ZaMp3.h"

ZaMp3::ZaMp3() {
	// TODO Auto-generated constructor stub
	ctxt = NULL;
	connection= NULL;
	sprintf(ctxtname,"%s","playtest");
}

void ZaMp3::setid(const char * id) {
	// TODO Auto-generated constructor stub
	sprintf(ctxtname,"%s",id);
}

ZaMp3::~ZaMp3() {
	// TODO Auto-generated destructor stub
}

int ZaMp3::play(const char * url)
{
	const char *mmrname = NULL;
	const char *audioout = NULL;
	const char *inputtype = "track";
	//int  final_return_code = EXIT_FAILURE;
	mode_t mode = S_IRUSR | S_IXUSR;
	int audio_oid; // output ID
	strm_dict_t *aoparams = NULL; // output parameters

	if (!ctxt)
	{
		audioout = DEFAULT_AUDIO_OUT;
		getcwd(cwd, PATH_MAX);
		rc = snprintf(inputurl, PATH_MAX, "file://%s%s", cwd, url);
		if (( connection = mmr_connect( mmrname ) ) == NULL )
			perror( "mmr_connect" );
		else if ( ( ctxt = mmr_context_create( connection, ctxtname, 0, mode ) ) == NULL ) {
			perror( "mmr_create" );
			perror( ctxtname );
		} else if ( audioout && ( audio_oid = mmr_output_attach( ctxt, audioout, "audio" ) ) < 0 ) {
			mmrerror( ctxt, audioout );
		} else if ( aoparams && mmr_output_parameters( ctxt, audio_oid, aoparams ) ) {
			mmrerror( ctxt, "output parameters (audio)" );
		} else if ( mmr_input_attach( ctxt, inputurl, inputtype ) < 0 ) {
			mmrerror( ctxt, inputurl );
		} else if ( mmr_play( ctxt ) < 0 ) {
			mmrerror( ctxt, "mmr_play" );
		}
	}
	else
	{
		mmr_stop(ctxt);
		//mmr_input_attach( ctxt, inputurl, inputtype );
		mmr_play( ctxt );
	}

	return 0;
}

int ZaMp3::stop()
{
	if (ctxt)
	return mmr_stop(ctxt);
	else
	return 0;
}

int ZaMp3::playloop(const char * url)
{
	const char *mmrname = NULL;
	const char *ctxtname = "testplayer";
	const char *audioout = NULL;
	const char *inputtype = "autolist";
	//int     final_return_code = EXIT_FAILURE;
	mode_t mode = S_IRUSR | S_IXUSR;
	int audio_oid; // output ID
	strm_dict_t *aoparams = NULL; // output parameters

	mmr_connection_t *connection;
	mmr_context_t *ctxt;

	audioout = DEFAULT_AUDIO_OUT;

	strm_dict_t *aiparams = strm_dict_new();
	aiparams = strm_dict_set(aiparams, "repeat", "all");


	getcwd(cwd, PATH_MAX);
	rc = snprintf(inputurl, PATH_MAX, "file://%s%s", cwd, url);

	if ( ( connection = mmr_connect( mmrname ) ) == NULL ) {
		perror( "mmr_connect" );
	} else if ( ( ctxt = mmr_context_create( connection, ctxtname, 0, mode ) ) == NULL ) {
		perror( ctxtname );
	} else if ( audioout && ( audio_oid = mmr_output_attach( ctxt, audioout, "audio" ) ) < 0 ) {
		mmrerror( ctxt, audioout );
	} else if ( aoparams && mmr_output_parameters( ctxt, audio_oid, aoparams ) ) {
		mmrerror( ctxt, "output parameters (audio)" );
	} else if ( mmr_input_attach( ctxt, inputurl, inputtype ) < 0 ) {
		mmrerror( ctxt, inputurl );
    } else if ( aiparams && mmr_input_parameters( ctxt, aiparams ) ) {  // NEW
    	mmrerror( ctxt, "input parameters (audio)" );  // NEW
    } else if ( mmr_play( ctxt ) < 0 ) {
		mmrerror( ctxt, "mmr_play" );
	}
	return 0;
}

void  ZaMp3::mmrerror( mmr_context_t *ctxt, const char *msg ) {
	const mmr_error_info_t *err = mmr_error_info( ctxt );
	unsigned errcode = err->error_code;
	fprintf( stderr, "%s: error %d (%s)\n", msg, errcode);
}

void ZaMp3::mute()
{
	audiomixer_set_output_level(AUDIOMIXER_OUTPUT_SPEAKER, volume / 2.0);
	if (rc == BPS_SUCCESS) {
		fprintf(stderr, "Successfully decreased the volume.\n");
	} else {
		fprintf(stderr, "Failed to decrease the volume.\n");
	}

}
