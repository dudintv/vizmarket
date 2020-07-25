require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:kind) }
  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:versions) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:kind) }
end
