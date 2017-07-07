class StorySerializer < ActiveModel::Serializer
	attributes :id, :caption, :likes_count, :comments_count, :media

	belongs_to :user

	def media
		[
			{
				media_url: object.face1_media.url, 
				thumb_url: object.face1_media.content_type == 'video/mp4' ? object.face1_video_thumb.url(:thumb) : object.face1_media.url(:thumb)  , 
				media_type:object.face1_media.content_type
			},

			{
				media_url: object.face2_media.url, 
				thumb_url: object.face2_media.content_type == 'video/mp4' ? object.face2_video_thumb.url(:thumb) : object.face2_media.url(:thumb)  , 
				media_type:object.face2_media.content_type
			},

			{
				media_url: object.face3_media.url, 
				thumb_url: object.face3_media.content_type == 'video/mp4' ? object.face3_video_thumb.url(:thumb) : object.face3_media.url(:thumb)  , 
				media_type:object.face3_media.content_type
			},

			{
				media_url: object.face4_media.url, 
				thumb_url: object.face4_media.content_type == 'video/mp4' ? object.face4_video_thumb.url(:thumb) : object.face4_media.url(:thumb)  , 
				media_type:object.face4_media.content_type
			},



		]

	end		


end