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

  context 'for subsribers of answer' do
    let(:users) { create_list(:user, 3) }
    let(:subscribtions) do
      users.each { |user| create(:subscriber, user: user, question: question) } 
    end

    it "creates 3 job" do

    end
  end

  describe '#send_notification_for_subscriber' do
    let!(:question) { create(:question) }
    let(:users)    { create_list(:user, 3) }
    let(:answer)  { create(:answer, question: question) }


    it "sends mail for subscribtions" do
      # here
      users.each { |user| Subscription.create(user: user, question: question) } 
      expect(NotificationMailer).to receive(:new_answer)
      answer.save
    end
  end
end
