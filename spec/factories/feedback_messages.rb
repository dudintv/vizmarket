FactoryBot.define do
  factory :feedback_message do
    message { "MyString" }
    user { create(:user) }
  end
end
