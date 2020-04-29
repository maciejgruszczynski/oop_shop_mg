# frozen_string_literal: true

require 'spec_helper'
require_relative '../cart'

RSpec.describe Cart do
  describe '#add_product' do
    subject { described_class.new }

    describe 'product in shop' do
      context 'quantity is valild' do
        it 'adds product to cart for the first time' do
          subject.add_product(1, 2)

          expect(subject.cart_items).to eq({ '1' => 2 })
        end

        it 'adds product to cart if already present in the cart' do
          subject.cart_items['1'] = 2
          subject.add_product(1, 3)

          expect(subject.cart_items).to eq({ '1' => 5 })
        end
      end
    end

    describe 'product not in the shop' do
      it 'cannot add product - errors expected' do
        subject.add_product(5, 2)

        expect(subject.errors).to eq(['Product with id=5 is not available'])
      end
    end

    describe 'remove product from cart' do
      it 'can remove existing product' do
        subject.cart_items.merge!('1' => 5, '2' => 3)
        subject.remove_product(1)

        expect(subject.cart_items).to eq({ '2' => 3 })
      end
    end

    describe 'clean cart' do
      it 'can remove all products from cart' do
        subject.cart_items.merge!('1' => 5, '2' => 3)
        subject.clean_cart

        expect(subject.cart_items).to eq({})
      end
    end

    describe 'update products in cart' do
      it 'can update quantity' do
        subject.cart_items.merge!('1' => 5, '2' => 3)
        subject.update_cart_items('1' => 4, '2' => 3)

        expect(subject.cart_items).to eq({ '1' => 4, '2' => 3 })
      end
    end
  end
end
