FactoryBot.define do
  factory :product do
    title { FFaker::Product.product_name }
    short_description { FFaker::Book.description }
    description { FFaker::CheesyLingo.paragraph }
    instruction { FFaker::DizzleIpsum.paragraphs }
    price { Random.rand(10..100) }
    price_original { Random.rand(2)==0 ? nil : Random.rand(10..100) }
    public { true }
    featured { false }
    deleted_at { nil }
    user
    kind

    factory :featured_product do
      featured { true }
    end
    
    factory :draft_product do
      public { false }
    end

    factory :deleted_product do
      deleted_at { Time.zone.now }
    end
  end
end
