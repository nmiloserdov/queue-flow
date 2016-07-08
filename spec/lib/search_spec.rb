require 'rails_helper'

RSpec.describe Search do
  describe '.sphinx_search' do
    it 'returns nil for empry query' do
      expect(ThinkingSphinx).not_to receive(:search)
      expect(described_class.sphinx_search("")).to eq(nil)
    end

    it 'returns nil if scope doesnt exist' do
      expect(ThinkingSphinx).not_to receive(:search)
      expect(described_class.sphinx_search("hello","search")).to eq(nil)
    end

    it "calls ThinkingSphinx if scope == global" do
      expect(ThinkingSphinx).to receive(:search)
      described_class.sphinx_search('hello', "global")
    end

    %w(question answer comment user).each do |scope|
      it "searchs by scope: #{scope}" do
        scope_class = scope.camelize.constantize
        expect(scope_class).to receive(:search).with('hello', page: nil)
        described_class.sphinx_search('hello', scope)
      end
    end
  end
end
