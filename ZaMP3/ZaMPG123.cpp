/*
 * ZaMPG123.cpp
 *
 *  Created on: 2012-11-8
 *      Author: Administrator
 */

#include "ZaMPG123.h"

namespace bbcubezone
{

ZaMPG123::ZaMPG123()
{
	// TODO Auto-generated constructor stub
	m_exit = false;
}

int ZaMPG123::setvolume(float v)
{
	  for(int i=0;i<32;i++)
	  {
		 mpg123_eq(this->m_mpg123, MPG123_LEFT, i, v);
	  }

	alSourcef(uiSource, AL_GAIN, v);
	return 1;
}

int ZaMPG123::init()
{
	int iMpg123_error;
	//init mpg123 library
	if (MPG123_OK != (iMpg123_error = mpg123_init()))
	{
		fprintf(stderr,"failed to init mpg123\n");
		return -1;
	}
	return 0;
}

void* playmp3(void* ins)
{
	ZaMPG123 * lp = (ZaMPG123 *) ins;
	ALuint g_Buffers[NUM_BUFFERS];

	ALuint uiBuffer;
	ALCdevice * pDevice = NULL;
	ALCcontext *pContext = NULL;
	ALboolean g_bEAX;
	int iLoop, iBuffersProcessed, iTotalBuffersProcessed;
	unsigned long ulFrequency = 0;
	size_t ulBufferSize;
	size_t ulBytesWritten;
	long lRate;
	ALuint ulFormat, error;
	int iEncoding, iChannels;
	void * pData = NULL;
	//WAVEFORMATEX *pwfex;
	int iState, iQueuedBuffers;

	int iMpg123_error;
	//init mpg123 library
	sleep(1);
	if (MPG123_OK != (iMpg123_error = mpg123_init()))
	{
		printf("failed to init mpg123\n");
		return ins;
	}

	//open a default mpg123 decoder
	lp->m_mpg123 = mpg123_new(mpg123_decoders()[0], &iMpg123_error);



	//open a openal default device
	pDevice = alcOpenDevice(NULL); //select the perfered device

	if (pDevice)
	{
		pContext = alcCreateContext(pDevice, NULL);
		alcMakeContextCurrent(pContext);
	}
	else
	{
		printf("failed to get a openal decice\n");
		return ins;
	}

	g_bEAX = alIsExtensionPresent("EAX2.0");

	//Generate openal  Buffers
	alGetError(); //clear all error code

	alGenBuffers(NUM_BUFFERS, g_Buffers);

	if ((error = alGetError()) != AL_NO_ERROR)
	{
		fprintf(stderr, "\nalGetError :%d", error);
	}

	alGenSources(1, &(lp->uiSource));

	//try to open a mp3 file, modify to your own mp3 files
	//if(MPG123_OK != (iMpg123_error = mpg123_open(mpg123,"/accounts/1000/shared/downloads/aaa.mp3")))
	if (MPG123_OK
			!= (iMpg123_error = mpg123_open(lp->m_mpg123, lp->m_filename.c_str())))
	{
		fprintf(stderr,"error in open mp3 file\n");
		return ins;
	}
	mpg123_id3v1 * v1=NULL;
	mpg123_id3v2 * v2=NULL;
	mpg123_scan(lp->m_mpg123);
	int meta = mpg123_meta_check(lp->m_mpg123);

	fprintf(stderr,"\nmpg123_new ID3");
	if((meta & MPG123_ID3) && mpg123_id3(lp->m_mpg123, &v1, &v2) == MPG123_OK)
	{
		mpg123_id3(lp->m_mpg123, &v1, &v2);

		if (v1)
		{
			fprintf(stderr,"\nmpg123_new ID3V1");
			fprintf(stderr,"\n %s", v1->album);
			fprintf(stderr,"\n %s", v1->title);
		}
		if (v2)
		{
			fprintf(stderr,"\nmpg123_new ID3V1");
			if (v2->artist->p)
			fprintf(stderr,"\n %s", v2->artist->p);
			if (v2->title->p)
			fprintf(stderr,"\n %s", v2->title->p);

		}
	}
		//get mp3 format infomation
	mpg123_getformat(lp->m_mpg123, &lRate, &iChannels, &iEncoding);

	//there only parse stereo mp3 file
	if (iChannels == 2)
	{
		ulFormat = alGetEnumValue("AL_FORMAT_STEREO16");
		ulBufferSize = lRate * 2; //set buffer to 250ms
		ulBufferSize -= (ulBufferSize % 4); //set pcm Block align
		ulFrequency = lRate; //set pcm sample rate

	}
	else
	{
		printf("channels info%i\n", iChannels);
		return ins;
	}

	pData = malloc(ulBufferSize);
	//feed data to openal buffer
	for (iLoop = 0; iLoop < 4; iLoop++)
	{
		mpg123_read(lp->m_mpg123, (unsigned char *) pData, ulBufferSize,
				&ulBytesWritten);
		alBufferData(g_Buffers[iLoop], ulFormat, pData, ulBytesWritten,
				ulFrequency);
		alSourceQueueBuffers(lp->uiSource, 1, &g_Buffers[iLoop]);
	}
	alSourcePlay(lp->uiSource);
	iTotalBuffersProcessed = 0;
	printf("playing\n");
	//wait for key press
	lp->m_exit = false;
	while (!lp->m_exit)
	{
//	    	bps_event_t *event = NULL;
//	    	bps_get_event(&event, 0);
		usleep(200000);
		iBuffersProcessed = 0;
		alGetSourcei(lp->uiSource, AL_BUFFERS_PROCESSED, &iBuffersProcessed);

		iTotalBuffersProcessed += iBuffersProcessed;
		printf("Buffers total Processed %d\r", iTotalBuffersProcessed);
		while (iBuffersProcessed)
		{
			uiBuffer = 0;
			alSourceUnqueueBuffers(lp->uiSource, 1, &uiBuffer);
			if ((error = alGetError()) != AL_NO_ERROR)
			{
				fprintf(stderr, "\n1alSourceUnqueueBuffers error:%d %d", lp->m_thread,error);
				break;
			}

			mpg123_read(lp->m_mpg123, (unsigned char *) pData, ulBufferSize,
					&ulBytesWritten);
			if (ulBytesWritten)
			{


				alBufferData(uiBuffer, ulFormat, pData, ulBytesWritten,
						ulFrequency);
				if ((error = alGetError()) != AL_NO_ERROR)
				{
					fprintf(stderr, "\nalBufferData error:%d %d", lp->m_thread,error);
				}
				alSourceQueueBuffers(lp->uiSource, 1, &uiBuffer);
				if ((error = alGetError()) != AL_NO_ERROR)
				{
					fprintf(stderr, "\nalSourceQueueBuffers error:%d %d", lp->m_thread,error);
				}
			}
			iBuffersProcessed--;
		}
		alGetSourcei(lp->uiSource, AL_SOURCE_STATE, &iState);
		if (iState != AL_PLAYING)
		{
			alGetSourcei(lp->uiSource, AL_BUFFERS_QUEUED, &iQueuedBuffers);

			if (iQueuedBuffers)
			{
				alSourcePlay(lp->uiSource); //buffers have data, play it
			}
			else
			{
				//there is no data any more
				break;
			}
		}
	}
	//close mpg123
	mpg123_close(lp->m_mpg123);
	//stop the source and clear the queue
	alSourceStop(lp->uiSource);
	alSourcei(lp->uiSource, AL_BUFFER, 0);

	free(pData);
	pData = NULL;
	return ins;
}

int ZaMPG123::run(char * fn)
{
	this->m_filename = fn;
	this->m_exit = true;
	pthread_cancel(this->m_thread);
	if (pthread_create(&m_thread, NULL, playmp3, this) != 0)
	{
		return 0;
	}
	return -1;
}

ZaMPG123::~ZaMPG123()
{
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
