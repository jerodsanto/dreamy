module Dreamy
  class User
    include EasyClassMaker

    attributes  :account_id, :disk_used_mb, :gecos, :home, :password, :quota_mb, :shell, :type, :username

    def self.new_from_xml(xml)
      u = new
      u.account_id    = (xml).at('account_id').innerHTML.to_i
      u.disk_used_mb  = (xml).at('disk_used_mb').innerHTML.to_f
      u.gecos         = (xml).at('gecos').innerHTML
      u.home          = (xml).at('home').innerHTML
      u.quota_mb      = (xml).at('quota_mb').innerHTML.to_i
      u.shell         = (xml).at('shell').innerHTML
      u.type          = (xml).at('type').innerHTML
      u.username      = (xml).at('username').innerHTML
      u
    end
  end
end
