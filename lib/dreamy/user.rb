module Dreamy
  class User
    include EasyClassMaker

    attributes  :account_id, :disk_used_mb, :gecos, :home, :password, :quota_mb, :shell, :type, :username

    def self.new_from_xml(xml)
      u = new
      u.account_id    = (xml).at('account_id').innerHTML
      u.disk_used_mb  = (xml).at('disk_used_mb').innerHTML
      u.gecos         = (xml).at('gecos').innerHTML
      u.home          = (xml).at('home').innerHTML
      u.password      = (xml).at('password').innerHTML
      u.quota_mb      = (xml).at('quota_mb').innerHTML
      u.shell         = (xml).at('shell').innerHTML
      u.type          = (xml).at('type').innerHTML
      u.username      = (xml).at('username').innerHTML
      u
    end
  end
end