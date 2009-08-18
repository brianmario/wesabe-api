module Apis
  module Wesabe
    class Merchant < ApiObject
      def transactions
        if @transactions_by_merchant.has_key?(self.id)
          @transactions_by_merchant[self.id]
        else
          @transactions_by_merchant[self.id] ||= begin
            xml = Nokogiri::XML(Base.get("/transactions/merchant/#{self.id}.xml"))
            transactions = []
            xml.css('merchant txactions').each do |transaction|
              transactions << Transaction.new(transaction)
            end
            transactions
          end
        end
      end
    end
  end
end