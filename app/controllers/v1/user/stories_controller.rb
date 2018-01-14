class V1::User::StoriesController < V1::User::BaseController
  before_action :set_story, only: [:show, :update, :destroy]

  # GET /stories
  def index
    @stories = current_user.stories.reorder('sequence desc', 'updated_at desc').page current_page
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
    render json: {success: true, data: { story: StorySerializer.new(@story) }}
  end

  # POST /stories
  def create
    @story = current_user.stories.new(story_params)

    if @story.save
      current_user.update_post_count
      render_success data: {story: StorySerializer.new(@story) }, message: I18n.t('resource.created', resource: Story.model_name.human)
    else
      render_unprocessable_entity message: @story.errors.full_messages.join(', ')
    end
  end

  # PATCH/PUT /stories/1
  def update
    if @story.update(story_params)
      render_success data: {story: StorySerializer.new(@story) }, message: I18n.t('resource.updated', resource: Story.model_name.human)
    else
      render_unprocessable_entity message: @story.errors.full_messages.join(', ')
    end
  end

  # DELETE /stories/1
  def destroy
    @story.destroy
    current_user.update_post_count
    render json: {success: true, message: 'Story deleted successfully', data: { story: StorySerializer.new(@story) }}
  end

  # POST /user/stories
  def arrange
    current_user.stories.update_all(sequence: 0)
    ids = params[:ids].split(',')
    ids.each_with_index do |id, index|
      story = current_user.stories.find_by(id: id)
      story.update(sequence: ids.count - index)
    end  
    render json: {success: true, message: 'Story arranged successfully', data: {}}

  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = current_user.stories.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def story_params
      params.require(:story).permit(:caption, :face1_video_thumb, :face2_video_thumb, :face3_video_thumb, :face4_video_thumb, :face5_video_thumb, :face6_video_thumb,:face1_media, :face2_media, :face3_media, :face4_media, :face5_media, :face6_media)
    end
end
