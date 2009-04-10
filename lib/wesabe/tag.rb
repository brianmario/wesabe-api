module Apis
  module Wesabe
    class Tag < ApiObject
      def initialize(*args)
        super
        @transactions_by_tag = {}
      end
      
      def transactions
        if @transactions_by_tag.has_key?(self.name)
          @transactions_by_tag[self.name]
        else
          @transactions_by_tag[self.name] ||= begin
            xml = Base.get("/transactions/tag/#{self.name}.xml")
            transactions_hash = Hash.from_xml(xml)
            transactions = []
            transactions_hash['txactions'].each do |transaction|
              transactions << Transaction.new(transaction)
            end
            transactions
          end
        end
      end
    end
  end
end