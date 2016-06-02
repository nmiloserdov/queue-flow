Rails.application.routes.draw do
  
  devise_for :users
  root to: "questions#index"
  
  concern :votable do
    patch :vote
  end

  concern :commentable do
    resources :comments, only: [:create], shallow: true
  end
  resources :comments, only: [:destroy]

  resources :attachments, only: [:destroy]

  resources :questions, concerns: [:commentable, :votable] do
    resources :answers, concerns: [:commentable, :votable], only:
      [:create, :destroy, :update, :edit], shallow: true do
        patch :best
    end
  end
end
