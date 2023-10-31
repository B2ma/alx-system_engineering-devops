# This file uses puppet to configure nginx.
# Requirements:

# Nginx should be listening on port 80
# When querying Nginx at its root / with a GET request (requesting a page) using curl, it must return a page that contains the string Hello World!
# The redirection must be a “301 Moved Permanently”
# This file is a Puppet manifest containing commands to automatically configure an Ubuntu machine to respect above requirements

# Check if Nginx is installed, if not, install it
if ! Package['nginx'] {
  package { 'nginx':
    ensure => 'installed',
  }
}

# Define a class for Nginx configuration
class { 'nginx':
  package_manage => false, # Prevent Puppet from managing the package again
  service_manage => true,
  service_enable => true,
}

nginx::resource::vhost { 'default':
  listen_port => '80',
  proxy      => 'false',
  rewrite    => [
    '^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent',
  ],
  error_page => {
    '404' => '/404.html',
  },
  location   => {
    '/' => {
      try_files => '$uri $uri/ =404',
    },
  },
}

file { '/usr/share/nginx/html/404.html':
  ensure  => file,
  content => "Ceci n'est pas une page\n",
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Nginx::Resource::Vhost['default'],
}

