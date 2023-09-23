#
# Cookbook:: linux
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

switch_user 'sudo_su_root' do
    user        'root'
end

yum 'yum-gi' do
    package         'git'
end