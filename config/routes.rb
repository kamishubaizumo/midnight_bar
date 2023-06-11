Rails.application.routes.draw do
  


      # 管理者用
      # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }

    namespace :admin do
      root to: "homes#home"

      resources :customers
      resources :items

        
        # 確認画面作成中断
          # collection do
          #   post "confirm"
          #   # patch 'edit_confirm'
          # end
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
      
      resources :items, only: [:index, :show]
      resources :customers, only: [:show, :edit, :update] do
        get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
        # 論理削除
        patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
      end

        resources :contacts, only: [:index,:show,:create,:destroy]
        resources :cart_items, only:[:index,:show,:update,:create,:destroy]
          delete '/cart_items' => 'cart_items#destroy_all'
          post '/orders/comfirm' => 'orders#comfirm'
          get '/orders/complete' => 'orders#complete'
        
        resources :orders
        resources :order_details
        

      
    end





end


