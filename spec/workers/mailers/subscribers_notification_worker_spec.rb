require 'rails_helper'

RSpec.describe Mailers::SubscribersNotificationWorker do

  let!(:users) { create_list(:user, 3) }
  let!(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  before do
    users.each {|user| user.subscribe_to!(question)}
  end

  describe '#perform' do

    it 'sends new answer notification for subscribers' do
      # here problem
      users.each do |user|
        expect(NotificationMailer).to receive(:new_answer).with(answer, user).and_call_original
      end
      Mailers::SubscribersNotificationWorker.perform_async(answer)
    end
  end
end
