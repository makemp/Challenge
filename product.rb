# frozen_string_literal: true

class Product
  attr_reader :code, :name, :price

  def self.calculate_base_price_for(items)
    items.reduce(0) { |memo, item| memo + item.price }
  end

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end
end
