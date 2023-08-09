require 'rails_helper'

RSpec.describe 'Login', type: :system do
  context 'new user' do
    it 'creates a new user on successful login' do
      email = 'test1234@abc.com'
      mock_omniauth(email: email)

      visit root_path
      click_on 'Sign in with Google'

      expect(page).to have_content(/Signed in successfully/i)
      expect(User.find_by(email: email)).to be_present
    end

    it 'displays the error when login fails' do
      mock_failed_omniauth

      visit root_path
      click_on 'Sign in with Google'

      expect(page).not_to have_content(/Signed in successfully/i)
      expect(page).to have_content(/invalid credentials/i)
    end
  end

  context 'existing user' do
    it 'allows a user to login' do
      user = create(:user)
      mock_omniauth(email: user.email)

      visit root_path
      click_on 'Sign in with Google'

      expect(page).to have_content(/Signed in successfully/i)
    end
  end

  def mock_omniauth(email:)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      :google_oauth2,
      uid: '12345',
      info: {
        email: email,
        first_name: 'John',
        last_name: 'Doe',
      },
    )
  end

  def mock_failed_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
  end
end
