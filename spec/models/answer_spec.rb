require 'rails_helper'

RSpec.describe Answer, type: :model do
  
  it { should belong_to :question }

  it { should have_db_index :question_id}

  it { should validate_presence_of :body }

  it { should validate_presence_of :question_id}
  
end
