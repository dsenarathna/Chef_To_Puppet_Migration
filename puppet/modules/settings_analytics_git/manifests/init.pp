# Class: settings_analytics_git
#
# This class pull repo from stash
#
# Parameters:
#
# Actions:
#   - git pull
#   - git tag
#
# Requires:
#
# Sample Usage:
#

class settings_analytics_git {


 $profiles_settings = hiera('profiles_settings')

  puppetgit::repo { 'settings':
    path                   => $profiles_settings['path'],
    source                 => $profiles_settings['source'],
    branch                 => $profiles_settings['branch'],
    git_tag                => $profiles_settings['git_tag'],
    owner                  => $profiles_settings['owner'],
    group                  => $profiles_settings['group'],
    mode                   => $profiles_settings['mode'],
    update                 => true,
    disable_host_key_check => true,
    host_key_domain        => 'stash.ignitionone.com'

        }

  $profiles_analytics = hiera('profiles_analytics')

  puppetgit::repo { 'analytics-report-builder':
    path                   => $profiles_analytics['path'],
    source                 => $profiles_analytics['source'],
    branch                 => $profiles_analytics['branch'],
    git_tag                => $profiles_analytics['git_tag'],
    owner                  => $profiles_analytics['owner'],
    group                  => $profiles_analytics['group'],
    mode                   => $profiles_analytics['mode'],
    update                 => true,
#   disable_host_key_check => true,
    host_key_domain        => 'stash.ignitionone.com'

        }

}
