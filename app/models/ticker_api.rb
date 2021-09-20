class TickerApi < ApiRequest
  attr_accessor :currencies_list

  def api_type
    'currencies/ticker'
  end

  def api_params
    params = @currencies_list.join(',')
    "&ids=#{params}"
  end

  def new_model_instance
    Ticker.new
  end

end