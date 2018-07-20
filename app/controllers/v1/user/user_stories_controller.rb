class V1::User::UserStoriesController < V1::User::BaseController
  before_action :set_user_story, only: [:show]

  # GET /user/user_stories
  def index
    @user_stories = current_user.following_user_stories.reorder('updated_at desc').page current_page
    render_success data: {
        user_stories: ActiveModel::Serializer::CollectionSerializer.new(@user_stories, serializer: UserStorySerializer),
        total_pages: @user_stories.total_pages,
        current_page: @user_stories.current_page,
        next_page: @user_stories.next_page,
        prev_page: @user_stories.prev_page,
        first_page: @user_stories.first_page?,
        last_page: @user_stories.last_page?
    }
  end

  # GET /user/user_stories/1
  def show
    @user_story.viewed(current_user) unless current_user == @user_story.user
    render json: {success: true, data: { user_story: UserStorySerializer.new(@user_story,scope: { include_details: true}) }}
  end

  # POST /user/user_stories
  def create
    user_story = current_user.user_stories.new(user_story_params)
    if user_story.save
      render_success data: {comment: UserStorySerializer.new(user_story) }, message: I18n.t('resource.created', resource: UserStory.model_name.human)
    else
      render_unprocessable_entity message: user_story.errors.full_messages.join(', ')
    end

  end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_story
      @user_story =current_user.following_user_stories.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_story_params
      params.require(:user_story).permit(media_attributes:[:media])
    end
end
