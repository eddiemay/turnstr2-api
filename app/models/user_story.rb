class UserStory < ApplicationRecord
  belongs_to :user
  has_many :media, class_name: 'UserStoryMedia', dependent: :destroy

  has_many :views, class_name: 'UserStoryView', dependent: :destroy

  accepts_nested_attributes_for :media


  def viewed(user)
    view = views.find_or_initialize_by(user_id: user.id)
    view.user =  user
    view.touch
    if view.save
      update_view_count
    end

  end

  def update_view_count
    update(view_count: views.count)
  end



end
