require 'spec_helper'

=begin
Ensure authorized keys of all IQT members are set and other keys are NOT present
Ensure timesyncd.conf is set with our NTP servers
Ensure root ssh login is not allowed in /etc/ssh/sshd_config
Ensure inotify-max-user-instances is set to 8192
Ensure fs.inotify.max_user_instances is set to 8192
Ensure host is registered to Nodemanager
Ensure eth0 is up and configured
Ensure eth1 (vlan tagging) is up
Ensure eth2 (nfs) is up and configured
Ensure host has mount to nfs server
Ensure /shared/data directory exists
Ensure /local/data directory exists
=end

describe service('docker') do
  it { should be_enabled }
  it { should be_running }
end

describe docker_container('plumber') do
  it { should exist }
  it { should be_running }
end

describe docker_container('logspout') do
  it { should exist }
  it { should be_running }
end

describe docker_container('zabbix-agent') do
  it { should exist }
  it { should be_running }
end

describe docker_container('vmware-tools') do
  it { should exist }
  it { should be_running }
end

describe docker_container('infra-dashboard-agent') do
  it { should exist }
  it { should be_running }
end

describe docker_container('infra-dashboard-publisher') do
  it { should exist }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end
