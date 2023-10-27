# This code uses Puppet to install flask from pip3
# Requirements:
# Install flask
# Version must be 2.1.0
# Install Flask 2.1.0 using pip3
exec { 'install_flask':
  command => 'pip3 install Flask==2.1.0',
  path    => ['/usr/bin'],
  unless  => 'pip3 show Flask | grep Version | grep -q 2.1.0',
}

# Install Werkzeug 2.1.1 using pip3
exec { 'install_werkzeug':
  command => 'pip3 install Werkzeug==2.1.1',
  path    => ['/usr/bin'],
  unless  => 'pip3 show Werkzeug | grep Version | grep -q 2.1.1',
}


