class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post
	after_create_commit { broadcast_create_commit }
	def broadcast_create_commit
		if self.user.id != self.post.user.id
			ActionCable.server.broadcast "user_noti_#{self.post.user.id}", { username: self.user.email, title: self.post.title }
			noti = Notification.new(:user_id => self.post.user.id, :post_id => self.post.id, :noti_type => 0, :title => self.post.title, :confirmed => false)
			noti.save
    end
	end
end
