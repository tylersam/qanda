# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  body        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'after_create_commit callback' do
    it 'updates the question status' do
      question = create(:question, status: 'unanswered')

      Answer.create!(question: question, body: 'abcd', user: create(:user))

      expect(question.reload.status).to eq('answered')
    end
  end

  context 'after_destroy_commit' do
    it 'updates the question status' do
      question = create(:question)
      answer = create(:answer, question: question)
      initial_status = question.status

      answer.destroy!

      expect(initial_status).to eq('answered')
      expect(question.reload.status).to eq('unanswered')
    end
  end
end
