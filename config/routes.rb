Rails.application.routes.draw do
  root             to: 'home#index'
  match 'convert', to: 'home#convert', via: [:post]
end
