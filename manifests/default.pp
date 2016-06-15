group { 'slurm':
    ensure => 'present',
    gid => 3000,
} ->
user { 'slurm':
    ensure => 'present',
    uid => 3000,
    gid => 3000,
    managehome => 'true',
}

file { '/home/vagrant/.ssh/id_rsa':
    mode => 600,
    owner => 'vagrant',
    group => 'vagrant',
    source => 'file:///vagrant/keys/id_rsa_vagrantslurm',
}

file { '/home/vagrant/.ssh/id_rsa.pub':
    mode => 600,
    owner => 'vagrant',
    group => 'vagrant',
    source => 'file:///vagrant/keys/id_rsa_vagrantslurm.pub',
}

host { 'head':
    ensure => 'present',
    ip => '192.168.2.100',
}
host { 'node1':
    ensure => 'present',
    ip => '192.168.2.101',
}
host { 'node2':
    ensure => 'present',
    ip => '192.168.2.102',
}

#Munge setup
package { ['openssl-devel', 'zlib-devel', 'bzip2-devel']:
    ensure => installed,
} ->
file {
    '/vagrant/make-munge.sh':
    ensure => 'file',
    path => '/vagrant/make-munge.sh',
    owner => 'root',
    group => 'root',
    mode  => '0755',
    notify => Exec['munge_script'],
}
exec { 'munge_script':
    command => "/bin/bash -c '/vagrant/make-munge.sh'",
    notify => Exec['slurm_script'],
}/* ->
file { '/etc/munge/munge.key':
    ensure => present,
    source => 'file:///vagrant/keys/munge.key',
    owner => 'munge',
    group => 'munge',
    mode => 400,
} -> 
service { 'munge':
    ensure => 'running',
    enable => 'true',
}*/

package { ['perl-ExtUtils-MakeMaker', 'readline-devel', 'pam-devel']:
    ensure => 'installed',
}

file { '/var/spool/slurmd':
    ensure => 'directory',
    owner => 'slurm',
    group => 'slurm',
    mode => 755,
}
file { '/var/spool/slurmctld':
    ensure => 'directory',
    owner => 'slurm',
    group => 'slurm',
    mode => 755,
}

file { '/opt/slurm':
    ensure => 'directory',
    owner => 'slurm',
    group => 'slurm',
    mode => 755,
} ->
file { '/opt/slurm/etc':
    ensure => 'directory',
    owner => 'slurm',
    group => 'slurm',
    mode => 755,
} ->
file { '/opt/slurm/etc/slurm.conf':
    ensure => present,
    source => 'file:///vagrant/slurm.conf',
    owner => 'slurm',
    group => 'slurm',
    mode => 644,
} 




file { '/var/run/slurm':
    ensure => 'directory',
    owner => 'slurm',
    group => 'slurm',
    mode => 755,
}
#Slurm setup
file { '/var/log/slurm_jobacct.log':
    ensure => 'present',
    owner => 'slurm',
    group => 'slurm',
    mode => 644,
}->
file { '/var/log/slurm_jobcomp.log':
    ensure => 'present',
    owner => 'slurm',
    group => 'slurm',
    mode => 644,
}->
file {
    '/vagrant/make-slurm.sh':
    ensure => 'file',
    path => '/vagrant/make-slurm.sh',
    owner => 'root',
    group => 'root',
    mode  => '0755',
    notify => Exec['slurm_script'],
}
exec { 'slurm_script':
    command => "/bin/bash -c '/vagrant/make-slurm.sh'",
}/* ->
service { 'slurm':
    ensure => 'running',
    enable => 'true',
}*/
