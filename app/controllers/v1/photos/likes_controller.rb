class V1::Photos::LikesController < V1::LikesController
  prepend_before_action :set_likable

  private

  def set_likable
    @likable = ::Photo.find(params[:photo_id])
  end
end
