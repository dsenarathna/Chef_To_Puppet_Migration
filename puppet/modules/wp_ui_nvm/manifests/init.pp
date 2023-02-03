# Class: wp_ui_nvm
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

class wp_ui_nvm {

 $wp_config = hiera('wp_config')

  class { 'nvm':
  user         => $wp_config['user'],
  install_node => $wp_config['install_node'],
        }

}
