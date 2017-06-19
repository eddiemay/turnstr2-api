class V1::PingController < ApplicationController

  def show
    render json: {message: 'Pong'}
  end


end
