module Dreamy
  class MysqlUser
    include EasyClassMaker

    attributes  :account_id, :db, :home, :username, :host, :select, :insert,
                :update, :delete, :create, :drop, :index, :alter

    def self.new_from_xml(xml)
      u = new
      u.account_id = (xml).at('account_id').innerHTML.to_i
      u.db         = (xml).at('db').innerHTML
      u.home       = (xml).at('home').innerHTML
      u.username   = (xml).at('username').innerHTML
      u.host       = (xml).at('host').innerHTML
      u.select     = (xml).at('select_priv').innerHTML
      u.insert     = (xml).at('insert_priv').innerHTML
      u.update     = (xml).at('update_priv').innerHTML
      u.delete     = (xml).at('delete_priv').innerHTML
      u.create     = (xml).at('create_priv').innerHTML
      u.drop       = (xml).at('drop_priv').innerHTML
      u.index      = (xml).at('index_priv').innerHTML
      u.alter      = (xml).at('alter_priv').innerHTML
      u
    end
  end
end