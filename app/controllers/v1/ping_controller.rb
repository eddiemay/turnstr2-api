class V1::PingController < ApplicationController

  def show

    h = []
    request.headers.each do |key, value|
      h << key
    end


    render json: h

  end


end
