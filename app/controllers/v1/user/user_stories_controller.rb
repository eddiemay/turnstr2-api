class V1::User::UserStoriesController < V1::User::BaseController
  before_action :set_user_story, only: [:show]

  # GET /stories
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

  # GET /stories/1
  def show
    render json: {success: true, data: { story: UserStorySerializer.new(@user_story) }}
  end

  # POST /stories
  def create

  end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_story
      @user_story =current_user.following_user_stories.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_story_params
      params.require(:story).permit(:caption, :face1_video_thumb, :face2_video_thumb, :face3_video_thumb, :face4_video_thumb, :face5_video_thumb, :face6_video_thumb,:face1_media, :face2_media, :face3_media, :face4_media, :face5_media, :face6_media)
    end
end
