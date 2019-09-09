class Review < ApplicationRecord
  # This file was generated (including the `belongs_to :product`) by running
  # following command in the command-line:
  # > rails g model review rating:integer body:text product:references
  belongs_to :user
  belongs_to :product


  validates :rating, {
    numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5
    }
  }
end
