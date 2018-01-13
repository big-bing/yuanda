Rails.application.routes.draw do

  namespace :admin do

    resources :orders do
      collection do
        post :search
        get :to_pdf
        post :create_tag
      end
      member do
        get :download_pdf
      end
    end

    resources :items

    resources :tags do
      collection do
        post :search
      end
      member do
        get :download_pdf
      end
    end

  end

end
