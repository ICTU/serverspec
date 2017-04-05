require 'spec_helper'

=begin
Ensure authorized keys of all IQT members are set and other keys are NOT present
Ensure timesyncd.conf is set with our NTP servers
Ensure host is registered to Nodemanager
=end

describe 'Linux kernel parameters' do
  context linux_kernel_parameter('fs.inotify.max_user_instances') do
    its(:value) { should eq 8192 }
  end
end

=begin
describe user('core') do
  it { should have_authorized_key '' }
end
=end

=begin
Next one fails, might be permissions issue, running as user core, does not have access to this file.
=end

describe file('/etc/ssh/sshd_config') do
   it { should contain 'PermitRootLogin no' }
end

describe file('/local/data') do
  it { should be_mounted.with( :type => 'ext4' ) }
end

describe file('/mnt/data') do
  it { should be_mounted.with( :type => 'nfs4' ) }
end

describe file('/shared/data') do
  it { should be_mounted.with( :type => 'nfs4' ) }
end

describe file('/var/lib/docker') do
  it { should be_mounted.with( :type => 'btrfs' ) }
end

describe interface('eth0') do
  it { should exist }
  it { should be_up }
  its(:ipv4_address) { should contain '10.' }
end

describe interface('eth1') do
  it { should exist }
  it { should be_up }
end

describe interface('eth2') do
  it { should exist }
  it { should be_up }
  its(:ipv4_address) { should contain '192.168.' }
end

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

describe docker_container('dashboard-agent-infra') do
  it { should exist }
  it { should be_running }
end

describe docker_container('bigboat-publisher-infra') do
  it { should exist }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end
