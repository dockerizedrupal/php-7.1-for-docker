class run::php70::ini::allow_url_fopen {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/allow_url_fopen.ini':
    ensure => present,
    content => template('run/php70/ini/allow_url_fopen.ini.erb'),
    mode => 644
  }
}
