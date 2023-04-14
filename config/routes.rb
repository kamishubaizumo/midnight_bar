Rails.application.routes.draw do
  



      # 管理者用
      # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }

    namespace :admin do
      root to: "homes#home"

      resources :items
      resources :tags
    end


      # 顧客用
      # URL /customers/sign_in ...
    devise_for :customers,skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    } 


    scope module: :public do
      root to: 'homes#top'
      get "home", to: "homes#home"

      resources :customers, only: [:show, :edit, :update]
      
    end


end


