# frozen_string_literal: true

require 'pry'

class Shop
  attr_reader :products

  def initialize
    @products = { '1' => 'shirt', '2' => 'pants' }
  end

  def product_in_shop?(product_id)
    true if @products.key?(product_id.to_s)
  end
end
