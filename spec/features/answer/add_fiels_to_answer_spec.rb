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

    click_on "Add file"
    click_on "Add file"
    all("input[type='file']").first.set("#{Rails.root}/spec/spec_helper.rb")
    all("input[type='file']").last.set("#{Rails.root}/spec/rails_helper.rb")
    click_on "Add"

    expect(page).to have_link 'spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb'
  end


end
