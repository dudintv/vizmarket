FactoryBot.define do
  factory :author do
    name { FFaker::Name.first_name }
    title { FFaker::Skill.specialty }
    user
    deteted_at { nil }
    links { "" }
    support_contacts { "" }
    private_contacts { "" }

    factory :deleted_author do
      deleted_at { Time.zone.now }
    end
  end
end
