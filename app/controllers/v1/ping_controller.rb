class V1::PingController < ApplicationController

  def show

    headers = []
    request.headers.each do |key, value|
      headers << key
    end


    render plain: request.headers['HTTP_AUTH_TOKEN']

  end


end
