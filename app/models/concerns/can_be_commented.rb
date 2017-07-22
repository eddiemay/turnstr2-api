module CanBeCommented
  extend ActiveSupport::Concern


  def update_comment_count
    update_attributes(comments_count: comments.count)
  end 

end
