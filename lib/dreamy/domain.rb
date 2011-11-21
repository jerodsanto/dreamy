module Dreamy
  class Domain
    include EasyClassMaker

    attributes  :account_id, :domain, :fastcgi, :home, :hosting_type, :outside_url, :passenger,
                :path, :php, :php_fcgid, :security, :type, :unique_ip, :user, :www_or_not, :xcache

    def self.new_from_xml(xml)
      instance = new
      add_from_xml(instance, xml, 'account_id')
      add_from_xml(instance, xml, 'domain')
      add_from_xml(instance, xml, 'fastcgi')
      add_from_xml(instance, xml, 'home')
      add_from_xml(instance, xml, 'hosting_type')
      add_from_xml(instance, xml, 'outside_url')
      add_from_xml(instance, xml, 'passenger')
      add_from_xml(instance, xml, 'path')
      add_from_xml(instance, xml, 'php')
      add_from_xml(instance, xml, 'php_fcgid')
      add_from_xml(instance, xml, 'security')
      add_from_xml(instance, xml, 'type')
      add_from_xml(instance, xml, 'unique_ip')
      add_from_xml(instance, xml, 'user')
      add_from_xml(instance, xml, 'www_or_not')
      add_from_xml(instance, xml, 'xcache')
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