class V1::User::StoriesController < V1::User::BaseController
  before_action :set_story, only: [:show, :update, :destroy]

  # GET /stories
  def index
    @stories = Story.all
    render json:@stories
  end

  # GET /stories/1
  def show
    render json: {success: true, message: 'Story fetched successfully', data: { story: StorySerializer.new(@story) }}
  end

  # POST /stories
  def create
    @story = Story.new(story_params)

    if @story.save
      render json: {success: true, message: 'Story created successfully', data: { story: StorySerializer.new(@story) }}, status: :created
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stories/1
  def update
    if @story.update(story_params)
      render json: {success: true, message: 'Story updated successfully', data: { story: StorySerializer.new(@story) }}
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stories/1
  def destroy
    @story.destroy
    render json: {success: true, message: 'Story deleted successfully', data: { story: StorySerializer.new(@story) }}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def story_params
      params.require(:story).permit(:user_id, :caption, :total_likes, :story_face1_thumb_url, :story_face2_thumb_url, :story_face3_thumb_url, :story_face4_thumb_url, :story_face1_url, :story_face2_url, :story_face3_url, :story_face4_url, :active )
    end
end
