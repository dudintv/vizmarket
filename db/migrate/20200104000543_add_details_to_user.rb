class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :country, :string
    add_column :users, :jobtitle, :string
    add_column :users, :about, :text
  end
end
