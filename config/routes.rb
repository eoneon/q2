Rails.application.routes.draw do
  resources :categories do
    resources :category_fields, only: [:create]
  end

  resources :item_fields do
    resources :field_values, except: [:index]
  end

  resources :item_fields do
    resources :field_chains, only: [:create, :destroy]
    collection do
      post :import
    end
  end

  resources :field_values do
    collection do
      post :import
    end
  end

  #resources :field_chains, only: [:create, :destroy]

  resources :items do
    resources :field_values, except: [:index]
  end

  root to: 'categories#index'
end
