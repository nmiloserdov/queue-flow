require 'rails_helper'

RSpec.describe Mailers::DailyDigestWorker do

  describe '#perform' do

    let!(:users) { create_list(:user, 3)}

    it 'creates a job' do
      expect { described_class.perform_async }
        .to change(described_class.jobs, :size).by(1)
    end

    it 'sends laters' do
      Sidekiq::Testing.inline! do
        users.each do |user|
          stub_letter = DailyMailer.digest(user)
          allow(DailyMailer).to receive(:digest).and_return(stub_letter)

          expect(DailyMailer).to receive(:digest).with(user).and_call_original
        end
        described_class.perform_async
      end
    end
  end
end
