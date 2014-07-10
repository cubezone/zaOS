#include "soundmanager.h"

namespace bbcubezone
{

soundmanager::soundmanager()
{
	m_sourcenum =0;
}

// Error message function for ALUT.
static void reportALUTError()
{
	fprintf(stderr,"\nsoundmanager:ALUT reported the following error: %s " ,alutGetErrorString(alutGetError()));
}

// Error message function for OpenAL.
static void reportOpenALError()
{
	fprintf(stderr,"\nsoundmanager:OpenAL reported the following error: %s " ,alutGetErrorString(alutGetError()));
}

bool soundmanager::addSong(string alsname, string soundDirectory)
{
	ALuint bufferID = alutCreateBufferFromFile(soundDirectory.c_str());
	fprintf(stderr,"\naddSong   : %s ",soundDirectory.c_str());
	if (alutGetError() == ALUT_ERROR_NO_ERROR)
	{
		mSoundBuffers[alsname] = bufferID;
	}
	else
	{
		reportALUTError();
	}
	return true;
}

#define BUFFER_SIZE     1024*4       // 4 KB buffer
#define BUFFER_CNT      4
static ALuint buffer[BUFFER_CNT];
static ALuint source;
// Deffering from ov_read, it will make sure that the buffer is full
// or it will continue reading till it's full, unless for the last bits.
int ov_read2(OggVorbis_File * ogg, char * buf, int buf_size)
{
	int bs;
	int cnt = 0;
	while (buf_size - cnt > 0)
	{
		int t = ov_read(ogg, &buf[cnt], buf_size - cnt, 0, 2, 1, &bs);
		if (t == 0)
			break;
		cnt += t;
	}
	return cnt;
}
int soundmanager::playogg(const char * file)
{
	ALint state;
	ALenum format;
	ALsizei freq;
	int cnt;
	char buf[BUFFER_SIZE];
	FILE * fp;
	if (!(fp = fopen(file, "r")))
		return -1;
	vorbis_info * info;
	OggVorbis_File ogg;
	if (ov_open(fp, &ogg, NULL, 0))
		return -2;
	info = ov_info(&ogg, -1);
	freq = info->rate;
	if (info->channels == 1)
		format = AL_FORMAT_MONO16;
	else
		format = AL_FORMAT_STEREO16;
	int i;
	for (i = 0; i < BUFFER_CNT; i++)
	{
		cnt = ov_read2(&ogg, buf, BUFFER_SIZE);
		if (cnt > 0)
			alBufferData(buffer[i], format, buf, cnt, freq);
	}
	alSourceQueueBuffers(source, BUFFER_CNT, buffer);
	alSourcePlay(source);
	while (1)
	{
		ALuint b;
		alGetSourcei(source, AL_BUFFERS_PROCESSED, &state);
		if (state <= 0)
			continue;
		while (state--)
		{
			alSourceUnqueueBuffers(source, 1, &b);
			cnt = ov_read2(&ogg, buf, BUFFER_SIZE);
			if (cnt > 0)
				alBufferData(b, format, buf, cnt, freq);
			else
				goto _end;
			alSourceQueueBuffers(source, 1, &b);
		}
		alGetSourcei(source, AL_SOURCE_STATE, &state);
		if (state != AL_PLAYING)
			alSourcePlay(source);
	}
	_end: ov_clear(&ogg);
	return 0;
}
bool soundmanager::init(string soundDirectory)
{
	if (alutInit(NULL, NULL) == false)
	{
		reportALUTError();
		return false;
	}
	alGenSources(soundmanager_MAX_NBR_OF_SOURCES, mSoundSources);

	if (alGetError() != AL_NO_ERROR)
	{
			reportOpenALError();
	}
	return true;
}


uint soundmanager::play(string alsname, float pitch, float gain)
{
	static uint sourceIndex = 0;

	// Get the corresponding buffer ID to the file name.
	ALuint bufferID = mSoundBuffers[alsname];

	if (bufferID != 0)
	{
		// Increment which source we are using, so that we play in an unused source.
		sourceIndex = (sourceIndex + 1) % soundmanager_MAX_NBR_OF_SOURCES;

		// Get the source from which the sound will be played.
		ALuint source = mSoundSources[sourceIndex];

		if (alIsSource(source) == AL_TRUE)
		{
			// Attach the buffer the available source.
			alSourcei(source, AL_BUFFER, bufferID);

			if (alGetError() != AL_NO_ERROR)
			{
				reportOpenALError();
				return false;
			}

			// Set the source pitch value.
			alSourcef(source, AL_PITCH, pitch);

			if (alGetError() != AL_NO_ERROR)
			{
				reportOpenALError();
				return false;
			}

			// Set the source gain value.
			alSourcef(source, AL_GAIN, gain);

			if (alGetError() != AL_NO_ERROR)
			{
				reportOpenALError();
				return false;
			}

			// Play the source.
			alSourcePlay(source);

			if (alGetError() != AL_NO_ERROR)
			{
				reportOpenALError();
				return false;
			}
		}
	}
	else
	{
		// Otherwise, the buffer was not found.
		return false;
	}

	return sourceIndex;
}

soundmanager::~soundmanager()
{
	ALuint bufferID = 0;

	// Clear all the sources.

	for (int i = 0; i < soundmanager_MAX_NBR_OF_SOURCES; i++)
	{
		ALuint source = mSoundSources[i];
		alDeleteSources(1, &source);

		if (alGetError() != AL_NO_ERROR)
		{
			reportOpenALError();
		}
	}
	// Clear the buffers and iterate through the hash table.

	std::map<string, ALuint>::iterator iter;
	for (iter = mSoundBuffers.begin(); iter != mSoundBuffers.end(); iter++)
	{
		// Get the buffer id and delete it.
		bufferID = iter->second;
		if (bufferID != 0)
		{
			alDeleteBuffers(1, &bufferID);

			if (alGetError() != AL_NO_ERROR)
			{
				reportOpenALError();
			}
		}
	}

	// Clear the QHash for sound buffer IDs.
	mSoundBuffers.clear();

	// Exit the ALUT.
	if (alutExit() == false)
	{
		reportALUTError();
	}
}

uint soundmanager::play(string alsname)
{
	// Play the sound with default gain and pitch values.
	return play(alsname, 1.0f, 1.0f);
}

bool soundmanager::stop(uint sourceid)
{
	alSourcef(this->mSoundSources[sourceid], AL_GAIN, 0);
	alSourceStop(this->mSoundSources[sourceid]);
	return 0;
}

int stopdelayint(void * in)
{
	float f = 1.0f;
	soundmanager::para *p = (soundmanager::para *) in;
	for(int i = 0 ; i <p->delay; i ++)
	{
		f -= 1.0f/p->delay;
		usleep(10*1000);
		alSourcef(p->sn->mSoundSources[p->sourceid], AL_GAIN, f);
		if (alGetError() != AL_NO_ERROR)
		{
			reportOpenALError();
		}
	}
	if (f != 0.0f)
	{
		alSourcef(p->sn->mSoundSources[p->sourceid], AL_GAIN, 0);
	}
	alSourceStop(p->sn->mSoundSources[p->sourceid]);
	return 0;

}

bool soundmanager::stopdelay(uint sourceid,int delay)
{
	para *l_p = (para *)malloc(sizeof(para));
	l_p->sn = this;
	l_p->sourceid = sourceid;
	l_p->delay = delay;
	StartThread(stopdelayint,(void*)l_p);
	return 0;
}

}
