class V1::Photos::PhotosController < V1::Photos::BaseController
  before_action :set_member
  before_action :set_photo, only: [:show]

  # GET /v1/photos
  def index
    @photos =  @member.present? ? (@member.photos.page current_page) : (current_user.following_photos.page current_page)
    render_success data: {
      photos: ActiveModel::Serializer::CollectionSerializer.new(@photos, serializer: PhotosSerializer),
      total_pages: @photos.total_pages,
      current_page: @photos.current_page,
      next_page: @photos.next_page,
      prev_page: @photos.prev_page,
      first_page: @photos.first_page?,
      last_page: @photos.last_page?
    }
  end

  # GET /stories/1
  def show
    render json: {success: true, data: { photo: PhotoDetailsSerializer.new(@photo, current_user: current_user) }}
  end

  private 

  def set_member
    @member = params[:member_id].present? ? User.find(params[:member_id]) : nil
  end  

  def set_photo
    @photo = @member.present? ? @member.photos.find(params[:id]) : Photo.find(params[:id])

  end

end
