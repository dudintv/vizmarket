require 'rails_helper'

RSpec.describe Script, type: :model do
  it { should belong_to(:version) }
end
