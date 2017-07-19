class V1::Story::StoriesController < V1::Story::BaseController

  # GET /stories
  def index
    @stories = ::Story.page current_page
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
    @story = Story.find params[:id]
    render json: {success: true, data: { story: StorySerializer.new(@story) }}
  end

end
