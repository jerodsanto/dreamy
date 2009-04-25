require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyAnnounceListTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @xml = <<EOF
<data>
  <name>Super Announce</name>
  <account_id>8675309</account_id>
  <domain>anessalee.net</domain>
  <listname>testlist</listname>
  <max_bounces>5</max_bounces>
  <num_subscribers>22</num_subscribers>
  <start_date>2009-04-20</start_date>
</data>
EOF
    end

    should "create a new list of announce lists from xml" do
      l = Dreamy::AnnounceList.new_from_xml(Hpricot.XML(@xml))
      assert_equal "Super Announce", l.name
      assert_equal "8675309", l.account_id
      assert_equal "anessalee.net", l.domain
      assert_equal "testlist", l.short_name
      assert_equal "5", l.max_bounces
      assert_equal "22", l.num_subscribers
      assert_equal "2009-04-20", l.start_date
    end
  end
  
end