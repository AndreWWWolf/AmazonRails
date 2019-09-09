class Product < ApplicationRecord
   belongs_to :user
   has_many :reviews, dependent: :destroy


  validates(:title, presence: true, uniqueness: true, case_sensitive: false)
  validates(:price, numericality: { greater_than: 0 })
  validates(:description, presence: true, length: { minimum: 10 })
  before_validation :set_default_value_price
  before_save :capitalize_product_title
  # validate: (:set_default_value_price)

  scope(:search, ->(query) { where("title ILIKE ?", "%#{query}%") })

  private

  def set_default_value_price
    self.price ||= 1
  end

  def capitalize_product_title
    self.title.capitalize!
  end
end
