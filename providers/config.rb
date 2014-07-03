#
# Author:: Kendrick Martin (kendrick.martin@webtrends.com)
# Contributor:: David Dvorak (david.dvorak@webtrends.com)
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

require 'chef/mixin/shell_out'

include Chef::Mixin::ShellOut
include Windows::Helper

action :config do
  cmd = "#{appcmd} set config #{@new_resource.cfg_cmd}"
  Chef::Log.debug(cmd)
  shell_out!(cmd, :returns => @new_resource.returns)
  Chef::Log.info("IIS Config command run")
end

def load_current_resource
  @current_resource = Chef::Resource::IisConfig.new(@new_resource.name)
  @current_resource.site_name(@new_resource.site_name)
  @current_resource.section(@new_resource.section)
  @current_resource.config_key(@new_resource.config_key)
  @current_resource.config_value(@new_resource.config_value)
  @current_resource.is_attribute(@new_resource.is_attribute)
  @current_resource.ensure(@new_resource.ensure)
  @current_resource.commit(@new_resource.commit)
  @current_resource.enabled(@new_resource.enabled)
  
  cmd = shell_out("#{appcmd} list config /section:#{@new_resource.section}")
  Chef::Log.debug("#{@new_resource} list app command output: #{cmd.stdout}")
  
  result = cmd.stdout.each_line do |line|
    if line.include? "#{@new_resource.config_key}"
      if line.include? "#{@new_resource.config_value}"
        true
      end
    end
  end if cmd.stderr.empty?
  Chef::Log.debug("#{@new_resource} current_resource match output:#{result}")
  
  if result
    @current_resource.exists = true
  else
    @current_resource.exists = false
  end
end

private
def appcmd
  @appcmd ||= begin
    "#{node['iis']['home']}\\appcmd.exe"
  end
end
