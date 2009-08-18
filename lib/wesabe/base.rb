module Apis
  module Wesabe
    class Base
      API_URL = 'www.wesabe.com'.freeze
      
      def initialize(args)
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
          xml = Nokogiri::XML(Base.get('/profile.xml'))
          puts xml.css('profile')
          Profile.new(xml.css('profile'))
        end
      end
      
      def accounts
        @accounts ||= begin
          xml = Nokogiri::XML(Base.get('/accounts.xml'))
          accounts = []
          xml.css('account').each do |account|
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
          xml = Nokogiri::XML(Base.get('/transactions.xml'))
          transactions = []
          xml.css('txactions').each do |transaction|
            transactions << Transaction.new(transaction)
          end
          transactions
        end
      end
      
      def transaction_search(terms)
        xml = Nokogiri::XML(Base.get("/accounts/search?q=#{terms}&format=xml"))
        transactions = []
        xml.css('txactions').each do |transaction|
          transactions << Transaction.new(transaction)
        end
        transactions
      end
      
      def self.get(url)
        req = Streamly::Request.new({
          :method => :get,
          :username => @@username,
          :password => @@password,
          :url => API_URL+url
        })
        return req.execute
      end
    end
  end
end