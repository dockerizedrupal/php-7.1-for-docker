class run::php70::ini::expose_php {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/expose_php.ini':
    ensure => present,
    content => template('run/php70/ini/expose_php.ini.erb'),
    mode => 644
  }
}
