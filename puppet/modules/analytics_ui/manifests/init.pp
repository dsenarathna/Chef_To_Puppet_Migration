# Class: analytics
#
# This class installs nvm,nodejs,nginx
#
# Parameters:
#
# Actions:
#   - Install nginx,runit
#   - Manage Nodejs
#
# Requires:
#
# Sample Usage:
#

class analytics_ui {

	if $::area == 'production' {
 file {
        '/etc/nginx/sites-available/analytics.ignitionone.com':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_analytics/analytics.ignitionone.com");

  }
  } elsif $::area == 'development' {
 file {
    '/etc/nginx/sites-available/dev-analytics.ignitionone.com':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_analytics/dev-analytics.ignitionone.com");
  }
  } elsif $::area == 'uat' {
 file {
    '/etc/nginx/sites-available/uat-analytics.ignitionone.com':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_analytics/uat-analytics.ignitionone.com");
  }
  }


    file {

       '/etc/nginx/sites-available/ui-analytics':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_analytics/ui-analytics");

						
        '/var/log/ui-analytics/':
        ensure => directory,
        owner  => 'netmining',
        group  => 'netmining',
        mode   => '0755',

           }

exec { 'nginx config ui-analytics':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/ui-analytics /etc/nginx/sites-enabled/ui-analytics',
 creates => '/etc/nginx/sites-enabled/ui-analytics'
     }
	 
    if $::area == 'production' {
 exec { 'nginx config analytics.ignitionone.com':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/analytics.ignitionone.com /etc/nginx/sites-enabled/analytics.ignitionone.com',
 creates => '/etc/nginx/sites-enabled/analytics.ignitionone.com'
     }
  } elsif $::area == 'development' {
 exec { 'nginx config dev-analytics.ignitionone.com':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/dev-analytics.ignitionone.com /etc/nginx/sites-enabled/dev-analytics.ignitionone.com',
 creates => '/etc/nginx/sites-enabled/dev-analytics.ignitionone.com'
     }
  } elsif $::area == 'uat' {
 exec { 'nginx config uat-analytics.ignitionone.com':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/uat-analytics.ignitionone.com /etc/nginx/sites-enabled/uat-analytics.ignitionone.com',
 creates => '/etc/nginx/sites-enabled/uat-analytics.ignitionone.com'
     }
  }


exec { 'nginx status ui-analytics ':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/nginx_status /etc/nginx/sites-enabled/nginx_status',
 creates => '/etc/nginx/sites-enabled/nginx_status'
     }

	   if ($::area == 'production') or ($::area == 'development') or ($::area == 'uat') {

exec { 'npm install ui-analytics ':
 command => 'npm install',
#path     => '/usr/bin:/usr/sbin:/bin',
 cwd      => '/opt/analytics-report-builder/', 
 user    => 'netmining',
 group   => 'netmining',
 provider    => shell,
     }


exec { 'git fetch --tags ui-analytics ':
 command => 'git fetch --tags',
#path     => '/usr/bin:/usr/sbin:/bin',
 cwd      => '/opt/analytics-report-builder/',
 user    => 'netmining',
 group   => 'netmining',
 provider    => shell,
     }

exec { 'git stash ui-analytics ':
 command => 'git stash',
#path     => '/usr/bin:/usr/sbin:/bin',
 cwd      => '/opt/analytics-report-builder/',
 user    => 'netmining',
 group   => 'netmining',
 provider    => shell,
     }


exec { 'supervisorctl restart analytics-ui':
  cwd     => '/opt/analytics-report-builder/',
  user    => 'root',
  group   => 'root',
  provider    => shell,
  require => Exec['npm install'],
  #refreshonly => true,
       }
}

}
