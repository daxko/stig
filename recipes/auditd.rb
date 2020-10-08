#
# Cookbook Name:: stig
# Recipe:: auditd
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Installs the auditd cookbook with the CIS ruleset
#
# See: https://supermarket.chef.io/cookbooks/auditd

# BEGIN
# Remove this block wnen this gets resolved: https://github.com/chef-cookbooks/auditd/issues/55
#
# Original code cherry-picked from:
# https://github.com/USGS-CIDA/stig/commit/7f0675a8d853c44302690035cd0aae74d15efdbf#diff-89808a75a87cc415db2e92796115f55a

service 'auditd' do
  if platform_family?('rhel') && node['init_package'] == 'systemd' && node['platform_version'] < '7.5'
    reload_command '/usr/libexec/initscripts/legacy-actions/auditd/reload'
    restart_command '/usr/libexec/initscripts/legacy-actions/auditd/restart'
  end
  if platform_family?('rhel') && node['init_package'] == 'systemd' && node['platform_version'] >= '7.5'
    reload_command '/usr/sbin/service auditd reload'
    restart_command '/usr/sbin/service auditd restart'
  end
  supports %i[start stop restart reload status]
  action :enable
end
# END

auditd_config_dir = '/etc/audit/'

directory auditd_config_dir

# Create auditd configuration file
template File.join(auditd_config_dir, 'auditd.conf') do
  source 'etc_audit_auditd.conf.erb'
  owner 'root'
  group 'root'
  mode 0o640
  notifies :restart, 'service[auditd]', :immediately
end

cookbook_file '/etc/audisp/audispd.conf' do
  source 'audispd.conf'
  owner 'root'
  group 'root'
  mode 0600
  notifies :stop, 'service[auditd]', :before
  notifies :start, 'service[auditd]', :delayed
end

cookbook_file '/etc/audisp/plugins.d/af_unix.conf' do
  source 'af_unix.conf'
  owner 'root'
  group 'root'
  mode 0600
  notifies :restart, 'service[auditd]', :delayed
end
