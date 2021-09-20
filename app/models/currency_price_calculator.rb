class CurrencyPriceCalculator
  def initialize(currency_data, based_data)
    @currency_data, @based_data = currency_data, based_data
  end

  def calculate
    return nil if @based_data.price.to_f == 0
    @currency_data.price.to_f / @based_data.price.to_f
  end
end