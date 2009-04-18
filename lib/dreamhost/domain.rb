module DreamHost
  class Domain
    include EasyClassMaker

    attributes  :account_id, :domain, :fastcgi, :home, :hosting_type, :outside_url, :passenger,
                :path, :php, :php_fcgid, :security, :type, :unique_ip, :user, :www_or_not, :xcache

    def self.new_from_xml(xml)
      d = new
      d.account_id    = (xml).at('account_id').innerHTML
      d.domain        = (xml).at('domain').innerHTML
      d.fastcgi       = (xml).at('fastcgi').innerHTML
      d.home          = (xml).at('home').innerHTML
      d.hosting_type  = (xml).at('hosting_type').innerHTML
      d.outside_url   = (xml).at('outside_url').innerHTML
      d.passenger     = (xml).at('passenger').innerHTML
      d.path          = (xml).at('path').innerHTML
      d.php           = (xml).at('php').innerHTML
      d.php_fcgid     = (xml).at('php_fcgid').innerHTML
      d.security      = (xml).at('security').innerHTML
      d.type          = (xml).at('type').innerHTML
      d.unique_ip     = (xml).at('unique_ip').innerHTML
      d.user          = (xml).at('user').innerHTML
      d.www_or_not    = (xml).at('www_or_not').innerHTML
      d.xcache        = (xml).at('xcache').innerHTML
      d
    end
    
    def short_home
      home.gsub(".dreamhost.com","")
    end
  end
end