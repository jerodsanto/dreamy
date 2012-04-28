require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyUserTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @xml = <<EOF
<data>
    <account_id>8675309</account_id>
    <disk_used_mb>123.04</disk_used_mb>
    <gecos>Joe Schmoe</gecos>
    <home>spork.Dreamy.com</home>
    <quota_mb>50</quota_mb>
    <shell>/bin/bash</shell>
    <type>mail</type>
    <username>joe@schmoe.com</username>
</data>
EOF
    end

    should "create a new user from xml" do
      u = Dreamy::User.new_from_xml(Hpricot.XML(@xml))
      assert_equal 8675309, u.account_id
      assert_equal 123.04, u.disk_used_mb
      assert_equal "Joe Schmoe", u.gecos
      assert_equal "spork.Dreamy.com", u.home
      assert_equal 50, u.quota_mb
      assert_equal "/bin/bash", u.shell
      assert_equal "mail", u.type
      assert_equal "joe@schmoe.com", u.username
    end
  end
  
end
