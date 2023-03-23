Rails.application.routes.draw do
 devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
 }
  namespace :admin do
    root to: 'homes#top'

    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :orders, only: [:update, :show]
    resources :order_details, only: [:update]
  end


   scope module: :public do
    get "/" => "homes#top"
    get '/about' => 'homes#about', as: 'about'
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    get 'customers/my_page' => 'customers#show'
    get 'customers/unsubscribe'
    get 'customers/withdraw'#patch
    resources :cart_items, only: [:index, :update, :destroy, :create]
    #destroy_all?後で追加？
    resources :orders, only: [:new, :create, :index, :show]
    get 'orders/comfirm'#post
    get 'orders/complete'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 end
