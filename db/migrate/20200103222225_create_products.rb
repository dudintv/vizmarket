class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :short_description
      t.text :description
      t.text :instruction
      t.decimal :price, precision: 10, scale: 2
      t.decimal :price_original, precision: 10, scale: 2
      t.boolean :public
      t.boolean :featured
      t.datetime :deleted_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
