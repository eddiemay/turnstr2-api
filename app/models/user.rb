class User < ApplicationRecord
  include UserAuthentication
  include HasEmail

  # Paperclip configuration for adding image to User
  has_attached_file :avatar_face1, styles: { medium: "300x300>", thumb: "100x100>" }
  has_attached_file :avatar_face2, styles: { medium: "300x300>", thumb: "100x100>" }
  has_attached_file :avatar_face3, styles: { medium: "300x300>", thumb: "100x100>" }
  has_attached_file :avatar_face4, styles: { medium: "300x300>", thumb: "100x100>" }
  has_attached_file :avatar_face5, styles: { medium: "300x300>", thumb: "100x100>" }
  has_attached_file :avatar_face6, styles: { medium: "300x300>", thumb: "100x100>" }
                      
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

  has_and_belongs_to_many :favourites,
      class_name: "User", 
      join_table:  :favourites, 
      foreign_key: :user_id, 
      association_foreign_key: :favourite_user_id

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

  after_create :add_default_family_member


  # Follows a user.
  def follow(other_user)
    following << other_user
    update_attributes(following_count: following.count, family_count: family.count)
    other_user.update_attributes(follower_count: other_user.followers.count, family_count: other_user.family.count)
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
    update_attributes(following_count: following.count, family_count: family.count)
    other_user.update_attributes(follower_count: other_user.followers.count, family_count: other_user.family.count)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # return true if other user added as family to current user
  def family_member?(other_user)
    family.include?(other_user)
  end 

  def favourite?(other_user)
    favourites.include?(other_user)
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

  def add_default_family_member
    # make first five user as family member
    User.order(:id).take(5).each do |user|
      user.follow(self)
      self.follow(user)
    end  
  end  

end
