#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php-7.1_ini_short_open_tag_on.yml"

container() {
  echo "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps php | grep php | awk '{ print $1 }')"
}

setup() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up -d

  sleep 20
}

teardown() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" kill
  docker-compose -f "${DOCKER_COMPOSE_FILE}" rm --force
}

@test "php-7.1: ini: short_open_tag: on" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/src/phpfarm/inst/current/etc/conf.d/short_open_tag.ini | grep 'short_open_tag'"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"On"* ]]
}
