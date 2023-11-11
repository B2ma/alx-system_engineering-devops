# This automate the task of creating a custom HTTP header response, but with Puppet.

# The name of the custom HTTP header must be X-Served-By
# The value of the custom HTTP header must be the hostname of the server Nginx is running on
exec { 'configure_nginx':
  command => '/bin/bash -c "
    apt-get update && apt-get install -y nginx &&
    echo \"Hello world!\" > /var/www/html/index.html &&
    echo \"Ceci n'est pas une page\" > /var/www/html/404.html &&
    cat > /etc/nginx/sites-available/default << EOF
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
    service nginx restart
  "',
}
