class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.string :image_url

      t.timestamps null: false
    end
  end
end
