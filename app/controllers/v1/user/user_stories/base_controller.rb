class V1::User::UserStories::BaseController < V1::User::BaseController
  before_action :set_user_story


  private
  def set_user_story
    @user_story =current_user.following_user_stories.find(params[:user_story_id])
  end


end
