Rails.application.routes.draw do
  root 'products#index'

  get '/product_card', to: 'products#product_card'
  get '/product_show', to: 'products#product_show'
end
