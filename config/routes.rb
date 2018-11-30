Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	devise_for :users
	mount ActionCable.server => '/cable'
	root 'post#index'
	get '/index' => 'post#index', as: :index
	get '/post' => 'post#create', as: :post
	get '/posts/:id' => 'post#read', as: :read
	get '/getMyNoti' => 'post#read_notification'
	post '/post/create' => 'post#create_post'
	post '/comment/create' => 'post#create_comment'
	delete '/posts/:id' => 'post#destroy_post'
	delete '/comment/:id' => 'post#destroy_comment'
	delete '/deleteMyNoti' => 'post#destroy_notification'
end
