class V1::Photos::PhotosController < V1::Photos::BaseController

  # GET /v1/photos
  def index
    @photos = ::Photo.page current_page
    render_success data: {
        stories: ActiveModel::Serializer::CollectionSerializer.new(@photos, serializer: PhotosSerializer),
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
    @photo = Photo.find params[:id]
    render json: {success: true, data: { story: PhotoDetailsSerializer.new(@photo, current_user: current_user) }}
  end

end
