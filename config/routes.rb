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

  resources :attachments, only: [:destroy]

  resources :questions, concerns: [:commentable, :votable] do
    resources :answers, concerns: [:commentable, :votable], only:
      [:create, :destroy, :update, :edit], shallow: true do
        patch :best
    end
  end
end
