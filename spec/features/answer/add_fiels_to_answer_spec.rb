require_relative '../feature_helper'

feature 'Attach files for Answer' do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  
  background do
    sign_in user
    visit question_path(question) 
  end

  scenario 'User attach photo for answer', js: true do
    click_on 'add answer'
    fill_in "Body", with: "Test answer"

    click_on 'Add file'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on "Add"
    within '.answers-container' do    
      expect(page).to have_link 'spec_helper.rb'
    end
  end


end
