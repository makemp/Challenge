# frozen_string_literal: true

class Checkout
  attr_reader :total

  def initialize(promotion_rules)
    @promotion_rules = promotion_rules || []
    @items = []
  end

  def scan(item)
    @items << item

    total = calculate_product_promo_price

    total = calculate_order_promo_price(total)

    @total = format('£%.2f', total)
  end

  private

  def calculate_product_promo_price
    items.group_by(&:code).reduce(0) do |sum, (_key, items)|
      promo_price = promotion_rules.reduce(nil) do |price, rule|
        rule_price = rule.apply_to(items, 'product')
        rule_price && (price.nil? || rule_price < price) ? rule_price : price
      end

      sum + (promo_price || Product.calculate_base_price_for(items))
    end
  end

  def calculate_order_promo_price(total)
    promotion_rules.reduce(total) do |price, rule|
      rule_price = rule.apply_to(total, 'order')
      rule_price && rule_price < price ? rule_price : price
    end
  end

  attr_reader :items, :promotion_rules
end
