require 'rails_helper'

RSpec.describe FeedbackMessage, type: :model do
  it { should belong_to(:user).optional }

  describe 'user destroying' do
    # let!(:user) { create(:user) }
    let!(:feedback_message) { create(:feedback_message) }

    it 'allows to destory user' do
      user = feedback_message.user
      user.destroy
      expect(User.where(id: user.id).to_a).to eql([])
    end

    it 'keeps feedback_messages after user destroing' do
      feedback_message.user.destroy
      expect(feedback_message.reload).to be
    end

    it 'nulify user_id in feedback_message' do
      feedback_message.user.destroy
      expect(feedback_message.reload.user_id).to be_nil
    end
  end
end
