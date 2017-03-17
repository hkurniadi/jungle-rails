class Review < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :user_id, presence: true

  validate :rating_or_description

  private

  def rating_or_description
    errors.add("Please rate or comment") if !rating && !description
  end
end
