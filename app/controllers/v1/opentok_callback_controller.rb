class V1::OpentokCallbackController < V1::BaseController

  # Filters
  skip_before_action :validate_user

  def show
    render json: current_user
  end

  # POST /v1/sessions
  def create
    if go_live_video = GoLiveVideo.create({
                                              opentok_id: params[:id],
                                              event: params[:event],
                                              opentok_created_at: params[:createdAt],
                                              duration: params[:duration],
                                              partner_id: params[:partnerId],
                                              reason: params[:reason],
                                              opentok_session_id: params[:sessionId],
                                              size: params[:size],
                                              status: params[:status],
                                              url: params[:url]
                                          })
      render_success message: "Saved", data: { go_live_video: go_live_video }
    else
      render_unprocessable_entity message: go_live_video.errors.full_messages.join(', ')
    end
  end


end
