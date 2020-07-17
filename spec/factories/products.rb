include ActionDispatch::TestProcess

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
    user { create(:user) }
    kind { Kind.find_by(title: 'script') }
    categories { [Category.find_by(title: 'animation')] }

    videos { 'https://www.youtube.com/watch?v=PdzuwlYgLUQ
              https://www.youtube.com/watch?v=Rv31GQZlAx0
              https://www.youtube.com/watch?v=uZ0sPEZdTks' }
    youtube_ids { 'PdzuwlYgLUQ Rv31GQZlAx0 uZ0sPEZdTks' }

    factory :featured_product do
      featured { true }
    end
    
    factory :draft_product do
      public { false }
    end

    factory :deleted_product do
      deleted_at { Time.zone.now }
    end

    factory :product_with_images do
      thumbnail { fixture_file_upload('spec/fixtures/images/square568x568.jpg', 'image/jpeg') }
      featured_image { fixture_file_upload('spec/fixtures/images/1920x1080.jpg', 'image/jpeg') }
      images {[
        fixture_file_upload('spec/fixtures/images/1920x1080_car.jpg', 'image/jpeg'),
        fixture_file_upload('spec/fixtures/images/1920x1080_cubes.jpg', 'image/jpeg'),
        fixture_file_upload('spec/fixtures/images/1920x1080_leopard.jpg', 'image/jpeg'),
      ]}
    end
  end
end
