class AddShowStatToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :show_stat, :integer
  end
end
