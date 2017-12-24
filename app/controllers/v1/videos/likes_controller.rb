class V1::Videos::LikesController < V1::LikesController
  prepend_before_action :set_likable

  private

  def set_likable
    @likable = ::GoLiveVideo.find(params[:video_id])
  end
end
