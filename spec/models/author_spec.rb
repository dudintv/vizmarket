require 'rails_helper'

RSpec.describe Author, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:products) }
  it { should validate_presence_of(:name) }

  describe '#set_as_completed' do
    let(:author) { create :author }

    it 'marks the author as completed' do
      expect{
        author.set_as_completed
        author.reload
      }.to change { author.completed }.to(true)
    end
  end
end
