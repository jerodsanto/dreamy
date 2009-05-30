require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyMysqlHostTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @xml = <<EOF
<data>
  <account_id>8675309</account_id>
  <domain>mysql.site.dreamhosters.com</domain>
  <home>haass.tuna.dreamhost.com</home>
</data>
EOF
    end

    should "create a new user from xml" do
      host = Dreamy::MysqlHost.new_from_xml(Hpricot.XML(@xml))
      assert_equal 8675309, host.account_id
      assert_equal "mysql.site.dreamhosters.com", host.domain
      assert_equal "haass.tuna.dreamhost.com", host.home
    end
  end
  
end