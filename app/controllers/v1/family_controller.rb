class V1::FamilyController < V1::BaseController
  # before_action :set_member

  # GET /v1/members/1/family
  def index
    user = User.find params[:member_id]
    @family = user.family.page current_page
    render_success data: {
        family: ActiveModel::Serializer::CollectionSerializer.new(@family, serializer: UserSerializer),
        total_pages: @family.total_pages,
        current_page: @family.current_page,
        next_page: @family.next_page,
        prev_page: @family.prev_page,
        first_page: @family.first_page?,
        last_page: @family.last_page?
    }

  end

  def create
    

  end
  

  def destroy

  end

  private

  def set_member
    @member = User.find params[:member_id]
  end  
end  
