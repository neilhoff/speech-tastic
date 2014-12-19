class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.string :link
      t.string :category
      t.string :type

      t.timestamps
    end
  end
end
