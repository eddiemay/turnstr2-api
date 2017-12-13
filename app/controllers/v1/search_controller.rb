class V1::SearchController < V1::BaseController
  before_action :set_member, only: [:show]

  # GET /comments
  def index
    keyword = params[:keyword] || ''
    render_success data: {
        members: ActiveModel::Serializer::CollectionSerializer.new(User.search(keyword).limit(10), serializer: UserListSerializer),
        stories:ActiveModel::Serializer::CollectionSerializer.new(::Story.search(keyword).limit(10), serializer: StorySerializer)

    }
  end

  # GET /comments/1
  def show
    render json: {success: true, data: { member: UserDetailsSerializer.new(@member, current_user: current_user) }}
  end

 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = User.find(params[:id])
    end

end
