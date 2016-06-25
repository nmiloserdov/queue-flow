shared_examples_for 'Concern Votable' do

  describe 'PATCH #vote' do
    sign_in_user

    it 'renders 200 when success' do
      patch :vote, { type: :up }.merge(votable_hash)
      expect(response).to have_http_status(200)
    end
    
    it 'renders 422 if error' do
      votable.user = @user
      votable.save
      patch :vote, { type: :down }.merge(votable_hash)
      expect(response).to have_http_status(422)
    end
  end

  def votable_hash
    key = votable.class.name.downcase + '_id'
    { key.to_sym => votable }
  end
end
