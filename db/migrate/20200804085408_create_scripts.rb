class CreateScripts < ActiveRecord::Migration[6.0]
  def change
    create_table :scripts do |t|
      t.text :script
      t.references :version, null: false, foreign_key: true

      t.timestamps
    end
  end
end
