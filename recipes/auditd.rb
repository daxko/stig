#
# Cookbook Name:: stig
# Recipe:: auditd
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Installs the auditd cookbook with the CIS ruleset
#
# See: https://supermarket.chef.io/cookbooks/auditd

auditd_config_dir = '/etc/audit/'

directory auditd_config_dir

# Create auditd configuration file
template File.join(auditd_config_dir, 'auditd.conf') do
  source 'etc_audit_auditd.conf.erb'
  owner 'root'
  group 'root'
  mode 0o640
  notifies :restart, 'systemd_unit[auditd_service]', :immediately
end

systemd_unit 'auditd_service' do
  action :nothing
end

cookbook_file '/etc/audisp/audispd.conf' do
  source 'audispd.conf'
  owner 'root'
  group 'root'
  mode 0600
  notifies :stop, 'systemd_unit[auditd_service]', :before
  notifies :start, 'systemd_unit[auditd_service]', :delayed
end

cookbook_file '/etc/audisp/plugins.d/af_unix.conf' do
  source 'af_unix.conf'
  owner 'root'
  group 'root'
  mode 0600
  notifies :restart, 'systemd_unit[auditd_service]', :delayed
end
