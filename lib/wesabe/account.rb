module Apis
  module Wesabe
    class Account < ApiObject
      def transactions
        @transactions ||= begin
          xml = Base.get("/accounts/#{self.guid}.xml")
          transactions_hash = Hash.from_xml(xml)
          puts transactions_hash.inspect
          transactions = []
          transactions_hash['account']['txactions'].each do |transaction|
            transactions << Transaction.new(transaction)
          end
          transactions
        end
      end
    end
  end
end