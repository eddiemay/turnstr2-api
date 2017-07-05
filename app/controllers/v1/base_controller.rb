class V1::BaseController < ApplicationController

  # Distribute the related stuff to different modules/concerns
  # to make controller slim and clean. They can be found under the
  # folder 'app/controllers/concerns'
  include AuthenticateUser

  def current_user
    @current_user
  end

  def current_page
  	params[:page] || 1
  end	



end
