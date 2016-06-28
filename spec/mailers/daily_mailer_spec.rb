require "rails_helper"

RSpec.describe DailyMailer, type: :mailer do
  describe "digest" do
    let(:user) { create(:user) }
    let(:mail) { DailyMailer.digest(user) }
    let!(:new_questions) { create_list(:question, 3, created_at: 1.day.ago + 2.hours) }
    let!(:old_questions) { create_list(:question, 3, created_at: 2.day.ago) }

    it "renders the headers" do
      expect(mail.subject).to eq("What new in our site?")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["news@queueflow.com"])
    end

    context 'body' do
      it "contains today questions" do
        expect(mail.body.encoded).to match(new_questions.map(&:title).join)
      end

      it "doesnt contains yesterday questions" do
        expect(mail.body.encoded).not_to match(old_questions.map(&:title).join)
      end
    end
  end
end
