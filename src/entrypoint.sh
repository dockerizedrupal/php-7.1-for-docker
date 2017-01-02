#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/php-7.1/build.sh && /src/php-7.1/clean.sh"
    ;;
  run)
    /bin/su - root -mc "source /src/php-7.1/variables.sh && /src/php-7.1/run.sh"
    ;;
esac
