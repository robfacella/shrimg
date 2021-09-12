#!/bin/bash
# Text to Speech of Whatever is selected&highlighted
xsel | festival --tts --pipe
# bound to:
# <WindowsKey>+<X>
