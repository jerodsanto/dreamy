module Dreamy
  class Base

    @@host = "api.dreamhost.com"

    def initialize(username, key)
      @username = username
      @key      = key
    end

    # returns an array of domain objects
    def domains
      doc = request("domain-list_domains")
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      (doc/:data).inject([]) { |domains, domain| domains << Domain.new_from_xml(domain); domains }
    end

    # returns an array of user objects
    def users(passwords=false)
      if passwords
        doc = request("user-list_users")
      else
        doc = request("user-list_users_no_pw")
      end
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      (doc/:data).inject([]) { |users, user| users << User.new_from_xml(user); users }
    end

    # returns an array of dns objects
    def dns
      doc = request("dns-list_records")
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      (doc/:data).inject([]) { |records, dns| records << Dns.new_from_xml(dns); records }
    end
    
    def dns_add(record,type,value)
      doc = request("dns-add_record", {"record" => record, "type" => type, "value" => value})
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      true
    end
    
    def dns_remove(record,type,value)
      doc = request("dns-remove_record", {"record" => record, "type" => type, "value" => value})
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      true
    end
    
    def announce_lists
      doc = request("announcement_list-list_lists")
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      (doc/:data).inject([]) { |lists, list| lists << AnnounceList.new_from_xml(list); lists }
    end
    
    # returns an array of subscriber objects
    def announce_list(listname,domain)
      doc = request("announcement_list-list_subscribers",{ "listname" => listname, "domain" => domain})
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      (doc/:data).inject([]) { |subs, sub| subs << Subscriber.new_from_xml(sub); subs }
    end
    
    # adds new subscriber to announce list
    def announce_add(listname,domain,email,name="")
      doc = request("announcement_list-add_subscriber",
                      {"listname" => listname, "domain" => domain, "email" => email, "name" => name})
      return true if (doc/:result).innerHTML == "success"
      false
    end
    
    def announce_remove(listname,domain,email)
      doc = request("announcement_list-remove_subscriber",
                      {"listname" => listname, "domain" => domain, "email" => email})
      return true if (doc/:result).innerHTML == "success"
      false
    end
    
    def ps
      doc = request("dreamhost_ps-list_ps")
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      (doc/:data).inject([]) { |servers, server| servers << PrivateServer.new_from_xml(server); servers }
    end
    
    def ps_settings(name)
      doc = request("dreamhost_ps-list_settings", {"ps" => name})
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      PrivateServer.settings_from_xml(doc)
    end
    
    def ps_set(name,setting,value)
      doc = request("dreamhost_ps-set_settings", {"ps" => name, setting => value})
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      true
    end
    
    def ps_size_history(name)
      doc = request("dreamhost_ps-list_size_history", {"ps" => name})
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      (doc/:data).inject([]) { |sizes, size| sizes << PrivateServer.size_from_xml(size); sizes }
    end
    
    def ps_size_set(name,size)
      doc = request("dreamhost_ps-set_size", {"ps" => name, "size" => size})
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      true
    end
    
    def ps_reboot_history(name)
      doc = request("dreamhost_ps-list_reboot_history", {"ps" => name})
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      (doc/:data).inject([]) { |reboots,reboot| reboots << reboot.at('stamp').innerHTML; reboots }
    end
    
    def ps_reboot!(name)
      doc = request("dreamhost_ps-reboot", {"ps" => name})
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
      true
    end

    private

    def request(cmd,values={})
      handle_response!(response(cmd,values))
    end


    def response(cmd,values={})
      values = {
        "username"  => @username,
        "key"       => @key,
        "cmd"       => cmd,
        "format"    => "xml",
        "unique_id" => UUID.new.generate
      }.merge(values)

      path = "/?#{values.to_param_array.join("&")}"
      http = Net::HTTP.new(@@host, 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      begin
        # puts path
        response = http.get(path)
      rescue => error
        raise CantConnect, error.message
      end
    end

    def handle_response!(response)
      if %w[200 304].include?(response.code)
        response = parse(response.body)
      elsif response.code == '503'
        raise Unavailable, response.message
      elsif response.code == '401'
        raise CantConnect, 'Authentication failed. Check your username and password'
      else
        raise CantConnect, "Dreamy is returning a #{response.code}: #{response.message}"
      end
    end

    # Converts a string response into an Hpricot xml element.
    def parse(response)
      Hpricot.XML(response || '')
    end

  end
end