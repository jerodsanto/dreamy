module Dreamy
  class PrivateServer
    include EasyClassMaker

    attributes  :account_id, :name, :type, :memory, :start_date

    def self.new_from_xml(xml)
      ps = new
      ps.account_id   = (xml).at('account_id').innerHTML.to_i
      ps.name         = (xml).at('ps').innerHTML
      ps.type         = (xml).at('type').innerHTML
      ps.memory       = (xml).at('memory_mb').innerHTML.to_i
      ps.start_date   = (xml).at('start_date').innerHTML
      ps
    end

    def self.settings_from_xml(xml)
      settings = {}
      (xml/:data).each do |d|
        settings[(d).at('setting').innerHTML] = (d).at('value').innerHTML
      end
      settings
    end

  end
end