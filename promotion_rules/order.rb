# frozen_string_literal: true

module PromotionRules
  class Order
    def initialize(border_total, promo_ratio)
      @border_total = border_total
      @promo_ratio  = promo_ratio
    end

    def apply_to(base_total, promo_type)
      return unless promo_type == type
      return base_total * (1 - promo_ratio) if base_total > border_total

      base_total
    end

    def type
      'order'
    end

    private

    attr_reader :border_total, :promo_ratio
  end
end
