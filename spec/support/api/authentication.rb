shared_examples_for 'API non-authenticable' do

  context 'unauthorized' do

    it 'returns 401 status if there is no access_token' do
      self.try(:url) ? do_request(url: url) : do_request
      expect(response.status).to eq 401
    end

    it 'returns 401 status if access_token is invalid' do
      if self.try(:url)
        do_request(url: url, access_token: '1234')
      else
        do_request(access_token: '1234')
      end
      expect(response.status).to eq 401
    end
  end
end
