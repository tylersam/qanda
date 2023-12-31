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
FactoryBot.define do
  factory :question do
    user
    body { 'Some question about something' }
    status { 'unanswered' }
  end
end
