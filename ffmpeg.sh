#!/bin/bash
ffmpeg -nostats -nostdin -hwaccel cuvid -y \
	-i - \
	-vf setsar=sar=1/1 \
		-f segment \
		-segment_time 3600 \
		-segment_atclocktime 1 \
		-strftime 1 \
		-reset_timestamps 1 \
		-c:v mpeg4 \
		-preset fast \
		-vtag xvid \
		-qscale:v 5 \
		-af "pan=mono|c0=c0,adelay=210|210" \
		-c:a libmp3lame \
		-qscale:a 3 \
		"/opptak/videoopptak_%F_%H:%M:%S.avi" \
	-vf setsar=sar=1/1 \
		-c:v libx264 \
		-preset fast \
		-pix_fmt yuv420p \
		-s 1280x800 \
		-g 100 \
		-strict -2 \
		-af "pan=mono|c0=c0,adelay=210|210" \
		-c:a aac \
		-b:a 160k \
		-ar 44100 \
		-threads 0 \
		-f flv \
		"rtmp://localhost/internt/live"
