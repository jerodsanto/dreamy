require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyControlTest < Test::Unit::TestCase
  
  @@base = Dreamy::Control.new(CREDS["user"],CREDS["key"])
  
  context "Initialization" do

    should "require email and API key" do
      assert_raise(ArgumentError) { Dreamy::Control.new }
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
  end
  
  
end