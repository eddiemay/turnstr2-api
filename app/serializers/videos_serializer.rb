class VideosSerializer < ActiveModel::Serializer
  attributes :id, :opentok_id, :event, :opentok_created_at, :likes_count, :comments_count,
             :duration, :size, :url, :thumb_url, :status, :created_at


end
