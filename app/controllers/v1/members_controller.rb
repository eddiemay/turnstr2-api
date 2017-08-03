class V1::MembersController < V1::BaseController
  before_action :set_member, only: [:show]

  # GET /comments
  def index
    members = User.page current_page
    render_success data: {
        members: ActiveModel::Serializer::CollectionSerializer.new(members, serializer: UserListSerializer),
        total_pages: members.total_pages,
        current_page: members.current_page,
        next_page: members.next_page,
        prev_page: members.prev_page,
        first_page: members.first_page?,
        last_page: members.last_page?
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
