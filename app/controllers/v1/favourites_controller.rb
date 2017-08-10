class V1::FavouritesController < V1::BaseController
  before_action :set_member

  # GET /member/1/favourites
  def index
    @favourites = @member.favourites.page(0).per(5)
    render_success data: {
        favourites: ActiveModel::Serializer::CollectionSerializer.new(@favourites, serializer: UserListSerializer),
        total_pages: @favourites.total_pages,
        current_page: @favourites.current_page,
        next_page: @favourites.next_page,
        prev_page: @favourites.prev_page,
        first_page: @favourites.first_page?,
        last_page: @favourites.last_page?
    }


  end  

  # POST /member/1/favourites
  def create
    begin
      if current_user.favourites << @member
        render_success data: {}, message: I18n.t('resource.created', resource: Favourite.model_name.human)
      else
        render_unprocessable_entity message: current_user.errors.full_messages.join(', ')
      end
    rescue ActiveRecord::RecordNotUnique
      render_unprocessable_entity message: 'Already favourite'
    end  
  
  end


  # DELETE /member/1/favourites
  def destroy

    if current_user.favourites.delete(@member)
      render json: {success: true, message: 'favourrite deleted successfully'}
    else
      render_unprocessable_entity message: current_user.errors.full_messages.join(', ')
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = User.find(params[:member_id])
  end


end
