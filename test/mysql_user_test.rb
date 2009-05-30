require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyMysqlUserTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @xml = <<EOF
<data>
  <account_id>8675309</account_id>
  <db>betterdb2435</db>
  <home>haass.tuna.dreamhost.com</home>
  <username>user_fu</username>
  <host>haass.tuna.dreamhost.com</host>
  <select_priv>Y</select_priv>
  <insert_priv>Y</insert_priv>
  <update_priv>N</update_priv>
  <delete_priv>Y</delete_priv>
  <create_priv>N</create_priv>
  <drop_priv>Y</drop_priv>
  <index_priv>Y</index_priv>
  <alter_priv>N</alter_priv>
</data>
EOF
    end

    should "create a new user from xml" do
      u = Dreamy::MysqlUser.new_from_xml(Hpricot.XML(@xml))
      assert_equal 8675309, u.account_id
      assert_equal "betterdb2435", u.db
      assert_equal "haass.tuna.dreamhost.com", u.home
      assert_equal "user_fu", u.username
      assert_equal "haass.tuna.dreamhost.com", u.host
      assert_equal "Y", u.select
      assert_equal "Y", u.insert
      assert_equal "N", u.update
      assert_equal "Y", u.delete
      assert_equal "N", u.create
      assert_equal "Y", u.drop
      assert_equal "Y", u.index
      assert_equal "N", u.alter
    end
  end
  
end