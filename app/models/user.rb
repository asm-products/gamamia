class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  ROLES = ["admin"]

  # enable reverse functionality for vots
  acts_as_voter

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :confirmable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # TODO Can a user have many identities? What if he connects both FB, TW etc profiles?
  has_many :identities, dependent: :destroy
  has_many :comments
  has_many :games

  validates :email,
                format: { without: TEMP_EMAIL_REGEX, on: :update},
                presence: true,
                uniqueness: true

  validates :username,
                format: { with: /\A[a-zA-Z0-9\-\_]+\Z/ },
                presence: true,
                uniqueness: true

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?

        user = User.new(
          name: auth.extra.raw_info.name,
          username: create_username_from(auth.info.nickname || auth.uid),
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20],
          avatar_url: auth.info.image
        )
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def self.create_username_from name
    username = n = ""
    loop do
      username = name.parameterize + n.to_s
      n = n.to_i + 1
      break unless User.exists?(username: username)
    end
    username
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end
