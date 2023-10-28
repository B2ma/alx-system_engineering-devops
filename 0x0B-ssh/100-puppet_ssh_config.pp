# This puppet file is used to set up your client SSH configuration 
# file so that you can connect to a server without typing a password

file { '/etc/ssh/ssh_config':
  ensure  => 'file',
  content => "
    Host your_server_ip_address
      IdentityFile ~/.ssh/school
      PasswordAuthentication no
  ",
  mode    => '0600',
}
