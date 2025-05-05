class DigitalProduct < Product 
    include DiscountEligible
    attr_reader :expiration_date, :url

    def initialize(hash)
        super
        self.expiration_date = hash['expiration_date']
        self.url = hash['url']
    end

    def url= (value)
        fail SimpleStore::Error, 'A URL do produto deve ser válida' if !value.start_with?('http')

        @url = value
    end
end