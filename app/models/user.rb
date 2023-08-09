class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i[google_oauth2]

  def first_initial
    first_name[0].upcase
  end

  def name
    "#{first_name} #{last_name}"
  end
end
