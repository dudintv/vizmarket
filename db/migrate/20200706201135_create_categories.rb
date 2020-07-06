class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title, unique: true

      t.timestamps
    end
    add_index :categories, :title, unique: true

    create_join_table :categories, :products do |t|
      t.index :category_id
      t.index :product_id
    end
  end
end
