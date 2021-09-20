require 'rails_helper'

RSpec.describe Ticker, type: :model do
  describe 'json mapping' do
    before do
      @ticker = Ticker.new
      @json_str = {"id"=>"BTC", "currency"=>"BTC", "symbol"=>"BTC", "name"=>"Bitcoin", "logo_url"=>"https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg", "status"=>"active", "price"=>"47807.92061495", "price_date"=>"2021-09-17T00:00:00Z", "price_timestamp"=>"2021-09-17T16:41:00Z", "circulating_supply"=>"18818443", "max_supply"=>"21000000", "market_cap"=>"899670629041", "market_cap_dominance"=>"0.3686", "num_exchanges"=>"389", "num_pairs"=>"64576", "num_pairs_unmapped"=>"5159", "first_candle"=>"2011-08-18T00:00:00Z", "first_trade"=>"2011-08-18T00:00:00Z", "first_order_book"=>"2017-01-06T00:00:00Z", "rank"=>"1", "rank_delta"=>"0", "high"=>"63598.08983869", "high_timestamp"=>"2021-04-13T00:00:00Z", "1d"=>{"volume"=>"37587368474.06", "price_change"=>"-316.13451064", "price_change_pct"=>"-0.0066", "volume_change"=>"-4055109525.48", "volume_change_pct"=>"-0.0974", "market_cap_change"=>"-5909168178.92", "market_cap_change_pct"=>"-0.0065"}, "7d"=>{"volume"=>"292347255225.05", "price_change"=>"2829.49626277", "price_change_pct"=>"0.0629", "volume_change"=>"-127858967425.84", "volume_change_pct"=>"-0.3043", "market_cap_change"=>"53535700516.12", "market_cap_change_pct"=>"0.0633"}, "30d"=>{"volume"=>"1492954927818.73", "price_change"=>"3029.35044678", "price_change_pct"=>"0.0677", "volume_change"=>"74907642625.51", "volume_change_pct"=>"0.0528", "market_cap_change"=>"58281877702.55", "market_cap_change_pct"=>"0.0693"}, "365d"=>{"volume"=>"20689518914678.70", "price_change"=>"36879.46970520", "price_change_pct"=>"3.3746", "volume_change"=>"10006148069165.50", "volume_change_pct"=>"0.9366", "market_cap_change"=>"697578163071.28", "market_cap_change_pct"=>"3.4518"}, "ytd"=>{"volume"=>"17536995293779.55", "price_change"=>"14928.48916941", "price_change_pct"=>"0.4540", "volume_change"=>"9905790247735.78", "volume_change_pct"=>"1.2981", "market_cap_change"=>"288542510890.34", "market_cap_change_pct"=>"0.4721"}}
      @ticker.from_json(@json_str.to_json)
    end

    it 'should have correct fields values' do
      @json_str.each do |key, value|
        break if key[0].match(/^(\d)+$/)
        expect(@ticker.send(key)).to eq(value), "has incorrect #{key} field"
      end
    end

    it 'should have correct values for intervals' do
      ['1d', '7d', '30d', '365d', 'ytd'].each do |key|
        field_name = key[0].match(/^(\d)+$/) ? "_#{key}" : key
        interval_value = @ticker.send(field_name)
        json_val = @json_str[key]

        json_val.each do |i_key, i_value|
          expect(interval_value.send(i_key)).to eq(i_value), "has incorrect interval #{key} field"
        end
      end
    end

  end
end