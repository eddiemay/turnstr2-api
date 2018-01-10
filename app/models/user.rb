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
  has_many :devices, class_name: 'UserDevice', dependent: :destroy


  has_one :live_session, -> { where('completed = ?', false).order("created_at DESC") }
  has_many :live_sessions
  has_many :video_stories, through: :live_sessions


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

  scope :with_voip_token, -> {joins(:devices).distinct}

  after_create :add_default_family_member

  scope :search, ->(text){
    where(
        " users.first_name LIKE :search
          OR users.last_name LIKE :search
          OR users.username LIKE :search
        ", { search: "%#{text.downcase}%"}
    )
  }

  scope :populars, -> {order("follower_count desc").limit(3)}



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

  def get_live_session(session_type)
    live_sessions.where("session_type = :session_type AND completed=0", {session_type: session_type}).order("created_at desc").first
  end

  def create_default_albums
    return if albums.count > 0 
    year = Date.today.year
    (1..12).each do |month|
      self.albums.create({month: month, year: year, title: "#{Date::MONTHNAMES[month]}, #{year}"})
    end  

  end 

  def add_default_family_member
    # make five user as family member
      User.where(id:  Rails.application.config.default_family_user_ids).each do |user|
      user.follow(self)
      self.follow(user)
    end  
  end

  def create_live_session(session_type = 'video_call')
    # don't create another live session if one already there
    tokbox_session = get_live_session(session_type)
    if tokbox_session.present?
      # Use same session if it is not older than 6 hours
      if (Time.now - tokbox_session.updated_at).to_i < (3600*1)
        tokbox_session.touch
        return tokbox_session
      end
    end

    opentok = OpenTok::OpenTok.new Rails.application.config.open_tok_api_key, Rails.application.config.open_tok_api_secret
    if session_type == 'go_live'
      # go live session will be recorded always
      session = opentok.create_session :archive_mode => :always, :media_mode => :routed
    else
      session = opentok.create_session :media_mode => :routed
    end
    token =  opentok.generate_token session.session_id
    LiveSession.create({session_id: session.session_id, user_id: self.id, token: token, session_type: session_type})
  end

  def create_tokbox_token session_id
    return live_session if live_session.present?

    opentok = OpenTok::OpenTok.new Rails.application.config.open_tok_api_key, Rails.application.config.open_tok_api_secret
    token =  opentok.generate_token session_id
    LiveSession.create({session_id: session_id, user_id: self.id, token: token})
  end


  def invite_users_to_my_live_session(invitees, call_type, tokbox_session)

    # no more than 3 invitees
    invitees = invitees.first(3)
    User.where(id: invitees).each do |user|

      # ignore if device is not registered for the user
      user_device = user.devices[0]
      next if user_device.blank?

      opentok = OpenTok::OpenTok.new Rails.application.config.open_tok_api_key, Rails.application.config.open_tok_api_secret
      tok_box_token = opentok.generate_token tokbox_session.session_id

      title = "Invitation from #{self.first_name} to join video call"
      data = {
          caller_first_name: self.first_name,
          caller_last_name: self.last_name,
          caller_tokbox_session_id: tokbox_session.session_id,
          token: tok_box_token,
          caller_id: self.id,
          sender_id: user.id,
          call_type: call_type
      }

      begin

        if user_device.device_name == "Android"
          # make sure Android device has push token
          next if user_device.device_push_token.blank?
          PushNotifier.send([user_device.device_push_token], title, data)
        else
          # make sure iOS device has voip token
          next if  user_device.voip_token.blank?
          PushNotifier.queue_voip(user_device.device_push_token, title, data)
        end

        # send all queued voip notification
        PushNotifier.deliver_voip

      rescue ActiveRecord::RecordInvalid => ex
        errors.add(:base, ex.message)
      end

    end

  end

  def live_broadcast_notification
    opentok = OpenTok::OpenTok.new Rails.application.config.open_tok_api_key, Rails.application.config.open_tok_api_secret
    tok_box_token = opentok.generate_token self.live_session.session_id, :role => :subscriber
    firebase_server_api_key = "AAAA8RDsLvc:APA91bEaDPTpc5jNOEOQbz8jjPaBA2_sgzsXK-XzJbffSmayzutm49ztX2Sh70ndF1Q5TINT0Dcxo14jF4Rub32BqAC9aaKtte1UToeTHCDXlbCMUQ_vlIzCzo4MnXu8FFrUo8D_undf"

    # Only followers need to be notified. Currently we are notifying all user
    registration_ids = UserDevice.where("user_id !=  #{self.id}").pluck(:device_push_token)

    data = {
        caller_first_name: self.first_name,
        caller_last_name: self.last_name,
        caller_tokbox_session_id: self.live_session.session_id,
        token: tok_box_token,
        caller_id: self.id,
        call_type: 'go_live_subscription'
    }


    HTTParty.post('https://fcm.googleapis.com/fcm/send',
                  :body => JSON.generate(
                      {
                          registration_ids: registration_ids,
                          priority: 'high',
                          notification: {title: "", body:"#{self.first_name} is live now"},
                          data: data
                      }
                  ),
                  :headers => {"Authorization" => "key=#{firebase_server_api_key}", "Content-Type" => "application/json"})

    true
  end

end
