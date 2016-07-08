require_relative '../feature_helper'

feature "User searching" do

  given!(:user)     { create(:user, email: "nekek@mail.ru") }
  given!(:question) { create(:question, body: 'absoribing question') }
  given!(:answer)   { create(:answer, body: 'absoribing answer') }
  given!(:comment)  { create(:comment, body: 'absoribing comment') }

  before do
    index 
    visit root_path
  end

  it 'searchs all rescources', js: true do
    select 'global', from: "Scope"
    fill_in 'Query', with: 'absoribing'
    click_on "Search"
    expect(page).to have_content(question.title)
    expect(page).to have_content(answer.question.title)
    expect(page).to have_content(comment.commentable.question.title)
  end

  it 'searchs only answer', js: true do
    select 'answer', from: "Scope"
    fill_in 'Query', with: 'absoribing'
    click_on "Search"
    expect(page).to have_content(answer.question.title)
    expect(page).not_to have_content(question.title)
    expect(page).not_to have_content(comment.commentable.question.title)
  end

  it 'searchs only question', js: true do
    select 'question', from: "Scope"
    fill_in 'Query', with: 'absoribing'
    click_on "Search"
    expect(page).to have_content(question.title)
    expect(page).not_to have_content(answer.question.title)
    expect(page).not_to have_content(comment.commentable.question.title)
  end

  it 'searchs only comment', js: true do
    select 'comment', from: "Scope"
    fill_in 'Query', with: 'absoribing'
    click_on "Search"
    expect(page).to have_content(comment.commentable.question.title)
    expect(page).not_to have_content(question.title)
    expect(page).not_to have_content(answer.question.title)
  end

  it 'searchs only user', js: true do
    select 'user', from: "Scope"
    fill_in 'Query', with: 'nekek'
    click_on "Search"
    expect(page).to have_content(user.email)
    expect(page).not_to have_content(question.title)
    expect(page).not_to have_content(answer.question.title)
    expect(page).not_to have_content(comment.commentable.question.title)
  end
end
