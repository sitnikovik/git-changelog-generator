#!/usr/bin/bash

###> Colors ###
RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
YELLOW_COLOR='\033[0;33m'
CYAN_COLOR='\033[0;36m'
COLOR_OFF='\033[0m'
YELLOW_COLOR_BG='\033[43m'
###< Colors ###

###> Get git log history ###
OUTPUT_FILE="./CHANGELOG.md"
GIT_LOG="git log --pretty=format:\"%s\""

while [ -n "$1" ]
  do
    case "$1" in
    # Output file
    -o | --output)
      if [ ! "$2" ]; then
        echo -e "${RED_COLOR}ERROR${COLOR_OFF}: provide output file"
        exit 128
      else
        OUTPUT_FILE="$2"
      fi
      GIT_LOG="$GIT_LOG --since=$2"
      ;;
    # From date filter
    --from-date)
      if [ ! "$2" ]; then
        echo -e "${RED_COLOR}ERROR${COLOR_OFF}: provide date from in Y-m-d format"
        exit 128
      fi
      GIT_LOG="$GIT_LOG --since=$2"
      ;;
    # Up to date filter
    --to-date)
      if [ ! "$2" ]; then
        echo -e "${RED_COLOR}ERROR${COLOR_OFF}: provide date up to in Y-m-d format"
        exit 128
      fi
      GIT_LOG="$GIT_LOG --until=$2"
      ;;
    # Author filter
    --author)
      if [ ! "$2" ]; then
        echo -e "${RED_COLOR}ERROR${COLOR_OFF}: provide author name"
        exit 128
      fi
      GIT_LOG="$GIT_LOG --author=$2"
      ;;
    esac
  shift
done

GIT_LOG="$GIT_LOG > $OUTPUT_FILE"
eval "$GIT_LOG"
###< Get git log history ###
