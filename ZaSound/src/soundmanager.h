/* Copyright (c) 2012 Research In Motion Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef _soundmanager_H
#define _soundmanager_H

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string>
#include <map>
#include <AL/al.h>
#include <AL/alc.h>
#include <AL/alut.h>

// The number of max number of sound sources
#define soundmanager_MAX_NBR_OF_SOURCES 32

/**
 * soundmanager Description:
 *
 * A very basic sound manager class for playing sounds using OpenAL library.
 */
namespace bbcubezone {
using namespace std;
class soundmanager
{
public:

  soundmanager();

  virtual ~soundmanager();

  bool init(string soundDirectory);

  bool play(string alsname);

  bool play(string alsname, float pitch, float gain);

  bool addSong(string alsname,string soundDirectory);
  //ALuint mSoundBuffers[1];
  map<string,ALuint> mSoundBuffers;


  map<string,ALuint> mSoundSources;
};

}
#endif //_soundmanager_H
