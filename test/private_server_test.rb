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
  
  context "Sizes" do
    setup do
      @xml = <<EOF
<data>
  <memory_mb>2300</memory_mb>
  <monthly_cost>0.00</monthly_cost>
  <period_cost>0.0000</period_cost>
  <period_seconds>715</period_seconds>
  <stamp>2009-04-29 16:28:28</stamp>
</data>
EOF
    end
    
    should "create size hash from xml" do
      size = Dreamy::PrivateServer.size_from_xml(Hpricot.XML(@xml))
      assert_equal 2300, size["memory_mb"]
      assert_equal 0.00, size["monthly_cost"]
      assert_equal 0.0000, size["period_cost"]
      assert_equal 715, size["period_seconds"]
      assert_equal "2009-04-29 16:28:28", size["stamp"]
    end
  end
  
  context "Usage" do
    setup do
      @xml = <<EOF
<data>
    <load>0.02</load>
    <memory_mb>146</memory_mb>
    <stamp>2009-05-02 17:26:44</stamp>
</data>
EOF
    end
    
    should "create usage hash from xml" do
      usage = Dreamy::PrivateServer.usage_from_xml(Hpricot.XML(@xml))
      assert_equal 0.02, usage["load"]
      assert_equal 146, usage["memory_mb"]
      assert_equal "2009-05-02 17:26:44", usage["stamp"]
    end
  end
  
end