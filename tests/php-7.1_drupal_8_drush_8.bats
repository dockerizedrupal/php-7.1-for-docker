#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php-7.1_drupal_8_drush_8.yml"

container() {
  echo "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps php | grep php | awk '{ print $1 }')"
}

setup_drupal() {
  docker exec "$(container)" /bin/su - container -lc "wget http://ftp.drupal.org/files/projects/drupal-8.1.10.tar.gz -O /tmp/drupal-8.1.10.tar.gz"
  docker exec "$(container)" /bin/su - container -lc "tar xzf /tmp/drupal-8.1.10.tar.gz -C /tmp"
  docker exec "$(container)" /bin/su - container -lc "rsync -avz /tmp/drupal-8.1.10/ /apache/data"
  docker exec "$(container)" /bin/su - container -lc "cp /apache/data/sites/default/default.services.yml /apache/data/sites/default/services.yml"
  docker exec "$(container)" /bin/su - container -lc "drush -r /apache/data -y site-install --db-url=mysqli://container:container@localhost/drupal --account-name=admin --account-pass=admin"
  docker exec "$(container)" /bin/su - container -lc "chown container.container /apache/data"
}

setup() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up -d

  sleep 20

  setup_drupal
}

teardown() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" kill
  docker-compose -f "${DOCKER_COMPOSE_FILE}" rm --force
}

@test "php-7.1: drupal 8" {
  run docker exec "$(container)" /bin/su - root -mc "drush -r /apache/data/ status | grep 'Drupal bootstrap'"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"Successful"* ]]
}

@test "php-7.1: drupal 8: drush 8" {
  run docker exec "$(container)" /bin/su - root -mc "drush --version"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"8.1.3"* ]]
}

@test "php-7.1: drupal 8: phpcs" {
  run docker exec "$(container)" /bin/su - root -mc "phpcs --version"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"2.3.0"* ]]
}

@test "php-7.1: drupal 8: phpcs: phpcompatibility" {
  run docker exec "$(container)" /bin/su - root -mc "phpcs -i | grep 'PHPCompatibility'"

  [ "${status}" -eq 0 ]
}

@test "php-7.1: drupal 8: phpcs: drupal" {
  run docker exec "$(container)" /bin/su - root -mc "phpcs -i | grep 'Drupal'"

  [ "${status}" -eq 0 ]
}
