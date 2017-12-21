class V1::PopularsController < V1::BaseController

  # GET /comments
  def index
    members = User.populars
    render_success data: {
        members: ActiveModel::Serializer::CollectionSerializer.new(members, serializer: UserListSerializer)
    }
  end


end
