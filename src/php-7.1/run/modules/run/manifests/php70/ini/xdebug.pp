class run::php70::ini::xdebug {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/xdebug.ini':
    ensure => present,
    content => template('run/php70/ini/xdebug.ini.erb'),
    mode => 644
  }
}
