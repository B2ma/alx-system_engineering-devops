#Using Puppet, create a manifest that kills a process named killmenow.

#Requirements:

#	Must use the exec Puppet resource
#	Must use pkill
exec { 'process kill killmenow':
  path    => '/usr/bin/',
  command => 'pkill -f killmenow',
}
