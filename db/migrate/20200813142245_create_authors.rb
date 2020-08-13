class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.datetime :deteted_at
      t.json :links
      t.json :support_contacts
      t.json :private_contacts

      t.timestamps
    end
  end
end
