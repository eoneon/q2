Rails.application.routes.draw do
  resources :categories do
    resources :item_fields
  end

  root to: 'categories#index'
end
