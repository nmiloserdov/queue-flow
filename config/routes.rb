Rails.application.routes.draw do
  
  use_doorkeeper
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  root to: "questions#index"
  get 'confirm_authorization' => 'authorizations#confirm'
  
  concern :votable do
    patch :vote
  end

  concern :commentable do
    resources :comments, only: [:create, :destroy], shallow: true
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: :index do
        get :me,    on: :collection
      end
      resources :questions, only: [:index, :show] do
        resources :answers,   only: [:index, :show]
      end
    end
  end

  # collection - without id
  # member - with id

  resources :attachments, only: [:destroy]

  resources :questions, concerns: [:commentable, :votable] do
    resources :answers, concerns: [:commentable, :votable], only:
      [:create, :destroy, :update, :edit], shallow: true do
        patch :best
    end
  end
end
