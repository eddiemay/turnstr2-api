class V1::Story::StoriesController < V1::Story::BaseController
  before_action :set_member
  before_action :set_story, only: [:show]
  # GET /stories
  def index
    @stories = @member.present? ? (@member.stories.page current_page) : (::Story.page current_page)
    render_success data: {
        stories: ActiveModel::Serializer::CollectionSerializer.new(@stories, serializer: StorySerializer),
        total_pages: @stories.total_pages,
        current_page: @stories.current_page,
        next_page: @stories.next_page,
        prev_page: @stories.prev_page,
        first_page: @stories.first_page?,
        last_page: @stories.last_page?
    }
  end

  # GET /stories/1
  def show
     render json: {success: true, data: { story: StoryDetailsSerializer.new(@story, current_user: current_user) }}
  end

  private 

  def set_member
    @member = params[:member_id].present? ? User.find(params[:member_id]) : nil
  end  

  def set_story
    @story = @member.present? ? @member.stories.find(params[:id]) : Story.find(params[:id])

  end
end
