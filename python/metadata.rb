maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs python packages"
version           "0.99"

recipe "python", "Installs python, pip, and virtualenv"

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end
