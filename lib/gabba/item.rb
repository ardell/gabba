module Gabba
  class Gabba
    module Item

      # Public:  Track an item purchased in an ecommerce transaction to Google Analytics.
      # (http://code.google.com/apis/analytics/docs/gaJS/gaJSApiEcommerce.html#_gat.GA_Tracker_._addItem)
      #
      # order_id    - (required) Maps to utmtid. URL-encoded order ID.
      # item_sku    - (required) Maps to utmipc. Product SKU/code
      # price       - (required) Maps to utmipr. Unit price
      # quantity    - (required) Maps to utmiqt. Quantity
      # currency    - (optional) Maps to utmcu. String with the currency code (default: USD), allowed currencies on https://developers.google.com/analytics/devguides/platform/currencies.
      # name        - (optional) Maps to utmipn. Product name (default: nil)
      # category    - (optional) Maps to utmiva. Category or variation (default: nil)
      # utmhid      - (optional) Maps to utmhid. String with the unique visitor id (default: random_id).

      #
      # Examples:
      #
      #   g = Gabba::Gabba.new("UT-1234", "mydomain.com")
      #   g.add_item("123456789", "SKU0000", "100.00", "2")
      #
      #   g = Gabba::Gabba.new("UT-6666", "myawesomeshop.net")
      #   g.add_item("123456789", "SKU0000", "100.00", "2", "ARS", "Product Name", "Clothing")
      #

      def add_item(order_id, item_sku, price, quantity, currency = @utmcu, name = nil, category = nil, utmhid = random_id)
        check_account_params
        hey(item_params(order_id, item_sku, price, quantity, currency, name, category, utmhid))
      end

      # Public: Renders item purchase params data in the format needed for GA
      # Called before actually sending the data along to GA in Gabba#add_item
      def item_params(order_id, item_sku, price, quantity, currency, name, category, utmhid)
        {
          :utmwv => @utmwv,
          :utmn => @utmn,
          :utmhn => @utmhn,
          :utmt => 'item',
          :utmcs => @utmcs,
          :utmul => @utmul,
          :utmhid => utmhid,
          :utmac => @utmac,
          :utmcc => @utmcc || cookie_params,
          :utmtid => order_id,
          :utmipc => item_sku,
          :utmipn => name,
          :utmiva => category,
          :utmipr => price,
          :utmiqt => quantity,
          :utmr => @utmr,
          :utmcu => currency,
          :utmip => @utmip,
          :utme => self.custom_var_data
        }
      end
    end
  end
end
