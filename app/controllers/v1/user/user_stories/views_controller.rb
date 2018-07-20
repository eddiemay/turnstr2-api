class V1::User::UserStories::ViewsController < V1::User::UserStories::BaseController

  # GET /user/user_stories/1/views
  def index
    @views = @user_story.views.reorder('updated_at desc').page current_page
    render_success data: {
        views: ActiveModel::Serializer::CollectionSerializer.new(@views, serializer: UserStoryViewSerializer),
        total_pages: @views.total_pages,
        current_page: @views.current_page,
        next_page: @views.next_page,
        prev_page: @views.prev_page,
        first_page: @views.first_page?,
        last_page: @views.last_page?
    }
  end

end
