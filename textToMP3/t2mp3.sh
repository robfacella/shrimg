# requirements:
# text2wave 	(from apt install festival)
# ffmpeg 	(from apt install ffmpeg)

#text2wave test.txt -o test.wav
# No output file set on text2wave pipes to stdout
text2wave test.txt | ffmpeg -i pipe:0 -acodec mp3 test.mp3
# ffmpeg input flag of pipe:0 pulls stdout in (pipe:1 would be stdout)
# set acodec to mp3 and an outputFile
# it threw a warning but seems to have worked fine

# the test.wav would take up 134.8kB
# whereas test.mp3 takes up   13.1kB

# piping the data skips a disk write, in theory
