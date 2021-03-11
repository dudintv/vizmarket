class CreateFeedbackMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :feedback_messages do |t|
      t.text :message
      t.string :contacts
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
