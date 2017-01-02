class run::coder {
  require run::user

  if $drupal_version == '7' {
    file { '/home/container/.drush/coder':
      ensure => link,
      target => '/usr/local/src/coder7'
    }

    file { '/usr/local/src/PHP_CodeSniffer_1/CodeSniffer/Standards/Drupal':
      ensure => link,
      target => '/usr/local/src/coder7/coder_sniffer/Drupal'
    }

    bash_exec { "chown -R -h $user_id /usr/local/src/coder7": }
    bash_exec { "chgrp -R -h $group_id /usr/local/src/coder7": }

    bash_exec { "chown -R -h $user_id /usr/local/src/PHP_CodeSniffer_1": }
    bash_exec { "chgrp -R -h $group_id /usr/local/src/PHP_CodeSniffer_1": }
  }
  elsif $drupal_version == '8' {
    file { '/home/container/.drush/coder':
      ensure => link,
      target => '/usr/local/src/coder8'
    }

    file { '/usr/local/src/PHP_CodeSniffer_2/CodeSniffer/Standards/Drupal':
      ensure => link,
      target => '/usr/local/src/coder8/coder_sniffer/Drupal'
    }

    bash_exec { "chown -R -h $user_id /usr/local/src/coder8": }
    bash_exec { "chgrp -R -h $group_id /usr/local/src/coder8": }

    bash_exec { "chown -R -h $user_id /usr/local/src/PHP_CodeSniffer_2": }
    bash_exec { "chgrp -R -h $group_id /usr/local/src/PHP_CodeSniffer_2": }
  }
}
