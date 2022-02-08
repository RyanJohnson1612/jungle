require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should be a valid object given all fields" do
      @category = Category.create(name: 'test category')
      @product = Product.new
      @product.name = "test"
      @product.price = 1000
      @product.quantity = 30
      @product.category_id = @category.id
      @product.save
      expect(@product.valid?).to be true
    end

    it "should validate that name exists" do
      @category = Category.create(name: 'test category')
      @product = Product.new
      @product.price = 1000
      @product.category_id = @category.id
      @product.save
      expect(@product.errors.messages[:name]).to include "can't be blank"
    end

    it "should validate that price exists" do
      @category = Category.create(name: 'test category')
      @product = Product.new
      @product.name = "test"
      @product.quantity = 30
      @product.category_id = @category.id
      @product.save
      expect(@product.errors.messages[:price]).to include "can't be blank"
    end

    it "should validate that quantity exists" do
      @category = Category.create(name: 'test category')
      @product = Product.new
      @product.name = "test"
      @product.price = 1000
      @product.category_id = @category.id
      @product.save
      expect(@product.errors.messages[:quantity]).to include "can't be blank"
    end

    it "should validate that category_id exists" do
      @category = Category.create(name: 'test category')
      @product = Product.new
      @product.name = "test"
      @product.price = 1000
      @product.quantity = 30
      @product.save
      expect(@product.errors.messages[:category_id]).to include "can't be blank"
    end
  end
end
