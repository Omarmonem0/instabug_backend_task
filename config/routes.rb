Rails.application.routes.draw do
  resources :applications, param: :uuid do
    resources :chats, param: :number do
      resources :messages
    end
  end
  get 'messages/:application_id/:chat_number/search', to: 'messages#search'
  get 'messages/:application_id/:chat_number' , to: 'messages#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end