#Increase the Nginx requests per minute

exec { 'nginx_fix':
  command => "sed -i 's/15/10000/' /etc/nginx/nginx.conf && sudo service nginx restart",
  path    => ['/bin', '/usr/bin', '/usr/sbin']
}
