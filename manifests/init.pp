# Cleanup puppet manifest
#(@) Joe DeCello - https://github.com/taverentech/
class diamond (
  $graphite_host,
  $graphite_port = 2003,
  $diamond_user = nobody,
  $diamond_group = nobody,
  $interval = 300
  ) {
  package { "diamond":
    ensure     => present,
  }
  file { 'diamond.conf':
    path      => '/etc/diamond/diamond.conf',
    ensure    => file,
    content   => template("diamond/diamond.conf.erb"),
    require   => Package['diamond'],
  }
  service { 'diamond':
    ensure    => 'running',
    enable    => true,
    restart   => 'service diamond stop; service diamond start',
    hasstatus => true,
    require   => File['/etc/diamond/diamond.conf'],
  }
}

