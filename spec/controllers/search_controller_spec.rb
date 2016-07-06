require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #search' do

    it 'renders template' do
      get :search, query: 'Hello'
      expect(response).to render_template(:search)
    end

    %w(question answer comment user).each do |scope|
      it "searchs by scope: #{scope}" do
        scope_class = scope.camelize.constantize
        expect(scope_class).to receive(:search).with('Hello', page: nil)
        get :search, query: 'Hello', scope: scope
      end
    end
  end
end
