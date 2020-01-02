FactoryBot.define do
  factory :authorization do
    user
    provider { 'provider' }
    uid { 'uid' }
  end
end
