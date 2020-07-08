require 'rails_helper'

RSpec.describe NewCategory, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:product) }
  it { should validate_presence_of(:title) }
end
