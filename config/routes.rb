Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search"
 
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :favorites, only:[:create,:destroy]
    resources :book_comments,only:[:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only:[:create, :destroy]
    get 'followings' => 'relationships#followings' , as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :groups do 
    get "join" => "groups#join" #ビューで使うルーティング
    get "new/mail"=> "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
