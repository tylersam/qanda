require 'rails_helper'

RSpec.describe 'Questions', type: :system do
  it 'creates a question with valid inputs' do
    login_as(create(:user))
    visit root_path
    click_on 'Ask Question'

    fill_in 'question[body]', with: 'How do I use enums in Rails 7?'
    click_on 'Create Question'

    expect(page).to have_content(/Question was successfully created/i)
    expect(page).to have_content(/How do I use enums in Rails 7/i)
  end

  it 'shows validation errors with invalid input' do
    login_as(create(:user))
    visit root_path
    click_on 'Ask Question'

    fill_in 'question[body]', with: ''
    click_on 'Create Question'

    expect(page).not_to have_content(/Question was successfully created/i)
    expect(page).to have_content(/question must be at least/i)
  end

  it 'allows the owner to edit their question' do
    user = create(:user)
    question = create(:question, user: user)

    login_as(user)
    visit edit_question_path(question)

    fill_in 'question[body]', with: 'Updated question body'
    click_on 'Update Question'

    expect(page).to have_content(/Question was successfully updated/i)
    expect(page).to have_content(/Updated question body/i)
  end

  it 'does not allow a user to edit another users question' do
    user1 = create(:user)
    user2 = create(:user)
    user1_question = create(:question, user: user1)

    login_as(user2)
    visit edit_question_path(user1_question)

    expect(page).to have_current_path(root_path)
    expect(page).to have_content(/Not allowed to modify another user's question/i)
  end
end
