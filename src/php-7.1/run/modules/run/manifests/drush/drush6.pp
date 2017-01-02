class run::drush::drush6 {
  require run::user

  if $drush_version == '6' {
    file { '/usr/local/bin/drush':
      ensure => link,
      target => '/usr/local/src/drush6/drush'
    }

    file { '/etc/bash_completion.d/drush.complete.sh':
      ensure => link,
      target => '/usr/local/src/drush6/drush.complete.sh'
    }

    bash_exec { "chown -R -h $user_id /usr/local/src/drush6": }
    bash_exec { "chgrp -R -h $group_id /usr/local/src/drush6": }
  }
}
