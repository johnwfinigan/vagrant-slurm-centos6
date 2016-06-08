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

package { ['openssl-devel', 'zlib-devel', 'bzip2-devel']:
    ensure => installed,
} ->
package { 'munge':
    provider => 'rpm',
    source => 'file:///vagrant/MUNGE/munge-0.5.11-1.el6.x86_64.rpm',
    ensure => 'installed',
    install_options => ['--nodeps'],
} ->
package { 'munge-libs':
    provider => 'rpm',
    source => 'file:///vagrant/MUNGE/munge-libs-0.5.11-1.el6.x86_64.rpm',
    ensure => 'installed',
} ->
package { 'munge-devel':
    provider => 'rpm',
    source => 'file:///vagrant/MUNGE/munge-devel-0.5.11-1.el6.x86_64.rpm', 
    ensure => 'installed',
} ->
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
} 


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

file { '/var/log/slurm_jobacct.log':
    ensure => 'present',
    owner => 'slurm',
    group => 'slurm',
    mode => 644,
}
file { '/var/log/slurm_jobcomp.log':
    ensure => 'present',
    owner => 'slurm',
    group => 'slurm',
    mode => 644,
}
