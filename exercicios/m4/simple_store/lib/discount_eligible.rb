module DiscountEligible

  def has_discount?
    days_to_expire >= 0 && days_to_expire <= 30
  end

  def discount_percentage
    if has_discount?
      -(0.6/30) * days_to_expire + 0.6
    else
      0
    end
  end

  #
  # @return [Fixnum] The number of days until the product expiration date.
  #
  def days_to_expire
    date_today = Date.today
    days_to_expire = Date.parse(expiration_date)

    (days_to_expire - date_today).to_i
  end

  #
  # @return [Float] The amount of discount, with at most 2 decimal places.
  #
  def discount_amount
    (price * discount_percentage).round(2)
  end

  #
  # @return [Float] the price of the product considering the discount_amount.
  # The value must be rounded to at most 2 decimal places.
  #
  def discounted_price
    (price-discount_amount).round(2)
  end
end
