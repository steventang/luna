class User < ActiveRecord::Base
	extend FriendlyId
	friendly_id :username

	has_many :articles, :dependent => :destroy
  has_many :arts, dependent: :destroy

	attr_accessor :remember_token, :reset_token

	before_save :downcase_email

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_USERNAME_REGEX = /\A[-\w]*\z/i

	# validates :name, :presence => true, :length => { :maximum => 50 }
	validates :email, :presence => true, :length => { :maximum => 255 }, 
										:format => { :with => VALID_EMAIL_REGEX }, :uniqueness => { :case_sensitive => false }
	validates :username, :presence => true, :length => { :maximum => 50 },
										:format => { :with => VALID_USERNAME_REGEX }, :uniqueness => { :case_sensitive => false }
	# validate :username_is_one_word

	has_secure_password
	validates :password, :length => { :minimum => 6 }, :allow_blank => true

	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
  	SecureRandom.urlsafe_base64
  end

  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token)) # hash our token
  end

	# Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
  	digest = send("#{attribute}_digest")
  	return false if digest.nil? # makes sure sign out happens across browsers
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forget a user and end permanent session
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Sets the password reset attributes.
	def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def send_welcome_email
  	UserMailer.account_creation(self).deliver
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # The idea is that these feeds would change as we think of an algo. Right now it's == default feed
  def article_feed
  	Article.all
  end

  def art_feed
    Art.all
  end

#  def feed
#    return { self.article_feed, self.art_feed }
#  end

	private
		def username_is_one_word
			errors.add(:username, "can't have spaces") if username.split.size > 1
		end

		def downcase_email
			self.email = email.downcase
		end

end
