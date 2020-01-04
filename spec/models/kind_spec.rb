require 'rails_helper'

RSpec.describe Kind, type: :model do
  it { should have_many(:products) }
end
