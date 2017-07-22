class V1::User::PhotosController < V1::User::BaseController
  before_action :set_album, only: [:index, :show, :destroy]
  before_action :set_photo, only: [:show, :destroy]

  # GET /photos
  def index
    @photos = @album.photos
    render_success data: {
        photos: ActiveModel::Serializer::CollectionSerializer.new(@photos, serializer: PhotosSerializer)
    }

  end

  # GET /photos/1
  def show
    render_success data: {
      photo: PhotoDetailsSerializer.new(@photo, current_user: current_user)
    }
  end

  # POST /photos
  def create
    @photo = current_user.albums.current[0].photos.new(photo_params)

    if @photo.save
      render_success data: {photo: PhotoDetailsSerializer.new(@photo, current_user: current_user)}, message: I18n.t('resource.crated', resource: Photo.model_name.human)
    else
      render_unprocessable_entity message: @photo.errors.full_messages.join(', ')
    end
  end



  # DELETE /photos/1
  def destroy
    if @photo.destroy
      render_success data: {photo: PhotosSerializer.new(@photo)}, message: I18n.t('resource.deleted', resource: Photo.model_name.human)
    else
      render_unprocessable_entity message: @photo.errors.full_messages.join(', ')
    end
  end

  private
    def set_album
      @album = current_user.albums.find(params[:album_id])
    end 

    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = @album.photos.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.fetch(:photo, {}).permit(:image)
    end
end
