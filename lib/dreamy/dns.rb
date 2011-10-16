module Dreamy
  class Dns
    include EasyClassMaker

    attributes  :account_id, :comment, :editable, :record, :type, :value, :zone, :account

    def self.new_from_xml(xml, account=nil)
      d = new
      d.account_id  = (xml).at('account_id').innerHTML.to_i
      d.comment     = (xml).at('comment').innerHTML
      d.editable    = (xml).at('editable').innerHTML.to_i
      d.record      = (xml).at('record').innerHTML
      d.type        = (xml).at('type').innerHTML
      d.value       = (xml).at('value').innerHTML
      d.zone        = (xml).at('zone').innerHTML
      d.account     = account
      d
    end

    def update new_type, new_value
      account.dns_remove record, type, value
      account.dns_add    record, new_type, new_value

      self
    end

  end
end