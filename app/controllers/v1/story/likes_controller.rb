class V1::Story::LikesController < V1::LikesController
  prepend_before_action :set_likable

  private

  def set_likable
    @likable = ::Story.find(params[:story_id])
  end
end
