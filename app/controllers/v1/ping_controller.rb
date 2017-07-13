class V1::PingController < ApplicationController

  def show
    # render json: {message: 'Pong'}

    render_success data: {
        photos: ActiveModel::Serializer::CollectionSerializer.new(::User.all, serializer: UserListSerializer)
    }
  end


end
