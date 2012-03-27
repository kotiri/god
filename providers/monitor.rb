#
# Cookbook Name:: god
# Provider:: monitor
#
# Copyright 2009-2012, Opscode, Inc.
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

action :create do
  include_recipe "god"

  template "/etc/god/conf.d/#{new_resource.name}.god" do
    source new_resource.config
    owner "root"
    group "root"
    mode 0644
    variables(
      :name => new_resource.name,
      :max_memory => new_resource.max_memory,
      :cpu => new_resource.cpu,
      :sv_bin => node['runit']['sv_bin'],
      :params => new_resource
    )
    notifies :restart, resources(:service => "god")
  end

  new_resource.updated_by_last_action(true)
end
