class V1::User::Fave5Controller < V1::User::BaseController

  # GET /v1/user/fave5
  def index
    result = current_user.family
    @fave = result.limit(5).order('updated_at DESC').page current_page
    render_success data: {
        fave: ActiveModel::Serializer::CollectionSerializer.new(@fave, serializer: UserSerializer),
        total_pages: @fave.total_pages,
        current_page: @fave.current_page,
        next_page: @fave.next_page,
        prev_page: @fave.prev_page,
        first_page: @fave.first_page?,
        last_page: @fave.last_page?
    }

  end
end  