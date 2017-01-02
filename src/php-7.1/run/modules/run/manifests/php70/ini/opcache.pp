class run::php70::ini::opcache {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/opcache.ini':
    ensure => present,
    content => template('run/php70/ini/opcache.ini.erb'),
    mode => 644
  }
}
