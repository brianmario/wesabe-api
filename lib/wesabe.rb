require 'rubygems' unless self.respond_to?(:gem)
require 'streamly' unless defined?(Streamly)
require 'nokogiri' unless defined?(Nokogiri)

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
      def initialize(node)
        @node = node
        @values = {}
      end
      
      def id
        method_missing(:id)
      end
      
      def method_missing(method, *args)
        if !@values.has_key?(method)
          value = @node.css(method.to_s)
          unless value.nil?
            @values[method] = value.first.text
          end
        end
        @values[method]
      end
    end
  end
end