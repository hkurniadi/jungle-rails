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
  end
end
