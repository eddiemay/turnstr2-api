class V1::User::GeneralController < V1::User::BaseController

  # GET /v1/user/general
  def index
    @general = User.order('created_at DESC')
    render_success data: {
        general: ActiveModel::Serializer::CollectionSerializer.new(@general, serializer: UserSerializer),
    }

  end
end  