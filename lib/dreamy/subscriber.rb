module Dreamy
  class Subscriber
    include EasyClassMaker

    attributes  :email, :confirmed, :subscribe_date, :name, :num_bounces

    def self.new_from_xml(xml)
      s = new
      s.email           = (xml).at('email').innerHTML
      # s.confirmed       = (xml).at('confirmed').innerHTML
      s.subscribe_date  = (xml).at('subscribe_date').innerHTML
      s.name            = (xml).at('name').innerHTML
      s.num_bounces     = (xml).at('num_bounces').innerHTML
      s
    end
  end
end