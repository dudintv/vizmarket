FactoryBot.define do
  sequence(:email) { |n| "user_#{n}@email.com" }

  factory :user do
    email
    password { 'qwerty' }
    password_confirmation { 'qwerty' }
    confirmed_at { Time.now.utc }
    name { FFaker::Name.first_name }
    surname { FFaker::Name.last_name }
    jobtitle { 'Vizrt artist' }
    country { FFaker::Address.country }
    about { "#{FFaker::Skill.specialties.join(', ')} #{FFaker::HTMLIpsum.a} #{FFaker::Youtube.url}" }
  end
end
