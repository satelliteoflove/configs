#!/bin/bash
# Get the current appearance setting from MacOS
osascript -e 'tell app "System Events" to tell appearance preferences to return dark mode'
