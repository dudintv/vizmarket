FactoryBot.define do
  factory :authorization do
    user
    provider { 'provider' }
    uid { 'uid' }

    factory :confirmed_authorization do
      confirmed_at { Time.zone.now }
    end
  end
end
