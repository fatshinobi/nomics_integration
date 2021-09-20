class DashboardController < ApplicationController
  def index
    set_tickers(%w(BTC ETH XRP))
  rescue Exception => e
    @error_message = e.message
    render 'error_result'
  end

  def filtered
    set_tickers(%w(BTC ETH))
    @allowed_attributes = %w(circulating_supply max_supply name symbol price)
  rescue Exception => e
    @error_message = e.message
    render 'error_result'
  end

  def calculation
    @currencies_names = [
      { name: 'Bitcoin', id: 'BTC' }, 
      { name: 'Ethereum', id: 'ETH' },
      { name: 'XRP', id: 'XRP' },
      { name: 'Cardano', id: 'ADA' },
      { name: 'Tether', id: 'USDT' },
      { name: 'Solana', id: 'SOL' },
      { name: 'Polkadot', id: 'DOT' },
    ].collect{ |rec| [rec[:name], rec[:id]] } #in real app we can pull the names from api

    selected_currency = params[:currency_code]
    selected_base = params[:base_code]

    return unless selected_currency && selected_base

    set_tickers([selected_currency, selected_base])

    calculated_currency = @tickers.detect { |rec| rec.currency == selected_currency }
    based = @tickers.detect { |rec| rec.currency == selected_base }

    calculator = CurrencyPriceCalculator.new(calculated_currency, based)

    @curency_name = calculated_currency.symbol
    @base_name = based.symbol
    @result_price = calculator.calculate

  rescue Exception => e
    @error_message = e.message
    render 'error_result'
  end

  private

  def set_tickers(currencies_list)
    request = TickerApi.new
    request.currencies_list = currencies_list
    @tickers = request.process
  end
end
