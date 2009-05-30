# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dreamy}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jerod Santo"]
  s.date = %q{2009-05-30}
  s.default_executable = %q{dh}
  s.email = %q{jerod.santo@gmail.com}
  s.executables = ["dh"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "README.md",
    "Rakefile",
    "VERSION.yml",
    "bin/dh",
    "lib/dreamy.rb",
    "lib/dreamy/announce_list.rb",
    "lib/dreamy/base.rb",
    "lib/dreamy/command.rb",
    "lib/dreamy/commands/announce.rb",
    "lib/dreamy/commands/base.rb",
    "lib/dreamy/commands/dns.rb",
    "lib/dreamy/commands/domains.rb",
    "lib/dreamy/commands/help.rb",
    "lib/dreamy/commands/mysql.rb",
    "lib/dreamy/commands/ps.rb",
    "lib/dreamy/commands/users.rb",
    "lib/dreamy/core_extensions.rb",
    "lib/dreamy/dns.rb",
    "lib/dreamy/domain.rb",
    "lib/dreamy/easy_class_maker.rb",
    "lib/dreamy/mysql/db.rb",
    "lib/dreamy/mysql/host.rb",
    "lib/dreamy/mysql/user.rb",
    "lib/dreamy/private_server.rb",
    "lib/dreamy/subscriber.rb",
    "lib/dreamy/user.rb",
    "test/announce_test.rb",
    "test/base_test.rb",
    "test/dns_test.rb",
    "test/domain_test.rb",
    "test/mysql_db_test.rb",
    "test/mysql_host_test.rb",
    "test/mysql_user_test.rb",
    "test/private_server_test.rb",
    "test/subscriber_test.rb",
    "test/test_helper.rb",
    "test/user_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/sant0sk1/dreamy}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A Ruby library and command line tool for accessing DreamHost's API}
  s.test_files = [
    "test/announce_test.rb",
    "test/base_test.rb",
    "test/dns_test.rb",
    "test/domain_test.rb",
    "test/mysql_db_test.rb",
    "test/mysql_host_test.rb",
    "test/mysql_user_test.rb",
    "test/private_server_test.rb",
    "test/subscriber_test.rb",
    "test/test_helper.rb",
    "test/user_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<visionmedia-terminal-table>, [">= 1.0.5"])
      s.add_runtime_dependency(%q<hpricot>, [">= 0.7"])
      s.add_runtime_dependency(%q<uuid>, [">= 2.0.1"])
    else
      s.add_dependency(%q<visionmedia-terminal-table>, [">= 1.0.5"])
      s.add_dependency(%q<hpricot>, [">= 0.7"])
      s.add_dependency(%q<uuid>, [">= 2.0.1"])
    end
  else
    s.add_dependency(%q<visionmedia-terminal-table>, [">= 1.0.5"])
    s.add_dependency(%q<hpricot>, [">= 0.7"])
    s.add_dependency(%q<uuid>, [">= 2.0.1"])
  end
end
