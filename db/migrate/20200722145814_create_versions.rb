class CreateVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :versions do |t|
      t.integer :number
      t.boolean :public
      t.text    :support
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
