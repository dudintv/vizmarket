FactoryBot.define do
  factory :invitation do
    code { "MyString" }
    user { nil }
    active { false }
  end
end
