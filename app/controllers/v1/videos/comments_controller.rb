class V1::Videos::CommentsController < V1::CommentsController
  prepend_before_action :set_commentable

  private

  def set_commentable
    @commentable = ::GoLiveVideo.find(params[:video_id])
  end
end
