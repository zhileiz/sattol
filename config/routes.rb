Rails.application.routes.draw do
  devise_for :authors
  root to: 'blog/posts#index'

  namespace :authors do
    resources :posts
  end

  scope module: 'blog' do
    get 'about' => 'pages#about', as: :aboutpage
    get 'service' => 'pages#service', as: :servicepage
    get 'home' => 'pages#home', as: :homepage
    get 'posts' => 'posts#index', as: :posts
    get 'posts/:id' => 'posts#show', as: :post
  end
end
