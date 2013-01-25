require File.dirname(__FILE__) + "/test_helper.rb"

class DreamyRegistrationTest < Test::Unit::TestCase

  context "Creation" do
    setup do
      @registration_xml = <<EOF
<data>
  <account_id>400222</account_id>
  <admin>clearsightstudio.com Private Registrant</admin>
  <admin_city>Brea</admin_city>
  <admin_country>US</admin_country>
  <admin_email>clearsightstudio.com@proxy.dreamhost.com</admin_email>
  <admin_fax/>
  <admin_org>A Happy DreamHost Customer</admin_org>
  <admin_phone>+1.2139471032</admin_phone>
  <admin_state>CA</admin_state>
  <admin_street1>417 Associated Rd #324</admin_street1>
  <admin_street2/>
  <admin_zip>92821</admin_zip>
  <autorenew>yes</autorenew>
  <billing>clearsightstudio.com Private Registrant</billing>
  <billing_city>Brea</billing_city>
  <billing_country>US</billing_country>
  <billing_email>clearsightstudio.com@proxy.dreamhost.com</billing_email>
  <billing_fax/>
  <billing_org>A Happy DreamHost Customer</billing_org>
  <billing_phone>+1.2139471032</billing_phone>
  <billing_state>CA</billing_state>
  <billing_street1>417 Associated Rd #324</billing_street1>
  <billing_street2/>
  <billing_zip>92821</billing_zip>
  <created>2010-03-31 11:22:59</created>
  <domain>clearsightstudio.com</domain>
  <expired>no</expired>
  <expires>2014-03-31 11:22:59</expires>
  <locked>yes</locked>
  <modified>2011-03-21 15:26:29</modified>
  <ns1>ns1.dreamhost.com</ns1>
  <ns2>ns2.dreamhost.com</ns2>
  <ns3>ns3.dreamhost.com</ns3>
  <ns4/>
  <registrant>clearsightstudio.com Private Registrant</registrant>
  <registrant_city>Brea</registrant_city>
  <registrant_country>US</registrant_country>
  <registrant_email>clearsightstudio.com@proxy.dreamhost.com</registrant_email>
  <registrant_fax/>
  <registrant_org>A Happy DreamHost Customer</registrant_org>
  <registrant_phone>+1.2139471032</registrant_phone>
  <registrant_state>CA</registrant_state>
  <registrant_street1>417 Associated Rd #324</registrant_street1>
  <registrant_street2/>
  <registrant_zip>92821</registrant_zip>
  <tech>clearsightstudio.com Private Registrant</tech>
  <tech_city>Brea</tech_city>
  <tech_country>US</tech_country>
  <tech_email>clearsightstudio.com@proxy.dreamhost.com</tech_email>
  <tech_fax/>
  <tech_org>A Happy DreamHost Customer</tech_org>
  <tech_phone>+1.2139471032</tech_phone>
  <tech_state>CA</tech_state>
  <tech_street1>417 Associated Rd #324</tech_street1>
  <tech_street2/>
  <tech_zip>92821</tech_zip>
</data>
EOF

      @d = Dreamy::Registration.new_from_xml(Hpricot.XML(@registration_xml))
    end

    should "assign valid http registration from xml" do
      assert_equal 400222, @d.account_id
      assert_equal "clearsightstudio.com", @d.domain
      assert_equal "2014-03-31 11:22:59", @d.expires
      assert_equal "2010-03-31 11:22:59", @d.created
      assert_equal "2011-03-21 15:26:29", @d.modified
      assert_equal "yes", @d.autorenew
      assert_equal "yes", @d.locked
      assert_equal "no", @d.expired
      assert_equal "ns1.dreamhost.com", @d.ns1
      assert_equal "ns2.dreamhost.com", @d.ns2
      assert_equal "ns3.dreamhost.com", @d.ns3
      assert_equal "clearsightstudio.com Private Registrant", @d.registrant
      assert_equal "A Happy DreamHost Customer", @d.registrant_org
      assert_equal "417 Associated Rd #324", @d.registrant_street1
      assert_equal "Brea", @d.registrant_city
      assert_equal "CA", @d.registrant_state
      assert_equal 92821, @d.registrant_zip
      assert_equal "US", @d.registrant_country
      assert_equal "+1.2139471032", @d.registrant_phone
      assert_equal "clearsightstudio.com@proxy.dreamhost.com", @d.registrant_email
      assert_equal "clearsightstudio.com Private Registrant", @d.tech
      assert_equal "A Happy DreamHost Customer", @d.tech_org
      assert_equal "417 Associated Rd #324", @d.tech_street1
      assert_equal "Brea", @d.tech_city
      assert_equal "CA", @d.tech_state
      assert_equal 92821, @d.tech_zip
      assert_equal "US", @d.tech_country
      assert_equal "+1.2139471032", @d.tech_phone
      assert_equal "clearsightstudio.com@proxy.dreamhost.com", @d.tech_email
      assert_equal "clearsightstudio.com Private Registrant", @d.billing
      assert_equal "A Happy DreamHost Customer", @d.billing_org
      assert_equal "417 Associated Rd #324", @d.billing_street1
      assert_equal "Brea", @d.billing_city
      assert_equal "CA", @d.billing_state
      assert_equal 92821, @d.billing_zip
      assert_equal "US", @d.billing_country
      assert_equal "+1.2139471032", @d.billing_phone
      assert_equal "clearsightstudio.com@proxy.dreamhost.com", @d.billing_email
      assert_equal "clearsightstudio.com Private Registrant", @d.admin
      assert_equal "A Happy DreamHost Customer", @d.admin_org
      assert_equal "417 Associated Rd #324", @d.admin_street1
      assert_equal "Brea", @d.admin_city
      assert_equal "CA", @d.admin_state
      assert_equal 92821, @d.admin_zip
      assert_equal "US", @d.admin_country
      assert_equal "+1.2139471032", @d.admin_phone
      assert_equal "clearsightstudio.com@proxy.dreamhost.com", @d.admin_email
    end
  end
  
end