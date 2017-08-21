Rails.application.routes.draw do
  devise_for :authors
  root to: 'blog/pages#home'

  namespace :authors do
    resources :posts do
      put 'publish' => 'posts#publish', on: :member
      put 'unpublish' => 'posts#unpublish', on: :member
    end
  end

  scope module: 'blog' do
    get 'about' => 'pages#about', as: :aboutpage
    get 'service' => 'pages#service', as: :servicepage
    get 'home' => 'pages#home', as: :homepage
    get 'business' => 'pages#business', as: :businesspage
    get 'posts' => 'posts#index', as: :posts
    get 'posts/:id' => 'posts#show', as: :post
  end
end
