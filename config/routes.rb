Rails.application.routes.draw do
  

  namespace :public do
    get 'items/index'
    get 'items/show'
  end
      # 管理者用
      # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }

    namespace :admin do
      root to: "homes#home"

      resources :customers
      resources :items do
        collection do 
              #タグで検索
          get "search_tag" => "items#search_tag"
        end
      end
        
        # 確認画面作成中断
        #   member do
        #     post "confirm"
        #     patch 'edit_confirm'
        #   end
      resources :tags
      resources :contacts
      resources :orders
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
      resources :contacts
      
    end





end


