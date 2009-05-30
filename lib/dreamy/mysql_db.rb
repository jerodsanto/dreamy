module Dreamy
  class MysqlDb
    include EasyClassMaker

    attributes  :account_id, :name, :description, :home, :disk_usage_mb

    def self.new_from_xml(xml)
      db = new
      db.account_id     = (xml).at('account_id').innerHTML.to_i
      db.name           = (xml).at('db').innerHTML
      db.description    = (xml).at('description').innerHTML
      db.home           = (xml).at('home').innerHTML
      db.disk_usage_mb  = (xml).at('disk_usage_mb').innerHTML.to_f
      db
    end
  end
end