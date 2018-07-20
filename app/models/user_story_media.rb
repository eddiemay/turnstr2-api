class UserStoryMedia < ApplicationRecord
  belongs_to :user_story
  before_post_process :resize_images

  has_attached_file :media, styles: { original: "500x500>"}




  # Helper method to determine whether or not an attachment is an image.
  def image?
    upload_content_type =~ %r{^(image|(x-)?application)/(jpeg|jpg|pjpeg|png|x-png)$}
  end

  private

  def resize_images
    return false unless image?
  end


end
