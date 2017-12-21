class V1::PopularsController < V1::BaseController

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


end
