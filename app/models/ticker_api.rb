class TickerApi < ApiRequest
  attr_accessor :currencies_list
  attr_accessor :fiat

  def api_type
    'currencies/ticker'
  end

  def api_params
    params = @currencies_list.join(',')
    "&ids=#{params}#{ @fiat ? "&convert=#{fiat}" : '' }"
  end

  def new_model_instance
    Ticker.new
  end

end