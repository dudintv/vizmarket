require 'rails_helper'

RSpec.describe Author, type: :model do
  it { should belong_to(:user) }
end
