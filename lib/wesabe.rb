require 'zlib' unless defined?(Zlib)
require 'curb' unless defined?(Curl)
require 'activesupport' unless defined?(ActiveSupport)

module Apis
  module Wesabe
    autoload :Account,                'wesabe/account'
    autoload :Base,                   'wesabe/base'
    autoload :Country,                'wesabe/country'
    autoload :Currency,               'wesabe/currency'
    autoload :FinancianInstitution,   'wesabe/financial_institution'
    autoload :Merchant,               'wesabe/merchant'
    autoload :Profile,                'wesabe/profile'
    autoload :Tag,                    'wesabe/tag'
    autoload :Transaction,            'wesabe/transaction'
    autoload :Transfer,               'wesabe/transfer'
    
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