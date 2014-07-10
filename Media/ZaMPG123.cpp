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

int ZaMPG123::run()
{
	ALuint g_Buffers[NUM_BUFFERS];
	ALuint uiSource;
	ALuint uiBuffer;
	ALCdevice * pDevice = NULL;
	ALCcontext *pContext = NULL;
	ALboolean g_bEAX;
	ALenum error, eBufferFormat;
	ALint iDataSize, iFrequency;
	ALuint ulFormat;
	int iLoop, iBuffersProcessed, iTotalBuffersProcessed;
	unsigned long ulDataSize = 0;
	unsigned long ulFrequency = 0;
	size_t ulBufferSize;
	size_t ulBytesWritten;
	long lRate;
	int iEncoding, iChannels;
	int encoding;
	void * pData = NULL;
	//WAVEFORMATEX *pwfex;
	int iState, iQueuedBuffers;
	mpg123_handle * mpg123;
	int iMpg123_error;
	//init mpg123 library
	if (MPG123_OK != (iMpg123_error = mpg123_init()))
	{
		printf("failed to init mpg123\n");
		return -1;
	}

	//open a default mpg123 decoder
	mpg123 = mpg123_new(mpg123_decoders()[0], &iMpg123_error);

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
		return -2;
	}

	g_bEAX = alIsExtensionPresent("EAX2.0");

	//Generate openal  Buffers
	alGetError(); //clear all error code

	alGenBuffers(NUM_BUFFERS, g_Buffers);

	if ((error = alGetError()) != AL_NO_ERROR)
	{
		fprintf(stderr, "\nalGetError :%d", error);
	}

	alGenSources(1, &uiSource);

	//try to open a mp3 file, modify to your own mp3 files
	if (MPG123_OK
			!= (iMpg123_error = mpg123_open(mpg123,
					"/accounts/1000/shared/downloads/aaa.mp3")))
	{
		fprintf(stderr,"error in open mp3 file\n");
		return -1;
	}
		//get mp3 format infomation
	mpg123_getformat(mpg123, &lRate, &iChannels, &iEncoding);

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
		return -3;
	}

	pData = malloc(ulBufferSize);
	//feed data to openal buffer
	for (iLoop = 0; iLoop < 4; iLoop++)
	{
		mpg123_read(mpg123, (unsigned char *) pData, ulBufferSize,
				&ulBytesWritten);
		alBufferData(g_Buffers[iLoop], ulFormat, pData, ulBytesWritten,
				ulFrequency);
		alSourceQueueBuffers(uiSource, 1, &g_Buffers[iLoop]);
	}
	alSourcePlay(uiSource);
	iTotalBuffersProcessed = 0;
	printf("playing\n");
	//wait for key press
	while (1)
	{
		bps_event_t *event = NULL;
		bps_get_event(&event, 0);
		usleep(200000);
		iBuffersProcessed = 0;
		alGetSourcei(uiSource, AL_BUFFERS_PROCESSED, &iBuffersProcessed);

		iTotalBuffersProcessed += iBuffersProcessed;
		printf("Buffers total Processed %d\r", iTotalBuffersProcessed);
		while (iBuffersProcessed)
		{
			uiBuffer = 0;
			alSourceUnqueueBuffers(uiSource, 1, &uiBuffer);
			if ((error = alGetError()) != AL_NO_ERROR)
			{
				fprintf(stderr, "\nalSourceUnqueueBuffers :%d", error);
			}

			mpg123_read(mpg123, (unsigned char *) pData, ulBufferSize,
					&ulBytesWritten);
			if (ulBytesWritten)
			{
				alBufferData(uiBuffer, ulFormat, pData, ulBytesWritten,
						ulFrequency);
				if ((error = alGetError()) != AL_NO_ERROR)
				{
					fprintf(stderr, "\nalSourceUnqueueBuffers :%d", error);
				}
				alSourceQueueBuffers(uiSource, 1, &uiBuffer);
				if ((error = alGetError()) != AL_NO_ERROR)
				{
					fprintf(stderr, "\nalSourceUnqueueBuffers :%d", error);
				}
			}
			iBuffersProcessed--;
		}
		alGetSourcei(uiSource, AL_SOURCE_STATE, &iState);
		if (iState != AL_PLAYING)
		{
			alGetSourcei(uiSource, AL_BUFFERS_QUEUED, &iQueuedBuffers);

			if (iQueuedBuffers)
			{
				alSourcePlay(uiSource); //buffers have data, play it
			}
			else
			{
				//there is no data any more
				break;
			}
		}
	}
	//close mpg123
	mpg123_close(mpg123);
	//stop the source and clear the queue
	alSourceStop(uiSource);
	alSourcei(uiSource, AL_BUFFER, 0);

	free(pData);
	pData = NULL;

	return 0;
}

ZaMPG123::~ZaMPG123()
{
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
