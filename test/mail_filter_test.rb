require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyMailFilterTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @xml = <<EOF
<data>
    <account_id>8675309</account_id>
    <address>test@anessalee.net</address>
    <filter_on>from</filter_on>
    <filter>sender@mydomain.com</filter>
    <action>forward</action>
    <action_value>test2@anessalee.net</action_value>
    <contains></contains>
    <stop></stop>
    <rank>0</rank>
</data>
EOF
    end

    should "create a new user from xml" do
      s = Dreamy::MailFilter.new_from_xml(Hpricot.XML(@xml))
      assert_equal 8675309, s.account_id
      assert_equal "test@anessalee.net", s.address
      assert_equal "from", s.filter_on
      assert_equal "sender@mydomain.com", s.filter
      assert_equal "forward", s.action
      assert_equal "test2@anessalee.net", s.action_value
      assert_equal "", s.contains
      assert_equal "", s.stop
      assert_equal 0, s.rank
    end
  end

end