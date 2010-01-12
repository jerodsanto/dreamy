module Dreamy
  class MailFilter
    include EasyClassMaker

    attributes	:account_id, :address, :rank, :filter, :filter_on, :action_value, :action, :contains, :stop

    def self.new_from_xml(xml)
      f = new
      f.account_id        = (xml).at('account_id').innerHTML.to_i
      f.address           = (xml).at('address').innerHTML
      f.rank              = (xml).at('rank').innerHTML.to_i
      f.filter            = (xml).at('filter').innerHTML
      f.filter_on         = (xml).at('filter_on').innerHTML
      f.action            = (xml).at('action').innerHTML
      f.action_value      = (xml).at('action_value').innerHTML
      f.contains          = (xml).at('contains').innerHTML
      f.stop              = (xml).at('stop').innerHTML
      f
    end
  end
end
