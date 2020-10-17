# frozen_string_literal: true

module PromotionRules
  class Product
    def initialize(code, count, new_price)
      @code = code
      @count = count
      @new_price = new_price
    end

    def apply_to(items, promo_type)
      return unless promo_type == type

      item, = items
      items_count = items.size
      items_count * new_price if code == item.code && items_count >= count
    end

    def type
      'product'
    end

    private

    attr_reader :code, :count, :new_price
  end
end
