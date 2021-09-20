class Ticker < ApiModel
  attr_accessor :id, :currency, :symbol, :name, :logo_url, :status, :price, :price_date, :price_timestamp, 
    :circulating_supply, :max_supply, :market_cap, :market_cap_dominance, :num_exchanges, :num_pairs, 
    :num_pairs_unmapped, :first_candle, :first_trade, :first_order_book, :rank, :rank_delta, :high, :high_timestamp, 
    :_1d, :_7d, :_30d, :_365d, :ytd

  def initialize
    @_1d, @_7d, @_30d, @_365d, @ytd = Interval.new, Interval.new, Interval.new, Interval.new, Interval.new
  end

end