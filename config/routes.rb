Rails.application.routes.draw do
  resources :applications, only: [:index, :show, :create] do 
    resources :chats, only: [:index, :show, :create] do
      resources :messages, only: [:index, :show, :create]
    end
  end
end