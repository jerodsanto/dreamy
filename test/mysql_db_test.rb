require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyMysqlDbTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @xml = <<EOF
<data>
  <account_id>8675309</account_id>
  <db>betterdb2435</db>
  <description>This one's better</description>
  <home>haass.tuna.dreamhost.com</home>
  <disk_usage_mb>0.0078125</disk_usage_mb>
</data>
EOF
    end

    should "create a new user from xml" do
      db = Dreamy::MysqlDb.new_from_xml(Hpricot.XML(@xml))
      assert_equal 8675309, db.account_id
      assert_equal "betterdb2435", db.name
      assert_equal "This one's better", db.description
      assert_equal "haass.tuna.dreamhost.com", db.home
      assert_equal 0.0078125, db.disk_usage_mb
    end
  end
  
end