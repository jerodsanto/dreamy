require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyDomainTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @domain_xml = <<EOF
<data>
  <account_id>8675309</account_id>
  <domain>anessalee.net</domain>
  <fastcgi>0</fastcgi>
  <home>juniormint.Dreamy.com</home>
  <hosting_type>full</hosting_type>
  <outside_url></outside_url>
  <passenger>0</passenger>
  <path>anessalee.net</path>
  <php>pcgi5</php>
  <php_fcgid>0</php_fcgid>
  <security>0</security>
  <type>http</type>
  <unique_ip></unique_ip>
  <user>sant0sk1</user>
  <www_or_not>both_work</www_or_not>
  <xcache>0</xcache>
</data>
EOF

      @mysql_xml = <<EOF
<data>
  <account_id>8675309</account_id>
  <domain>mysql.anessalee.net</domain>
  <home>zechiel.swordfish.Dreamy.com</home>
  <type>mysqldns</type>
  <unique_ip></unique_ip>
</data>
EOF

    @d = Dreamy::Domain.new_from_xml(Hpricot.XML(@domain_xml))
    @m = Dreamy::Domain.new_from_xml(Hpricot.XML(@mysql_xml))
    end

    should "assign valid http domain from xml" do
      assert_equal "8675309", @d.account_id
      assert_equal "anessalee.net", @d.domain
      assert_equal "0", @d.fastcgi
      assert_equal "juniormint.Dreamy.com", @d.home
      assert_equal "full", @d.hosting_type
      assert_equal "", @d.outside_url
      assert_equal "0", @d.passenger
      assert_equal "anessalee.net", @d.path
      assert_equal "pcgi5", @d.php
      assert_equal "0", @d.php_fcgid
      assert_equal "0", @d.security
      assert_equal "http", @d.type
      assert_equal "", @d.unique_ip
      assert_equal "sant0sk1", @d.user
      assert_equal "both_work", @d.www_or_not
      assert_equal "0", @d.xcache
    end
    
    should "assign valid mysql domain from xml" do
      assert_equal "8675309", @m.account_id
      assert_equal "mysql.anessalee.net", @m.domain
      assert_equal "zechiel.swordfish.Dreamy.com", @m.home
      assert_equal "mysqldns", @m.type
      assert_equal "", @m.unique_ip
    end
    
    should "return shortened server name if requested" do
      assert_equal "juniormint", @d.short_home
    end
  end
  
end