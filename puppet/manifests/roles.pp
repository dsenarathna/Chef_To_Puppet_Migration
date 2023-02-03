# Manifest: roles.pp
#
# This manifest file defines all the roles
#
class role_admin {
  motd::register { 'admin': }
  include freetds
  dyn_include { 'service::collectd::admin': tag => 'collectd' }
  dyn_include { 'service::logstash::admin': tag => 'logstash' }
  dyn_include { 'service::tools::admin': tag => 'tools' }

  if $::webserver == 'apache2' {
    include service::apache::admin
    include service::apache::general
  } elsif $::webserver == 'nginx' {
    include service::nginx::admin
    include service::nginx::general
  }

  if ! $::role_failover {
    include service::geoip
    include service::javascript::library
    include service::legacy::php
    include service::mysql::general
    include phpmyadmin
    include service::mysql::table_backup
    include service::opt::admin
    include service::opt::apache
    include service::php::general
    include service::php::library
    include service::php::modules::evo
    include service::php::modules::frameworks
    include service::php::subversion
    include service::php::web
    include service::test_environment
    include service::yii
  }
}

class role_admin_drlinux {
  include service::opt::drlinux
  include service::supervisor::general
  dyn_include { 'projects::clickthroughtest': }
  dyn_include { 'subversion::repos': }
  dyn_include { 'users::development': tag => 'account' }
}

class role_admin_nan {
  motd::register { 'admin DISPLAY': }
  include service::php::admin_display
  include gsutil
  include service::nan_crons
  include service::smarttags

  if $::area == 'staging' or $::area == 'production' {
    include service::nan_devops
  }
}

class role_admin_onsite {
  motd::register { 'admin ONSITE': }
  include service::clients
  include service::demostore
  include service::gor::general
  include service::nan::admin
  include service::nan_crons
  include service::php::admin_onsite
  include service::profilefrontclient::php
  include service::supervisor::general
  include service::supervisor::exportq_worker
  include service::supervisor::process_exporter_worker
  include service::supervisor::prepare-exporter-worker
  include service::supervisor::exporter_worker
  include projects::onsite
  include projects::wp_libs
  include service::exportq
  include service::mysql::general
  include phpmyadmin
  dyn_include { 'legacy::evo5::contacts_processor': }
  dyn_include { 'legacy::evo5::export': }
  dyn_include { 'legacy::evo5::statistics': }
  dyn_include { 'projects::export_logger': }
  dyn_include { 'projects::exportq_export_worker': }
  dyn_include { 'service::tools::admin::onsite': tag => 'tools' }
  dyn_include { 'systems::projects::yourls': }

  if ! $::role_web_onsite {
    dyn_include { 'service::php::core': tag => 'php::modules::core' }
  }
}

class role_admin_systems {
  motd::register { 'admin SYSTEMS': }
  dyn_include { 'service::tools::admin::systems': tag => 'tools' }

  if ! $::role_failover {
    dyn_include { 'systems::projects::monitor': }
  }
}

class role_activemq {
  motd::register { 'ActiveMQ': }
  include service::activemq::general
  dyn_include { 'service::collectd::activemq': tag => 'collectd' }
}
class role_adstxt {
  motd::register { 'adstxt': }
  include service::adstxt::general
}
class role_aerospike {
  motd::register { 'aerospike': }
  #dyn_include { 'service::logstash::aerospike': tag => 'logstash' }
  include service::aerospike::general
}

class role_3rdparty {
  motd::register { '3rdparty': }
  include 3rdparty
}

class role_ac2_storm {
  motd::register { 'ac2_Storm': }
}

class role_ac2_storm_control {
  motd::register { 'AC2 Storm Control': }
  include java::jdk8
  class {
    'storm_nuevo':
      storm_ui     => true,
      storm_nimbus => true;
   }
  supervisor::conf { 'storm-nimbus-uat': }
  supervisor::conf { 'storm-ui': }
  include service::logstash::storm
}

class role_ac2_storm_worker {
  motd::register { 'AC2 Storm Worker': }
  include java::jdk8
  class {
    'storm_nuevo':
      storm_supervisor     => true,
      storm_logviewer      => true;
   }
  supervisor::conf { 'storm-supervisor': }
  supervisor::conf { 'storm-logviewer': }
  include service::logstash::storm
}

class role_app_dc_afu {
  motd::register { 'DC Feed Update': }
  dyn_include { 'projects::dynamic_creative::auto_feed_update': tag => 'projects::dynamic_creative' }
  dyn_include { 'service::collectd::dc_afu': tag => 'collectd' }
  dyn_include { 'users::dct': tag => 'account' }
}

class role_app_dc_ira {
  motd::register { 'DC Image Resizing': }
  dyn_include { 'projects::dynamic_creative::image_resizing': tag => 'projects::dynamic_creative' }
  dyn_include { 'service::collectd::dc_ira': tag => 'collectd' }
  dyn_include { 'users::dct': tag => 'account' }
}

class role_app_dc_pfa {
  motd::register { 'DC Feed API': }
  dyn_include { 'projects::dynamic_creative::feed_api': tag => 'projects::dynamic_creative' }
  dyn_include { 'service::collectd::dc_pfa': tag => 'collectd' }
  dyn_include { 'users::dct': tag => 'account' }
}

class role_app_streamsets {
  motd::register { 'role_app_streamsets': }
  include sdc
}

class role_app_mcrouter {
  motd::register { 'MC Router': }
  dyn_include { 'service::collectd::mcrouter': tag => 'collectd' }
  dyn_include { 'service::mcrouter::display': tag => 'mcrouter' }
}

class role_apt_repo {
  include apt::repo
}

class role_bitbucket {
  include bitbucket
}

class role_build {
  include glassfish
  include java::sun
  if $::webserver == 'apache2' {
    include service::apache::general
  } elsif $::webserver == 'nginx' {
    include service::nginx::general
  }
  include service::php::general
  include service::php::library
  include service::php::modules::evo
  include service::php::modules::frameworks
  dyn_include { 'users::development': tag => 'account' }
}

class role_cassandra {
  motd::register { 'Cassandra': }
  include service::cassandra::general
  include service::sysfs::cassandra
  dyn_include { 'service::collectd::cassandra': tag => 'collectd' }
  dyn_include { 'service::logstash::cassandra': tag => 'logstash' }
  dyn_include { 'users::cassandra': tag => 'account' }
}

class role_cassandra3 {
  hiera_include('classes')
  motd::register { 'Cassandra 3': }
  dyn_include { 'service::collectd::cassandra3': tag => 'collectd' }
  dyn_include { 'service::logstash::cassandra': tag => 'logstash' }

}

class role_cassandra_dmp {
  motd::register { 'Cassandra - DMP': }
  include role_cassandra
}

class role_cfengine {
  motd::register { 'CFengine master': }
  include root::subversion
  include service::javascript::library
  include service::opt::apache
  include service::opt::bind
  include service::php::subversion
  include service::php::web
}

class role_chef {
  motd::register { 'Chef': }
  include service::chef
}

class role_columnfive {
  include projects::columnfive
  dyn_include { 'users::ftp::columnfive': tag => 'account' }
  dyn_include { 'groups::ftp': tag => 'account' }
}

class role_com {
  motd::register { 'ProfileFront': }
  include service::profilefront
  include service::redis::profilefront
  include service::supervisor::general
  dyn_include { 'service::collectd::profilefront': tag => 'collectd' }
  dyn_include { 'service::logstash::com': tag => 'logstash' }
  dyn_include { 'users::profilefront': tag => 'account' }
}

class role_com_c {
  dyn_include { 'service::collectd::com_c': tag => 'collectd' }
  dyn_include { 'service::memcached::profilefront': tag => 'memcached' }
}

class role_com_r {
  include role_com
}

class role_com_w {
  include role_com
}

class role_controlroom {
  include service::cake
  dyn_include { 'projects::controlroom': }
  dyn_include { 'users::controlroom': tag => 'account' }
}

class role_couchbase {
  motd::register { 'role_couchbase': }
  include couchbase
}

class role_docker_registry {
  motd::register { 'role_docker_registry': }
  include docker_registry
}

class role_docker_build {
  motd::register { 'role_docker_build': }
  include docker_build
}

class role_dns {
  dyn_include { 'bind::server':  tag => 'bind' }
  include service::opt::bind
}

class role_dns_master {
  motd::register { 'DNS master': }
  include role_dns
}

class role_dns_master_slave {
  motd::register { 'DNS master slave': }
  include role_dns
}

class role_dns_slave {
  motd::register { 'DNS slave': }
  include role_dns
}

class role_elasticsearch_dms {
  motd::register { 'Elasticsearch': }
  dyn_include { 'service::limits::elasticsearch': tag => 'limits' }
  if $::area == 'production' or $::area == 'staging' {
	dyn_include { 'users::graylog': tag => 'account' }
  }
  include service::elasticsearch::dms
}

class role_elasticsearch_sharedservices {
  motd::register { 'Elasticsearch': }
  dyn_include { 'service::limits::elasticsearch': tag => 'limits' }
  dyn_include { 'users::graylog': tag => 'account' }
  include service::elasticsearch::sharedservices
}


class role_elasticsearch_shared {
  motd::register { 'Elasticsearch': }
  dyn_include { 'service::limits::elasticsearch': tag => 'limits' }
  dyn_include { 'users::graylog': tag => 'account' }
  include service::elasticsearch::shared
}

class role_elasticsearch_tracking {
  motd::register { 'Elasticsearch': }
  dyn_include { 'service::limits::elasticsearch': tag => 'limits' }
  if $::area == 'production' or $::area == 'staging' {
	dyn_include { 'users::graylog': tag => 'account' }
  }
  include service::elasticsearch::tracking
}

class role_emr {
  motd::register {'EMR':}
  include emr
}

class role_exelate {
  dyn_include { 'users::ftp::exelate': tag => 'account' }
  dyn_include { 'groups::ftp': tag => 'account' }
  include service::profilefrontclient::php
}

class role_failover {
  include service::nginx::failover
  include service::nginx::general
}
class role_foreman {
  include foreman::frontend
  dyn_include { 'service::memcached::foreman': tag => 'memcached' }
}
class role_foreman_admin {
  include foreman::appserver
}
class role_foremanmc {
  dyn_include { 'service::memcached::foreman': tag => 'memcached' }
}
class role_foreman_proxy {
  motd::register { 'foreman-proxy': }
  include foreman::proxy
}

class role_gearman_worker {
  dyn_include { 'gearman::worker': tag => 'gearman' }
}

class role_graylog_server_systems {
  motd::register { 'Elasticsearch': }
  motd::register { 'Graylog server': }

  dyn_include { 'service::elasticsearch::systems': tag => 'elasticsearch' }
  dyn_include { 'service::graylog::server::systems': tag => 'graylog' }
  dyn_include { 'service::limits::elasticsearch': tag => 'limits' }
  dyn_include { 'service::collectd::graylog': tag => 'collectd' }
}

class role_graylog_server_wdc {
  motd::register { 'Elasticsearch': }
  motd::register { 'Graylog server': }

  dyn_include { 'service::elasticsearch::wdc': tag => 'elasticsearch' }
  dyn_include { 'service::graylog::server::wdc': tag => 'graylog' }
  dyn_include { 'service::limits::elasticsearch': tag => 'limits' }
  dyn_include { 'service::collectd::graylog': tag => 'collectd' }
}

class role_graylog_server_dms {
  motd::register { 'Graylog server': }
  dyn_include { 'service::graylog::server::dms': tag => 'graylog' }
  dyn_include { 'users::graylog': tag => 'account' }
}

class role_graylog_server_sharedservices {
  motd::register { 'Graylog server': }
  dyn_include { 'service::graylog::server::sharedservices': tag => 'graylog' }
  dyn_include { 'users::graylog': tag => 'account' }
}

class role_graylog_server_tracking {
  motd::register { 'Graylog server': }
  dyn_include { 'service::graylog::server::tracking': tag => 'graylog' }
  dyn_include { 'users::graylog': tag => 'account' }
}

class role_graylog_web_systems {
  motd::register { 'Graylog web': }
  dyn_include { 'service::graylog::web::systems': tag => 'graylog' }
}

class role_graylog_web_wdc {
  motd::register { 'Graylog web': }
  dyn_include { 'service::graylog::web::wdc': tag => 'graylog' }
}

class role_graylog_web_dms {
  motd::register { 'Graylog web': }
  if $::area == 'production' or $::area == 'staging' {
	dyn_include { 'users::graylog': tag => 'account' }
  }
  dyn_include { 'service::graylog::web::dms': tag => 'graylog' }
}

class role_graylog_web_sharedservices {
  motd::register { 'Graylog web': }
  dyn_include { 'users::graylog': tag => 'account' }
  dyn_include { 'service::graylog::web::sharedservices': tag => 'graylog' }
}


class role_graylog_web_tracking {
  motd::register { 'Graylog web': }
  if $::area == 'production' or $::area == 'staging' {
	dyn_include { 'users::graylog': tag => 'account' }
  }
  dyn_include { 'service::graylog::web::tracking': tag => 'graylog' }
}

class role_hadoop {
  dyn_include { 'users::ftp::hadoop': tag => 'account' }
  dyn_include { 'groups::ftp': tag => 'account' }
}

class role_icinga {
  motd::register { 'icinga': }
  dyn_include { 'icinga': }
}

class role_icinga_master {
  dyn_include { 'icinga2::master': tag => 'icinga' }
}

class role_icinga_satellite {
  dyn_include { 'icinga2::satellite': tag => 'icinga' }
}

class role_kafka {
  motd::register { 'kafka': }
  include users::kafka
  include service::kafka::general
  include service::supervisor::general
  include service::supervisor::kafka
  include service::supervisor::kafka::rest
  include service::supervisor::kafka::mirror
  dyn_include { 'service::collectd::kafka': tag => 'collectd' }
}

class role_kafka2 {
  motd::register { 'kafka2': }
  include kafka2
  dyn_include { 'service::collectd::kafka': tag => 'collectd' }
}

class role_kafka2_zookeeper {
  motd::register { 'kafka2_zookeeper': }
  include kafka2::zookeeper
  dyn_include { 'service::collectd::zookeeper': tag => 'collectd' }
}

class role_kafkaoffsetmonitor {
  motd::register { 'Kafkaoffsetmonitor': }
  include service::supervisor::general
  include service::supervisor::kafkaoffsetmonitor
  include kafkaoffsetmonitor
}

class role_ldap {
  motd::register { 'Joined to SI Domain': }
  include ldap
}

class role_loadbalancer {
  motd::register { 'Load Balancer': }
  include lua
  include nginxkeepalived
  include service::firewall::loadbalancer
  include service::limits::nginxplus
  include service::nginx::loadbalancer
  dyn_include { 'users::loadbalancer': tag => 'account' }
  dyn_include { 'service::collectd::nginx-pools': tag => 'collectd' }
}

class role_loadbalancer_nofw {
  motd::register { 'Load Balancer': }
  include lua
  include nginxkeepalived
  include service::limits::nginxplus
  include service::nginx::loadbalancer
  dyn_include { 'users::loadbalancer': tag => 'account' }
  dyn_include { 'service::collectd::nginx-pools': tag => 'collectd' }
}

class role_awsloadbalancer {
  motd::register { 'Load Balancer': }
  include service::limits::nginxplus
  dyn_include { 'service::collectd::nginx-pools': tag => 'collectd' }
  nginxplus::ca {
        'GeoTrust_G3':;
         'gd_bundle-g2-g1':;
        }

  nginxplus::ssl {
        'netmining.com':
          ca => 'gd_bundle-g2-g1';
        'netmng.com':
          ca => 'gd_bundle-g2-g1';
        'ignitionone.com':
          ca => 'gd_bundle-g2-g1';
  }

  nginxplus::conf { 'lb.conf': }
  class {
        'nginxplus':
          worker_connections => 32767,
          worker_priority    => 0,
          worker_processes   => 'auto',
          ssl_truncation     => false,
  }

}

class role_openresty_loadbalancer {
  $openresty_config = hiera('openresty_config')
  $keepalived_enable = hiera('keepalived_enable', true)

  motd::register { 'Openresty Load Balancer': }

  # clean up nginxplus collectd config
  # when converting from nginxplus to openresty
  if $openresty_config['nginxplus_migrate'] {
    file {'/etc/collectd/plugins/nginx-pools.conf':
      ensure => absent,
      force  => true,
      notify => Service['collectd'];
    }
  }
  # open file limits
  include service::limits::nginxplus
  # certificate authority
  openresty::ca {
    'GeoTrust_G3':;
    'gd_bundle-g2-g1':;
  }
  # ssl
  openresty::ssl {
    'netmining.com':
      ca => 'gd_bundle-g2-g1';
    'netmng.com':
      ca => 'gd_bundle-g2-g1';
    'ignitionone.com':
      ca => 'gd_bundle-g2-g1';
  }
  # pull lua modules from stash
  puppetgit::repo { 'nginx-lua-metrics':
    path                   => '/opt/nginx-lua-metrics',
    source                 => 'ssh://git@stash.ignitionone.com:7999/devops/nginx-lua-metrics.git',
    branch                 => 'master',
    owner                  => 'root',
    group                  => 'nginx',
    mode                   => '0644',
    update                 => true,
    disable_host_key_check => true,
    host_key_domain        => 'stash.ignitionone.com'
  }
  # openresty
  include openresty
  # collectd
  include service::collectd::openresty-pools
  # keepalived
  if "${keepalived_enable}" == "true" {
    include keepalived
  }
}

class role_awsactiveloadbalancer {
  motd::register { 'Active/Active Load Balancer': }
  include service::limits::nginxplus
  include nginxkeepalived
  dyn_include { 'service::collectd::nginx-pools': tag => 'collectd' }
  nginxplus::ca {
        'GeoTrust_G3':;
         'gd_bundle-g2-g1':;
        }

  nginxplus::ssl {
        'netmining.com':
          ca => 'gd_bundle-g2-g1';
        'netmng.com':
          ca => 'gd_bundle-g2-g1';
        'ignitionone.com':
          ca => 'gd_bundle-g2-g1';
  }

  nginxplus::conf { 'lb.conf': }
  class {
        'nginxplus':
          worker_connections => 32767,
          worker_priority    => 0,
          worker_processes   => 'auto',
          ssl_truncation     => false,
  }

}

class role_loadbalancer_haproxy {
  motd::register { 'Load Balancer': }
  include service::nginx::haproxy
  include service::haproxy::onsite
  include logrotate
  logrotate::conf {
		'nginx':
		  configfile => 'nginx';
	  }
}
class role_logshipper {
  dyn_include { 'service::logstash::logshipper': tag => 'logstash' }
}

class role_mailman {
  motd::register { 'Mailman': }
  include service::mailman
}

class role_microstrategy {
  motd::register {'Microstrategy': }
  include microstrategy
}

class role_microstrategy-ui {
  motd::register {'Microstrategy-UI': }
  include microstrategy-ui
}

class role_mongodb {
  include service::mongodb::searchsocial
}

class role_nan_dms {
  motd::register { 'nan_dms': }
  include service::cake
  include service::nan_dms
  include service::php::dms

  if $::fqdn == 'vadmin-001.us-atl.ignitionone.com' {
	include service::dynamicinsights
	include service::yearofhealth
  }
}

class role_nan_tools {
  motd::register { 'nan_tools': }
  include service::php::nan_tools
  include service::nan_tools
}

class role_netacuity {
  include service::netacuity
}



class role_neo4j {
  motd::register { 'neo4j': }
  dyn_include { 'service::limits::neo4j': tag => 'limits' }
  include neo4j
}

class role_openam {
  motd::register { 'Tomcat7 OpenAM': }
  include service::openam
}

class role_proxy {
  if $::webserver == 'apache2' {
	include service::apache::proxy
  } elsif $::webserver == 'nginx' {
	include service::nginx::proxy
  }
  include service::javascript::library
  include service::opt::apache
  include service::php::web
  dyn_include { 'projects::controlroom::proxy':  tag => 'projects::controlroom' }
  dyn_include { 'systems::projects::proxy': }
  dyn_include { 'systems::projects::yourls::proxy': tag => 'systems::projects::yourls' }
}

class role_puppetmaster {
  motd::register { 'puppetmaster': }
  include puppet::master
  include service::rsync
  
}

class role_rabbitmq {
  motd::register { 'RabbitMQ': }
  include service::rabbitmq::searchsocial
#  dyn_include { 'service::collectd::rabbitmq': tag => 'collectd' }
}

class role_redis {
  motd::register { 'Redis': }
  if $::division == 'searchignite' {
	include service::redis::searchsocial
  } elsif $::role_admin_onsite {
	include service::redis::adminonsite
  } elsif $::fqdn == 'vapp-redis-001.nl-ams.ignitionone.com' {
	include service::redis::onsite
  } elsif $::fqdn == 'vapp-redis-onsite-001.nl-ams.ignitionone.com' {
	include service::redis::onsite
  } elsif $::fqdn == 'store-001.us-wdc.ignitionone.com' {
	include service::redis::3rdparty
  }
  dyn_include { 'service::collectd::redis': tag => 'collectd' }
}

class role_rserver {
  motd::register { 'Rserver': }
  include rserver
  include service::mongodb::general
  dyn_include { 'projects::mmmhome': }
  dyn_include { 'projects::rserver': }
  dyn_include { 'users::datascientists': tag => 'account' }
}

class role_rstudio {
  motd::register { 'Rstudio': }
  include rstudio
}

class role_samba {
  include samba
  dyn_include { 'users::samba': tag => 'account' }
}

class role_stash {
  motd::register { 'Atlassian Stash': }
  include service::apache::general
  include service::apache::proxy
  include service::stash
}

class role_statsd {
  dyn_include { 'service::carbon::statsd': tag => 'carbon' }
  dyn_include { 'service::statsd::general': tag => 'statsd' }
}

class role_store {
  motd::register { 'store': }
  include freetds

  if $::division == 'netmining' {
    include ramdisk
    include service::geoip::maxmind
    include service::nan_crons
    include service::opt::apache
    include service::php::library
    include service::php::modules::evo
    include service::php::modules::frameworks
    include service::rtbd::dirs
    include service::supervisor::general
    dyn_include { 'service::collectd::store': tag => 'collectd' }
    dyn_include { 'service::logstash::store': tag => 'logstash' }
    dyn_include { 'service::memcached::store': tag => 'memcached' }

  if ! $::role_cassandra {
    if $::webserver == 'apache2' {
      include service::apache::general
    } elsif $::webserver == 'nginx' {
      include service::nginx::general
    }

      include service::mysql::store
      include service::mysql::table_backup
      include service::php::general
      include service::php::display_store
    }
  }
}

class role_storm_nimbus {
  include service::storm::nimbus
  include service::supervisor::storm::nimbus
  include service::logstash::storm
  include users::storm
}

class role_storm_redis {
  include service::redis::storm
  include service::logstash::storm
  dyn_include { 'service::collectd::redis': tag => 'collectd' }
  if ! $::role_worker {
	include service::supervisor::general
	dyn_include { 'service::nmqd::worker': tag => 'projects::nmqd' }
  }
}

class role_storm_supervisor {
  include service::storm::supervisor
  include service::supervisor::storm::supervisor
  include service::logstash::storm
  include users::storm
}

class role_storm_zookeeper {
  include service::zookeeper::kafka
  dyn_include { 'service::collectd::zookeeper': tag => 'collectd' }
}

class role_subversion {
  motd::register { 'subversion': }
  if $::webserver == 'apache2' {
	include service::apache::subversion
  } elsif $::webserver == 'nginx' {
	include service::nginx::subversion
  }
  dyn_include { 'subversion': }
}

class role_web {
  include ramdisk
  if $::webserver == 'apache2' {
	include service::apache::general
	include service::apache::web
  } elsif $::webserver == 'nginx' {
	include service::nginx::general
  }
  include service::geoip::maxmind
  include service::gor::general
  include service::javascript::library
  include service::legacy::php
  include service::opt::apache
  include service::php::general
  include service::php::library
  include service::php::modules::evo
  include service::php::modules::frameworks
  include service::php::web
  include service::profilefrontclient::php
  include service::supervisor::general
  dyn_include { 'freetds': }
  dyn_include { 'service::collectd::web': tag => 'collectd' }
  dyn_include { 'service::tools::web': tag => 'tools' }
}

class role_web_2waycm {
  motd::register { 'web 2waycm': }
  if $::webserver == 'apache2' {
    include service::apache::general
    include service::apache::web
  } elsif $::webserver == 'nginx' {
    include service::nginx::general
    include service::nginx::web_nan
  }
  include ramdisk
  include service::geoip::maxmind
  include service::gor::general
  include service::javascript::library
  include service::legacy::php
  include service::opt::apache
  include service::php::general
  include service::php::library
  include service::php::modules::evo
  include service::php::modules::frameworks
  include service::php::web
  include service::profilefrontclient::php
  include service::supervisor::general
  dyn_include { 'freetds': }
  dyn_include { 'service::collectd::web': tag => 'collectd' }
  dyn_include { 'service::tools::web': tag => 'tools' }
  include service::legacy::hil5_core_nan
  include service::mysql::general
  include phpmyadmin
  include service::mysql::table_backup
  include service::nan_crons
  include service::nan::data
  include service::php::display
  include service::unibidder::nan
  dyn_include { 'service::collectd::web_nan': tag => 'collectd' }
  dyn_include { 'service::collectd::2waycm': tag => 'collectd' }
  dyn_include { 'service::logstash::web_nan': tag => 'logstash' }
  dyn_include { 'service::memcached::web_nan': tag => 'memcached' }
}

class role_web_ad {
  motd::register { 'web AD': }
  include role_web
  include service::html5dct
  include service::legacy::hil5_core_nan
  include service::mysql::general
  include phpmyadmin
  include service::mysql::table_backup
  include service::nan_crons
  include service::nan::ad
  include service::php::display
  dyn_include { 'service::collectd::web_ad': tag => 'collectd' }
  dyn_include { 'service::logstash::web_ad': tag => 'logstash' }
  dyn_include { 'service::memcached::web_ad': tag => 'memcached' }
  dyn_include { 'service::nmqd::ad': tag => 'projects::nmqd' }

  if $::webserver == 'nginx' {
	include service::nginx::general
	include service::nginx::web_ad
  }
}

class role_web_jad {
  motd::register { 'web JAD': }
  if ! $::role_web_ad {
	include role_web
	include phpmyadmin
	include service::html5dct
	include service::legacy::hil5_core_nan
	include service::memcached::web_ad
	include service::mysql::general
	include service::mysql::table_backup
	include service::nan::ad
	include service::nan_crons
	include service::supervisor::general
	dyn_include { 'service::collectd::web_ad': tag => 'collectd' }
	dyn_include { 'service::logstash::web_ad': tag => 'logstash' }
	dyn_include { 'service::memcached::web_ad': tag => 'memcached' }
	dyn_include { 'service::nmqd::ad': tag => 'projects::nmqd' }

  }
}

class role_web_brp {
  motd::register { 'web BRP': }
  include role_web
  include service::nan_crons
  include service::php::web_rtb
  include service::unibidder::brp
  dyn_include { 'service::memcached::rtb': tag => 'memcached' }
}

class role_web_cdn {
  motd::register { 'web CDN': }
  include role_web
  include service::cdn
  include service::nginx::web_cdn
}

class role_web_dc {
  motd::register { 'web DC': }
  dyn_include { 'projects::dynamic_creative::core': tag => 'projects::dynamic_creative' }
  dyn_include { 'service::collectd::dc_core': tag => 'collectd' }
  dyn_include { 'service::logstash::web_dc': tag => 'logstash' }
  dyn_include { 'users::dct': tag => 'account' }
  if $::area == 'staging' {
	dyn_include { 'users::dct_staging': tag => 'account' }
  }
}
class role_web_display_tools {
  motd::register { 'web Display Tools': }
  include service::nginx::general
  include service::gor::general
  include service::javascript::library
  include service::legacy::php
  include service::php::general
  include service::php::library
  include service::php::modules::evo
  include service::php::modules::frameworks
  include service::php::web
  include service::profilefrontclient::php
}

class role_web_jrtb {

  motd::register { 'web jRTB': }
  include ramdisk
  include service::rtb_throttle
  include service::rtbd
  include service::rtbd::dirs
  include service::nan_crons
  include service::nginx::web_jrtb
  include service::gor::general
  include service::javascript::library
  include service::php::general
  include service::php::library
  include service::php::modules::evo
  include service::php::modules::frameworks
  include service::supervisor::general
  dyn_include { 'service::collectd::web': tag => 'collectd' }
  dyn_include { 'service::tools::web': tag => 'tools' }
  dyn_include { 'service::collectd::web_rtb': tag => 'collectd' }
  dyn_include { 'service::logstash::web_jrtb': tag => 'logstash' }
  dyn_include { 'service::nmqd::rtb': tag => 'projects::nmqd' }
}

class role_web_mobile_rtb {
  motd::register { 'web mobile RTB': }
  include mobile
}

class role_php56 {
  include service::php::php56
}

class role_web_nan {
  motd::register { 'web NAN': }
  include role_web
  include service::html5dct
  include service::legacy::hil5_core_nan
  include service::mysql::general
  include phpmyadmin
  include service::mysql::table_backup
  include service::nan_crons
  include service::nan::data
  include service::php::display
  include service::unibidder::nan
  dyn_include { 'service::collectd::web_nan': tag => 'collectd' }
  dyn_include { 'service::logstash::web_nan': tag => 'logstash' }
  dyn_include { 'service::memcached::web_nan': tag => 'memcached' }
  dyn_include { 'service::nmqd::nan': tag => 'projects::nmqd' }

  if $::webserver == 'nginx' {
	include service::nginx::general
	include service::nginx::web_nan
  }
}

class role_web_onsite {
  motd::register { 'web ONSITE': }
  include freetds
  include geoip
  include role_web
  include service::php::web_onsite
  include service::clients
  include service::geoip
  include service::mysql::table_backup
  include service::mysql::general
  include phpmyadmin
  include service::nan_crons
  include projects::onsite
  include projects::wp_libs
  include service::exportq
  include service::javascript::library
  include service::mail
  include service::php::general
  include service::php::library
  include service::php::modules::evo
  include service::php::modules::frameworks
  include service::php::web_onsite
  include service::profilefrontclient::php

  if $::webserver == 'apache2' {
	include service::apache::general
	include service::apache::web
  } elsif $::webserver == 'nginx' {
	include service::nginx::general
	include service::nginx::web_onsite
  }

  dyn_include { 'service::logstash::web_onsite': tag => 'logstash' }
  dyn_include { 'service::php::core': tag => 'php::modules::core' }
  dyn_include { 'service::tools::web::onsite': tag => 'tools' }
}

class role_web_rtb {

  motd::register { 'web RTB': }
  if ! $::role_web_jrtb {
	include role_web
	include service::nan_crons
	include service::php::display
	include service::php::web_rtb
	include service::rtb_throttle
	include service::rtbd::dirs
	include service::unibidder::rtb
	dyn_include { 'service::collectd::web_rtb': tag => 'collectd' }
	dyn_include { 'service::logstash::web_rtb': tag => 'logstash' }
	dyn_include { 'service::memcached::rtb': tag => 'memcached' }
	dyn_include { 'service::nmqd::rtb': tag => 'projects::nmqd' }

	if $::webserver == 'nginx' and $::fqdn != 'vdev-002.us-atl.ignitionone.com' {
	  include service::nginx::web_rtb
	} elsif $::webserver == 'nginx' and $::fqdn == 'vdev-002.us-atl.ignitionone.com' {
	  include service::nginx::admin
	  include service::displayapi
	  include service::nan_devops
	}
  }
}

class role_worker {
  motd::register { 'nmqd-worker': }
  include ramdisk
  include service::nan_crons
  if $::webserver == 'apache2' {
	include service::apache::general
  } elsif $::webserver == 'nginx' {
	include service::nginx::general
	include service::nginx::web_rtb
  }
  include service::mysql::general
  include phpmyadmin
  include service::php::display
  include service::php::general
  include service::php::library
  include service::php::modules::evo
  include service::php::modules::frameworks
  include service::php::worker
  include service::supervisor::general
  include service::supervisor::nmqd_stats
  include service::supervisor::nmqd_worker
  include service::unibidder::rtb
  dyn_include { 'service::collectd::worker': tag => 'collectd' }
  dyn_include { 'service::nmqd::worker': tag => 'projects::nmqd' }
}

class role_worker_admin {
  motd::register { 'nmqd-admin': }
  dyn_include { 'service::nmqd::worker_admin': tag => 'projects::nmqd' }
}

class role_worker_stats {
  motd::register { 'nmqd-stats': }
  dyn_include { 'service::nmqd::worker_queue': tag => 'projects::nmqd' }
  include service::supervisor::nmqd_stats
}

class role_worker_queue {
  motd::register { 'nmqd-queue': }
  include ramdisk
  include service::nan_crons
  if $::webserver == 'apache2' {
	include service::apache::general
  } elsif $::webserver == 'nginx' {
	include service::nginx::general
	include service::nginx::web_rtb
  }
  include service::php::display
  include service::php::worker
  include service::php::general
  include service::php::library
  include service::php::modules::evo
  include service::php::modules::frameworks
  dyn_include { 'service::nmqd::worker_queue': tag => 'projects::nmqd' }
}

class role_wp_api {
  motd::register { 'WP API': }
  include git
  include nodejs
  include service::nginx::general
  include service::nginx::admin
  include service::mysql::general
  include phpmyadmin
  include subversion
  include service::php::core
  include service::php::general
  include service::php::library
  include service::php::modules::evo
  include service::php::wp_api
  include projects::mat
  include projects::wp_libs
}

class role_zookeeper {
  motd::register { 'zookeeper': }
  include users::zookeeper
}

class role_secor {
  motd::register { 'secor': }
  include service::supervisor::general
  include service::supervisor::secor
  include service::secor
}

class role_j2waycm {
  motd::register { 'j2waycm': }
  include service::gor::general
  include service::nan_crons
  dyn_include { 'service::collectd::j2waycm': tag => 'collectd' }
  include users::2waycm
  include service::j2waycm::general
}

class role_jenkins_server {
  motd::register { 'Jenkins Server': }
  include service::jenkins::server
}

class role_jenkins_worker {
 motd::register { 'Jenkins Worker': }
  include jenkins_worker
}

class role_preview_engine {
  motd::register { 'preview_engine': }
  include users::preview_engine
  include service::preview_engine::general
}

class role_kafkautils {
  motd::register { 'kafkautils': }
  include kafkautils
}

class role_samhain {
  include samhain
}

class role_yule {
  motd::register { 'Yule (log) Server': }
  include yule
}

class role_duo {
  motd::register { 'DUO Two-Factor Authentication Enabled': }
  include duo_unix
}

class role_harden {
  motd::register {'Hardened': }
  include harden
}

class role_creativegallery_netmining {
  motd::register {'Creative Gallery - Netmining': }
  include creativegallery
  include users::creativegallery
}

class role_creativegallery_ignitionone {
  motd::register {'Creative Gallery - Ignitionone': }
  include creativegallery
  include users::creativegallery
}

class role_self_service_api {
  motd::register { 'Display SOA API': }
  include service::self-service-api::general
}

class role_mpcw {
	motd::register { 'Model Processor Cache Warmer': }
	include mpcw
}

class role_continuum {
  motd::register { 'VersionOne Continuum': }
}

class role_openvas {
}

class role_redis_fcap {
motd::register { 'Redis_fcap': }
  include service::redis5::fcap
  dyn_include { 'service::collectd::redis5': tag => 'collectd' }
}

class role_analytics {
  motd::register { 'Vapp-Analytics': }
}

class role_vapp_wordpress {
  motd::register { 'WordPress APP': }
    include service::apache2_4::general
  }
  
  class role_wordpress_db {
  motd::register { 'Wordpress_DB': }
  include service::mysql5_7::general
}

class role_wordpress_admin {
motd::register { 'Wordpress_Admin': }
  include service::wordpress_admin::general
}

class role_wordpress_node {
motd::register { 'Wordpress_Node': }
  include service::wordpress_node::general
}

class role_wordpress_lb {
motd::register { 'Wordpress_LB': }
  include service::wordpress_lb::general
}

class role_display_ui {
  motd::register { 'display_ui': }
	
	  include ::stdlib
	  include display_ui_nvm
	  include nvm
	  include display_ui
	  include display_ui_git
	  
    if $::area == 'production' {
	supervisor::conf { 'display-ui': }
  } elsif $area == 'development' {
    supervisor::conf { 'display-ui-dev': }
  } elsif $area == 'qa' {
    supervisor::conf { 'display-ui-qa': }
  }			
}
	
class role_profile_settings_analytics {
  motd::register { 'profile_settings_analytics': }

          include ::stdlib
          include settings_analytics_nvm
          include nvm
          include settings_ui
          include analytics_ui
          include settings_analytics_git

    if $::area == 'production' {
        supervisor::conf { 'settings-ui': }
        supervisor::conf { 'analytics-ui': }
  } elsif $area == 'development' {
        supervisor::conf { 'settings-ui-dev': }
        supervisor::conf { 'analytics-ui-dev': }
  } elsif $area == 'qa' {
        supervisor::conf { 'settings-ui-qa': }
        
  } elsif $area == 'uat' {
        supervisor::conf { 'settings-ui-uat': }
        supervisor::conf { 'analytics-ui-uat': }
        
  }
}

class role_wp_ui {
  motd::register { 'wp_ui': }

          include ::stdlib
          include wp_ui_nvm
          include nvm
          include wp_ui
          include wp_ui_git

    if $::area == 'production' {
        supervisor::conf { 'wp-ui': }
  } elsif $area == 'development' {
    supervisor::conf { 'wp-ui-dev': }
  } elsif $area == 'qa' {
    supervisor::conf { 'wp-ui-qa': }
  }
}

	
 class role_api_display {
 include service::vdev-php::general
 }
