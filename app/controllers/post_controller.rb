class PostController < ApplicationController
	before_action :authenticate_user!
	def index
		@post = Post.all
		@user = User.all
	end
	
	def create_post
		post = Post.new
		post.title = params[:title]
		post.content = params[:content]
		post.user_id = current_user.id
		post.ip_address = request.remote_ip
		if post.save
			redirect_to root_path
		end
	end
	
	def read
		@post = Post.find(params[:id])
		@user = User.all
		@post_user = @user.find(@post.user_id)
		@comment = Comment.where(:post_id => params[:id])
	end
	
	def destroy_post
		post = Post.find(params[:id])
		if post.user_id === current_user.id and post.destroy
			redirect_to root_path
		end
	end
	
	def create_comment
		comment = Comment.new
		comment.post_id = params[:post_id]
		comment.content = params[:content]
		comment.user_id = current_user.id
		comment.ip_address = request.remote_ip
		if comment.save
			redirect_to :back
			#redirect_back(fallback_location: root_path)
		end
	end
	
	def destroy_comment
		# comment = Comment.find_by(:post_id => params[:id], )
		# if post.user_id === current_user.id and post.destroy
		# 	redirect_to root_path
		# end
	end
	
	def read_notification
		noti = Notification.where(:user_id => current_user.id)
		render :json => noti.reverse.to_json
		noti.where(:confirmed => false).each do |n|
			unless n.confirmed
				n.confirmed = true
				n.save
			end
		end
	end
	
	def destroy_notification
		noti = Notification.where(:user_id => current_user.id)
		noti.each do |n|
			n.destroy
		end
		redirect_to root_path
		#redirect_back(fallback_location: root_path)
	end
end
