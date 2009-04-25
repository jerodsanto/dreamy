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
      assert_kind_of Array, @@base.domains
      assert_kind_of Dreamy::Domain, @@base.domains.first
    end
    
  end
  
  context "Users" do

    should "return array of user objects" do
      assert_kind_of Array, @@base.users
      assert_kind_of Dreamy::User, @@base.users.first
    end
    
    should "not include user passwords by default" do
      assert_equal "********", @@base.users.first.password
    end
  end
  
  context "DNS" do

    should "return array of DNS records" do
      assert_kind_of Array, @@base.dns
      assert_kind_of Dreamy::Dns, @@base.dns.first
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
    
  end
  
  context "Announcement lists" do
    
    context "listing lists" do
      
      should "return array of AnnounceList records" do
        lists = @@base.announce_lists
        assert_kind_of Array, lists
        assert_kind_of Dreamy::AnnounceList, lists.first
      end
      
    end
    
    context "subscribers" do
      
      should "require values for listname and domain" do
        assert_raise(ArgumentError) { @@base.announce_list() }
      end
      
      should "return array of Subscriber records" do
        subscribers = @@base.announce_list(CREDS["listname"],CREDS["domain"])
        assert_kind_of Array, subscribers
        assert_kind_of Dreamy::Subscriber, subscribers.first
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
  
end