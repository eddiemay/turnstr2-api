class V1::Story::StoriesController < V1::Story::BaseController

  # GET /stories
  def index
    @stories = ::Story.all
    render_success data: {
        stories: ActiveModel::Serializer::CollectionSerializer.new(@stories, serializer: StorySerializer)
    }
  end

  # GET /stories/1
  def show
    render json: {success: true, data: { story: StorySerializer.new(@story) }}
  end

end
