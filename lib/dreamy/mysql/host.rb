module Dreamy
  class MysqlHost
    include EasyClassMaker

    attributes  :account_id, :domain, :home

    def self.new_from_xml(xml)
      host = new
      host.account_id = (xml).at('account_id').innerHTML.to_i
      host.domain     = (xml).at('domain').innerHTML
      host.home       = (xml).at('home').innerHTML
      host
    end
  end
end