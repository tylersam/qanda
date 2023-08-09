class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = create_or_update_user

    if user.persisted?
      flash[:notice] = 'Signed in successfully.'
      sign_in_and_redirect(user, event: :authentication)
    else
      redirect_to(
        new_user_session_url,
        alert: 'Sign in failed. Please try again',
      )
    end
  end

  private

  def create_or_update_user
    user = User.find_or_initialize_by(email: response_auth.info.email)
    user.first_name = response_auth.info.first_name
    user.last_name = response_auth.info.last_name
    user.save
    user
  end

  def response_auth
    request.env['omniauth.auth']
  end
end
