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

  resources :field_values do
    collection do
      post :import
    end
  end

  resources :items

  root to: 'categories#index'
end
