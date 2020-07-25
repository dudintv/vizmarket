FactoryBot.define do
  factory :version do
    sequence(:number) { |n| n }
    public { false }
    product

    factory :version_with_one_file do
      files {[
        fixture_file_upload('spec/fixtures/files/text1.txt', 'text/plain')
      ]}
    end

    factory :version_with_files do
      files {[
        fixture_file_upload('spec/fixtures/files/text1.txt', 'text/plain'),
        fixture_file_upload('spec/fixtures/files/text2.txt', 'text/plain'),
        fixture_file_upload('spec/fixtures/files/text3.txt', 'text/plain')
      ]}
    end
  end
end
