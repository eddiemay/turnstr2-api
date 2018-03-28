class V1::FamilyController < V1::BaseController
  before_action :set_member

  # GET /v1/members/1/family
  def index
    # temporarily, we are shipping hardcoded users so video call can be done
    ## @family = User.where(email: [
    ##    'vikesh@gmail.com',
    ##    'saini@ankit.com',
    ##    'nilay1@devzila.com',
    ##    'rocky@gmail.com'
    ##]).page current_page

    @family = @member.family.page current_page

    # uncomment following line when patch work no longer needed
    # @family = @member.family.page current_page
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

  #POST /v1/members/1/family
  def create
    

    if (@member.following?(current_user))
      current_user.follow(@member) unless current_user.following?(@member) 
      render_success data: {user: UserListSerializer.new(@member) }, message: I18n.t('resource.created', resource: Follow.model_name.human)
    
    else
      render_error message: "You can not add someone as family unless he/she follow you"
    end  


  end
  

  def destroy
    current_user.unfollow(@member)
    render_success data: {user: UserListSerializer.new(@member) }, message: I18n.t('resource.deleted', resource: Follow.model_name.human)
  end

  private

  def set_member
    @member = User.find params[:member_id]
  end  
end  
