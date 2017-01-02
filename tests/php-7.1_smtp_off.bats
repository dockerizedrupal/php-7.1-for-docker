#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php-7.1_smtp_off.yml"

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

@test "php-7.1: smtp: off" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/postfix/main.cf | grep 'relayhost'"

  [ "${status}" -ne 0 ]
}
