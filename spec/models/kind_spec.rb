require 'rails_helper'

RSpec.describe Kind, type: :model do
  it { should have_many(:products) }
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }
end
