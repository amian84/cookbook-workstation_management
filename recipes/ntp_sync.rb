#
# Cookbook Name: workstation_management
# Recipe:: ntp_sync
#
# Copyright 2011 Junta de Andalucía
#
# Author::
#  * Roberto C. Morano <rcmorano@emergya.com>
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

package 'ntpdate' do
  action :nothing
end.run_action(:install)

begin
  unless node['ntp_sync']['server'].nil?
    execute "ntpdate" do
      command "ntpdate -u #{node['ntp_sync']['server']}"
      action :run
    end
  end
rescue Exception => e
  Chef::Log.warn(e)
end
