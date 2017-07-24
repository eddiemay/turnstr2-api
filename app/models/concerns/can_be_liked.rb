module CanBeLiked
  extend ActiveSupport::Concern


  def update_like_count
    update_attributes(likes_count: likes.count)
  end 

  def has_liked(user)
  	likes.where(user_id: user.id).count > 0
  end	

  def get_like(user)
  	likes.find_by(user_id: user.id)
  end	

end
