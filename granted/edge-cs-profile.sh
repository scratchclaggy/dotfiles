#!/bin/sh
# Opens Edge using the first 'not default' profile... so the second profile.
exec "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" --profile-directory="Profile 1" "$@" 2>/dev/null
 
