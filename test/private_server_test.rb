require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyPrivateServerTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @xml = <<EOF
<data>
    <account_id>8675309</account_id>
    <ps>ps10034</ps>
    <type>web</type>
    <memory_mb>200</memory_mb>
    <start_date>2008-07-23</start_date>
</data>
EOF
    end

    should "create a new PS from xml" do
      ps = Dreamy::PrivateServer.new_from_xml(Hpricot.XML(@xml))
      assert_equal 8675309, ps.account_id
      assert_equal "ps10034", ps.name
      assert_equal "web", ps.type
      assert_equal 200, ps.memory
      assert_equal "2008-07-23", ps.start_date
    end
  end
  
  context "Settings" do
    setup do
      @xml = <<EOF
<data>
  <setting>apache2_enabled</setting>
  <value>1</value>
</data>
<data>
  <setting>comment</setting>
  <value></value>
</data>
<data>
  <setting>courier_enabled</setting>
  <value>0</value>
</data>
<data>
  <setting>jabber_transports_enabled</setting>
  <value>1</value>
</data>
<data>
  <setting>lighttpd_enabled</setting>
  <value>0</value>
</data>
<data>
  <setting>machine</setting>
  <value>ps12345</value>
</data>
<data>
  <setting>modphp_4_selected</setting>
  <value>1</value>
</data>
<data>
  <setting>php_cache_xcache</setting>
  <value>0</value>
</data>
<data>
  <setting>proftpd_enabled</setting>
  <value>1</value>
</data>
<result>success</result>
EOF
    end
    
    should "create settings hash from xml" do
      settings = Dreamy::PrivateServer.settings_from_xml(Hpricot.XML(@xml))
      assert_equal "1", settings["apache2_enabled"]
      assert_equal "", settings["comment"]
      assert_equal "0", settings["courier_enabled"]
      assert_equal "1", settings["jabber_transports_enabled"]
      assert_equal "0", settings["lighttpd_enabled"]
      assert_equal "ps12345", settings["machine"]
      assert_equal "1", settings["modphp_4_selected"]
      assert_equal "0", settings["php_cache_xcache"]
      assert_equal "1", settings["proftpd_enabled"]
    end
  end
  
end