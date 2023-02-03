# Class: display_ui
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

class display_ui {


  package {
        'nginx':
        ensure => installed;
		  }

    file {

       '/etc/nginx/sites-available/ui-display-management':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
	    content => template("${::puppet_dir_master}/systems/_LINUX_/etc/display_ui/ui-display-management");

	  
       '/etc/nginx/sites-available/nginx_status':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify  => [Service['nginx']],
	    content => template("${::puppet_dir_master}/systems/_LINUX_/etc/display_ui/nginx_status");
	  
	  '/home/netmining/.ssh/my-new-ssh-key':
	   owner  => 'netmining',
	   group  => 'netmining',
	   mode   => '0600',
	   notify  => [Service['ssh'],Exec['npm install']],
	   content => template("${::puppet_dir_master}/systems/_LINUX_/etc/display_ui/my-new-ssh-key");
	   
	   '/home/netmining/.ssh/my-new-ssh-key.pub':
	   owner  => 'netmining',
	   group  => 'netmining',
	   mode   => '0644',
	   notify  => [Service['ssh'],Exec['npm install']],
	   content => template("${::puppet_dir_master}/systems/_LINUX_/etc/display_ui/my-new-ssh-key.pub");
	   
	   '/home/netmining/.ssh/known_hosts':
	   owner  => 'netmining',
	   group  => 'netmining',
	   mode   => '0644',
	   notify  => [Service['ssh']],
	   content => template("${::puppet_dir_master}/systems/_LINUX_/etc/display_ui/known_hosts");

        '/usr/local/bin/node':
                ensure => link,
                target => '/home/netmining/.nvm/versions/node/v6.11.4/bin/node';

        '/usr/local/bin/npm':
                ensure => link,
                target => '/home/netmining/.nvm/versions/node/v6.11.4/bin/npm';

        '/etc/nginx/sites-enabled/default':
                ensure  => 'absent';
				
	    '/var/log/display-ui/':
		ensure => directory,
        owner  => 'netmining',
        group  => 'netmining',
        mode   => '0755',

           }
		   
exec { 'nginx config':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/ui-display-management /etc/nginx/sites-enabled/ui-display-management',
 creates => '/etc/nginx/sites-enabled/ui-display-management'
     }
 
exec { 'nginx status':
 path     => '/usr/bin:/usr/sbin:/bin',
 command => 'ln -s /etc/nginx/sites-available/nginx_status /etc/nginx/sites-enabled/nginx_status',
 creates => '/etc/nginx/sites-enabled/nginx_status'
     }

exec { 'npm install':
  cwd     => '/opt/display-management/',
  user    => 'netmining',
  group   => 'netmining',
  provider    => shell,
  #refreshonly => true,
       }

exec { 'git fetch --tags':
  cwd     => '/opt/display-management/',
  user    => 'netmining',
  group   => 'netmining',
  provider    => shell,
  #refreshonly => true,
       }
	   
exec { 'git stash':
  cwd     => '/opt/display-management/',
  user    => 'netmining',
  group   => 'netmining',
  provider    => shell,
  #refreshonly => true,
       }

exec { 'supervisorctl restart display-ui':
  cwd     => '/opt/display-management/',
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
