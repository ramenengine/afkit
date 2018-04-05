cd kit/dep/fmod5
library fmod.dll
cd ../../..

function: FMOD_System_Create  ( &dest -- ) \ dest receives system
\ function: FMOD_ErrorString
function: FMOD_System_Init  ( system chans flags &extradriverinfo -- )
function: FMOD_System_SetOutput  ( system outputtype -- )
function: FMOD_System_SetDriver  ( system driver -- )
function: FMOD_System_SetSoftwareChannels  ( system num -- )
function: FMOD_System_SetSoftwareFormat   ( system samplerate format #outs #ins resamplemethod -- )
function: FMOD_System_CreateSound  ( system zname FMOD_MODE optionalinfo &dest -- )
function: FMOD_System_CreateStream  ( system zname FMOD_MODE optionalinfo &dest -- ) \ same as above
function: FMOD_System_PlaySound ( system sound channelgroup paused &chan -- ) \ chan receives OR passes channel
function: FMOD_System_Update ( system -- )
function: FMOD_System_Release ( system -- )

function: FMOD_Memory_Initialize ( void-*poolmem, int-poollen, FMOD_MEMORY_ALLOCCALLBACK-useralloc, FMOD_MEMORY_REALLOCCALLBACK-userrealloc, FMOD_MEMORY_FREECALLBACK-userfree, FMOD_MEMORY_TYPE-memtypeflags -- )

function: FMOD_System_GetMasterChannelGroup  ( system-&dest -- ) \ dest receives chan group
function: FMOD_ChannelGroup_SetVolume        ( FMOD_CHANNELGROUP-*channelgroup, float-volume -- )

function: FMOD_Channel_SetPaused ( FMOD_CHANNEL-*channel, FMOD_BOOL-paused -- )
function: FMOD_Channel_Stop ( FMOD_CHANNEL-*channel -- )

function: FMOD_Sound_GetNumSubSounds  ( FMOD_SOUND-*sound, int-*numsubsounds -- )
function: FMOD_Sound_GetSubSound ( FMOD_SOUND-*sound, int-index, FMOD_SOUND-**subsound -- )
function: FMOD_Sound_Release ( sound -- )

function: FMOD_System_GetMasterChannelGroup ( system &channelgroup -- )
function: FMOD_ChannelGroup_Stop ( channelgroup -- )
function: FMOD_Channel_SetMode ( channel -- )

\ FMOD_MODE
#define FMOD_DEFAULT  $00000000
#define FMOD_LOOP_OFF  $00000001
#define FMOD_LOOP_NORMAL  $00000002
#define FMOD_LOOP_BIDI  $00000004
#define FMOD_2D  $00000008
#define FMOD_3D  $00000010
#define FMOD_HARDWARE  $00000020
#define FMOD_SOFTWARE  $00000040
#define FMOD_CREATESTREAM  $00000080
#define FMOD_CREATESAMPLE  $00000100
#define FMOD_CREATECOMPRESSEDSAMPLE  $00000200
#define FMOD_OPENUSER  $00000400
#define FMOD_OPENMEMORY  $00000800
#define FMOD_OPENMEMORY_POINT  $10000000
#define FMOD_OPENRAW  $00001000
#define FMOD_OPENONLY  $00002000
#define FMOD_ACCURATETIME  $00004000
#define FMOD_MPEGSEARCH  $00008000
#define FMOD_NONBLOCKING  $00010000
#define FMOD_UNIQUE  $00020000
#define FMOD_3D_HEADRELATIVE  $00040000
#define FMOD_3D_WORLDRELATIVE  $00080000
#define FMOD_3D_LOGROLLOFF  $00100000
#define FMOD_3D_LINEARROLLOFF  $00200000
#define FMOD_3D_CUSTOMROLLOFF  $04000000
#define FMOD_3D_IGNOREGEOMETRY  $40000000
#define FMOD_CDDA_FORCEASPI  $00400000
#define FMOD_CDDA_JITTERCORRECT  $00800000
#define FMOD_UNICODE  $01000000
#define FMOD_IGNORETAGS  $02000000
#define FMOD_LOWMEM  $08000000
#define FMOD_LOADSECONDARYRAM  $20000000
#define FMOD_VIRTUAL_PLAYFROMSTART  $80000000


\ FMOD_INITFLAGS
\ #define FMOD_INIT_NORMAL                 $00000000 \ All platforms - Initialize normally */
\ #define FMOD_INIT_STREAM_FROM_UPDATE     $00000001 \ All platforms - No stream thread is created internally.  Streams are driven from System::update.  Mainly used with non-realtime outputs. */
\ #define FMOD_INIT_3D_RIGHTHANDED         $00000002 \ All platforms - FMOD will treat +X as right, +Y as up and +Z as backwards (towards you). */
\ #define FMOD_INIT_SOFTWARE_DISABLE       $00000004 \ All platforms - Disable software mixer to save memory.  Anything created with FMOD_SOFTWARE will fail and DSP will not work. */
\ #define FMOD_INIT_SOFTWARE_OCCLUSION     $00000008 \ All platforms - All FMOD_SOFTWARE with FMOD_3D based voices will add a software lowpass filter effect into the DSP chain which is automatically used when Channel::set3DOcclusion is used or the geometry API. */
\ #define FMOD_INIT_SOFTWARE_HRTF          $00000010 \ All platforms - All FMOD_SOFTWARE with FMOD_3D based voices will add a software lowpass filter effect into the DSP chain which causes sounds to sound duller when the sound goes behind the listener.  Use System::setAdvancedSettings to adjust cutoff frequency. */
\ #define FMOD_INIT_SOFTWARE_REVERB_LOWMEM $00000040 \ All platforms - SFX reverb is run using 22/24khz delay buffers, halving the memory required. */
\ #define FMOD_INIT_ENABLE_PROFILE         $00000020 \ All platforms - Enable TCP/IP based host which allows FMOD Designer or FMOD Profiler to connect to it, and view memory, CPU and the DSP network graph in real-time. */
\ #define FMOD_INIT_VOL0_BECOMES_VIRTUAL   $00000080 \ All platforms - Any sounds that are 0 volume will go virtual and not be processed except for having their positions updated virtually.  Use System::setAdvancedSettings to adjust what volume besides zero to switch to virtual at. */
\ }
\ #define FMOD_INIT_WASAPI_EXCLUSIVE       $00000100 \ Win32 Vista only - for WASAPI output - Enable exclusive access to hardware, lower latency at the expense of excluding other applications from accessing the audio hardware. */
\ {
\ #define FMOD_INIT_DSOUND_HRTFNONE        $00000200 \ Win32 only - for DirectSound output - FMOD_HARDWARE | FMOD_3D buffers use simple stereo panning/doppler/attenuation when 3D hardware acceleration is not present. */
\ #define FMOD_INIT_DSOUND_HRTFLIGHT       $00000400 \ Win32 only - for DirectSound output - FMOD_HARDWARE | FMOD_3D buffers use a slightly higher quality algorithm when 3D hardware acceleration is not present. */
\ #define FMOD_INIT_DSOUND_HRTFFULL        $00000800 \ Win32 only - for DirectSound output - FMOD_HARDWARE | FMOD_3D buffers use full quality 3D playback when 3d hardware acceleration is not present. */
\ #define FMOD_INIT_PS2_DISABLECORE0REVERB $00010000 \ PS2 only - Disable reverb on CORE 0 to regain 256k SRAM. */
\ #define FMOD_INIT_PS2_DISABLECORE1REVERB $00020000 \ PS2 only - Disable reverb on CORE 1 to regain 256k SRAM. */
\ #define FMOD_INIT_PS2_DONTUSESCRATCHPAD  $00040000 \ PS2 only - Disable FMOD's usage of the scratchpad. */
\ #define FMOD_INIT_PS2_SWAPDMACHANNELS    $00080000 \ PS2 only - Changes FMOD from using SPU DMA channel 0 for software mixing, and 1 for sound data upload/file streaming, to 1 and 0 respectively. */
\ #define FMOD_INIT_PS3_PREFERDTS          $00800000 \ PS3 only - Prefer DTS over Dolby Digital if both are supported. Note: 8 and 6 channel LPCM is always preferred over both DTS and Dolby Digital. */
\ #define FMOD_INIT_PS3_FORCE2CHLPCM       $01000000 \ PS3 only - Force PS3 system output mode to 2 channel LPCM. */
\ #define FMOD_INIT_XBOX_REMOVEHEADROOM    $00100000 \ Xbox only - By default DirectSound attenuates all sound by 6db to avoid clipping/distortion.  CAUTION.  If you use this flag you are responsible for the final mix to make sure clipping / distortion doesn't happen. */
\ #define FMOD_INIT_360_MUSICMUTENOTPAUSE  $00200000 \ Xbox 360 only - The "music" channelgroup which by default pauses when custom 360 dashboard music is played, can be changed to mute (therefore continues playing) instead of pausing, by using this flag. */
\ #define FMOD_INIT_SYNCMIXERWITHUPDATE    $00400000 \ Win32/Wii/PS3/Xbox/Xbox 360 - FMOD Mixer thread is woken up to do a mix when System::update is called rather than waking periodically on its own timer. */


\ {
\ FMOD_CREATESOUNDEXINFO
\   int  cbsize;
\   unsigned int  length;
\   unsigned int  fileoffset;
\   int  numchannels;
\   int  defaultfrequency;
\   FMOD_SOUND_FORMAT  format;
\   unsigned int  decodebuffersize;
\   int  initialsubsound;
\   int  numsubsounds;
\   int *  inclusionlist;
\   int  inclusionlistnum;
\   FMOD_SOUND_PCMREADCALLBACK  pcmreadcallback;
\   FMOD_SOUND_PCMSETPOSCALLBACK  pcmsetposcallback;
\   FMOD_SOUND_NONBLOCKCALLBACK  nonblockcallback;
\   const char *  dlsname;
\   const char *  encryptionkey;
\   int  maxpolyphony;
\   void *  userdata;
\   FMOD_SOUND_TYPE  suggestedsoundtype;
\   FMOD_FILE_OPENCALLBACK  useropen;
\   FMOD_FILE_CLOSECALLBACK  userclose;
\   FMOD_FILE_READCALLBACK  userread;
\   FMOD_FILE_SEEKCALLBACK  userseek;
\   FMOD_SPEAKERMAPTYPE  speakermap;
\   FMOD_SOUNDGROUP *  initialsoundgroup;
\   unsigned int  initialseekposition;
\   FMOD_TIMEUNIT  initialseekpostype;
\ }

0
enum    FMOD_OUTPUTTYPE_AUTODETECT      \ Picks the best output mode for the platform.  This is the default. */

enum    FMOD_OUTPUTTYPE_UNKNOWN         \ All                   - 3rd party plugin unknown.  This is for use with System::getOutput only. */
enum    FMOD_OUTPUTTYPE_NOSOUND         \ All                   - All calls in this mode succeed but make no sound. */
enum    FMOD_OUTPUTTYPE_WAVWRITER       \ All                   - Writes output to fmodoutput.wav by default.  Use the 'extradriverdata' parameter in System::init by simply passing the filename as a string to set the wav filename. */
enum    FMOD_OUTPUTTYPE_NOSOUND_NRT     \ All                   - Non-realtime version of FMOD_OUTPUTTYPE_NOSOUND.  User can drive mixer with System::update at whatever rate they want. */
enum    FMOD_OUTPUTTYPE_WAVWRITER_NRT   \ All                   - Non-realtime version of FMOD_OUTPUTTYPE_WAVWRITER.  User can drive mixer with System::update at whatever rate they want. */

enum    FMOD_OUTPUTTYPE_DSOUND          \ Win32/Win64           - DirectSound output.  Use this to get hardware accelerated 3d audio and EAX Reverb support. (Default on Windows) */
enum    FMOD_OUTPUTTYPE_WINMM           \ Win32/Win64           - Windows Multimedia output. */
enum    FMOD_OUTPUTTYPE_OPENAL          \ Win32/Win64           - OpenAL 1.1 output. Use this for lower CPU overhead than FMOD_OUTPUTTYPE_DSOUND and also Vista H/W support with Creative Labs cards. */
enum    FMOD_OUTPUTTYPE_WASAPI          \ Win32                 - Windows Audio Session API. (Default on Windows Vista) */
enum    FMOD_OUTPUTTYPE_ASIO            \ Win32                 - Low latency ASIO 2.0 driver. */
enum    FMOD_OUTPUTTYPE_OSS             \ Linux/Linux64/Solaris - Open Sound System output. (Default on Linux/Linux64/Solaris) */
enum    FMOD_OUTPUTTYPE_ALSA            \ Linux/Linux64         - Advanced Linux Sound Architecture output. */
enum    FMOD_OUTPUTTYPE_ESD             \ Linux/Linux64         - Enlightment Sound Daemon output. */
enum    FMOD_OUTPUTTYPE_SOUNDMANAGER    \ Mac                   - Macintosh SoundManager output. */
enum    FMOD_OUTPUTTYPE_COREAUDIO       \ Mac                   - Macintosh CoreAudio output.  (Default on Mac) */
enum    FMOD_OUTPUTTYPE_XBOX            \ Xbox                  - Native hardware output. (Default on Xbox) */
enum    FMOD_OUTPUTTYPE_PS2             \ PS2                   - Native hardware output. (Default on PS2) */
enum    FMOD_OUTPUTTYPE_PS3             \ PS3                   - Native hardware output. (Default on PS3) */
enum    FMOD_OUTPUTTYPE_GC              \ GameCube              - Native hardware output. (Default on GameCube) */
enum    FMOD_OUTPUTTYPE_XBOX360         \ Xbox 360              - Native hardware output. (Default on Xbox 360) */
enum    FMOD_OUTPUTTYPE_PSP             \ PSP                   - Native hardware output. (Default on PSP) */
enum   FMOD_OUTPUTTYPE_WII        \ Wii                  - Native hardware output. (Default on Wii) */
drop

cr .( FMOD 5.x )
