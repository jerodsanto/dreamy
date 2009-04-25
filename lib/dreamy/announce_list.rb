module Dreamy
  class AnnounceList
    include EasyClassMaker

    attributes  :account_id, :listname, :domain, :name, :start_date, :max_bounces, :num_subscribers

    def self.new_from_xml(xml)
      l = new
      l.account_id      = (xml).at('account_id').innerHTML
      l.listname        = (xml).at('listname').innerHTML
      l.domain          = (xml).at('domain').innerHTML
      l.name            = (xml).at('name').innerHTML
      l.start_date      = (xml).at('start_date').innerHTML
      l.max_bounces     = (xml).at('max_bounces').innerHTML
      l.num_subscribers = (xml).at('num_subscribers').innerHTML
      l
    end
  end
end