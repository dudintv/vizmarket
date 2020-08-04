FactoryBot.define do
  factory :script do
    script { "Dim a As Alpha\nDim b As Boolean" }
    version
  end
end
