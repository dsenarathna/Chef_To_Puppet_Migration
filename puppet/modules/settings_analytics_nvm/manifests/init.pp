# Class: settings_analytics_nvm
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

class settings_analytics_nvm {

 $profiles_settings = hiera('profiles_settings')

  class { 'nvm':
  user         => $profiles_settings['user'],
  install_node => $profiles_settings['install_node'],
        }

# $profiles_analytics = hiera('profiles_analytics')

#  class { 'nvm':
#  user         => $profiles_analytics['user'],
# install_node => $profiles_analytics['install_node'],
#        }
}
