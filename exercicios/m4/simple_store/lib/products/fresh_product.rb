class FreshProduct < Product
    include DiscountEligible
    attr_reader :expiration_date

    def initialize(hash)
        super
        self.expiration_date = hash['expiration_date']
    end
end
