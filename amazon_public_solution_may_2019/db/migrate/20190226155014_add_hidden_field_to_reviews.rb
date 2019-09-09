class AddHiddenFieldToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :hidden, :boolean, default: false
  end
end
