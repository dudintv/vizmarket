class CreateKinds < ActiveRecord::Migration[6.0]
  def change
    create_table :kinds do |t|
      t.string :title

      t.timestamps
    end

    add_column :products, :kind_id, :integer
    add_index :products, :kind_id
  end
end
