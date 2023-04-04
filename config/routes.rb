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
    root to: 'homes#top'
   
    get '/about' => 'homes#about', as: 'about'
    resources :items, only: [:index, :show]
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create,]


    #destroy_all?後で追加？
     get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/comfirm' => 'orders#comfirm'#post
    
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 end
