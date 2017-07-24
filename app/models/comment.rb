class Comment < ApplicationRecord
	belongs_to :commentable, polymorphic: true
	belongs_to :user

	after_create :update_comment_count

	def update_comment_count
		commentable.update_comment_count
	end	
end
