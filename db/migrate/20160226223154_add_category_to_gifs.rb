class AddCategoryToGifs < ActiveRecord::Migration
  def change
    add_column :gifs, :category, :string
  end
end
