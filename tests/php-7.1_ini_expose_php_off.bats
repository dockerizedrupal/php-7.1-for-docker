#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php-7.1_ini_expose_php_off.yml"

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

@test "php-7.1: ini: expose_php: off" {
  run docker exec "$(container)" /bin/su - root -mc "php -i | grep 'expose_php'"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"Off"* ]]
}
