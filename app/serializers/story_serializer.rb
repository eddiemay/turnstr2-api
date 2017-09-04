class StorySerializer < ActiveModel::Serializer
	attributes :id, :caption, :likes_count, :comments_count, :media

	belongs_to :user

	def media
		[
			{
				media_url: object.face1_media.file? ? object.face1_media.url : nil, 
				thumb_url: object.face1_media.content_type == 'video/mp4' ? 
					object.face1_video_thumb.file? ? object.face1_video_thumb.url(:thumb) : nil 
					: object.face1_media.file? ? object.face1_media.url(:thumb) : nil , 
				media_type:object.face1_media.content_type
			},

			{
				media_url: object.face2_media.file? ? object.face2_media.url : nil,  
				thumb_url: object.face2_media.content_type == 'video/mp4' ? 
					object.face2_video_thumb.file? ? object.face2_video_thumb.url(:thumb) : nil 
					: object.face2_media.file? ? object.face2_media.url(:thumb) : nil , 
				media_type:object.face2_media.content_type
			},

			{
				media_url: object.face3_media.file? ? object.face3_media.url : nil, 
				thumb_url: object.face3_media.content_type == 'video/mp4' ? 
					object.face3_video_thumb.file? ? object.face3_video_thumb.url(:thumb) : nil 
					: object.face3_media.file? ? object.face3_media.url(:thumb) : nil , 
				media_type:object.face3_media.content_type
			},

			{
				media_url: object.face4_media.file? ? object.face4_media.url : nil, 
					thumb_url: object.face4_media.content_type == 'video/mp4' ? 
					object.face4_video_thumb.file? ? object.face4_video_thumb.url(:thumb) : nil 
					: object.face4_media.file? ? object.face4_media.url(:thumb) : nil , 
			media_type:object.face4_media.content_type
			},

			{
				media_url: object.face5_media.file? ? object.face5_media.url : nil, 
					thumb_url: object.face5_media.content_type == 'video/mp4' ? 
					object.face5_video_thumb.file? ? object.face5_video_thumb.url(:thumb) : nil 
					: object.face5_media.file? ? object.face5_media.url(:thumb) : nil , 
				media_type:object.face5_media.content_type
			},

			{
				media_url: object.face6_media.file? ? object.face6_media.url : nil, 
				thumb_url: object.face6_media.content_type == 'video/mp4' ? 
					object.face6_video_thumb.file? ? object.face6_video_thumb.url(:thumb) : nil 
					: object.face6_media.file? ? object.face6_media.url(:thumb) : nil , 
				media_type:object.face6_media.content_type
			}


		]

	end		


end