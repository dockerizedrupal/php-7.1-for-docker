# php-7.1-for-docker

A Docker image for [PHP](http://php.net/) version 7.0 that runs PHP in FPM (FastCGI Process Manager) mode.

## Run the container

    CONTAINER="apache-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v $(pwd):/apache/data \
      --entrypoint /bin/echo \
      dockerizedrupal/apache-2.4:2.0.0 "Data-only container for Apache."

    CONTAINER="php" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      --volumes-from apache-data \
      -e SERVER_NAME="localhost" \
      -e TIMEZONE="Etc/UTC" \
      -e DRUPAL_VERSION="8" \
      -e DRUSH_VERSION="8" \
      -e SMTP_HOST="" \
      -e SMTP_PORT="25" \
      -e SMTP_FROM= \
      -e SMTP_USERNAME="" \
      -e SMTP_PASSWORD="" \
      -e MYSQL_HOST="" \
      -e MYSQL_PORT="3306" \
      -e MYSQL_MAX_ALLOWED_PACKET="512M" \
      -e MEMCACHED_HOST="" \
      -e MEMCACHED_PORT="11211" \
      -e REDIS_HOST="" \
      -e REDIS_PORT="6379" \
      -e PHP_INI_REALPATH_CACHE_SIZE="256k" \
      -e PHP_INI_REALPATH_CACHE_TTL="3600" \
      -e PHP_INI_POST_MAX_SIZE="512M" \
      -e PHP_INI_TIMEZONE="UTC" \
      -e PHP_INI_UPLOAD_MAX_FILESIZE="512M" \
      -e PHP_INI_SHORT_OPEN_TAG="On" \
      -e PHP_INI_MAX_EXECUTION_TIME="300" \
      -e PHP_INI_MAX_INPUT_VARS="4096" \
      -e PHP_INI_MEMORY_LIMIT="512M" \
      -e PHP_INI_DISPLAY_ERRORS="On" \
      -e PHP_INI_DISPLAY_STARTUP_ERRORS="On" \
      -e PHP_INI_ERROR_REPORTING="E_ALL" \
      -e PHP_INI_EXPOSE_PHP="On" \
      -e PHP_INI_ALLOW_URL_FOPEN="On" \
      -e PHP_INI_OPCACHE="On" \
      -e PHP_INI_OPCACHE_MEMORY_CONSUMPTION="2048" \
      -e PHP_INI_XDEBUG="On" \
      -e PHP_INI_XDEBUG_REMOTE_PORT="9000" \
      -e PHP_INI_XDEBUG_REMOTE_HOST="127.0.0.1" \
      -e PHP_INI_XDEBUG_REMOTE_CONNECT_BACK="On" \
      -e PHP_INI_XDEBUG_IDEKEY="PHPSTORM" \
      -e PHP_INI_XDEBUG_VAR_DISPLAY_MAX_DEPTH="5" \
      -e PHP_INI_MEMCACHED="On" \
      -e PHP_INI_REDIS="On" \
      -e PHP_INI_BLACKFIRE="On" \
      -e PHP_INI_BLACKFIRE_SERVER_ID="" \
      -e PHP_INI_BLACKFIRE_SERVER_TOKEN="" \
      -e PHP_INI_SYS_TEMP_DIR="" \
      -e PHP_INI_APCU="On" \
      -e PHP_INI_APD="On" \
      -e PHP_FPM_PM="dynamic" \
      -e PHP_FPM_PM_MAX_CHILDREN="5" \
      -e PHP_FPM_PM_START_SERVERS="2" \
      -e PHP_FPM_PM_MIN_SPARE_SERVERS="1" \
      -e PHP_FPM_PM_MAX_SPARE_SERVERS="3" \
      -e PHP_FPM_PM_PROCESS_IDLE_TIMEOUT="10s" \
      -e PHP_FPM_PM_MAX_REQUESTS="0" \
      -e CRON="On" \
      -e CRONTAB_1_MAILTO="" \
      -e CRONTAB_1_EXPRESSION="" \
      -e CRONTAB_1_COMMAND="" \
      -e USER_ID="" \
      -e GROUP_ID="" \
      -d \
      dockerizedrupal/php-7.1:2.0.0

    CONTAINER="apache" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from apache-data \
      --link php:php \
      -d \
      dockerizedrupal/apache-2.4:2.0.0

## Build the image

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 2.0.0 \
      && sudo docker build -t dockerizedrupal/php-7.1:2.0.0 . \
      && cd -

## Tests

Tests are implemented in [Bats: Bash Automated Testing System](https://github.com/sstephenson/bats).

### Test results for the current release

    1..89
    ok 1 php-7.1
    ok 2 php-7.1: cron: off
    ok 3 php-7.1: cron: CRONTAB_1_MAILTO: off
    ok 4 php-7.1: cron: CRONTAB_1_EXPRESSION: off
    ok 5 php-7.1: cron: CRONTAB_1_COMMAND: off
    ok 6 php-7.1: cron: CRONTAB_2_MAILTO: off
    ok 7 php-7.1: cron: CRONTAB_2_EXPRESSION: off
    ok 8 php-7.1: cron: CRONTAB_2_COMMAND: off
    ok 9 php-7.1: cron: CRONTAB_3_MAILTO: off
    ok 10 php-7.1: cron: CRONTAB_3_EXPRESSION: off
    ok 11 php-7.1: cron: CRONTAB_3_COMMAND: off
    ok 12 php-7.1: cron: on
    ok 13 php-7.1: cron: CRONTAB_1_MAILTO: on
    ok 14 php-7.1: cron: CRONTAB_1_EXPRESSION: on
    ok 15 php-7.1: cron: CRONTAB_1_COMMAND: on
    ok 16 php-7.1: cron: CRONTAB_2_MAILTO: on
    ok 17 php-7.1: cron: CRONTAB_2_EXPRESSION: on
    ok 18 php-7.1: cron: CRONTAB_2_COMMAND: on
    ok 19 php-7.1: cron: CRONTAB_3_MAILTO: on
    ok 20 php-7.1: cron: CRONTAB_3_EXPRESSION: on
    ok 21 php-7.1: cron: CRONTAB_3_COMMAND: on
    ok 22 php-7.1: drupal 7
    ok 23 php-7.1: drupal 7: drush 5
    ok 24 php-7.1: drupal 7: phpcs
    ok 25 php-7.1: drupal 7: phpcs: phpcompatibility
    ok 26 php-7.1: drupal 7: phpcs: drupal
    ok 27 php-7.1: drupal 7
    ok 28 php-7.1: drupal 7: drush 6
    ok 29 php-7.1: drupal 7: phpcs
    ok 30 php-7.1: drupal 7: phpcs: phpcompatibility
    ok 31 php-7.1: drupal 7: phpcs: drupal
    ok 32 php-7.1: drupal 7
    ok 33 php-7.1: drupal 7: drush 7
    ok 34 php-7.1: drupal 7: phpcs
    ok 35 php-7.1: drupal 7: phpcs: phpcompatibility
    ok 36 php-7.1: drupal 7: phpcs: drupal
    ok 37 php-7.1: drupal 8: drupal console
    ok 38 php-7.1: drupal 8
    ok 39 php-7.1: drupal 8: drush 8
    ok 40 php-7.1: drupal 8: phpcs
    ok 41 php-7.1: drupal 8: phpcs: phpcompatibility
    ok 42 php-7.1: drupal 8: phpcs: drupal
    ok 43 php-7.1: fpm: pm
    ok 44 php-7.1: fpm: pm.max_children
    ok 45 php-7.1: fpm: pm.max_requests
    ok 46 php-7.1: fpm: pm.max_spare_servers
    ok 47 php-7.1: fpm: pm.min_spare_servers
    ok 48 php-7.1: fpm: pm.process_idle_timeout
    ok 49 php-7.1: fpm: pm.start_servers
    ok 50 php-7.1: ini: allow_url_fopen: off
    ok 51 php-7.1: ini: allow_url_fopen: on
    ok 52 php-7.1: ini: blackfire: off
    ok 53 php-7.1: ini: blackfire: on
    ok 54 php-7.1: ini: blackfire.server_id
    ok 55 php-7.1: ini: blackfire.server_token
    ok 56 php-7.1: ini: display_errors: off
    ok 57 php-7.1: ini: display_errors: on
    ok 58 php-7.1: ini: display_startup_errors: off
    ok 59 php-7.1: ini: display_startup_errors: on
    ok 60 php-7.1: ini: error_reporting
    ok 61 php-7.1: ini: expose_php: off
    ok 62 php-7.1: ini: expose_php: on
    ok 63 php-7.1: ini: igbinary: on
    ok 64 php-7.1: ini: max_execution_time
    ok 65 php-7.1: ini: max_input_vars
    ok 66 php-7.1: ini: memcached: off
    ok 67 php-7.1: ini: memcached: on
    ok 68 php-7.1: ini: memory_limit
    ok 69 php-7.1: ini: opcache.memory_consumption
    ok 70 php-7.1: ini: opcache: off
    ok 71 php-7.1: ini: opcache: on
    ok 72 php-7.1: ini: post_max_size
    ok 73 php-7.1: ini: realpath_cache_size
    ok 74 php-7.1: ini: realpath_cache_ttl
    ok 75 php-7.1: ini: redis: off
    ok 76 php-7.1: ini: redis: on
    ok 77 php-7.1: ini: short_open_tag: off
    ok 78 php-7.1: ini: short_open_tag: on
    ok 79 php-7.1: ini: timezone
    ok 80 php-7.1: ini: upload_max_filesize
    ok 81 php-7.1: ini: xdebug.idekey
    ok 82 php-7.1: ini: xdebug: off
    ok 83 php-7.1: ini: xdebug: on
    ok 84 php-7.1: ini: xdebug.remote_connect_back: off
    ok 85 php-7.1: ini: xdebug.remote_connect_back: on
    ok 86 php-7.1: ini: xdebug.remote_host
    ok 87 php-7.1: ini: xdebug.remote_port
    ok 88 php-7.1: smtp: off
    ok 89 php-7.1: smtp: on

## License

**MIT**
