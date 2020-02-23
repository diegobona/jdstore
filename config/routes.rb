Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root "products#index"

  resources :products do
      member do
        post 'add_to_cart'
      end
  end

  namespace :admin do
    resources :products
    resources :orders
    resources :orders do
      member do
        post :ship
        post :shipped
        post :cancel
        post :return
      end
    end
  end

  resources :carts do
    member do
      delete :clearCart
      #结账是基于一个购物车
      post :checkout
      get :checkout
    end
    resources :cart_items
  end

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  namespace :account do
    resources :orders
  end


end
