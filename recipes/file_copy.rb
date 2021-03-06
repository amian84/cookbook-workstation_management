#
# Cookbook Name:: fixed_files
# Recipe:: file_copy
#
# Copyright 2011 Junta de Andalucía
#
# Author::
#  * David Amian <damian@emergya.com>
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


node["file_copy"]["file_copy"].each do |fixedfile|
  path_client = fixedfile["path_client"]
  file_url = fixedfile["file_url"]
  overwrite = fixedfile["overwrite"]
  if overwrite == 'true'
    begin
      grp_members = Etc.getgrnam(fixedfile["group"]).mem
      remote_file path_client do
        source file_url
        owner fixedfile["user"]
        mode fixedfile["mode"]
        group fixedfile["group"]
      end
    rescue ArgumentError => e
      puts 'Group ' + fixedfile["group"] +' doesn\'t exist'
      
    end
  else
    begin
      grp_members = Etc.getgrnam(fixedfile["group"]).mem
      remote_file path_client do
        source file_url
        owner fixedfile["user"]
        mode fixedfile["mode"]
        group fixedfile["group"]
        action :create_if_missing
      end
    rescue ArgumentError => e
      puts 'Group ' + fixedfile["group"] +' doesn\'t exist'
      
    end

  end
end


