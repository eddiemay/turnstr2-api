class V1::Story::CommentsController < V1::CommentsController
  prepend_before_action :set_commentable

  private

  def set_commentable
    @commentable = ::Story.find(params[:story_id])
  end
end
