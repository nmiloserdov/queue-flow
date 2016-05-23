Rails.application.routes.draw do
  
  devise_for :users
  root to: "questions#index"
  
  resources :attachments, only: [:destroy]
  resources :questions do
    patch :vote
    resources :answers, only: [:create, :destroy, :update,:edit], shallow: true do
      patch :vote
      patch :best
    end
  end
end
