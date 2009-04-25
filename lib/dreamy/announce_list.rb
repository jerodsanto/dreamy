module Dreamy
  class AnnounceList
    include EasyClassMaker

    attributes  :account_id, :name, :domain, :short_name, :start_date, :max_bounces, :subscribers

    def self.new_from_xml(xml)
      l = new
      l.account_id      = (xml).at('account_id').innerHTML
      l.short_name      = (xml).at('listname').innerHTML
      l.domain          = (xml).at('domain').innerHTML
      l.name            = (xml).at('name').innerHTML
      l.start_date      = (xml).at('start_date').innerHTML
      l.max_bounces     = (xml).at('max_bounces').innerHTML
      l.subscribers     = (xml).at('num_subscribers').innerHTML
      l
    end
  end
end