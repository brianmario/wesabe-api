module Apis
  module Wesabe
    class Base
      API_URL = 'www.wesabe.com'.freeze
      
      def initialize(*args)
        if args.is_a?(Hash)
          @@username = args[:username]
          @@password = args[:password]
        elsif args.is_a?(Array)
          @@username = args[0]
          @@password = args[1]
        end
        
        @transactions_by_merchant = {}
      end
      
      def profile
        @profile ||= begin
          xml = Base.get('/profile.xml')
          profile = Hash.from_xml(xml)
          Profile.new(profile['profile'])
        end
      end
      
      def accounts
        @accounts ||= begin
          xml = Base.get('/accounts.xml')
          accounts_hash = Hash.from_xml(xml)
          accounts = []
          accounts_hash['accounts']['account'].each do |account|
            accounts << Account.new(account)
          end
          accounts
        end
      end
      
      def account(id)
        accounts.find {|a| a.id.to_s == id.to_s || a.guid.to_s == id.to_s}
      end
      
      def transactions
        @transactions ||= begin
          xml = Base.get("/transactions.xml")
          transactions_hash = Hash.from_xml(xml)
          puts transactions_hash.inspect
          transactions = []
          transactions_hash['txactions'].each do |transaction|
            transactions << Transaction.new(transaction)
          end
          transactions
        end
      end
      
      def transaction_search(terms)
        xml = Base.get("/accounts/search?q=#{terms}&format=xml")
        transactions_hash = Hash.from_xml(xml)
        transactions = []
        transactions_hash['txactions'].each do |transaction|
          transactions << Transaction.new(transaction)
        end
        transactions
      end
      
      def self.get(url)
        @curl = Curl::Easy.new
        @curl.follow_location = true
        @curl.connect_timeout = 5
        @curl.timeout = 5
        @curl.dns_cache_timeout = 5
        @curl.userpwd = "#{@@username}:#{@@password}"
        @curl.url = API_URL+url
        @curl.perform
        return @curl.body_str
      end
    end
  end
end