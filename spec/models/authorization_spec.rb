require 'rails_helper'

RSpec.describe Authorization, type: :model do
  it { should belong_to :user }
  it { should validate_uniqueness_of(:uid).scoped_to(:provider)  }
end
