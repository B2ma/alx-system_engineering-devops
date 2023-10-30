# This file uses puppet to configure nginx.
# Requirements:

# Nginx should be listening on port 80
# When querying Nginx at its root / with a GET request (requesting a page) using curl, it must return a page that contains the string Hello World!
# The redirection must be a “301 Moved Permanently”
# This file is a Puppet manifest containing commands to automatically configure an Ubuntu machine to respect above requirements

package { 'nginx':
  ensure => 'installed'
}

file { '/var/www/html/index.html':
  content => 'Hello World',
}

file_line { 'redirection-301':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/nginx/sites-available/default'],
}
