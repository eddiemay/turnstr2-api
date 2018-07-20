class UserStorySerializer < ActiveModel::Serializer
	attributes :id, :thumb_url, :view_count

	belongs_to :user, serializer: UserListSerializer

  attribute :recent_views, if: :include_details?


	def include_details?
		scope.present? && scope[:include_details].eql?(true)
	end

  def recent_views
    result = []
    object.views.reorder('updated_at desc').limit(3).each do |view|
      result << {id: view.id, user: UserListSerializer.new(view.user, without_serializer: true)}
    end
    result
  end



end