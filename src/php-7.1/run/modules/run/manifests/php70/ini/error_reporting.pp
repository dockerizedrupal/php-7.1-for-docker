class run::php70::ini::error_reporting {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/error_reporting.ini':
    ensure => present,
    content => template('run/php70/ini/error_reporting.ini.erb'),
    mode => 644
  }
}
