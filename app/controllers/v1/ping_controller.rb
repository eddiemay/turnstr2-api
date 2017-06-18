class V1::PingController < V1::BaseController

  def show
    render_success message: 'Pong'
  end


end
