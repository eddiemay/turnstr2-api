module CanBeLiked
  extend ActiveSupport::Concern


  def update_like_count
    update_attributes(likes_count: likes.count)
  end 

end
