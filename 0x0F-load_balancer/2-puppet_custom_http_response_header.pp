- This automate the task of creating a custom HTTP header response, but with Puppet.

- The name of the custom HTTP header must be X-Served-By
- The value of the custom HTTP header must be the hostname of the server Nginx is running on
package { 'nginx':
  ensure => installed,
}

file { '/var/www/html/index.html':
  content => 'Hello world!',
}

file { '/var/www/html/404.html':
  content => "Ceci n'est pas une page",
}

exec { 'set_nginx_header':
  command => '/bin/bash -c "echo \"X-Served-By $HOSTNAME;\" > /etc/nginx/sites-available/default"',
  notify  => Service['nginx'],
  require => Package['nginx'],
}

file { '/etc/nginx/sites-available/default':
  content => @(EOF),
    server {
        listen 80 default_server;
        listen [::]:80 default_server;
        add_header X-Served-By $HOSTNAME;
        root   /var/www/html;
        index  index.html index.htm;

        location /redirect_me {
            return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
        }

        error_page 404 /404.html;

        location /404 {
            root /var/www/html;
            internal;
        }
    }
    EOF
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure => running,
  enable => true,
}
