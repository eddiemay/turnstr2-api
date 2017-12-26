class V1::Videos::VideosController < V1::Videos::BaseController
  before_action :set_member
  before_action :set_video, only: [:show]
  # GET /stories
  def index
    #@videos = @member.present? ? (@member.video_stories.page(current_page)) : (::GoLiveVideo.page current_page)

    # temporary
    @videos = @member.present? ? (::GoLiveVideo.page current_page) : (::GoLiveVideo.page current_page)
    render_success data: {
        stories: ActiveModel::Serializer::CollectionSerializer.new(@videos, serializer: VideosSerializer),
        total_pages: @videos.total_pages,
        current_page: @videos.current_page,
        next_page: @videos.next_page,
        prev_page: @videos.prev_page,
        first_page: @videos.first_page?,
        last_page: @videos.last_page?
    }
  end

  # GET /stories/1
  def show
     render json: {success: true, data: { story: VideoSerializer.new(@video, current_user: current_user) }}
  end

  private 

  def set_member
    @member = params[:member_id].present? ? User.find(params[:member_id]) : nil
  end  

  def set_video
    @video = @member.present? ? @member.stories.find(params[:id]) : Story.find(params[:id])

  end
end
