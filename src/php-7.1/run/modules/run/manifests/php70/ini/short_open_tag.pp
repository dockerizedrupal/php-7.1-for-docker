class run::php70::ini::short_open_tag {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/short_open_tag.ini':
    ensure => present,
    content => template('run/php70/ini/short_open_tag.ini.erb'),
    mode => 644
  }
}
