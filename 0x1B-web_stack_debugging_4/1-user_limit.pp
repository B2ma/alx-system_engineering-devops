# Adjusting user file limits in the OS configuration

exec { 'Update hard file limit':
  command  => 'sudo sed -i \'s/nofile 5/nofile 30000/\' /etc/security/limits.conf',
  provider => shell,
}

exec { 'Update soft file limit':
  command  => 'sudo sed -i \'s/nofile 4/nofile 10000/\' /etc/security/limits.conf',
  provider => shell,
}
