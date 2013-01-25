module Dreamy
  class Registration
    include EasyClassMaker

    attributes :account_id,
      :domain,
      :expires,
      :created,
      :modified,
      :autorenew,
      :locked,
      :expired,
      :ns1,
      :ns2,
      :ns3,
      :ns4,
      :registrant,
      :registrant_org,
      :registrant_street1,
      :registrant_street2,
      :registrant_city,
      :registrant_state,
      :registrant_zip,
      :registrant_country,
      :registrant_phone,
      :registrant_fax,
      :registrant_email,
      :tech,
      :tech_org,
      :tech_street1,
      :tech_street2,
      :tech_city,
      :tech_state,
      :tech_zip,
      :tech_country,
      :tech_phone,
      :tech_fax,
      :tech_email,
      :billing,
      :billing_org,
      :billing_street1,
      :billing_street2,
      :billing_city,
      :billing_state,
      :billing_zip,
      :billing_country,
      :billing_phone,
      :billing_fax,
      :billing_email,
      :admin,
      :admin_org,
      :admin_street1,
      :admin_street2,
      :admin_city,
      :admin_state,
      :admin_zip,
      :admin_country,
      :admin_phone,
      :admin_fax,
      :admin_email
                

    def self.new_from_xml(xml)
      instance = new
      add_from_xml(instance, xml, 'account_id')
      add_from_xml(instance, xml, 'domain')
      add_from_xml(instance, xml, 'expires')
      add_from_xml(instance, xml, 'created')
      add_from_xml(instance, xml, 'modified')
      add_from_xml(instance, xml, 'autorenew')
      add_from_xml(instance, xml, 'locked')
      add_from_xml(instance, xml, 'expired')
      add_from_xml(instance, xml, 'ns1')
      add_from_xml(instance, xml, 'ns2')
      add_from_xml(instance, xml, 'ns3')
      add_from_xml(instance, xml, 'ns4')
      add_from_xml(instance, xml, 'registrant')
      add_from_xml(instance, xml, 'registrant_org')
      add_from_xml(instance, xml, 'registrant_street1')
      add_from_xml(instance, xml, 'registrant_street2')
      add_from_xml(instance, xml, 'registrant_city')
      add_from_xml(instance, xml, 'registrant_state')
      add_from_xml(instance, xml, 'registrant_zip')
      add_from_xml(instance, xml, 'registrant_country')
      add_from_xml(instance, xml, 'registrant_phone')
      add_from_xml(instance, xml, 'registrant_fax')
      add_from_xml(instance, xml, 'registrant_email')
      add_from_xml(instance, xml, 'tech')
      add_from_xml(instance, xml, 'tech_org')
      add_from_xml(instance, xml, 'tech_street1')
      add_from_xml(instance, xml, 'tech_street2')
      add_from_xml(instance, xml, 'tech_city')
      add_from_xml(instance, xml, 'tech_state')
      add_from_xml(instance, xml, 'tech_zip')
      add_from_xml(instance, xml, 'tech_country')
      add_from_xml(instance, xml, 'tech_phone')
      add_from_xml(instance, xml, 'tech_fax')
      add_from_xml(instance, xml, 'tech_email')
      add_from_xml(instance, xml, 'billing')
      add_from_xml(instance, xml, 'billing_org')
      add_from_xml(instance, xml, 'billing_street1')
      add_from_xml(instance, xml, 'billing_street2')
      add_from_xml(instance, xml, 'billing_city')
      add_from_xml(instance, xml, 'billing_state')
      add_from_xml(instance, xml, 'billing_zip')
      add_from_xml(instance, xml, 'billing_country')
      add_from_xml(instance, xml, 'billing_phone')
      add_from_xml(instance, xml, 'billing_fax')
      add_from_xml(instance, xml, 'billing_email')
      add_from_xml(instance, xml, 'admin')
      add_from_xml(instance, xml, 'admin_org')
      add_from_xml(instance, xml, 'admin_street1')
      add_from_xml(instance, xml, 'admin_street2')
      add_from_xml(instance, xml, 'admin_city')
      add_from_xml(instance, xml, 'admin_state')
      add_from_xml(instance, xml, 'admin_zip')
      add_from_xml(instance, xml, 'admin_country')
      add_from_xml(instance, xml, 'admin_phone')
      add_from_xml(instance, xml, 'admin_fax')
      add_from_xml(instance, xml, 'admin_email')
      instance
    end

    def self.add_from_xml(domain, xml, attr)
      domain.send "#{attr}=", extract(xml, attr)
    end

    def self.extract(xml, attr)
      node = (xml).at(attr)
      value = node.innerHTML if node
      value = Integer( value ) rescue value  # make it numeric if it's an integer
    end

    def short_home
      home.gsub(".Dreamy.com","")
    end
  end
end