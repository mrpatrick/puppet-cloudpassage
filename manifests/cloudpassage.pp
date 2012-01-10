# CloudPassage



class cloudpassage::install {  
  yumrepo{"cloudpassage" :
    descr => "CloudPassage production",
    baseurl => 'http://packages.cloudpassage.com/fc76b60165f3bf7e681ec6c7e49c2a6f/redhat/$basearch',
    gpgcheck => 1,
    gpgkey => "http://packages.cloudpassage.com/cloudpassage.packages.key"
  }
  package{"cphalo" :
    require => Yumrepo["cloudpassage"],
    ensure => latest,
    notify => Exec["cphalod start"]
  }
  exec{"cphalod start" :
    command => "/etc/init.d/cphalod start"
    cwd => "/etc/init.d",
    refreshonly => true,
    require => Package["cphalo"],
  }
}

class cloudpassage::config {
  File {
    require => Class["cloudpassage::install"],
    owner => "root",
    group => "root",
    mode => 644
  }
  
}

class cloudpassage::service {
  
  service{"cphalod" :
    ensure  => running,
    enable  => true,
    start => "/etc/init.d/cphalod start --tag=$operatingsystem",
    require => Class["cloudpassage::install"],
  }
}
  
class cloudpassage {
  include cloudpassage::install, cloudpassage::config, cloudpassage::service
}
