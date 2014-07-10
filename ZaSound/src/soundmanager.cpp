#include "soundmanager.h"

namespace bbcubezone
{

soundmanager::soundmanager()
{

}

// Error message function for ALUT.
static void reportALUTError()
{
	//fprintf(stderr,"ALUT reported the following error: %s " ,alutGetErrorString(alutGetError()));
}

// Error message function for OpenAL.
static void reportOpenALError()
{
	//fprintf(stderr,"OpenAL reported the following error: %s " ,alutGetErrorString(alutGetError()));
}

bool soundmanager::addSong(string alsname, string soundDirectory)
{
	ALuint bufferID = alutCreateBufferFromFile(soundDirectory.c_str());

	if (alutGetError() == ALUT_ERROR_NO_ERROR)
	{
		mSoundBuffers[alsname] = bufferID;
	}
	else
	{
		reportALUTError();
	}

	alGenSources(1, &mSoundSources[0]);

	if (alGetError() != AL_NO_ERROR)
	{
		reportOpenALError();
	}
	return true;
}

bool soundmanager::init(string soundDirectory)
{
	if (alutInit(NULL, NULL) == false)
	{
		reportALUTError();
		return false;
	}
	return true;
}


bool soundmanager::play(string alsname, float pitch, float gain)
{
	static uint sourceIndex = 0;

	// Get the corresponding buffer ID to the file name.
	ALuint bufferID = mSoundBuffers[alsname];

	if (bufferID != 0)
	{
		// Increment which source we are using, so that we play in an unused source.
		sourceIndex = (sourceIndex + 1) % soundmanager_MAX_NBR_OF_SOURCES;

		// Get the source from which the sound will be played.
		ALuint source = mSoundSources[alsname];

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

	return true;
}

soundmanager::~soundmanager()
{
	ALuint bufferID = 0;

	// Clear all the sources.
	std::map<string, ALuint>::iterator iter;
	for (iter = mSoundSources.begin(); iter != mSoundSources.end(); iter++)
	{
		ALuint source = iter->second;
		alDeleteSources(1, &source);

		if (alGetError() != AL_NO_ERROR)
		{
			reportOpenALError();
		}
	}
	mSoundSources.clear();
	// Clear the buffers and iterate through the hash table.

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

bool soundmanager::play(string alsname)
{
	// Play the sound with default gain and pitch values.
	return play(alsname, 1.0f, 1.0f);
}

}
