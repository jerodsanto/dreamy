require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyDnsTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @xml = <<EOF
<data>
    <account_id>8675309</account_id>
    <comment></comment>
    <editable>0</editable>
    <record>anessalee.net</record>
    <type>A</type>
    <value>202.22.191.4</value>
    <zone>anessalee.net</zone>
  </data>
EOF
    end

    should "create a new DNS entry from xml" do
      d = Dreamy::Dns.new_from_xml(Hpricot.XML(@xml))
      assert_equal "8675309", d.account_id
      assert_equal "", d.comment
      assert_equal "0", d.editable
      assert_equal "anessalee.net", d.record
      assert_equal "A", d.type
      assert_equal "202.22.191.4", d.value
      assert_equal "anessalee.net", d.zone
    end
  end
  
end