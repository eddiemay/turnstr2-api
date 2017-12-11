class V1::PingController < ApplicationController

  def show

    headers = []
    request.headers.each do |key, value|
      headers << key
    end


    render json: headers

  end


end
