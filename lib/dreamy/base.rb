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
                      {"listname" => listname, "domain" => domain, "email" => email} )
      return true if (doc/:result).innerHTML == "success"
      false
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