# Class: display_ui_nvm
#
# This class pull nvm parameters
#
# Parameters:
#
# Actions:
#   - user
#   - install_node
#
# Requires:
#
# Sample Usage:
#

class display_ui_nvm {

 $displayui_config = hiera('displayui_config')

  class { 'nvm':
  user         => $displayui_config['user'],
  install_node => $displayui_config['install_node'],
        }

}
