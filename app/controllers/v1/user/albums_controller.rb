class V1::User::AlbumsController < V1::User::BaseController
  
  # GET /photos
  def index
    current_user.create_default_albums if current_user.albums.count == 0
    albums = current_user.albums

    render_success data: {
        albums: ActiveModel::Serializer::CollectionSerializer.new(albums, serializer: AlbumSerializer)
    }

  end


 end
