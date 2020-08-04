require 'rails_helper'

RSpec.describe Version, type: :model do
  it { should belong_to(:product) }
  it { should have_one(:script) }
end
