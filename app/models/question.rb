# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  status     :enum             default("unanswered"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_questions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  enum :status,
       { unanswered: 'unanswered', answered: 'answered', solved: 'solved' }

  validates :body,
            length: {
              minimum: 10,
              message: 'question must be at least 10 characters',
            }

  def update_status
    if self.answers.size.zero?
      self.update(status: 'unanswered')
    else
      self.update(status: 'answered')
    end
  end
end
