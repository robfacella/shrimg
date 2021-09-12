#from poppler-utils
#pdf2txt input.pdf - instead of output file to send to stdout
#pdftotext test.pdf -
#pipe stdout to text2wave and pipe to mp3
pdftotext test.pdf - | text2wave | ffmpeg -i pipe:0 -y -acodec mp3 test.mp3
