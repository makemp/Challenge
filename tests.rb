# frozen_string_literal: true

require_relative 'checkout'
require_relative 'promotion_rules/product'
require_relative 'promotion_rules/order'
require_relative 'product'

def assert(left, right)
  raise "#{left} is not equal #{right}!" unless left == right
end

heart = Product.new('001', 'Lavender heart', 9.25)
cufflinks = Product.new('002', 'Personalised cufflinks', 45.00)
shirt = Product.new('003', 'Kids T-shirt', 19.95)

promotions = [PromotionRules::Order.new(60.00, 0.1),
              PromotionRules::Product.new('001', 2, 8.5)]

# Scenario 1
co = Checkout.new(promotions)
co.scan(heart)
co.scan(cufflinks)
co.scan(shirt)

assert(co.total, '£66.78')

# Scenario 2
co = Checkout.new(promotions)
co.scan(heart)
co.scan(shirt)
co.scan(heart)

assert(co.total, '£36.95')

# Scenario 3
co = Checkout.new(promotions)
co.scan(heart)
co.scan(cufflinks)
co.scan(heart)
co.scan(shirt)

assert(co.total, '£73.76')

# Scenario 4a - more products promotions

promotions = [PromotionRules::Order.new(60.00, 0.1),
              PromotionRules::Product.new('001', 2, 8.5),
              PromotionRules::Product.new('001', 3, 7.5)]

co = Checkout.new(promotions)
co.scan(heart)
co.scan(heart)
co.scan(heart)

assert(co.total, '£22.50')

# Scenario 4b - more products promotions

promotions = [PromotionRules::Order.new(60.00, 0.1),
              PromotionRules::Product.new('001', 2, 8.5),
              PromotionRules::Product.new('001', 3, 7.5)]

co = Checkout.new(promotions)
co.scan(heart)
co.scan(heart)

assert(co.total, '£17.00')

# Scenario 4c - more products promotions

promotions = [PromotionRules::Order.new(60.00, 0.1),
              PromotionRules::Product.new('001', 2, 8.5),
              PromotionRules::Product.new('001', 3, 7.5)]

co = Checkout.new(promotions)
co.scan(heart)
co.scan(heart)
co.scan(heart)
co.scan(heart)
co.scan(heart)
co.scan(heart)
co.scan(heart)
co.scan(heart)
co.scan(heart)
co.scan(heart)

assert(co.total, '£67.50')

# Scenario 5a - more order promotions

promotions = [PromotionRules::Order.new(60.00, 0.1),
              PromotionRules::Order.new(100.00, 0.2)]

co = Checkout.new(promotions)
co.scan(cufflinks)
co.scan(cufflinks)
co.scan(cufflinks)

assert(co.total, '£108.00')

# Scenario 5b - more order promotions

promotions = [PromotionRules::Order.new(60.00, 0.1),
              PromotionRules::Order.new(100.00, 0.2),
              PromotionRules::Product.new('002', 3, 30)]

co = Checkout.new(promotions)
co.scan(cufflinks)
co.scan(cufflinks)
co.scan(cufflinks)

assert(co.total, '£81.00')

# Scenario 5c - more order promotions

promotions = [PromotionRules::Order.new(60.00, 0.1),
              PromotionRules::Order.new(100.00, 0.2),
              PromotionRules::Product.new('002', 3, 35)]

co = Checkout.new(promotions)
co.scan(cufflinks)
co.scan(cufflinks)
co.scan(cufflinks)

assert(co.total, '£84.00')

# Scenario 6a - more order promotions and more product promotions

promotions = [PromotionRules::Order.new(60.00, 0.1),
              PromotionRules::Order.new(100.00, 0.2),
              PromotionRules::Product.new('002', 3, 35),
              PromotionRules::Product.new('002', 2, 40)]

co = Checkout.new(promotions)
co.scan(cufflinks)
co.scan(cufflinks)
co.scan(cufflinks)
co.scan(shirt)

assert(co.total, '£99.96')

# Scenario 6b - more order promotions and more product promotions

promotions = [PromotionRules::Order.new(60.00, 0.1),
              PromotionRules::Order.new(100.00, 0.2),
              PromotionRules::Product.new('002', 3, 35),
              PromotionRules::Product.new('002', 2, 40),
              PromotionRules::Product.new('003', 2, 15),
              PromotionRules::Product.new('003', 3, 12),
              PromotionRules::Product.new('003', 5, 9)]

co = Checkout.new(promotions)
co.scan(cufflinks)
co.scan(cufflinks)
co.scan(cufflinks)
co.scan(shirt)
co.scan(shirt)
co.scan(shirt)
co.scan(shirt)

assert(co.total, '£122.40')

# Scenario 7a - no promotions

co = Checkout.new([])
co.scan(heart)
co.scan(cufflinks)
co.scan(shirt)

assert(co.total, '£74.20')

# Scenario 7a - no promotions

co = Checkout.new(nil)
co.scan(heart)
co.scan(cufflinks)
co.scan(shirt)

assert(co.total, '£74.20')
