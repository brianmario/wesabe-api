require 'zlib' unless defined?(Zlib)
require 'curb' unless defined?(Curl)

module Apis
  module Wesabe
    autoload :Account,                'apis/wesabe/account'
    autoload :Base,                   'apis/wesabe/base'
    autoload :Country,                'apis/wesabe/country'
    autoload :Currency,               'apis/wesabe/currency'
    autoload :FinancianInstitution,   'apis/wesabe/financial_institution'
    autoload :Merchant,               'apis/wesabe/merchant'
    autoload :Profile,                'apis/wesabe/profile'
    autoload :Tag,                    'apis/wesabe/tag'
    autoload :Transaction,            'apis/wesabe/transaction'
    autoload :Transfer,               'apis/wesabe/transfer'
    
    class ApiObject
      def initialize(hash)
        @hash = hash
      end
      
      def method_missing(method, *args)
        @hash[method.to_s]
      end
    end
  end
end