require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'Validations' do

    context "given all four fields set" do
      it "should save the new product successfully" do
        @category = Category.new({
            name: "Utility"
          })
        @category.save
        @product = Product.new({
            name: "Smart Bottle",
            price: 100,
            quantity: 12,
            category_id: @category.id
          })
        expect(@product.save!).to be true
      end
    end

    context "given all four fields set except 'name'" do
      it "should not save the new product" do
        @category = Category.new({
            name: "Utility"
          })
        @category.save
        @product = Product.new({
            price: 100,
            quantity: 12,
            category_id: @category.id
          })
        expect{ @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
        # @product.errors.full_messages[0] returns "Name can't be blank"
        expect(@product.errors.full_messages).to contain_exactly("Name can't be blank")
      end
    end

    context "given all four fields set except 'price'" do
      it "should not save the new product" do
        @category = Category.new({
            name: "Utility"
          })
        @category.save
        @product = Product.new({
            name: "Smart Bottle",
            quantity: 12,
            category_id: @category.id
          })
        expect{ @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
        # @product.errors.full_messages returns ["Price can't be blank", "Price cents is not a number", "Price is not a number"]
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end

    context "given all four fields set except 'quantity'" do
      it "should not save the new product" do
        @category = Category.new({
            name: "Utility"
          })
        @category.save
        @product = Product.new({
            name: "Smart Bottle",
            price: 100,
            category_id: @category.id
          })
        expect{ @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(@product.errors.full_messages).to contain_exactly("Quantity can't be blank")
      end
    end

    context "given all four fields set except 'category_id'" do
      it "should not save the new product" do
        @category = Category.new({
            name: "Utility"
          })
        @category.save
        @product = Product.new({
            name: "Smart Bottle",
            price: 100,
            quantity: 12
          })
        expect{ @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(@product.errors.full_messages).to contain_exactly("Category can't be blank")
      end
    end
  end
end
