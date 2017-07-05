class V1::CommentsController < V1::BaseController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  def index
    comments = @commentable.comments.page current_page
    render_success data: {
        stories: ActiveModel::Serializer::CollectionSerializer.new(comments, serializer: CommentsSerializer),
        total_pages: comments.total_pages,
        current_page: comments.current_page,
        next_page: comments.next_page,
        prev_page: comments.prev_page,
        first_page: comments.first_page?,
        last_page: comments.last_page?
    }
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    comment = @commentable.comments.create!(comment_params)
    comment.user_id = current_user.id
    if comment.save
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = @commentable.comments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit :body
    end
end
