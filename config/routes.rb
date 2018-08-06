Rails.application.routes.draw do
  resources :categories do
    resources :item_fields, except: [:index]
  end

  resources :item_fields do
    resources :field_values, except: [:index]
  end

  resources :item_fields do
    collection do
      post :import
    end
  end

  root to: 'categories#index'
end
