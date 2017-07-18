class V1::Photos::CommentsController < V1::CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = ::Photo.find(params[:photo_id])
  end
end
