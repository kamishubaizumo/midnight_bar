Rails.application.routes.draw do
  


      # 管理者用
      # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }

    namespace :admin do
      root to: "homes#home"

      resources :items
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
        # 年齢確認ページ
      get 'verify_age', to: "homes#verify_age"
        # Cookieを使って年齢認証 Yes のルート(すぐにリダイレクトするので View 無し)
      get 'verified', to: "homes#verified"
      
    end


end


