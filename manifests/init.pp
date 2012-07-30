class diamond ($graphite_host, $graphite_port = 2003, $diamond_user = nobody, $diamond_group = nobody, $interval = 300) {
	package { "diamond":
		ensure => present;
	}
	file {
		"/etc/diamond/diamond.conf":
			ensure => file,
			content => template("diamond/diamond.conf.erb");
	}
	exec { "restart-diamond":
		require => Package["diamond"],
		subscribe  => [
				File['/etc/diamond/diamond.conf'],
				Package['diamond']
			],
		command => "/etc/init.d/diamond stop; /etc/init.d/diamond start";
	}
}
