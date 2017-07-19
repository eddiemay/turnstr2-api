class V1::LikesController < V1::BaseController
  before_action :set_like, only: [:destroy]

  # POST /comments
  def create
    like = @likable.likes.new
    like.user_id = current_user.id
    begin
      if like.save
        render_success data: {like: LikeSerializer.new(like) }, message: I18n.t('resource.created', resource: Like.model_name.human)
      else
        render_unprocessable_entity message: like.errors.full_messages.join(', ')
      end
    rescue ActiveRecord::RecordNotUnique
      render_unprocessable_entity message: "Already liked"
    end  
  end


  # DELETE /comments/1
  def destroy
    unless current_user.id == @like.user_id 
      render_unprocessable_entity message: "Unauthorized access" and return
    end  

    if @like.destroy
      render json: {success: true, message: 'Like deleted successfully', data: { like: LikeSerializer.new(@like) }}
    else
      render_unprocessable_entity message: like.errors.full_messages.join(', ')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = @likable.likes.find(params[:id])
    end


end
