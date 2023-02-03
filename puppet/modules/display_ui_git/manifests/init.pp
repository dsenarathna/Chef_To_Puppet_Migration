# Class: display_ui_git
#
# This class pull display-management repo from stash
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

class display_ui_git {


 $displayui_config = hiera('displayui_config')

  puppetgit::repo { 'display-management':
    path                   => $displayui_config['path'],
    source                 => $displayui_config['source'],
    branch                 => $displayui_config['branch'],
    git_tag                => $displayui_config['git_tag'],
    owner                  => $displayui_config['owner'],
    group                  => $displayui_config['group'],
    mode                   => $displayui_config['mode'],
    update                 => true,
    disable_host_key_check => true,
    host_key_domain        => 'stash.ignitionone.com'

        }
              

}
