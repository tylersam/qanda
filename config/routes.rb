Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks',
             },
             path_names: {
               sign_in: 'login',
             }
  # can't use the controller options in devise_for b/c the database_authenticatable
  #  module is not currently being used
  #  when that module isn't used, devise ignores the sessions controller option
  devise_scope :user do
    get 'login', to: 'login#show', as: :new_user_session
    get 'login', to: 'login#show', as: :new_session
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end

  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end

  unauthenticated do
    devise_scope :user do
      root to: 'login#show'
    end
  end

  resources :questions, only: %i[show new edit create update destroy]
end
