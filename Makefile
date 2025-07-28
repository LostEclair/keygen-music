FFMPEG_EXE		:= ffmpeg
FFMPEG_FLAGS		:= -y -loglevel warning
FFMPEG_CONV_FLAGS	:= -vn -ar 44100 -ac 2 -acodec pcm_s16le
FFMPEG_OUTPUT_SUFFIX	:= .converted.wav

## All extensions
# TRACKER_FILES		:= $(shell find . -type f	\
# 				-iname "*.xm" -o	\
# 				-iname "*.mod" -o	\
# 				-iname "*.it" -o	\
# 				-iname "*.v2m" -o	\
# 				-iname "*.s3m" -o	\
# 				-iname "*.ahx" -o	\
# 				-iname "*.sid" -o	\
# 				-iname "*.ym" -o	\
# 				-iname "*.hsc" -o	\
# 				-iname "*.amd" -o	\
# 				-iname "*.rad" -o	\
# 				-iname "*.d00" -o	\
# 				-iname "*.nsf" -o	\
# 				-iname "*.mo3" -o	\
# 				-iname "*.bp" -o	\
# 				-iname "*.spc" -o	\
# 				-iname "*.mtm") -o	\
# 				-iname "*.sc68")

# Everything i've converted... (Make a pull request if you've found a way to convert more)
# ./configure [...] --enable-libopenmpt --enable-libmodplug [...]
TRACKER_FILES	:= $(shell find . -type f		\
				-iname "*.xm" -o	\
				-iname "*.mod" -o	\
				-iname "*.it" -o	\
				-iname "*.s3m" -o	\
				-iname "*.mo3" -o	\
				-iname "*.mtm")
WAV_FILES	:= $(addsuffix ${FFMPEG_OUTPUT_SUFFIX},$(TRACKER_FILES))

.PHONY: all clean

all: ${WAV_FILES}

clean:
	find . -type f -name "*${FFMPEG_OUTPUT_SUFFIX}" -delete

%.converted.wav: %
	${FFMPEG_EXE} ${FFMPEG_FLAGS} \
		-i "$<" ${FFMPEG_CONV_FLAGS} \
		"$@"
