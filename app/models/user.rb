class User < ActiveRecord::Base
  has_many :likes
  has_many :activities
  has_many :matches
  has_many :liked_users, :through => :likes
  has_many :identities
  has_many :alerts
  belongs_to :profile
  after_create :create_profile
  geocoded_by :current_sign_in_ip,
    :latitude => :last_latitude, :longitude => :last_longitude
  # after_validation :geocode
  before_validation :geocode, if: :current_sign_in_ip_changed?

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  scope :excluding_user, ->(user) { where("id <> ? ", user.id)}
  scope :with_overlapping_activity, ->(activity) { joins(:activity).merge(Activity.overlapping?(activity)) }

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          gender: auth.extra.raw_info.gender,
          #username: auth.info.nickname || auth.uid,
          gender: auth.extra.raw_info.gender,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20],
          pic: auth.info.image
        )
        # user.skip_confirmation!
        user.save!
      end
    end

    def create_profile
      profile = Profile.create if profile.nil?
      self.save
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.token = auth.credentials.token
      identity.token_expires_at = auth.credentials.expires_at 
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end