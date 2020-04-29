# frozen_string_literal: true

require 'pry'
require_relative 'shop'

class Cart
  attr_reader :cart_items
  attr_reader :errors
  attr_reader :shop

  def initialize
    @shop = Shop.new
    @cart_items = {}
    @errors = []
  end

  def add_product(product_id, quantity)
    if shop.product_in_shop?(product_id)
      if product_in_cart?(product_id)
        increase_product_quantity(product_id, quantity)
      else
        @cart_items.merge!(product_id.to_s => quantity)
      end
    else
      @errors << "Product with id=#{product_id} is not available"
    end
  end

  def remove_product(product_id)
    @cart_items.delete(product_id.to_s)
  end

  def update_cart_items(params)
    @cart_items = params
  end

  def clean_cart
    @cart_items = {}
  end

  private

  def product_in_cart?(product_id)
    true if @cart_items.key?(product_id.to_s)
  end

  def increase_product_quantity(item_id, quantity)
    current_quantity = @cart_items[item_id.to_s]
    new_quantity = current_quantity + quantity
    @cart_items[item_id.to_s] = new_quantity
  end
end
