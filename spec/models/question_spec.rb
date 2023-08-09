require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '#update_status' do
    it 'sets the status to answered if any answers exist' do
      question = create(:question)
      create(:answer, question: question)
      question.update!(status: 'unanswered')

      question.update_status

      expect(question.status).to eq('answered')
    end

    it 'sets the status to unanswered if no answers exist' do
      question = create(:question, status: 'answered')

      question.update_status

      expect(question.status).to eq('unanswered')
    end
  end
end
