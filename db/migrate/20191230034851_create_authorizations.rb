class CreateAuthorizations < ActiveRecord::Migration[6.0]
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
