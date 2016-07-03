require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  let(:question)    { create(:question) }
  let!(:answer)     { create(:answer, question: question) }
  let!(:user)       { create(:user) }
  


  context 'for onwer of answer' do
    let(:owner_email) { user.email }

    describe '#new_answer' do
      let(:mail) { NotificationMailer.new_answer(answer, user) }

      it "renders the headers" do
        expect(mail.subject).to eq("Hey, new answer on your question.")
        expect(mail.to).to eq([owner_email])
        expect(mail.from).to eq(["notification@queueflow.com"])
      end

      context 'body' do
        it 'contains answer body and question title' do
          expect(mail.body.encoded).to match([question.title, answer.body].join)
        end
      end
    end
  end
end
