module Apis
  module Wesabe
    class Account < ApiObject
      def transactions
        @transactions ||= begin
          xml = Nokogiri::XML(Base.get("/accounts/#{self.guid}.xml"))
          transactions = []
          xml.css('account txactions').each do |transaction|
            transactions << Transaction.new(transaction)
          end
          transactions
        end
      end
    end
  end
end