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
  
end