# Class: settings
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

class settings_ui {


  package {
        'nginx':
        ensure => installed;
                  }
				  
	if $::area == 'production' {
 file {
        '/etc/nginx/sites-available/settings.ignitionone.com':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_settings/settings.ignitionone.com");

  }
  } elsif $::area == 'development' {
 file {
    '/etc/nginx/sites-available/dev-settings.ignitionone.com':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_settings/dev-settings.ignitionone.com");
  } 
  } elsif $::area == 'qa' {
 file {
    '/etc/nginx/sites-available/qa-settings.ignitionone.com':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_settings/qa-settings.ignitionone.com");
  }
    } elsif $::area == 'uat' {
 file {
    '/etc/nginx/sites-available/uat-settings.ignitionone.com':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_settings/uat-settings.ignitionone.com");
  }
  }
		  

    file {

       '/etc/nginx/sites-available/ui-settings':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_settings/ui-settings");

     		
       '/etc/nginx/sites-available/nginx_status':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_settings/nginx_status");

          '/home/netmining/.ssh/my-new-ssh-key':
           owner  => 'netmining',
           group  => 'netmining',
           mode   => '0600',
           notify  => [Service['ssh'],Exec['npm install']],
           content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_settings/my-new-ssh-key");

           '/home/netmining/.ssh/my-new-ssh-key.pub':
           owner  => 'netmining',
           group  => 'netmining',
           mode   => '0644',
           notify  => [Service['ssh'],Exec['npm install']],
           content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_settings/my-new-ssh-key.pub");

           '/home/netmining/.ssh/known_hosts':
           owner  => 'netmining',
           group  => 'netmining',
           mode   => '0644',
           notify  => [Service['ssh']],
           content => template("${::puppet_dir_master}/systems/_LINUX_/etc/profile_settings/known_hosts");

        '/usr/local/bin/node':
                ensure => link,
                target => '/home/netmining/.nvm/versions/node/v0.12.7/bin/node';

        '/usr/local/bin/npm':
                ensure => link,
                target => '/home/netmining/.nvm/versions/node/v0.12.7/bin/npm';

        '/etc/nginx/sites-enabled/default':
                ensure  => 'absent';

        '/var/log/ui-settings/':
        ensure => directory,
        owner  => 'netmining',
        group  => 'netmining',
        mode   => '0755',

           }

exec { 'nginx config':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/ui-settings /etc/nginx/sites-enabled/ui-settings',
 creates => '/etc/nginx/sites-enabled/ui-settings'
     }

if $::area == 'production' {
 exec { 'nginx config settings.ignitionone.com':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/settings.ignitionone.com /etc/nginx/sites-enabled/settings.ignitionone.com',
 creates => '/etc/nginx/sites-enabled/settings.ignitionone.com'
     }
  } elsif $::area == 'development' {
 exec { 'nginx config dev-settings.ignitionone.com':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/dev-settings.ignitionone.com /etc/nginx/sites-enabled/dev-settings.ignitionone.com',
 creates => '/etc/nginx/sites-enabled/dev-settings.ignitionone.com'
     }
  } elsif $::area == 'qa' {
 exec { 'nginx config qa-settings.ignitionone.com':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/qa-settings.ignitionone.com /etc/nginx/sites-enabled/qa-settings.ignitionone.com',
 creates => '/etc/nginx/sites-enabled/qa-settings.ignitionone.com'
     }
  } elsif $::area == 'uat' {
 exec { 'nginx config uat-settings.ignitionone.com':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/uat-settings.ignitionone.com /etc/nginx/sites-enabled/uat-settings.ignitionone.com',
 creates => '/etc/nginx/sites-enabled/uat-settings.ignitionone.com'
     }
  }
  
	 
exec { 'nginx status':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/nginx_status /etc/nginx/sites-enabled/nginx_status',
 creates => '/etc/nginx/sites-enabled/nginx_status'
     }

exec { 'npm install':
  cwd     => '/opt/settings/',
  user    => 'netmining',
  group   => 'netmining',
  provider    => shell,
  #refreshonly => true,
       }

exec { 'git fetch --tags':
  cwd     => '/opt/settings/',
  user    => 'netmining',
  group   => 'netmining',
  provider    => shell,
  #refreshonly => true,
       }

exec { 'git stash':
  cwd     => '/opt/settings/',
  user    => 'netmining',
  group   => 'netmining',
  provider    => shell,
  #refreshonly => true,
       }

exec { 'supervisorctl restart settings-ui':
  cwd     => '/opt/settings/',
  user    => 'root',
  group   => 'root',
  provider    => shell,
  require => Exec['npm install'],
  #refreshonly => true,
       }

service { 'nginx':
          ensure     => running,
          enable     => true,
          hasrestart => true,
                }

}
