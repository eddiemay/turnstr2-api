class V1::User::PhotosController < V1::User::BaseController
  before_action :set_photo, only: [:show, :update, :destroy]

  # GET /photos
  def index
    @photos = current_user.photos.grouped
    render_success data: {
        photos: ActiveModel::Serializer::CollectionSerializer.new(@photos, serializer: PhotosSerializer)
    }

  end

  # GET /photos/1
  def show
    render json: @photo
  end

  # POST /photos
  def create
    @photo = current_user.photos.new(photo_params)

    if @photo.save
      render_success data: {photo: PhotosSerializer.new(@photo)}, message: I18n.t('resource.updated', resource: Photo.model_name.human)
    else
      render_unprocessable_entity message: @photo.errors.full_messages.join(', ')
    end
  end


  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      render_success data: {photo: PhotosSerializer.new(@photo)}, message: I18n.t('resource.updated', resource: Photo.model_name.human)
    else
      render_unprocessable_entity message: @photo.errors.full_messages.join(', ')
    end
  end

  # DELETE /photos/1
  def destroy
    @photo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = current_user.photos.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.fetch(:photo, {}).permit(:image)
    end
end
