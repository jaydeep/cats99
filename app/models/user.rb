class User < ActiveRecord::Base
  attr_accessible :username, :password, :session_token
	attr_reader :password

	before_validation :ensure_session_token

	validates :username, :presence => true
	validates :password_digest, :presence => { :message => "Password can't be blank" }
	validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :session_token, :presence => true

	has_many(
	:cats,
	:class_name => "Cat",
	:foreign_key => :user_id
	)

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def is_password?(password)
		BCrypt::Password.new(self.password_digest).is_password?(password)
	end

	def self.find_by_credentials(username_param, password_param)
		# return nil if username_param.nil? || password_param.nil?
    user = User.find_by_username(username_param)
		return nil if user.nil?
    user.is_password?(password_param) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
		puts "this was my session token #{session_token}"
    self.session_token = self.class.generate_session_token
		puts "this is my session token now #{session_token}"
    self.save!
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
