require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyBaseTest < Test::Unit::TestCase
  
  @@base = Dreamy::Base.new(CREDS["user"],CREDS["key"])
  
  context "Initialization" do

    should "require email and API key" do
      assert_raise(ArgumentError) { Dreamy::Base.new }
    end
    
  end
  
  context "Domains" do

    should "return array of domain objects" do
      domains = @@base.domains
      assert_kind_of Array, domains
      assert_kind_of Dreamy::Domain, domains.first unless domains.empty?
    end
    
  end
  
  context "Users" do

    should "return array of user objects" do
      users = @@base.users
      assert_kind_of Array, users
      assert_kind_of Dreamy::User, users.first unless users.empty?
    end
    
    should "not include user passwords by default" do
      assert_equal "********", @@base.users.first.password
    end
  end
  
  context "DNS" do

    should "return array of DNS records" do
      records = @@base.dns
      assert_kind_of Array, records
      assert_kind_of Dreamy::Dns, records.first unless records.empty?
    end
    
    context "adding a record" do
      setup { @record_count = @@base.dns.size }
      
      should "require 3 arguments" do
        assert_raise(ArgumentError) { @@base.dns_add("first","second") }
      end
      
      should "add record and return true with valid data" do
        assert @@base.dns_add("test." + CREDS["domain"],"A","208.97.188.35")
        assert_equal @record_count + 1, @@base.dns.size
      end
      
      should "not add record and raise error with invalid data" do
        assert_raise(Dreamy::ApiError) { @@base.dns_add("test." + CREDS["domain"],"B","208.97.188.35") }
        assert_equal @record_count, @@base.dns.size
      end
      
    end
    
    context "removing a record" do
      
      should "require 3 arguments" do
        assert_raise(ArgumentError) { @@base.dns_remove("first","second") }
      end
      
      should "remove record and return true with valid data" do
        record_count = @@base.dns.size
        assert @@base.dns_remove("test." + CREDS["domain"],"A","208.97.188.35")
        assert_equal record_count - 1, @@base.dns.size
      end
      
      should "not remove record and raise error with invalid data" do
        record_count = @@base.dns.size
        assert_raise(Dreamy::ApiError) { @@base.dns_remove("test." + CREDS["domain"],"B","208.97.188.35") }
        assert_equal record_count, @@base.dns.size
      end
      
    end
    
  end
  
  context "Announcement lists" do
    
    context "listing lists" do
      
      should "return array of AnnounceList records" do
        lists = @@base.announce_lists
        assert_kind_of Array, lists
        assert_kind_of Dreamy::AnnounceList, lists.first unless lists.empty?
      end
      
    end
    
    context "subscribers" do
      
      should "require values for listname and domain" do
        assert_raise(ArgumentError) { @@base.announce_list() }
      end
      
      should "return array of Subscriber records" do
        subscribers = @@base.announce_list(CREDS["listname"],CREDS["domain"])
        assert_kind_of Array, subscribers
        assert_kind_of Dreamy::Subscriber, subscribers.first unless subscribers.empty?
      end
      
    end
    
    context "adding a subscriber" do
      
      should "require values for listname, domain, and email" do
        assert_raise(ArgumentError) { @@base.announce_add() }
      end
      
      # should "return true on success" do
      #         assert @@base.announce_add(CREDS["listname"],CREDS["domain"],"new_guy@test.com")
      #       end
      
    end
    
    context "removing a subscriber" do
      
      should "require values for listname, domain, and email" do
        assert_raise(ArgumentError) { @@base.announce_remove() }
      end
      
      # should "return true on success" do
      #         assert @@base.announce_remove(CREDS["listname"],CREDS["domain"],"new_guy@test.com")
      #       end
      
    end
    
  end # announcement lists
  
  context "MySQL" do
    
    should "return array of MysqlDb records" do
      dbs = @@base.mysql_dbs
      assert_kind_of Array, dbs
      assert_kind_of Dreamy::MysqlDb, dbs.first unless dbs.empty?
    end

    should "return array of MysqlHost records" do
      hosts = @@base.mysql_hosts
      assert_kind_of Array, hosts
      assert_kind_of Dreamy::MysqlHost, hosts.first unless hosts.empty?
    end
    
    should "return array of MysqlUser records" do
      users = @@base.mysql_users
      assert_kind_of Array, users
      assert_kind_of Dreamy::MysqlUser, users.first unless users.empty?
    end
    
  end
  
  context "Private Servers" do
    setup { @ps = CREDS["ps"] }
    
    should "return an array of PrivateServer objects" do
      ps = @@base.ps
      assert_kind_of Array, ps
      assert_kind_of Dreamy::PrivateServer, ps.first unless ps.empty?
    end
    
    context "settings" do
      
      should "return a hash of settings" do
        settings = @@base.ps_settings(@ps)
        assert_kind_of Hash, settings
      end
      
      should "require values for ps, setting, and value when setting value" do
        assert_raise(ArgumentError) { @@base.ps_set() }        
      end
      
      should "set specified setting" do
        @@base.ps_set(@ps,'comment','testps')
        settings = @@base.ps_settings(@ps)
        assert_equal 'testps', settings['comment']
      end
      
    end
    
    context "Size" do
      
      should "return an array of size history hashes" do
        sizes = @@base.ps_size_history(@ps)
        assert_kind_of Array, sizes
        assert_kind_of Hash, sizes.first
      end
      
      should "set new size" do
        @@base.ps_size_set(@ps,"200")
        assert_equal 200, @@base.ps_size_history(@ps).last["memory_mb"]
      end
      
    end
    
    context "Rebooting" do
      
      should "return an array of reboot time stamps" do
        reboots = @@base.ps_reboot_history(@ps)
        assert_kind_of Array, reboots
      end
      
    end
    
    context "Usage" do
      
      should "return array of usage hashes" do
        usage = @@base.ps_usage(@ps)
        assert_kind_of Array, usage
        assert_kind_of Hash, usage.first
      end
      
    end
    
    context "Pending requests" do
      
      should "return array of pending hashes" do
        pending = @@base.ps_pending
        assert_kind_of Array, pending
        assert_kind_of Hash, pending.first unless pending.empty?
      end
      
    end
    
  end
  
end