#
# Author:: Kendrick Martin (kendrick.martin@webtrends.com)
# Cookbook Name:: iis
# Resource:: config
#
# Copyright:: 2011, Webtrends Inc.
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

actions :config

attribute :cfg_cmd, :kind_of => String, :name_attribute => true
attribute :site_name, :kind_of => String
attribute :section, :kind_of => String
attribute :config_key, :kind_of => String
attribute :config_value, :kind_of => String
attribute :is_attribute, :kind_of => [TrueClass, FalseClass], :default => false
attribute :ensure, :kind_of => String, :equal_to => ['Present', 'present', 'Absent', 'absent']
attribute :commit, :kind_of => String
attribute :enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :returns, :kind_of => [Integer, Array], :default => 0

def initialize(*args)
  super
  @action = :config
end