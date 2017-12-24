class V1::User::VideosController < V1::User::BaseController

  # GET /user/video
  def index
    @videos = current_user.video_stories
    render_success data: {
        videos: ActiveModel::Serializer::CollectionSerializer.new(@videos, serializer: VideosSerializer)
    }

  end

end
