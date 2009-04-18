require File.dirname(__FILE__) + "/test_helper.rb"

class DreamySubscriberTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @xml = <<EOF
<data>
    <email>joe@schmoe.com</email>
    <confirmed>1</confirmed>
    <subscribe_date>2007-12-13 16:55:15</subscribe_date>
    <name>Josh</name>
    <num_bounces>0</num_bounces>
</data>
EOF
    end

    should "create a new user from xml" do
      s = Dreamy::Subscriber.new_from_xml(Hpricot.XML(@xml))
      assert_equal "joe@schmoe.com", s.email
      # assert_equal "1", s.confirmed
      assert_equal "2007-12-13 16:55:15", s.subscribe_date
      assert_equal "Josh", s.name
      assert_equal "0", s.num_bounces
    end
  end
  
end