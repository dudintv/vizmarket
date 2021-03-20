class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :code
      t.references :user, null: false, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
