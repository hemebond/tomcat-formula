require_relative '../../../shared/spec_helper.rb'

describe 'tomcat/manager.sls' do
  case os[:family]
  when 'debian'
    ver = '8'
    pkgs_installed = %w(libtcnative-1)
    main_config = '/etc/default/tomcat8'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/java-7-openjdk'
    limits_file = '/etc/security/limits.d/tomcat8.conf'

    describe command("apt install libxml2-utils") do
      its(:exit_status) { should eq 0 }
    end
  when 'redhat'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/etc/sysconfig/tomcat'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat'
    user = 'tomcat'
    group = 'tomcat'
    java_home = '/usr/lib/jvm/jre'
    limits_file = '/etc/security/limits.d/tomcat7.conf'

    describe command("yum install libxml2") do
      its(:exit_status) { should eq 0 }
    end
  when 'arch'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/default-runtime'
    limits_file = '/etc/security/limits.conf'

    describe command("pacman -S libxml2") do
      its(:exit_status) { should eq 0 }
    end
  when 'ubuntu'
    case os[:release]
    when '14.04'
      ver = '7'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat7'
      server_config = '/etc/tomcat7/server.xml'
      context_config = '/etc/tomcat7/context.xml'
      catalina_logfile = '/var/log/tomcat7/catalina.out'
      web_config = '/etc/tomcat7/web.xml'
      user_config = '/etc/tomcat7/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat7'
      user = 'tomcat7'
      group = 'tomcat7'
      java_home = '/usr/lib/jvm/java-7-openjdk'
      limits_file = '/etc/security/limits.d/tomcat7.conf'

      describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    when '16.04'
      ver = '8'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat8'
      server_config = '/etc/tomcat8/server.xml'
      context_config = '/etc/tomcat8/context.xml'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
      web_config = '/etc/tomcat8/web.xml'
      user_config = '/etc/tomcat8/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat8'
      user = 'tomcat8'
      group = 'tomcat8'
      java_home = '/usr/lib/jvm/java-7-openjdk'
      limits_file = '/etc/security/limits.d/tomcat8.conf'

       describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    end
  end

  describe service(service) do
    it { should be_running }
  end

  describe file(user_config) do
    it { should be_file }
    its(:content) { should match('This file is managed/autogenerated by salt.') }
    case os[:family]
    when 'debian', 'redhat'
      its(:content) { should match(/rolename="manager-\w+"/) }
      its(:content) { should match("username=\"#{username}\" password=\"#{password}\" roles=\"#{roles}\"") }
    when 'arch'
      its(:content) { should match(/rolename="manager-\w+"/) }
      its(:content) { should match("username=\"#{username}\" password=\"#{password}\" roles=\"#{roles}\"") }
    end

    describe command("xmllint --noout #{user_config}") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe file(catalina_logfile) do
    it { should be_file }
    its(:content) { should contain('INFO: Server startup in') }
  end
end

describe 'tomcat/cluster.sls' do
  case os[:family]
  when 'debian'
    ver = '8'
    pkgs_installed = %w(libtcnative-1)
    main_config = '/etc/default/tomcat8'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/java-7-openjdk'
    limits_file = '/etc/security/limits.d/tomcat8.conf'

    describe command("apt install libxml2-utils") do
      its(:exit_status) { should eq 0 }
    end
  when 'redhat'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/etc/sysconfig/tomcat'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    cur_date = Time.now.strftime("%Y-%m-%d")
    catalina_logfile = "/var/log/tomcat8/catalina.#{cur_date}.log"
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat'
    user = 'tomcat'
    group = 'tomcat'
    java_home = '/usr/lib/jvm/jre'
    limits_file = '/etc/security/limits.d/tomcat7.conf'

    describe command("yum install libxml2") do
      its(:exit_status) { should eq 0 }
    end      
  when 'arch'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/default-runtime'
    limits_file = '/etc/security/limits.conf'

    describe command("pacman -S libxml2") do
      its(:exit_status) { should eq 0 }
    end
   when 'ubuntu'
    case os[:release]
    when '14.04'
      ver = '7'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat7'
      server_config = '/etc/tomcat7/server.xml'
      context_config = '/etc/tomcat7/context.xml'
      catalina_logfile = '/var/log/tomcat7/catalina.out'
      web_config = '/etc/tomcat7/web.xml'
      user_config = '/etc/tomcat7/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat7'
      user = 'tomcat7'
      group = 'tomcat7'
      java_home = '/usr/lib/jvm/default-java'
      limits_file = '/etc/security/limits.d/tomcat7.conf'

      describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    when '16.04'
      ver = '8'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat8'
      server_config = '/etc/tomcat8/server.xml'
      context_config = '/etc/tomcat8/context.xml'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
      web_config = '/etc/tomcat8/web.xml'
      user_config = '/etc/tomcat8/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat8'
      user = 'tomcat8'
      group = 'tomcat8'
      java_home = '/usr/lib/jvm/default-java'
      limits_file = '/etc/security/limits.d/tomcat8.conf'

       describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    end
  end

  describe file(server_config) do
    it { should be_file }
    its(:content) { should contain('This file is managed/autogenerated by salt.') }
    its(:content) { should contain('jvmRoute="ip-') }
    its(:content) { should contain('org.apache.catalina.ha.tcp.SimpleTcpCluster') }

    describe command("xmllint --noout #{server_config}") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe file(catalina_logfile) do
    it { should be_file }
    its(:content) { should contain('INFO: Server startup in') }
    its(:content) { should contain('INFO: Cluster is about to start') }
    its(:content) { should contain('INFO: Done sleeping, membership established, start level') }
  end
end

describe 'tomcat/vhosts.sls' do
  case os[:family]
  when 'debian'
    ver = '8'
    pkgs_installed = %w(libtcnative-1)
    main_config = '/etc/default/tomcat8'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/java-7-openjdk'
    limits_file = '/etc/security/limits.d/tomcat8.conf'

    describe command("apt install libxml2-utils") do
      its(:exit_status) { should eq 0 }
    end
  when 'redhat'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/etc/sysconfig/tomcat'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat'
    user = 'tomcat'
    group = 'tomcat'
    java_home = '/usr/lib/jvm/jre'
    limits_file = '/etc/security/limits.d/tomcat7.conf'

    describe command("yum install libxml2") do
      its(:exit_status) { should eq 0 }
    end
  when 'arch'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/default-runtime'
    limits_file = '/etc/security/limits.conf'

    describe command("pacman -S libxml2") do
      its(:exit_status) { should eq 0 }
    end
  when 'ubuntu'
    case os[:release]
    when '14.04'
      ver = '7'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat7'
      server_config = '/etc/tomcat7/server.xml'
      context_config = '/etc/tomcat7/context.xml'
      catalina_logfile = '/var/log/tomcat7/catalina.out'
      web_config = '/etc/tomcat7/web.xml'
      user_config = '/etc/tomcat7/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat7'
      user = 'tomcat7'
      group = 'tomcat7'
      java_home = '/usr/lib/jvm/java-7-openjdk'
      limits_file = '/etc/security/limits.d/tomcat7.conf'

      describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    when '16.04'
      ver = '8'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat8'
      server_config = '/etc/tomcat8/server.xml'
      context_config = '/etc/tomcat8/context.xml'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
      web_config = '/etc/tomcat8/web.xml'
      user_config = '/etc/tomcat8/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat8'
      user = 'tomcat8'
      group = 'tomcat8'
      java_home = '/usr/lib/jvm/java-7-openjdk'
      limits_file = '/etc/security/limits.d/tomcat8.conf'

       describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
  end
  describe file(server_config) do
    it { should be_file }
    its(:content) { should contain('This file is managed/autogenerated by salt.') }
    its(:content) { should contain('example.com') }
    its(:content) { should contain('../webapps/myapp') }
    its(:content) { should contain('/var/lib/tomcat7/webapps/myapp') }
    its(:content) { should contain('unpackWARs="true"') }
    its(:content) { should contain('reloadable="true"') }
    its(:content) { should contain('debug="0"') }
    describe command("xmllint --noout #{server_config}") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe file(catalina_logfile) do
    it { should be_file }
    its(:content) { should contain('INFO: Server startup in') }
  end
end

describe 'tomcat/expires.sls' do
  case os[:family]
  when 'debian'
    ver = '8'
    pkgs_installed = %w(libtcnative-1)
    main_config = '/etc/default/tomcat8'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/java-7-openjdk'
    limits_file = '/etc/security/limits.d/tomcat8.conf'

    describe command("apt install libxml2-utils") do
      its(:exit_status) { should eq 0 }
    end
  when 'redhat'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/etc/sysconfig/tomcat'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat'
    user = 'tomcat'
    group = 'tomcat'
    java_home = '/usr/lib/jvm/jre'
    limits_file = '/etc/security/limits.d/tomcat7.conf'

    describe command("yum install libxml2") do
      its(:exit_status) { should eq 0 }
    end
  when 'arch'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/default-runtime'
    limits_file = '/etc/security/limits.conf'

    describe command("pacman -S libxml2") do
      its(:exit_status) { should eq 0 }
    end
  when 'ubuntu'
    case os[:release]
    when '14.04'
      ver = '7'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat7'
      server_config = '/etc/tomcat7/server.xml'
      context_config = '/etc/tomcat7/context.xml'
      catalina_logfile = '/var/log/tomcat7/catalina.out'
      web_config = '/etc/tomcat7/web.xml'
      user_config = '/etc/tomcat7/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat7'
      user = 'tomcat7'
      group = 'tomcat7'
      java_home = '/usr/lib/jvm/java-7-openjdk'
      limits_file = '/etc/security/limits.d/tomcat7.conf'

      describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    when '16.04'
      ver = '8'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat8'
      server_config = '/etc/tomcat8/server.xml'
      context_config = '/etc/tomcat8/context.xml'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
      web_config = '/etc/tomcat8/web.xml'
      user_config = '/etc/tomcat8/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat8'
      user = 'tomcat8'
      group = 'tomcat8'
      java_home = '/usr/lib/jvm/java-7-openjdk'
      limits_file = '/etc/security/limits.d/tomcat8.conf'

       describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    end
  end

  describe file(web_config) do
    it { should be_file }
    its(:content) { should contain('This file is managed/autogenerated by salt.') }
    its(:content) { should contain('<filter-name>ExpiresFilter</filter-name>') }
    its(:content) { should contain('2 weeks') }
    describe command("xmllint --noout #{web_config}") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe file(catalina_logfile) do
    it { should be_file }
    its(:content) { should contain('INFO: Server startup in') }
  end
end

describe 'tomcat/context.sls' do
  case os[:family]
   when 'debian'
    ver = '8'
    pkgs_installed = %w(libtcnative-1)
    main_config = '/etc/default/tomcat8'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/java-7-openjdk'
    limits_file = '/etc/security/limits.d/tomcat8.conf'

    describe command("apt install libxml2-utils") do
      its(:exit_status) { should eq 0 }
    end
  when 'redhat'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/etc/sysconfig/tomcat'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat'
    user = 'tomcat'
    group = 'tomcat'
    java_home = '/usr/lib/jvm/jre'
    limits_file = '/etc/security/limits.d/tomcat7.conf'

    describe command("yum install libxml2") do
      its(:exit_status) { should eq 0 }
    end
  when 'arch'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/default-runtime'
    limits_file = '/etc/security/limits.conf'

    describe command("pacman -S libxml2") do
      its(:exit_status) { should eq 0 }
    end
  when 'ubuntu'
    case os[:release]
    when '14.04'
      ver = '7'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat7'
      server_config = '/etc/tomcat7/server.xml'
      context_config = '/etc/tomcat7/context.xml'
      catalina_logfile = '/var/log/tomcat7/catalina.out'
      web_config = '/etc/tomcat7/web.xml'
      user_config = '/etc/tomcat7/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat7'
      user = 'tomcat7'
      group = 'tomcat7'
      java_home = '/usr/lib/jvm/java-7-openjdk'
      limits_file = '/etc/security/limits.d/tomcat7.conf'

      describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    when '16.04'
      ver = '8'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat8'
      server_config = '/etc/tomcat8/server.xml'
      context_config = '/etc/tomcat8/context.xml'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
      web_config = '/etc/tomcat8/web.xml'
      user_config = '/etc/tomcat8/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat8'
      user = 'tomcat8'
      group = 'tomcat8'
      java_home = '/usr/lib/jvm/java-7-openjdk'
      limits_file = '/etc/security/limits.d/tomcat8.conf'

       describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
   end
end
  describe file(context_config) do
    it { should be_file }
    its(:content) { should contain('This file is managed/autogenerated by salt.') }
    its(:content) { should match(/<Environment.*name="env\.first".*value="first\.text".*type="java\.lang\.String".*override="True.*\/>/m) }
    its(:content) { should match(/<Listener.*className="org\.apache\.catalina\.core\.AprLifecycleListener".*SLEngine="on".*\/>/m) }

    describe command("xmllint --noout #{context_config}") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe file(catalina_logfile) do
    it { should be_file }
    its(:content) { should contain('INFO: Server startup in') }
  end
end

describe 'tomcat/cluster.sls' do
  case os[:family]
  when 'debian'
    ver = '8'
    pkgs_installed = %w(libtcnative-1)
    main_config = '/etc/default/tomcat8'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/java-7-openjdk'
    limits_file = '/etc/security/limits.d/tomcat8.conf'

    describe command("apt install libxml2-utils") do
      its(:exit_status) { should eq 0 }
    end
  when 'redhat'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/etc/sysconfig/tomcat'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    cur_date = Time.now.strftime("%Y-%m-%d")
    catalina_logfile = "/var/log/tomcat8/catalina.#{cur_date}.log"
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat'
    user = 'tomcat'
    group = 'tomcat'
    java_home = '/usr/lib/jvm/jre'
    limits_file = '/etc/security/limits.d/tomcat7.conf'

    describe command("yum install libxml2") do
      its(:exit_status) { should eq 0 }
    end      
  when 'arch'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat/catalina.out'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/default-runtime'
    limits_file = '/etc/security/limits.conf'

    describe command("pacman -S libxml2") do
      its(:exit_status) { should eq 0 }
    end
   when 'ubuntu'
    case os[:release]
    when '14.04'
      ver = '7'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat7'
      server_config = '/etc/tomcat7/server.xml'
      context_config = '/etc/tomcat7/context.xml'
      catalina_logfile = '/var/log/tomcat7/catalina.out'
      web_config = '/etc/tomcat7/web.xml'
      user_config = '/etc/tomcat7/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat7'
      user = 'tomcat7'
      group = 'tomcat7'
      java_home = '/usr/lib/jvm/default-java'
      limits_file = '/etc/security/limits.d/tomcat7.conf'

      describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    when '16.04'
      ver = '8'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat8'
      server_config = '/etc/tomcat8/server.xml'
      context_config = '/etc/tomcat8/context.xml'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
      web_config = '/etc/tomcat8/web.xml'
      user_config = '/etc/tomcat8/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat8'
      user = 'tomcat8'
      group = 'tomcat8'
      java_home = '/usr/lib/jvm/default-java'
      limits_file = '/etc/security/limits.d/tomcat8.conf'

       describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    end
  end

  describe file(server_config) do
    it { should be_file }
    its(:content) { should contain('This file is managed/autogenerated by salt.') }
    its(:content) { should contain('jvmRoute="ip-') }
    its(:content) { should contain('org.apache.catalina.ha.tcp.SimpleTcpCluster') }

    describe command("xmllint --noout #{server_config}") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe file(catalina_logfile) do
    it { should be_file }
    its(:content) { should contain('INFO: Server startup in') }
    its(:content) { should contain('INFO: Cluster is about to start') }
    its(:content) { should contain('INFO: Done sleeping, membership established, start level') }
  end
end
