class cloudpassage($api_key, $repo_key, $tags) {
  class { 'cloudpassage::install': }
  class { 'cloudpassage::service': }
}

class cloudpassage::install {  
  yumrepo { 'cloudpassage':
    enabled   => 1,
    gpgcheck  => 1,
    gpgkey    => 'http://packages.cloudpassage.com/cloudpassage.packages.key',
    baseurl   => "http://packages.cloudpassage.com/${cloudpassage::repo_key}/redhat/\$basearch",
    descr     => 'CloudPassage Production',
  }

  package { 'cphalo':
    ensure  => latest,
    require => Yumrepo['cloudpassage'],
    notify  => Exec['cphalod start'],
  }

  exec { 'cphalod start':    
    command     => "/etc/init.d/cphalod start --api-key=${cloudpassage::api_key} --tag=${cloudpassage::tags}",
    refreshonly => true,
    require     => Package['cphalo'],
  }
}

class cloudpassage::service {
  service { 'cphalod':
    ensure  => running,
    enable  => true,
    start   => "/etc/init.d/cphalod start --tag=${cloudpassage::tags}",
    require => Class['cloudpassage::install'],
  }
}
