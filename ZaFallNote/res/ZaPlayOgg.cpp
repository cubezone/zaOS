#include "ZaPlayOgg.h"

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
int playogg(const char * file)
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
int playogg(char * ogg)
{
//alutInit(&argc, argv);
	ALCdevice * dev;
	ALCcontext * ctx;
	dev = alcOpenDevice(NULL);
	ctx = alcCreateContext(dev, NULL);
	alcMakeContextCurrent(ctx);
	alGenBuffers(BUFFER_CNT, buffer);
	alGenSources(1, &source);
	alListener3f(AL_POSITION, 0.0f, 0.0f, 0.0f);
	alSource3f(source, AL_POSITION, 0.0f, 0.0f, 0.0f);
	playogg(ogg);
	alDeleteBuffers(BUFFER_CNT, buffer);
	alDeleteSources(1, &source);
//alutExit();
	return 0;
}


void  openAVFile(const char *fname)
{


    /* We need to make sure ffmpeg is initialized. Optionally silence warning
     * output from the lib */
   {av_register_all();
    av_log_set_level(AV_LOG_ERROR);
    }

    AVFormatContext *ctx;
    if( avformat_open_input(&ctx, fname, NULL, NULL) == 0)
    {
        /* After opening, we must search for the stream information because not
         * all formats will have it in stream headers */
        if(avformat_find_stream_info(ctx, NULL) >= 0)
            return ;
        av_close_input_file(ctx);
    }

    int audiocount;
    for(int i = 0;i < ctx->nb_streams;i++)
      {
          if(ctx->streams[i]->codec->codec_type == AVMEDIA_TYPE_AUDIO)
              audiocount++;
      }

}

int  main()
{
	 openAVFile("/accounts/1000/shared/music/aa.ogg");
	 return 0;
}
