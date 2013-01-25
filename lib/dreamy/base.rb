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
      api_error?(doc)
      (doc/:data).inject([]) { |domains, domain| domains << Domain.new_from_xml(domain); domains }
    end

    # returns an array of registration objects
    def registrations
      doc = request("domain-list_registrations")
      api_error?(doc)
      (doc/:data).inject([]) { |registrations, registration| registrations << Registration.new_from_xml(registration); registrations }
    end

    # returns an array of user objects
    def users(passwords=false)
      if passwords
        doc = request("user-list_users")
      else
        doc = request("user-list_users_no_pw")
      end
      api_error?(doc)
      (doc/:data).inject([]) { |users, user| users << User.new_from_xml(user); users }
    end

    # returns an array of dns objects
    def dns
      doc = request("dns-list_records")
      api_error?(doc)
      (doc/:data).inject([]) { |records, dns| records << Dns.new_from_xml(dns,self); records }
    end
    
    def dns_add(record,type,value)
      doc = request("dns-add_record", {"record" => record, "type" => type, "value" => value})
      api_error?(doc)
      true
    end
    
    def dns_remove(record,type,value)
      doc = request("dns-remove_record", {"record" => record, "type" => type, "value" => value})
      api_error?(doc)
      true
    end
    
    def announce_lists
      doc = request("announcement_list-list_lists")
      api_error?(doc)
      (doc/:data).inject([]) { |lists, list| lists << AnnounceList.new_from_xml(list); lists }
    end
    
    # returns an array of subscriber objects
    def announce_list(listname,domain)
      doc = request("announcement_list-list_subscribers",{ "listname" => listname, "domain" => domain})
      api_error?(doc)
      (doc/:data).inject([]) { |subs, sub| subs << Subscriber.new_from_xml(sub); subs }
    end
    
    # adds new subscriber to announce list
    def announce_add(listname,domain,email,name="")
      doc = request("announcement_list-add_subscriber",
                      {"listname" => listname, "domain" => domain, "email" => email, "name" => name})
      api_error?(doc)
      true
    end
    
    def announce_remove(listname,domain,email)
      doc = request("announcement_list-remove_subscriber",
                      {"listname" => listname, "domain" => domain, "email" => email})
      api_error?(doc)
      true
    end

    # options:
    #   stamp        - the time to send the message, like "2009-05-28" or "2009-05-28 14:24:36"
    #   charset      - the character set in which the message is encoded
    #   type         - the format of the message, either "text" or "html"
    #   duplicate_ok - whether to allow duplicate messages to be sent, like 1 or 0
    def announce_post(listname,domain,subject,message,name,options={})
      values = {
        "listname" => listname,
        "domain" => domain,
        "subject" => subject,
        "message" => message,
        "name" => name
      }.merge(options)
      doc = request("announcement_list-post_announcement", values, true)
      api_error?(doc)
      true
    end
   
		def mail_list_filters
      doc = request("mail-list_filters")
      api_error?(doc)
      (doc/:data).inject([]) { |filters, filter| filters << MailFilter.new_from_xml(filter); filters }
		end

		def mail_add_filter(address,filter_on,filter,action,action_value,contains="",stop="",rank="")
      doc = request("mail-add_filter",
				{
					"address"       => address,
					"filter_on"     => filter_on,
					"filter"        => filter,
					"action"        => action,
					"action_value"  => action_value,
					"contains"      => contains,
					"stop"          => stop,
					"rank"          => rank
				})
      api_error?(doc)
			true
		end

    def mail_remove_filter(address,filter_on,filter,action,action_value,contains,stop,rank)
      doc = request("mail-remove_filter",
                    {
                      "address"       => address,
                      "filter_on"     => filter_on,
                      "filter"        => filter,
                      "action"        => action,
                      "action_value"  => action_value,
                      "contains"      => contains,
                      "stop"          => stop,
                      "rank"          => rank
                    })
      api_error?(doc)
      true
    end
 
    def mysql_dbs
      doc = request("mysql-list_dbs")
      api_error?(doc)
      (doc/:data).inject([]) { |dbs, db| dbs << MysqlDb.new_from_xml(db); dbs }
    end
    
    def mysql_hosts
      doc = request("mysql-list_hostnames")
      api_error?(doc)
      (doc/:data).inject([]) { |hosts, host| hosts << MysqlHost.new_from_xml(host); hosts }
    end
    
    def mysql_users
      doc = request("mysql-list_users")
      api_error?(doc)
      (doc/:data).inject([]) { |users, user| users << MysqlUser.new_from_xml(user); users }
    end
    
    def ps
      doc = request("dreamhost_ps-list_ps")
      api_error?(doc)
      (doc/:data).inject([]) { |servers, server| servers << PrivateServer.new_from_xml(server); servers }
    end
    
    def ps_settings(name)
      doc = request("dreamhost_ps-list_settings", {"ps" => name})
      api_error?(doc)
      PrivateServer.settings_from_xml(doc)
    end
    
    def ps_set(name,setting,value)
      doc = request("dreamhost_ps-set_settings", {"ps" => name, setting => value})
      api_error?(doc)
      true
    end
    
    def ps_size_history(name)
      doc = request("dreamhost_ps-list_size_history", {"ps" => name})
      api_error?(doc)
      (doc/:data).inject([]) { |sizes, size| sizes << PrivateServer.size_from_xml(size); sizes }
    end
    
    def ps_size_set(name,size)
      doc = request("dreamhost_ps-set_size", {"ps" => name, "size" => size})
      api_error?(doc)
      true
    end
    
    def ps_reboot_history(name)
      doc = request("dreamhost_ps-list_reboot_history", {"ps" => name})
      api_error?(doc)
      (doc/:data).inject([]) { |reboots,reboot| reboots << reboot.at('stamp').innerHTML; reboots }
    end
    
    def ps_reboot!(name)
      doc = request("dreamhost_ps-reboot", {"ps" => name})
      api_error?(doc)
      true
    end
    
    def ps_usage(name)
      doc = request("dreamhost_ps-list_usage", {"ps" => name})
      api_error?(doc)
      (doc/:data).inject([]) { |usages, usage| usages << PrivateServer.usage_from_xml(usage); usages }
    end
    
    def ps_add(type,movedata="no")
      doc = request("dreamhost_ps-add_ps", {"type" => type, "movedata" => movedata})
      api_error?(doc)
      true
    end
    
    def ps_remove
      doc = request("dreamhost_ps-remove_pending_ps")
      api_error?(doc)
      true
    end
    
    def ps_pending
      doc = request("dreamhost_ps-list_pending_ps")
      api_error?(doc)
      (doc/:data).inject([]) { |pends, pend| pends << PrivateServer.pending_from_xml(pend); pends }
    end

    def api_cmds
      doc = request("api-list_accessible_cmds")
      api_error?(doc)
      (doc/:data).inject([]) do |cmds, cmd|  
        cmds << [ (cmd/:cmd).first.inner_html,
                  (cmd/:args).map {|_| _.inner_html},
                  (cmd/:order).map {|_| _.inner_html} ]
        cmds
      end
    end

    private
    
    def api_error?(doc)
      raise ApiError, (doc/:data).innerHTML if (doc/:result).innerHTML == "error"
    end

    def request(cmd,values={},use_post=false)
      handle_response!(response(cmd,values,use_post))
    end

    def response(cmd,values={},use_post=false)
      values = {
        "username"  => @username,
        "key"       => @key,
        "cmd"       => cmd,
        "format"    => "xml",
        "unique_id" => UUID.new.generate
      }.merge(values)

      http = Net::HTTP.new(@@host, 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      begin
        # puts path
        response = if use_post
          request = Net::HTTP::Post.new("/")
          request.form_data = values
          http.request(request)
        else
          path = "/?#{values.to_param_array.join("&")}"
          http.get(path)
        end
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
