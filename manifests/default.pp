
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

package { ['openssl-devel', 'zlib-devel', 'bzip2-devel', 'chrpath']:
    ensure => installed,
} ->
package { 'epel-release-6-8.noarch':
	provider => 'rpm',
	ensure => 'installed',
	source => 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm',
} ->
package { ['munge', 'munge-devel', 'munge-libs']:
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
} ->
package { ['perl-DBI', 'perl-ExtUtils-MakeMaker', 'readline-devel', 'pam-devel']:
    ensure => 'installed',
} ->
group { 'slurm':
    ensure => 'present',
    gid => 3000,
} ->
user { 'slurm':
    ensure => 'present',
    uid => 3000,
    gid => 3000,
    managehome => 'true',
} ->
file { '/var/spool/slurmd':
    ensure => 'directory',
    owner => 'slurm',
    group => 'slurm',
    mode => 755,
} ->
file { '/var/spool/slurmctld':
    ensure => 'directory',
    owner => 'slurm',
    group => 'slurm',
    mode => 755,
} ->
file { '/var/run/slurm':
    ensure => 'directory',
    owner => 'slurm',
    group => 'slurm',
    mode => 755,
} ->
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
file { '/var/log/slurmctld.log':
    ensure => 'present',
    owner => 'slurm',
    group => 'slurm',
    mode => 644,
}->
file { '/var/log/slurmd.log':
    ensure => 'present',
    owner => 'slurm',
    group => 'slurm',
    mode => 644,
}->
exec { 'slurm_script':
    command => "/bin/rpm -i --replacepkgs /vagrant/RPMS/*",
}->
file { '/etc/slurm/slurm.conf':
    ensure => present,
    source => 'file:///vagrant/slurm.conf',
    owner => 'slurm',
    group => 'slurm',
    mode => 644,
} ->
service { 'slurm':
    ensure => 'running',
    enable => 'true',
}
