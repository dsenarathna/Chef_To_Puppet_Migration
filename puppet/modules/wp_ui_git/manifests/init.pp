# Class: wp_ui_git
#
# This class pull website-personalization repo from stash
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

class wp_ui_git {


 $wp_config = hiera('wp_config')

  puppetgit::repo { 'website-personalization':
    path                   => $wp_config['path'],
    source                 => $wp_config['source'],
    branch                 => $wp_config['branch'],
    git_tag                => $wp_config['git_tag'],
    owner                  => $wp_config['owner'],
    group                  => $wp_config['group'],
    mode                   => $wp_config['mode'],
    update                 => true,
    disable_host_key_check => true,
    host_key_domain        => 'stash.ignitionone.com'

        }


}
