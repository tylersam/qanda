require 'rails_helper'

RSpec.describe 'Answers', type: :system do
  it 'creates an answer with valid inputs' do
    question = create(:question)

    login_as(create(:user))
    visit question
    click_on 'Add Answer'

    fill_in 'answer[body]', with: 'A response to the question'
    click_on 'Create Answer'

    expect(page).to have_content(/Answer was successfully created/i)
    expect(page).to have_content(question.body)
    expect(page).to have_content(/A response to the question/i)
  end

  it 'shows validation errors with invalid input' do
    question = create(:question)

    login_as(create(:user))
    visit question
    click_on 'Add Answer'

    fill_in 'answer[body]', with: ''
    click_on 'Create Answer'

    expect(page).not_to have_content(/Answer was successfully created/i)
    expect(page).to have_content(/can't be blank/i)
  end

  it 'allows the owner to edit their answer' do
    user = create(:user)
    question = create(:question)
    answer = create(:answer, question: question, user: user)

    login_as(user)
    visit question

    within("#answer_#{answer.id}") { click_on 'Edit' }

    fill_in 'answer[body]', with: 'Updated answer to the question'
    click_on 'Update Answer'

    expect(page).to have_content(/Answer was successfully updated/i)
    expect(page).to have_content(/Updated answer to the question/i)
  end

  it 'does not allow a user to edit another users answer' do
    user1 = create(:user)
    user2 = create(:user)
    question = create(:question)
    user1_answer = create(:answer, user: user1, question: question)

    login_as(user2)
    visit question

    within("#answer_#{user1_answer.id}") do
      expect(page).not_to have_content(/Edit/i)
    end

    visit edit_question_answer_path(question, user1_answer)

    expect(page).to have_current_path(question_path(question))
    expect(page).to have_content(/Not allowed to modify another user's answer/i)
  end
end
