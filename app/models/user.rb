class User < ApplicationRecord
  include UserAuthentication
  include HasEmail

  # Paperclip configuration for adding image to User
  has_attached_file :avatar_face1, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :avatar_face2, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :avatar_face3, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :avatar_face4, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :avatar_face5, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :avatar_face6, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
                      
  validates_attachment_content_type :avatar_face1, :avatar_face2, :avatar_face3,:avatar_face4, :avatar_face5, :avatar_face6, content_type: /\Aimage\/.*\Z/

  
  validates :username, uniqueness: true, allow_nil: true
  validates :email, presence: true
  validates :password, length: {:within => 8..20}, confirmation: true, :if => lambda{ !password.nil? }


  has_many :albums
  has_many :photos, through: :albums
  has_many :stories
  has_many :comments
  has_many :likes
  has_many :liked_photo, through: :likes, source: :likable, source_type: 'Photo'
  has_many :liked_story, through: :likes, source: :likable, source_type: 'Story'

  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :family, -> (user){ 
    unscope(where: :user_id)
    .where('users.id in (
      select followed_id from relationships where follower_id = :user_id and followed_id in ( 
        select follower_id from relationships where followed_id= :user_id))', 
        user_id: user.id
      )}, 
    class_name: 'User'

    # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end



  def password_reset_expired?
    reset_password_sent_at < 2.hours.ago
  end

  def create_reset_digest
    update_attributes(reset_password_roken: User.new_token, reset_password_sent_at: Time.zone.now)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Sends password reset email.
  def send_password_reset_email
    #UserMailer.password_reset(self).deliver_now
  end

  def create_default_albums
    return if albums.count > 0 
    year = Date.today.year
    (1..12).each do |month|
      self.albums.create({month: month, year: year, title: "#{Date::MONTHNAMES[month]}, #{year}"})
    end  

  end  

end
