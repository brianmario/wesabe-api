module Apis
  module Wesabe
    class Merchant < ApiObject
      def transactions
        if @transactions_by_merchant.has_key?(self.id)
          @transactions_by_merchant[self.id]
        else
          @transactions_by_merchant[self.id] ||= begin
            xml = Base.get("/transactions/merchant/#{self.id}.xml")
            transactions_hash = Hash.from_xml(xml)
            transactions = []
            transactions_hash['merchant']['txactions'].each do |transaction|
              transactions << Transaction.new(transaction)
            end
            transactions
          end
        end
      end
    end
  end
end