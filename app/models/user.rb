# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :questions, dependent: :restrict_with_exception
  has_many :answers, dependent: :restrict_with_exception

  def first_initial
    first_name[0].upcase
  end

  def name
    "#{first_name} #{last_name}"
  end

  def first_name_last_initial
    "#{first_name} #{last_name[0].upcase}."
  end
end
