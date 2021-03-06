#
# Author:: Seth Chisamore <schisamo@opscode.com>
# Cookbook Name:: python
# Recipe:: default
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

python_pkgs = value_for_platform(
  ["debian","ubuntu"] => {
    "default" => ["python","python-dev"]
  },
  ["centos","redhat","fedora"] => {
    "default" => ["python26","python26-devel"]
  },
  "default" => ["python","python-dev"]
)

python_pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

# Ubuntu's python-setuptools, python-pip and python-virtualenv packages 
# are broken...this feels like Rubygems!
# http://stackoverflow.com/questions/4324558/whats-the-proper-way-to-install-pip-virtualenv-and-distribute-for-python
# https://bitbucket.org/ianb/pip/issue/104/pip-uninstall-on-ubuntu-linux
bash "install-pip" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
  curl -O http://python-distribute.org/distribute_setup.py
  python distribute_setup.py
  easy_install pip
  EOH
  not_if "which pip"
end

python_pip "virtualenv" do
  action :install
end
