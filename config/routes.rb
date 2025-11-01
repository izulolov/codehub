Rails.application.routes.draw do
  root "questions#index"
  resources :questions, only: [ :index, :show, :create, :update, :destroy, :new, :edit ]
end
