class Like < ApplicationRecord
	belongs_to :likable, polymorphic: true
	belongs_to :user

	after_create :update_like_count
	after_destroy :update_like_count

	def update_like_count
		likable.update_like_count
	end	
end
