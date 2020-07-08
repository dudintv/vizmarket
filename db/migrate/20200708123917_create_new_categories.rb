class CreateNewCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :new_categories do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
