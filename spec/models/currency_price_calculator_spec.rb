require 'rails_helper'

RSpec.describe CurrencyPriceCalculator, type: :model do
  before do
      @based_data = Ticker.new
      @based_data.currency = 'BTC'
      @based_data.price = 100.0

      @currency_data = Ticker.new
      @currency_data.currency = 'ETH'
      @currency_data.price = 50.0

  end

  describe 'calculate' do
    before do
      calculator = CurrencyPriceCalculator.new(@currency_data, @based_data)
      @result = calculator.calculate
    end

    it 'result should be correct' do
      expect(@result).to eq 0.5
    end
  end

  describe 'deviding by zero' do
    before do
      @based_data.price = 0

      calculator = CurrencyPriceCalculator.new(@currency_data, @based_data)
      @result = calculator.calculate
    end

    it 'result should be nil' do
      expect(@result).to be nil
    end
  end

end